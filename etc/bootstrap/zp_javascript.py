from common import *

class JavaScript():

    name = 'JavaScript'
    ext = '.js'
    classes = set()

    def __init__(self, parse_node):
        self.parse_node = parse_node

    def py_parse(self, source):
        parse_tree = parse(source)
        body = parse_tree.body

        out = ''

        for node in body:
            out += self.parse_node(node)

        return out

    def parse_arguments(self, node, begin=0, end=None):
        if end is not None:
            args = ','.join([self.parse_arg(arg) for arg in node.args[begin:end]])
        args = ','.join([self.parse_arg(arg) for arg in node.args[begin:]])
        kwarg = ''
        return (args, kwarg)

    def parse_FunctionDef(self, node):
        body = '; '.join([self.parse_node(node) for node in node.body])
        name = node.name

        # # byte_at -> noop
        # if name == 'byte_at':
        #     return ''
        if name == '__init__':
            if node.args.args[0].arg == 'self':
                args, kwarg = self.parse_arguments(node.args, 1)
            out =' constructor(' + args + ') { var self = this; '  # quick hack
            out += body.replace('var ', '') + '};'
            return out

        args, kwarg = self.parse_arguments(node.args)

        out = " function " + name + '(' + args + ') { ' + body + '};'
        return out

    def parse_Compare(self, node):
        def compare(op, l, r):
            if isinstance(op, Is):
                out = self.parse_node(op) + self.parse_node(l) + ', ' + self.parse_node(r) + ')'
            else:
                out = ' (' + self.parse_node(l) + ' ' + self.parse_node(op) + ' ' + self.parse_node(r) + ')'
            return out

        def type_compare(op, arg, typ):
            if typ == 'str':
                typ = 'string'
            elif typ == 'int':
                typ = 'number'
            elif typ == 'float':
                typ = 'number'
            elif typ == 'bool':
                typ = 'boolean'

            if isinstance(op, Is) \
               and typ not in ['string', 'number', 'boolean']:
                out = self.parse_node(op) + '(typeof ' + arg + ')'
                out += ', ' + typ + ')'
            # special case for type(x) is type
            elif isinstance(op, Is) \
               and typ in ['string', 'number', 'boolean']:
                out = ' ((typeof ' + arg + ') === "' + typ + '")'
            else:
                out = ' ((typeof ' + arg + ') ' + self.parse_node(op)
                out += ' ' + typ + ')'
            return out

        left = node.left
        ops = node.ops
        comparators = node.comparators
        # there can be more than one comparator, in which case we 'and'
        if len(ops) > 1:
            if isinstance(left, Call) and \
               left.func.id == 'type':
                out = ' && '.join([type_compare(ops[i], left.args[i].id, comparators[i].id)
                                   for i in range(len(ops))])
                return out

            out = ' && '.join([compare(ops[i], left, comparators[i])
                               for i in range(len(ops))])
        else:
            if isinstance(left, Call):
                if left.func.id == 'type':
                    return type_compare(ops[0], left.args[0].id, comparators[0].id)
            out = compare(ops[0], left, comparators[0])
        return out

    def parse_Call(self, node):
        func = self.parse_node(node.func)
        args = ','.join([self.parse_node(arg) for arg in node.args])
        nargs = len(node.args)
        keywords = node.keywords

        if keywords != []:
            raise Exception

        if isinstance(node.func, Attribute) and node.func.attr == 'get':
            out = '(' +node.func.value.id + '[' + self.parse_node(node.args[0]) + ']'
            out += ' || ' + self.parse_node(node.args[1]) + ')'
            return out

        if func == 'ord':
            if isinstance(node.args[0], Str):
                return str(ord(node.args[0].s))
            else:
                return args + '.charCodeAt(0)'
        elif func == 'str':
            return 'String(' + args + ')'
        elif func == 'repr':
            return 'JSON.stringify(' + args + ')'
        elif func == 'range':
            # we will use
            # [...Array(5).keys()];
            # to allow using x = range(10), for example.
            # args: start, stop, step
            if nargs == 1:
                if isinstance(node.args[0], Num):
                    # return '[...Array(' + str(node.args[0].n) + ').keys()]'
                    return ''
                else:
                    return '[...Array(' + args + ').keys()]'
            # TODO: handle other cases!
        elif func[-14:] == 'indents.append':
            return func[:-7] + '.push(' + args + ')'
        elif func == 'len':
            return args + '.length'
        elif func == 'isinstance':
            # we need to handle builtin types (change their names)
            # vs class instance checks
            obj = self.parse_node(node.args[0])
            klass = self.parse_node(node.args[1])
            if klass == 'str':
                return '((typeof ' + obj + ') === "string")'
            elif klass == 'int' or klass == 'float':
                return '((typeof ' + obj + ') === "number")'
            elif klass == 'bytes':
                return '(' + obj + ' instanceof Uint8Array)'
            else:  # default to class
                return '(' + obj + ' instanceof ' + klass + ')'
        elif func == 'print':
            return 'console.log(' + args + ')'

        return func + '(' + args + ')'

    def parse_BinOp(self, node):
        def binop(op, l, r):
            return '(' + self.parse_node(l) + ' ' + self.parse_node(op) + ' ' + self.parse_node(r) + ')'

        def array_mult(arr, r):
            out = ' new Array(' + self.parse_node(r) + ')'
            out += '.fill(' + str(arr[0]) + ')'
            return out

        def floor_div(l, r):
            out = ' ((' + self.parse_node(l) + '/' + self.parse_node(r) + ') >> 0)'
            return out

        left = node.left
        op = node.op
        right = node.right

        if isinstance(op, FloorDiv):
            return floor_div(left, right)
        elif isinstance(op, Mult) and isinstance(right, Num) \
           and isinstance(left, List):
            arr = literal_eval(left)  # get actual array
            if len(arr) == 1:
                return array_mult(arr, right)
            else:
                raise Exception

        return ' ' + binop(op, left, right)

    def parse_If(self, node):
        test = self.parse_node(node.test)  # Compare, BoolOp
        body = '; '.join([self.parse_node(node) for node in node.body])
        orelse = node.orelse
        out = " if(" + test + ') {' + body
        if orelse != []:
            out += "} else {"
            out += '; '.join([self.parse_node(node) for node in orelse]) + '}'
        else:
            out += '}'
        return out

    def parse_BoolOp(self, node):
        # ('test', 'body', 'orelse')
        op = self.parse_node(node.op)
        # values = self.parse_node(node.values)
        values = f") {op} (".join([self.parse_node(node) for node in node.values])
        return '((' + values + '))'

    def parse_Assign(self, node):
        # value and targets can be tuples!
        targets = node.targets
        value = node.value

        if len(targets) > 1:
            raise Exception

        def define(x, y):
            py = self.parse_node(y)

            if isinstance(x, Subscript):
                arr = self.parse_node(x.value)
                pos = self.parse_node(x.slice)
                return arr + '[' + pos + '] = ' + py + ';'

            if isinstance(y, Call) and isinstance(y.func, Name):
                if y.func.id == 'bytearray':
                    px = self.parse_node(x)
                    out = ' var ' + px + ' = ' + \
                        'new Uint8Array(' + str(y.args[0].n) + ');'
                    return out
                elif y.func.id in self.classes:
                    px = self.parse_node(x)
                    return ' var ' + px + ' = new ' + py + ';'



            px = self.parse_node(x)
            if isinstance(targets[0], Attribute):
                    return ' ' + px + " = " + py + ';'
            else:
                    return ' var ' + px + " = " + py + ';'

        if isinstance(value, Tuple):
            target_elts = targets[0].elts
            value_elts = value.elts
            out = ' '.join([define(target_elts[i], value_elts[i]) for i in range(len(target_elts))])
        else:
            out = define(targets[0], value)
        return out

    def parse_AugAssign(self, node):
        # ('target', 'op', 'value')
        target = self.parse_node(node.target)
        op = self.parse_node(node.op)
        value = self.parse_node(node.value)
        out = ' ' + target + op + '= ' + value + ';'
        return out

    def parse_Attribute(self, node):
        value = self.parse_node(node.value)
        attr = node.attr
        return value + '.' + attr

    def parse_Subscript(self, node):
        value = self.parse_node(node.value)
        _slice = self.parse_node(node.slice)

        if isinstance(node.slice, Slice):
            return value + '.slice(' + _slice + ')'

        return value + '[' + _slice + ']'

    def parse_Return(self, node):
        if node.value == None:
            return 'return null;'
        else:
            return 'return ' + self.parse_node(node.value) + ';'

    def parse_Expr(self, node):
        return self.parse_node(node.value) + ';'

    def parse_For(self, node):
        # We don't implement for/else.

        #TODO: do multiple args (tuples)

        # for i in range(10):
        #     body
        # for node.target.id in node.iter (Call):
        #     node.body (array)
        target = self.parse_node(node.target)
        _iter = self.parse_node(node.iter)  # handle 'range' in parse_Call
        body = '; '.join([self.parse_node(node) for node in node.body])

        # specialise 'for i in range(N)'
        if isinstance(node.iter, Call) \
           and node.iter.func.id == 'range' \
           and len(node.iter.args) == 1 \
           and isinstance(node.iter.args[0], Num):
            out = ' for (const ' + target + '=0; ' + target + '<'
            out += str(node.iter.args[0].n) + '; ' + target + '++) {'
            out += body + '}'
            return out

        out = ' for (const ' + target + ' in ' + _iter + ') {' + body + '}'
        return out

    def parse_While(self, node):
        test = self.parse_node(node.test)
        body = '; '.join([self.parse_node(node) for node in node.body])
        # not easily mapped
        # orelse = '; '.join([self.parse_node(node) for node in node.orelse])
        return ' while (' + test + ') {' + body + '};'


    def parse_Slice(self, node):
        lower = self.parse_node(node.lower)
        upper = self.parse_node(node.upper)
        step = self.parse_node(node.step)  # ignored
        if lower is not None and upper is not None:
            return ', '.join([lower, upper])
        elif lower is not None:
            return lower
        elif upper is not None:
            return ', '.join(['0', upper])
        else:
            raise Exception

    def parse_ClassDef(self, node):
        # ('name', 'bases', 'keywords', 'body', 'decorator_list')
        name = node.name
        body = '; '.join([self.parse_node(node) for node in node.body])
        bases = node.bases  # TODO: implement (multiple) inheritance
        keywords = node.keywords  # ignored
        decorator_list = node.decorator_list  # ignored

        # store class name for future reference when instantiating
        self.classes.add(name)

        return 'class ' + name + ' {' + body + '}'

    def parse_List(self, node):
        elts = ', '.join([self.parse_node(e) for e in node.elts])
        return '[' + elts + ']'

    def parse_Dict(self, node):
        keys = node.keys
        values = node.values
        kvs = []
        for i in range(len(keys)):
            k = self.parse_node(keys[i])
            v = self.parse_node(values[i])
            kvs.append(k + ':' + v)

        return '{' + ', '.join(kvs) + '}'

    def parse_IfExp(self, node):
        # ('test', 'body', 'orelse')
        test = self.parse_node(node.test)  # Compare, BoolOp
        body = self.parse_node(node.body)
        orelse = self.parse_node(node.orelse)
        return ' (' + test + ' ? ' + body + ' : ' + orelse + ')'

    def parse_Raise(self, node):
        exc = self.parse_node(node.exc)
        cause = self.parse_node(node.cause)
        return ' throw "' + exc.encode('unicode-escape').decode().replace('"', '\\"') + '";'

    def parse_FloorDiv(self, node):
        # Should be handled elsewhere, e.g. in BinOp
        raise Exception

    @staticmethod
    def parse_arg(node):
        arg = node.arg
        return arg

    @staticmethod
    def parse_Add(node):
        return '+'

    @staticmethod
    def parse_Sub(node):
        return '-'

    @staticmethod
    def parse_Mult(node):
        return '*'

    @staticmethod
    def parse_Gt(node):
        return ">"

    @staticmethod
    def parse_GtE(node):
        return ">="

    @staticmethod
    def parse_Lt(node):
        return "<"

    @staticmethod
    def parse_LtE(node):
        return ">="

    @staticmethod
    def parse_Eq(node):
        return "==="

    @staticmethod
    def parse_NotEq(node):
        return "!=="

    @staticmethod
    def parse_Is(node):
        return "Object.is("

    @staticmethod
    def parse_And(node):
        return "&&"

    @staticmethod
    def parse_Or(node):
        return "||"

    @staticmethod
    def parse_Break(node):
        return 'break;'

    @staticmethod
    def parse_Continue(node):
        return 'continue;'

    @staticmethod
    def parse_Pass(node):
        return '{};'

    @staticmethod
    def parse_BitAnd(node):
        return '&'
