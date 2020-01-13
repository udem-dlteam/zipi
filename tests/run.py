import os
import re
import argparse
import subprocess

ZIPI_CODE_TARGET = './.tmp_zipi_output.scm'

bcolors = {
    'FAIL': '\033[91m',
    'OKGREEN': '\033[92m',
    'ENDC': '\033[0m'
}


def colored(text, color_code):
    return f'{bcolors[color_code]}{text}{bcolors["ENDC"]}'


def clean_name(name):
    return re.sub('\.py|\.|\/', '', name)


def collect_tests(pattern):
    tests = {}

    for root, dirs, files in os.walk(os.curdir):
        if root == '.':
            continue

        for file in files:
            if not file.endswith('.py') or pattern and not re.match(pattern, file):
                continue
            else:
                if root in tests:
                    tests[root].append(file)
                else:
                    tests[root] = [file]

    return tests


def run_one_test(path, cpython, zipi, scheme):
    cpython_output = subprocess.run([cpython, path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    zipi_output = subprocess.run([*zipi.split(), path], stdout=subprocess.PIPE)

    with open(ZIPI_CODE_TARGET, 'w') as file:
        file.write(zipi_output.stdout.decode())

    scheme_output = subprocess.run([*scheme.split(), ZIPI_CODE_TARGET], stdout=subprocess.PIPE)

    if cpython_output.returncode == 0:
        return cpython_output.stdout == scheme_output.stdout
    else:
        cpython_error = cpython_output.stderr.decode().strip().rsplit('\n', 1)[-1]
        zipi_error = scheme_output.stdout.decode().strip().rsplit('\n', 1)[-1]
        return cpython_error == zipi_error


def run_all(cpython='python3', zipi='../etc/py19 -t gambit', scheme='gsi ../pyc/', pattern=None):
    test_files = collect_tests(pattern)
    n_tests = sum(len(tests) for tests in test_files.values())

    print(f"=== Zipi tests ({n_tests} tests) ===")

    for folder, folder_tests in test_files.items():
        print(f' - {clean_name(folder)} ({len(folder_tests)} tests)')

        for file in folder_tests:
            path = os.path.join(folder, file)
            success = run_one_test(path, cpython, zipi, scheme)
            status = colored('SUCCESS', 'OKGREEN') if success else colored('FAIL', 'FAIL')

            print(f'     {clean_name(file)}: {"." * (45 - len(file))} {status}')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run the Zipi test suite against cPython")

    parser.add_argument("--cpython", help="specify cPython interpreter")
    parser.add_argument("--zipi", help="specify Zipi compiler")
    parser.add_argument("--scheme", help="specify Scheme interpreter")
    parser.add_argument("--pattern", help="run tests for files matching the given pattern")

    args = {k: v for k, v in vars(parser.parse_args()).items() if v is not None}

    run_all(**args)
