import re
import ast as AST


class Transformer:
    def __init__(self, transform, cps=False):
        self.transform = transform
        self.rootdir = ""
        self.classes = set()
        self.cps = cps
        self.ext = ".js"
        self.counter = 0
        # Flag to modify behavior
        self.in_class = False

    def gensym(self):
        gs = "g" + str(self.counter)
        self.counter += 1
        return gs

    @staticmethod
    def to_string(s):
        return '"' + s.encode("unicode-escape").decode().replace('"', '\\"') + '"'

    def Module(self, node):
        return self.transform(node.body)

    def Expr(self, node):
        return self.transform(node.value) + ";"

    def Num(self, node):
        # return self.to_string(node.n)
        return str(node.n)

    def Str(self, node):
        return self.to_string(node.s)

    def BinOp(self, node):
        def binop(op, l, r):
            return (
                "("
                + self.transform(l)
                + " "
                + self.transform(op)
                + " "
                + self.transform(r)
                + ")"
            )

        def array_mult(arr, r):
            out = " new Array(" + self.transform(r) + ")"
            out += ".fill(" + str(arr[0]) + ")"
            return out

        def floor_div(l, r):
            out = " ((" + self.transform(l) + "/" + self.transform(r) + ") >> 0)"
            return out

        left = node.left
        op = node.op
        right = node.right

        if isinstance(op, AST.FloorDiv):
            return floor_div(left, right)
        elif (
            isinstance(op, AST.Mult)
            and isinstance(right, AST.Num)
            and isinstance(left, AST.List)
        ):
            arr = AST.literal_eval(left)  # get actual array
            if len(arr) == 1:
                return array_mult(arr, right)
            else:
                raise Exception

        return " " + binop(op, left, right)

    def Add(self, node):
        return "+"

    def Call(self, node):
        func = self.transform(node.func)
        args = ",".join([self.transform(arg) for arg in node.args])
        nargs = len(node.args)
        keywords = node.keywords

        if keywords != []:
            raise Exception

        if isinstance(node.func, AST.Attribute) and node.func.attr == "get":
            out = "(" + node.func.value.id + "[" + self.transform(node.args[0]) + "]"
            out += " || " + self.transform(node.args[1]) + ")"
            return out

        if func == "ord":
            if isinstance(node.args[0], AST.Str):
                return str(ord(node.args[0].s))
            else:
                return args + ".charCodeAt(0)"
        elif func == "str":
            return "String(" + args + ")"
        elif func == "repr":
            return "JSON.stringify(" + args + ")"
        elif func == "range":
            # we will use
            # [...Array(5).keys()];
            # to allow using x = range(10), for example.
            # args: start, stop, step
            if nargs == 1:
                if isinstance(node.args[0], AST.Num):
                    # return '[...Array(' + str(node.args[0].n) + ').keys()]'
                    return ""
                else:
                    return "[...Array(" + args + ").keys()]"
            # TODO: handle other cases!
        elif func[-14:] == "indents.append":
            return func[:-7] + ".push(" + args + ")"
        elif func == "len":
            return args + ".length"
        elif func == "isinstance":
            # we need to handle builtin types (change their names)
            # vs class instance checks
            obj = self.transform(node.args[0])
            klass = self.transform(node.args[1])
            if klass == "str":
                return "((typeof " + obj + ') === "string")'
            elif klass == "int" or klass == "float":
                return "((typeof " + obj + ') === "number")'
            elif klass == "bytes":
                return "(" + obj + " instanceof Uint8Array)"
            else:  # default to class
                return "(" + obj + " instanceof " + klass + ")"
        elif func == "print":
            return "console.log(" + args + ")"
        if func == 'arguments':
            # javascript strict mode requires special handling of
            # 'eval' and 'arguments' identifiers
            func = '_arguments'

        return func + "(" + args + ")"

    @staticmethod
    def Name(node):
        return node.id

    def FunctionDef(self, node):
        body = "; ".join([self.transform(node) for node in node.body])
        name = node.name

        # For class constructors
        if name == "__init__":
            if node.args.args[0].arg == "self":
                args = self.arguments(node.args, 1)
            out = " constructor(" + args + ") { var self = this; "  # quick hack
            out += body.replace("var ", "") + "};"
            return out
        elif name == "source":
            body = "return ts.buf.slice(start, end);"

        # Only parse args
        args = self.transform(node.args)

        out = " function " + name + "(" + args + ") { " + body + "};"
        return out

    def Return(self, node):
        if node.value is None:
            return "return null;"
        else:
            return "return " + self.transform(node.value) + ";"

    def arguments(self, node, begin=0, end=None):
        if end is not None:
            args = ",".join([self.transform(arg) for arg in node.args[begin:end]])
        args = ",".join([self.transform(arg) for arg in node.args[begin:]])
        return args

    @staticmethod
    def arg(node):
        return node.arg

    def Assign(self, node):
        # value and targets can be tuples!
        targets = node.targets
        value = node.value

        if len(targets) > 1:
            raise Exception

        def define(x, y):
            py = self.transform(y)

            if isinstance(x, AST.Subscript):
                arr = self.transform(x.value)
                pos = self.transform(x.slice)
                return arr + "[" + pos + "] = " + py + ";"

            if isinstance(y, AST.Call) and isinstance(y.func, AST.Name):
                if y.func.id == "bytearray":
                    px = self.transform(x)
                    out = (
                        " var "
                        + px
                        + " = "
                        + "new Uint8Array("
                        + str(y.args[0].n)
                        + ");"
                    )
                    return out
                elif y.func.id in self.classes:
                    px = self.transform(x)
                    if self.in_class:
                        return " " + px + " = new " + py + ";"
                    else:
                        return " var " + px + " = new " + py + ";"

            px = self.transform(x)
            if isinstance(targets[0], AST.Attribute):
                return " " + px + " = " + py + ";"
            else:
                if self.in_class:
                    return " " + px + " = " + py + ";"
                else:
                    return " var " + px + " = " + py + ";"

        if isinstance(value, AST.Tuple) and len(targets) > 1:
            target_elts = targets[0].elts
            value_elts = value.elts
            out = " ".join(
                [define(target_elts[i], value_elts[i]) for i in range(len(target_elts))]
            )
        elif isinstance(value, AST.Tuple) and len(targets) == 1:
            if self.in_class:
                out = f"{self.transform(targets[0])} = ["
            else:
                out = f"var {self.transform(targets[0])} = ["
            out += ",".join(
                [self.transform(value.elts[i]) for i in range(len(value.elts))]
            )
            out += '];'
        else:
            out = define(targets[0], value)

        return out

    def Dict(self, node):
        keys = node.keys
        values = node.values
        kvs = []
        for i in range(len(keys)):
            k = self.transform(keys[i])
            v = self.transform(values[i])
            kvs.append(k + ":" + v)

        return "{" + ", ".join(kvs) + "}"

    def Index(self, node):
        return self.transform(node.value)

    def If(self, node):
        test = self.transform(node.test)  # Compare, BoolOp
        body = "; ".join([self.transform(node) for node in node.body])
        orelse = node.orelse
        out = " if(" + test + ") {" + body
        if orelse != []:
            out += "} else {"
            out += "; ".join([self.transform(node) for node in orelse]) + "}"
        else:
            out += "}"
        return out

    def Compare(self, node):
        def compare(op, l, r):
            if isinstance(op, AST.Is):
                out = (
                    self.transform(op)
                    + self.transform(l)
                    + ", "
                    + self.transform(r)
                    + ")"
                )
            else:
                out = (
                    " ("
                    + self.transform(l)
                    + " "
                    + self.transform(op)
                    + " "
                    + self.transform(r)
                    + ")"
                )
            return out

        def type_compare(op, arg, typ):
            if typ == "str":
                typ = "string"
            elif typ == "int":
                typ = "number"
            elif typ == "float":
                typ = "number"
            elif typ == "bool":
                typ = "boolean"

            if isinstance(op, AST.Is) and typ not in ["string", "number", "boolean"]:
                out = self.transform(op) + "(typeof " + arg + ")"
                out += ", " + typ + ")"
            # special case for type(x) is type
            elif isinstance(op, AST.Is) and typ in ["string", "number", "boolean"]:
                out = " ((typeof " + arg + ') === "' + typ + '")'
            else:
                out = " ((typeof " + arg + ") " + self.transform(op)
                out += " " + typ + ")"
            return out

        def x_in_y(left, op, comparators):
            return ""

        left = node.left
        ops = node.ops
        comparators = node.comparators

        # Special case for x in tokenset:
        if (
            len(ops) == 1
            and isinstance(ops[0], AST.In)
            and comparators[0].func.id == "tokenset"
        ):
            # [3,79,42].indexOf(x) >= 0
            args = ",".join(self.transform(i) for i in comparators[0].args)
            left = self.transform(left)
            out = f"[{args}].indexOf({left}) >= 0"
        # there can be more than one comparator, in which case we 'and'
        elif len(ops) > 1:
            if isinstance(left, AST.Call) and left.func.id == "type":
                out = " && ".join(
                    [
                        type_compare(ops[i], left.args[i].id, comparators[i].id)
                        for i in range(len(ops))
                    ]
                )
                return out

            out = " && ".join(
                [compare(ops[i], left, comparators[i]) for i in range(len(ops))]
            )
        else:
            if isinstance(left, AST.Call):
                if left.func.id == "type":
                    return type_compare(ops[0], left.args[0].id, comparators[0].id)
            out = compare(ops[0], left, comparators[0])
        return out

    @staticmethod
    def parse_Is(node):
        return "Object.is("

    def Subscript(self, node):
        value = self.transform(node.value)
        _slice = self.transform(node.slice)

        if isinstance(node.slice, AST.Slice):
            return value + ".slice(" + _slice + ")"

        return value + "[" + _slice + "]"

    def Slice(self, node):
        lower = self.transform(node.lower)
        upper = self.transform(node.upper)
        step = self.transform(node.step)  # ignored
        if lower is not None and upper is not None:
            return ", ".join([lower, upper])
        elif lower is not None:
            return lower
        elif upper is not None:
            return ", ".join(["0", upper])
        else:
            raise Exception

    def IfExp(self, node):
        # ('test', 'body', 'orelse')
        test = self.transform(node.test)  # Compare, BoolOp
        body = self.transform(node.body)
        orelse = self.transform(node.orelse)
        return " (" + test + " ? " + body + " : " + orelse + ")"

    def Bytes(self, node):
        return (
            '"'
            + node.s.decode("utf-8")
            .encode("unicode-escape")
            .decode()
            .replace('"', '\\"')
            + '"'
        )

    def List(self, node):
        elts = ", ".join([self.transform(e) for e in node.elts])
        return "[" + elts + "]"

    @staticmethod
    def Mult(node):
        return "*"

    def AugAssign(self, node):
        # ('target', 'op', 'value')
        target = self.transform(node.target)
        op = self.transform(node.op)
        value = self.transform(node.value)
        out = " " + target + op + "= " + value + ";"
        return out

    def For(self, node):
        # We don't implement for/else.

        # TODO: do multiple args (tuples)
        if isinstance(node.target, AST.Tuple):
            raise Exception

        # for i in range(10):
        #     body
        # for node.target.id in node.iter (Call):
        #     node.body (array)

        # Use gensymd iter vars
        target = self.transform(node.target)
        gs = self.gensym()

        # We now have to modify the 'Name' emitter to replace all
        # occurrences of the initial target with the gensym
        def NameSwap(node):
            id = node.id
            if id == target:
                return gs
            else:
                return id

        self.Name = NameSwap

        _iter = self.transform(node.iter)
        body = "; ".join([self.transform(node) for node in node.body])
        # Set Name back to default
        self.Name = lambda node: node.id

        # specialise 'for i in range(N)'
        if (
            isinstance(node.iter, AST.Call)
            and node.iter.func.id == "range"
            and len(node.iter.args) == 1
            and isinstance(node.iter.args[0], AST.Num)
        ):
            out = " for (let " + gs + "=0; " + gs + "<"
            out += str(node.iter.args[0].n) + "; " + gs + "++) {"
            out += body + "}"
            return out

        out = " for (const " + gs + " in " + _iter + ") {" + body + "}"

        return out

    def ClassDef(self, node):
        # ('name', 'bases', 'keywords', 'body', 'decorator_list')
        self.in_class = True

        # javascript strict mode requires special handling of
        # 'eval' and 'arguments' identifiers
        name = node.name
        if name == 'arguments':
            name = '_arguments'

        body = "; ".join([self.transform(node) for node in node.body])
        bases = node.bases  # TODO: implement (multiple) inheritance
        keywords = node.keywords  # ignored
        decorator_list = node.decorator_list  # ignored

        # store class name for future reference when instantiating
        self.classes.add(name)

        self.in_class = False
        return "class " + name + " {" + body + "}"

    def Attribute(self, node):
        value = self.transform(node.value)
        attr = node.attr
        return value + "." + attr

    @staticmethod
    def Gt(node):
        return ">"

    @staticmethod
    def Sub(node):
        return "-"

    def While(self, node):
        test = self.transform(node.test)
        body = "; ".join([self.transform(node) for node in node.body])
        # not easily mapped
        # orelse = '; '.join([self.transform(node) for node in node.orelse])

        return " while (" + test + ") {" + body + "};"

    def NameConstant(self, node):
        val = node.value
        if val is True:
            return "true"
        elif val is False:
            return "false"
        else:
            return str(node.value)

    def BoolOp(self, node):
        # ('test', 'body', 'orelse')
        op = self.transform(node.op)
        # values = self.transform(node.values)
        values = f") {op} (".join([self.transform(node) for node in node.values])
        return "((" + values + "))"

    @staticmethod
    def And(node):
        return "&&"

    @staticmethod
    def Eq(node):
        return "==="

    def FloorDiv(self, node):
        # Should be handled elsewhere, e.g. in BinOp
        raise Exception

    @staticmethod
    def Break(node):
        return "break;"

    @staticmethod
    def Or(node):
        return "||"

    @staticmethod
    def Lt(node):
        return "<"

    @staticmethod
    def Continue(node):
        return "continue;"

    @staticmethod
    def LtE(node):
        return ">="

    @staticmethod
    def NotEq(node):
        return "!=="

    @staticmethod
    def BitAnd(node):
        return "&"

    @staticmethod
    def GtE(node):
        return ">="

    @staticmethod
    def Pass(node):
        return "{};"

    def ImportFrom(self, node):
        # Handling of 'from x import *'
        # Since everything is top-level, we can jut prepend all the code
        # i.e. recursively compile:
        module = node.module
        module_file = self.rootdir + "/" + module + ".py"

        with open(module_file, "r") as f:
            source = f.read()

        module_code = self.transform(AST.parse(source))
        module_code = re.sub(r"(;)\1+", r"\1", module_code)

        return module_code

    def Global(self, node):
        # assume a noop, onus on programmer + "use strict";
        return ""

    def Import(self, node):
        # noop for the time being
        return ""

    def Tuple(self, node):
        elts = ",".join(self.transform(i) for i in node.elts)
        return f"[{elts}]"

    def UnaryOp(self, node):
        op = self.transform(node.op)
        operand = self.transform(node.operand)
        return f"({op}{operand})"

    @staticmethod
    def USub(node):
        return "-"

    @staticmethod
    def Not(node):
        return "!"

    @staticmethod
    def Is(node):
        return "Object.is("

    @staticmethod
    def Ellipsis(node):
        return "..."

    def Raise(self, node):
        # We will limit ourselves to relatively simple exceptions.
        # We will take 'raise Exception(foo)' and turn it into
        # throw foo;
        args = self.transform(node.exc.args)
        return f"throw ({args});"
