import re
import ast as AST


class Transformer:
    def __init__(self, transform, cps=False, es6_classes=False):
        self.transform = transform
        self.rootdir = ""
        self.classes = set()
        self.cps = cps
        self.ext = ".js"
        self.counter = 0
        # Flag to modify behavior
        self.in_class = False
        self.imports = set()
        self.modules = []
        self.base_class = False
        self.es6_classes = es6_classes
        self.name_prefix = False
        self.in_global = False
        self.global_vars = set()
        self.recur_FunctionDef = []

    def gensym(self):
        gs = "g" + str(self.counter)
        self.counter += 1
        return gs

    def get_identifier(self, node):
        if isinstance(node, AST.FunctionDef) or isinstance(node, AST.ClassDef):

            decorators = set()

            for d in node.decorator_list:
                if isinstance(d, AST.Name):
                    decorators.add(d.id)
                elif isinstance(d, AST.Call):
                    decorators.add(d.func.id)

            if "nocompile" in decorators:
                return None
            else:
                return node.name

        elif isinstance(node, AST.Assign):
            for t in node.targets:
                return self.get_identifier(t)
        elif isinstance(node, AST.Name):
            return node.id

    def find_class_init(self, nodes):
        # Finds the __init__ FunctionDef in a list of class child nodes.
        node = False
        for n in nodes:
            if isinstance(n, AST.FunctionDef) and n.name == "__init__":
                node = n
        return node

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

        def str_mult(s, n):
            return f"{self.transform(s)}.repeat({self.transform(n)})"

        def concat(arr, r):
            return f"{self.transform(arr)}.concat({self.transform(r)})"

        left = node.left
        op = node.op
        right = node.right

        if isinstance(op, AST.FloorDiv):
            return floor_div(left, right)
        elif isinstance(left, AST.Str) and isinstance(op, AST.Mult):
            return str_mult(left, right)
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
        elif (
            (isinstance(left, AST.List) or isinstance(right, AST.List))
            and isinstance(op, AST.Add)
        ):
            return concat(left, right)

        return " " + binop(op, left, right)

    def Add(self, node):
        return "+"

    def Call(self, node):
        func = self.transform(node.func)
        args = ",".join([self.transform(arg) for arg in node.args])
        nargs = len(node.args)
        keywords = node.keywords

        if keywords != []:
            raise Exception(f"Cannot emit code for Call node ({func}({args}))")

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
            # return "String(" + args + ")"
            return f"{args}.toString()"
        elif func == "int":
            return "Number(" + args + ")"
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
        elif func == "dict":
            return "{};"
        elif func == "set":
            # Don't accept arguments.
            return "new Set();"
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
                # return "(" + obj + " instanceof " + klass + ")"
                if klass[:4] == "AST.":
                    return f"({obj}.constructor.name === '{klass[4:]}')"
                else:
                    return f"({obj}.constructor.name === '{klass}')"
        elif func == "print":
            return "console.log(" + args + ")"
        elif func == "arguments":
            # javascript strict mode requires special handling of
            # 'eval' and 'arguments' identifiers
            func = "aarguments"
        elif func == "object":
            return "{}"
        elif isinstance(node.func, AST.Attribute) and node.func.attr == "encode":
            return self.transform(node.func.value)
        elif isinstance(node.func, AST.Attribute) and node.func.attr == "find":
            return (
                self.transform(node.func.value)
                + ".indexOf("
                + ",".join(self.transform(arg) for arg in node.args)
                + ")"
            )
        elif isinstance(node.func, AST.Attribute) and node.func.attr == "append":
            return (
                self.transform(node.func.value)
                + ".push("
                + ",".join(self.transform(arg) for arg in node.args)
                + ")"
            )

        # Implement 'foo'.join(bar)?
        # elif (
        #     isinstance(func, AST.Attribute)
        #     and isinstance(func.value, AST.Str)
        #     and func.attr == "join"
        # ):
        #     return False

        if func in self.classes:
            return "new " + func + "(" + args + ")"
        else:
            return func + "(" + args + ")"

    @staticmethod
    def Name(node):
        return node.id

    def TestFunctionDef(self, node):
        decorator = node.decorator_list[0]
        node.decorator_list = []
        function_code = self.FunctionDef(node)
        test_result = self.transform(decorator.args[0])
        test_args = ",".join([self.transform(arg) for arg in decorator.args[1:]])

        test_op = decorator.func.id

        out = f"tests.push(function () {{"
        # Capture console.log to variable
        out += "var console_log = console.log;"  # First, capture current log
        out += "var _res = '';"
        out += "console.log = function (s) { _res += (s + '\\n') };"  # Mimic Python print
        out += f"var res = {node.name}({test_args});"
        out += "if (_res !== '') { res = _res; }"
        out += "console.log = console_log;"  # Put proper log back into place

        if test_op == "Equals":
            out += f"if (res === {test_result}) {{"
        elif test_op == "Is":
            out += f"if (Object.is({node.name}({test_args}), {test_result})) {{"
        elif test_op == "IsInstance":
            out += f"if ({node.name}({test_args}) instanceof {test_result}) {{"

        out += f"console.log(\"Test '{node.name}' passed.\"); return true;}}"
        out += f"else {{"
        out += f"console.log(\"Test '{node.name}' FAILED.\"); console.log(res); return false;}}"
        out += f"}});"

        return f"{function_code} {out}"

    def FunctionDef(self, node):

        decorators = set()

        for d in node.decorator_list:
            if isinstance(d, AST.Name):
                decorators.add(d.id)
            elif isinstance(d, AST.Call):
                decorators.add(d.func.id)

        if "nocompile" in decorators:
            return " "
        elif any(d in ["Equals", "Is", "IsInstance"] for d in decorators):
            return self.TestFunctionDef(node)

        # Check if global call is present
        for n in node.body:
            if isinstance(n, AST.Global):
                self.in_global = True

        # Check if recursive FunctionDef
        for n in node.body:
            if isinstance(n, AST.FunctionDef):
                self.recur_FunctionDef.append(0)

        body = "; ".join([self.transform(node) for node in node.body]) + ";"
        name = node.name

        # For class constructors
        if name == "__init__" and self.es6_classes:
            if node.args.args[0].arg == "self":
                args = self.arguments(node.args, 1)
            out = " constructor(" + args + ") {"
            if self.base_class:
                out += " super(); "
            out += " var self = this; "  # quick hack
            out += body.replace("var ", "") + "};"
            return out
        elif name == "__init__":
            # Noop for non-es6 classes.
            # Body is retrieved in ClassDef.
            return " "
        elif name == "source":
            body = "return ts.buf.slice(start, end);"

        # Only parse args
        args = self.transform(node.args)

        out = " function "

        out += name + "(" + args + ") { " + body + "};"

        if len(self.recur_FunctionDef) == 0:
            self.in_global = False

        if len(self.recur_FunctionDef) > 0:
            self.recur_FunctionDef.pop()

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
        target = targets[0]
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
                    if self.in_class or (self.in_global and (px in self.global_vars)):
                        return " " + px + " = " + py + ";"
                    else:
                        return " var " + px + " = " + py + ";"

            px = self.transform(x)

            # Used in class constructors (prefix 'this.')
            if self.name_prefix:
                # Don't prefix 'self.'!
                if px[:5] != "self.":
                    px = self.name_prefix + px
                elif px[:5] == "self.":
                    px = self.name_prefix + px[5:]

            if isinstance(targets[0], AST.Attribute):
                return " " + px + " = " + py + ";"
            else:
                if self.in_class or (self.in_global and (px in self.global_vars)):
                    return " " + px + " = " + py + ";"
                else:
                    return " var " + px + " = " + py + ";"

        def define_tuples(target, value):
            # These should be the same length
            left = target.elts
            right = value.elts
            out = ""
            if len(right) > 0:  # a, b = foo, bar
                for i in range(len(left)):
                    out += define(left[i], right[i])
            else:  # a, b = ()    (or [])
                for i in range(len(left)):
                    out += define(left[i], value)
            return out

        # Handle 'a, b = foo, bar'
        if isinstance(target, AST.Tuple) and (
            isinstance(value, AST.Tuple) or isinstance(value, AST.List)
        ):
            out = define_tuples(target, value)
        else:
            out = define(target, value)

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

        # Don't compile if __name__ == "__main__" expressions
        if (
            isinstance(node.test, AST.Compare)
            and isinstance(node.test.left, AST.Name)
            and node.test.left.id == "__name__"
        ):
            return " "

        test = self.transform(node.test)  # Compare, BoolOp
        body = "; ".join([self.transform(node) for node in node.body]) + ";"
        orelse = node.orelse
        out = " if(" + test + ") {" + body

        if orelse != []:
            out += "} else {"
            out += "; ".join([self.transform(node) for node in orelse]) + "};"
        else:
            out += "};"
        return out

    def Compare(self, node):
        def compare(op, l, r):
            if isinstance(op, AST.Is) or isinstance(op, AST.IsNot):
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
            and comparators[0].func.id == "py_tokenset"
        ):
            # [3,79,42].indexOf(x) >= 0
            args = ",".join(self.transform(i) for i in comparators[0].args)
            left = self.transform(left)
            out = f"[{args}].indexOf({left}) >= 0"
        # Special case 'if foo is (not) absent'
        elif (
            len(comparators) == 1
            and len(ops) == 1
            and (isinstance(ops[0], AST.Is) or isinstance(ops[0], AST.IsNot))
            and (
                (isinstance(comparators[0], AST.Name) and comparators[0].id == "absent")
                or (
                    isinstance(comparators[0], AST.NameConstant)
                    and comparators[0].value == "absent"
                )
            )
        ):
            # isEmpty is provided by the runtime
            left = self.transform(left)
            if isinstance(ops[0], AST.IsNot):
                # out = f"!isEmpty({left})"
                out = f"!({left} === absent)"
            else:
                # out = f"isEmpty({left})"
                out = f"({left} === absent)"
            return out
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
    def Is(node):
        return "Object.is("

    @staticmethod
    def IsNot(node):
        return "!Object.is("

    def Subscript(self, node):
        value = self.transform(node.value)
        _slice = self.transform(node.slice)

        if (
            isinstance(node.slice, AST.Index)
            and isinstance(node.slice.value, AST.UnaryOp)
            and isinstance(node.slice.value.op, AST.USub)
        ):
            return value + ".slice(" + _slice + ")[0]"

        if isinstance(node.slice, AST.Slice):
            return value + ".slice(" + _slice + ")"

        return value + "[" + _slice + "]"

    def Slice(self, node):
        lower = self.transform(node.lower)
        upper = self.transform(node.upper)
        step = self.transform(node.step)  # ignored

        # Cast "\"None\"" to None (output from Name node)
        if lower == "\"None\"":
            lower = None

        if upper == "\"None\"":
            upper = None

        if step == "\"None\"":
            step = None

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
        if len(node.elts) == 0:
            return "[]"
        else:
            elts = ", ".join([self.transform(e) for e in node.elts])
            return f"[{elts}]"

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
        body = "; ".join([self.transform(node) for node in node.body]) + ";"
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

        out = " for (const " + gs + " of " + _iter + ") {" + body + "};"

        return out

    def ClassDef(self, node):
        # ('name', 'bases', 'keywords', 'body', 'decorator_list')

        # Handle inheritance
        if len(node.bases) > 1:
            raise Exception
        elif len(node.bases) == 1:
            self.base_class = self.transform(node.bases[0])

        # javascript strict mode requires special handling of
        # 'eval' and 'arguments' identifiers
        name = node.name
        if name == "arguments":
            name = "aarguments"

        self.in_class = True

        # store class name for future reference when instantiating
        self.classes.add(name)

        if self.es6_classes:
            body = "; ".join([self.transform(node) for node in node.body]) + ";"
            if self.base_class:
                out = f"class {name} extends {self.base_class} {{ {body} }}"
            else:
                out = f"class {name} {{ {body} }}"
        else:
            # First, look for __init__:
            __init__ = self.find_class_init(node.body)

            # Get the body of the constructor
            if __init__:
                self.name_prefix = "this."
                constructor_body = (
                    "; ".join([self.transform(node) for node in __init__.body]) + ";"
                )
                self.name_prefix = False

                # Get the constructor arguments:
                if __init__.args.args[0].arg == "self":
                    constructor_args = self.arguments(__init__.args, 1)
                else:
                    constructor_args = self.transform(__init__.args)

                out = f"function {name} ({constructor_args}) {{ {constructor_body}"
            else:
                out = f"function {name} () {{ var self = this;"

            # Add all class variables to constructor
            self.name_prefix = "this."
            class_vars = "; ".join(
                [self.transform(n) for n in node.body if isinstance(n, AST.Assign)]
            )
            out += f" {class_vars} }};"
            self.name_prefix = False

            # Add all methods to the prototype
            for n in node.body:
                if isinstance(n, AST.FunctionDef):
                    if n.name == "__init__":
                        pass
                    else:

                        _body = "; ".join([self.transform(node) for node in n.body]) + ";"
                        _name = n.name

                        # Skip zeroth 'self' argument
                        if n.args.args[0].arg == "self":
                            _args = self.arguments(n.args, 1)

                        out += f"{name}.prototype.{_name} = function ({_args})"
                        out += f"{{ {_body} }};"

            # Handle inheritance
            if self.base_class:
                out += f"{name}.prototype = Object.create({self.base_class}.prototype);"
                out += f"{name}.prototype.constructor = {name};"

        self.in_class = False
        self.base_class = False

        return out

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
        body = "; ".join([self.transform(node) for node in node.body]) + ";"
        # not easily mapped
        # orelse = '; '.join([self.transform(node) for node in node.orelse])

        return " while (" + test + ") {" + body + "};"

    def NameConstant(self, node):
        val = node.value
        if val is True:
            return "true"
        elif val is False:
            return "false"
        elif val is None:
            return "undefined"
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
        return "<="

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
        # return "{};"
        return "/* pass */"

    def ImportFrom(self, node):
        # if node.module in self.imports:
        #     return " "

        # Handling of 'from x import *'
        # Since everything is top-level, we can jut prepend all the code
        # i.e. recursively compile:
        module = node.module
        if module in ["sys", "argparse", "_runtime"]:
            return " "

        self.imports.add(node.module)
        module_file = self.rootdir + "/" + module + ".py"

        with open(module_file, "r") as f:
            source = f.read()

        module_code = self.transform(AST.parse(source))
        module_code = re.sub(r"(;)\1+", r"\1", module_code)

        return module_code

    def Global(self, node):
        # assume a noop, onus on programmer + "use strict";
        for n in node.names:
            self.global_vars.add(n)
        return ""

    def Import(self, node):
        imports = [
            self._alias(n) if isinstance(n, AST.alias) else self.transform(n)
            for n in node.names
        ]
        # Can return multiple imports 'import foo, bar, baz'
        modules = ""

        for module in imports:

            # import foo as FOO, see 'alias' node
            if isinstance(module, tuple):
                module, asname = module
            else:
                asname = module

            # Don't import some modules
            if module in ["sys", "argparse", "_runtime"]:
                return " "
            # And don't reimport them
            # elif module in self.imports:
            #     return " "

            module_code = f"var {asname} = (function () {{"
            self.imports.add(module)
            module_file = self.rootdir + "/" + module + ".py"

            with open(module_file, "r") as f:
                source = f.read()

            _ast = AST.parse(source)
            module_code += self.transform(_ast)
            module_code = re.sub(r"(;)\1+", r"\1", module_code)
            # Get all top-level definitions and export them
            ids = [self.get_identifier(n) for n in _ast.body]
            ids = [i for i in ids if i is not None]
            exports = "return {"
            for id in ids[:-1]:
                exports += f"{id}:{id},"
            exports += f"{ids[-1]}:{ids[-1]} }}"
            module_code += f"{exports} }})();"

            modules += module_code

        return modules

    def _alias(self, node):
        name = node.name
        asname = node.asname
        if asname:
            return (name, asname)
        else:
            return name

    def Tuple(self, node):
        elts = ",".join(self.transform(i) for i in node.elts)
        return f"[{elts}]"

    def UnaryOp(self, node):
        op = self.transform(node.op)
        operand = self.transform(node.operand)
        return f"({op}({operand}))"

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
        return "ELLIPSIS"

    def Raise(self, node):
        # We will limit ourselves to relatively simple exceptions.
        # We will take 'raise Exception(foo)' and turn it into
        # throw foo;
        if isinstance(node.exc, AST.Name):
            exc = self.transform(node.exc)
            return f"throw ({exc});"
        else:
            args = self.transform(node.exc.args)
            return f"throw ({args});"

    def Try(self, node):
        # ('body', 'handlers', 'orelse', 'finalbody')
        try_body = "; ".join([self.transform(node) for node in node.body]) + ";"
        catch_body = (
            "; ".join([self.transform(node) for node in node.handlers[0].body])
            + " console.log(err);"
        )
        out = f"try {{try_body}} catch(err){{catch_body}};"
        return out

    def Assert(self, node):
        # if (!cond) { throw msg; }
        test = self.transform(node.test)
        msg = self.transform(node.msg)
        return f"console.assert({test}, {msg});"
        # return f"if (!{test}) {{ throw ({msg}); }}"

    # def JoinedStr(self, node):
    #     print(node._lineno)
    #     raise Exception

    def Lambda(self, node):
        # args = ', '.join([self.transform(a) for a in node.args])
        args = self.transform(node.args)
        body = self.transform(node.body)
        return f"(function ({args}) {{ return ({body}); }})"

    @staticmethod
    def Div(node):
        return "/"

    @staticmethod
    def Mod(node):
        return "%"
