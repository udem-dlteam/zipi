#!/usr/bin/env python3

import argparse, ast, datetime, logging, os, re

import templates

class History:
    save_header = "### zemantics save: "

    def __init__(self, _dirname = ".zemantics_history", _extension=".py", _save_prefix="zemantics_v"):
        self._dirname = _dirname
        self._save_prefix = _save_prefix
        self._extension = _extension

        if not os.path.exists(_dirname):
            os.mkdir(_dirname)
            self.save_version(Template())

    def __iter__(self):
        files = []

        for path, _, filenames in os.walk(self._dirname):
            for filename in filenames:
                if self.is_save_file(filename):
                    files.append(os.path.join(path, filename))

        return iter(sorted(files, key=os.path.basename))

    def __getitem__(self, index):
        return Version(list(self)[index])

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
        return max(map(lambda f: int(self.get_save_file_serial(f)), self), default=-1) + 1

    def save_version(self, version):
        if not isinstance(version, Version):
            return TypeError("save_version() requires a Version object, to save a file from path use save()")

        n = self.get_next_save_file_serial()
        filename = f"{self._save_prefix}{n}{self._extension}"
        save_path = os.path.join(self._dirname, filename)

        content = str(version)

        if content.startswith(self.save_header):
            content = content.split('\n', maxsplit=1)[1]

        content = f"{self.save_header}{filename} @ {datetime.datetime.now()}\n{content}"
        with open(save_path, 'x') as target:
            target.write(content)

    def save(self, path):
        self.save_version(Version(path))

    def update_template(self, path):
        version = Version(path)
        last_save = self[-1]

        with open(path, 'r') as f:
            content = f.read()

        # Sanity check to make sure we are not about to write on a non-semantics file
        if not "@define_semantics" in content:
            raise ValueError(f"'{path}'' does not look like a semantics file, no '@define_demantics'")

        # Save the file if any change was made
        # Remove the save header before comparison
        if str(version) != str(last_save).split('\n', 1)[1]:
            self.save_version(version)
        else:
            logging.info("File not saved before update due to no change since last save")

        new_version = Version.from_content(content).update_template()

        with open(path, 'w') as f:
            f.write(str(new_version))

    def get_history_list(self):
        descriptions = []
        for path in self:
            with open(path, 'r') as f:
                descriptions.append(f.readline().replace(self.save_header, '', 1).strip())
        return descriptions


class Version:
    def __init__(self, path=None):
        if path is not None:
            with open(path, 'r') as f:
                self.content = f.read()
        else:
            self.content = ""

    def __getattr__(self, attr):
        semantics = self._parse_semantics(attr)

        if semantics is None:
            raise AttributeError
        else:
            return semantics

    def __str__(self):
        return self.content

    def _parse_semantics(self, name):
        for sem in self._iter_semantics():
            if sem.name == name:
                return sem
        return None

    def _update_semantics_body(self, semantics, block):
        name = semantics.name

        body_start = f"# {name}:start-body"
        body_end = f"# {name}:end-body"

        lines = self.content.splitlines()

        body_lineno = next((i for i, line in enumerate(lines) if body_start in line), None)
        body_endlineno = next((i for i, line in enumerate(lines) if body_end in line), None)

        if body_lineno is None or body_endlineno is None:
            raise ValueError(f"semantics {self.name} does not have a body")

        block_lines = block.splitlines()

        lines[body_lineno + 1:body_endlineno] = block_lines
        self.content = '\n'.join(lines)

    def _iter_semantics(self):
        lines = self.content.splitlines()

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

                yield SemanticsParser(semantics_content, name, self, lineno, end_lineno)

    @classmethod
    def from_content(cls, content):
        version = cls()
        version.content = content
        return version

    def copy(self):
        return self.from_content(self.content)

    def update_template(self):
        template = Template()

        for semantics in self._iter_semantics():
            name = semantics.name
            template_semantics = getattr(template, name, None)

            if template_semantics is None:
                logging.warning(f"could not find semantics {name} in template")
            else:
                template_semantics.body = semantics.body

        return self.from_content(template.content)


class Template(Version):
    operations = templates.operations
    symbols = templates.symbols
    arithmetic_template = templates.arithmetic_template
    inplace_arithmetic_template = templates.inplace_arithmetic_template
    main_template = templates.main_template

    def __init__(self):
        self.content = self.init_template()

    def init_template(self):
        arithmetic_templates = [self.arithmetic_template.format(op=op, magic_method=magic_method,
                                                                symbol=self.symbols[op])
                                for op, magic_method in self.operations.items()]

        inplace_arithmetic_templates = [self.inplace_arithmetic_template.format(op=op, magic_method=magic_method,
                                                                                symbol=self.symbols[op])
                                        for op, magic_method in self.operations.items()]

        arithmetic_semantics = '\n\n'.join(arithmetic_templates + inplace_arithmetic_templates)

        semantics = self.main_template.format(arithmetic=arithmetic_semantics)

        return semantics

    def init_file(self, path):
        with open(path, 'x') as f:
            f.write(str(self))


class SemanticsParser:
    def __init__(self, content, name, version, lineno, end_lineno, _last=[None]):
        # To avoid conflicts, we allow only one live semantics parser at a time
        # We are not going to revinvent git today
        if _last[0] is not None:
            _last[0]._kill()
        _last[0] = self

        self.content = content
        self.name = name
        self.version = version
        self.lineno = lineno
        self.end_lineno = end_lineno

    def __str__(self):
        return self.content

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
        version = self.version

        if version is None:
            raise ValueError("SemanticsParser is not longer alive, version was updated")

        # This should call _kill
        version._update_semantics_body(self, block)

    def _kill(self):
        # Ensure this SemanticsParser can no longer update its Version
        self.version = None


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Manage Python semantics file")

    subparser = parser.add_subparsers(dest='command', required=True)

    # update command
    update_parser = subparser.add_parser('update', description="Update a semantics file from template")
    update_parser.add_argument('path')

    # save command
    save_parser = subparser.add_parser('save', description="Save a semantics file in history")
    save_parser.add_argument('path')

    # save command
    init_parser = subparser.add_parser('init', description="Initialize a semantics file from templates")
    init_parser.add_argument('path')

    # list command
    list_parser = subparser.add_parser('list', description="Print a list of previous semantics version")

    args = parser.parse_args()

    command = args.command

    if command == 'save':
        path = args.path
        History().save(path)
    elif command == 'update':
        path = args.path
        History().update_template(path)
    elif command == 'init':
        path = args.path
        Template().init_file(path)
    elif command == 'list':
        for description in History().get_history_list():
            print(description)
