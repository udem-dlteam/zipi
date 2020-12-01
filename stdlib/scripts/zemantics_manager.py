import ast, os, re, datetime

class History:
    def __init__(self, _dirname = ".zemantics_history", _extension=".py", _save_prefix="zemantics_v"):
        self._dirname = _dirname
        self._save_prefix = _save_prefix
        self._extension = _extension

        if not os.path.exists(_dirname):
            os.mkdir(_dirname)

    def __iter__(self):
        files = []

        for path, _, filenames in os.walk(self._dirname):
            for filename in filenames:
                if self.is_save_file(filename):
                    files.append(os.path.join(path, filename))

        return iter(sorted(files, key=os.path.basename))

    def __getitem__(self, index):
        return list(self)[index]

    def is_save_file(self, path):
        filename = os.path.basename(path)
        return filename.startswith(self._save_prefix) and filename.endswith(self._extension)

    def get_save_file_serial(self, path):
        if self.is_save_file(path):
            filename = os.path.basename(path)
            return filename[len(self._save_prefix):-len(self._extension)]
        else:
            raise ValueError("not a valid zemantics save file name")


    def get_next_save_file_serial(self):
        return max(map(lambda f: int(self.get_save_file_serial(f)), self), default=0) + 1

    def save(self, version):
        n = self.get_next_save_file_serial()
        filename = f"{self._save_prefix}{n}{self._extension}"
        save_path = os.path.join(self._dirname, filename)

        save_header = "### zemantics save"
        content = str(version)

        if content.startswith(save_header):
            content = content.split('\n', maxsplit=1)[1]

        content = f"{save_header}: {filename} @ {datetime.datetime.now()}\n{content}"
        with open(save_path, 'x') as target:
            target.write(content)


class Version:
    def __init__(self, path):
        with open(path, 'r') as f:
            self.path = path
            self.content = f.read()

        self._parse()

    def __getattr__(self, attr):
        semantics = self.semantics.get(attr)

        if semantics is None:
            raise AttributeError
        else:
            return semantics

    def _parse(self):
        lines = self.content.splitlines()
        self.semantics = {}

        file_ast = ast.parse(self.content)

        for stmt in file_ast.body:
            if isinstance(stmt, ast.FunctionDef):
                decs = stmt.decorator_list
                lineno = decs[0].lineno if decs else stmt.lineno

                # include trailing comments in the body if it is indented
                end_lineno = tmp_end_lineno = stmt.end_lineno
                for l in lines[end_lineno:]:
                    tmp_end_lineno += 1
                    if l.startswith("  " * 2):
                        if "#" in l:
                            end_lineno = tmp_end_lineno
                    else:
                        break

                name = stmt.name
                semantics_content = "\n".join(lines[lineno - 1:end_lineno])

                self.semantics[name] = SemanticsParser(semantics_content, name, lineno, end_lineno)

    def __str__(self):
        return self.content


class SemanticsParser:
    def __init__(self, content, name, lineno, end_lineno):
        self.content = content
        self.name = name
        self.lineno = lineno
        self.end_lineno = end_lineno

    def __str__(self):
        return self.content

    def replace(self, semantics):
        lines = semantics.splitlines()
        new_lines = lines[:self.lineno] + self.content.splitlines() + lines[end_lineno + 1:]
        return "\n".join(new_lines)

    def get_body_linenos(self):
        lines = self.content.splitlines()
        body_start = f"# {self.name}:start-body"
        body_end = f"# {self.name}:end-body"

        body_lineno = next((i for i, line in enumerate(lines) if body_start in line), None)
        body_endlineno = next((i for i, line in enumerate(lines) if body_end in line), None)

        if body_lineno is None or body_endlineno is None:
            raise ValueError(f"semantics {self.name} does not have a body")
        else:
            return body_lineno + 1, body_endlineno

    @property
    def body(self):
        body_lineno, body_endlineno = self.get_body_linenos()

        lines = self.content.splitlines()
        return '\n'.join(lines[body_lineno:body_endlineno])

    @body.setter
    def body(self, block):
        body_lineno, body_endlineno = self.get_body_linenos()

        lines = self.content.splitlines()
        lines[body_lineno:body_endlineno] = block.splitlines()

        self.content = '\n'.join(lines)


if __name__ == "__main__":
    v = Version("../zemantics.py")

    print(v.add.body)
    v.add.body = "foo"
    print(v.add.body)
    print(v.add)
