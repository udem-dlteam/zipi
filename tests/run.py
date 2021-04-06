import os
import time
import re
import argparse
import subprocess
import multiprocessing
import signal
import collections

# Console color codes
bcolors = {
    'RED': '\033[91m',
    'GREEN': '\033[92m',
    'YELLOW': '\033[93m',
    'ENDC': '\033[0m'
}

# Tests results
class Status:
    def __init__(self, *messages):
        self.messages = messages

class OK(Status):
    priority = 0

    @staticmethod
    def status_repr():
        return colored('OK', 'GREEN')

    @staticmethod
    def is_success():
        return True

class MinorFail(Status):
    priority = 1

    @staticmethod
    def status_repr():
        return colored('MINOR', 'YELLOW')

    @staticmethod
    def is_success():
        return True

class MajorFail(Status):
    priority = 2

    @staticmethod
    def status_repr():
        return colored('MAJOR', 'RED')

    @staticmethod
    def is_success():
        return False

class CriticalFail(Status):
    priority = 3

    @staticmethod
    def status_repr():
        return colored('CRITICAL', 'RED')

    @staticmethod
    def is_success():
        return False


def colored(text, color):
    """
    Wraps the given 'text' with the color code corresponding to the given 'color'
    """
    return f'{bcolors[color]}{text}{bcolors["ENDC"]}'


def clean_name(name):
    """
    Clean a file or path name by removing .py, / and .
    """
    return re.sub('\.py$|^\.|^\/', '', name)

def file_matches_pattern(filename, rootname, pattern):
    return re.match(pattern, filename) or re.findall(pattern, rootname)


def collect_tests(pattern):
    """
    Traverse the current folder and recover all files except run.py
    Return a dict which keys are folders and values list of files in these folders
    """
    tests = {}

    for root, dirs, files in os.walk(os.curdir):
        if root == '.':
            continue

        for file in files:
            if not file.endswith('.py') or pattern and not file_matches_pattern(file, root, pattern):
                continue
            else:
                if root in tests:
                    tests[root].append(file)
                else:
                    tests[root] = [file]

    return tests


def run_one_test(path, cpython, zipi):
    """
    Run a single test a 'path' using the given commands to run 'cpython' and 'zipi
    Return True of the test succeeded and False of it failed

    To determine if a test succeeds, compare the stdout from cpython to the one from the scheme execution
    if cpython returns an error code 1, then compare the last line of stderr from cpython to the last line from scheme.
    We do this because full traceback will likely never be exactly identical between cpython and zipi
    """
    cpython_output = subprocess.run([cpython, path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    scheme_output = subprocess.run([*zipi.split(), path], stdout=subprocess.PIPE)

    scheme_stdout = scheme_output.stdout
    cpython_stdout = cpython_output.stdout

    if scheme_output.returncode == -signal.SIGSEGV:
        return CriticalFail('Segmentation fault')
    elif cpython_output.returncode == 0:
        if cpython_stdout == scheme_stdout:
            return OK()
        else:
            return MajorFail('Incorrect result or unexpected exception')
    else:
        cpython_error = cpython_output.stderr.decode().strip().rsplit('\n', 1)[-1]
        zipi_error = scheme_stdout.decode().strip().rsplit('\n', 1)[-1]

        if cpython_error == zipi_error:
            return OK()
        elif cpython_error.split(":")[0] == zipi_error.split(":")[0]:
            return MinorFail(
                        f'(cPython) {cpython_error}',
                        f'(zipi)    {zipi_error}')
        else:
            return MajorFail('Incorrect exception raised or no exception raised')


def process_file(file, folder, cpython, zipi):
    """
    Wrapper to run the test at [folder]/[file] from a subprocess
    """
    try:
        path = os.path.join(folder, file)
        status = run_one_test(path, cpython, zipi)

        print(f'     {clean_name(file)}: {"." * (45 - len(file))} {status.status_repr()}')
        for msg in status.messages:
            print(f'       {msg}')

        return status
    except KeyboardInterrupt:
        print(colored(f"KeyboardInterrupt in test {folder}/{file}", "RED"))
        raise


def run_all(cpython='python3', zipi='../bin/zipi', pattern=None):
    """
    Collects all tests and runs them in parallel with multiprocessing using the given commands to run 'cpython' and 'zipi'
    A 'pattern' can be provided, which will run only tests matching the pattern with re.match
    """
    print("Resetting module cache... ")
    os.system(zipi+" -X reset")

    start = time.time()

    test_files = collect_tests(pattern)
    n_tests = sum(len(tests) for tests in test_files.values())
    results = collections.defaultdict(int)

    print(f"=== Zipi tests ({n_tests} tests) ===")

    for folder, folder_tests in test_files.items():
        print(f' - {clean_name(folder)} ({len(folder_tests)} tests)')

        for folder_test in folder_tests:
            result = process_file(folder_test, folder, cpython, zipi)
            results[type(result)] += 1

    total_time = time.time() - start

    print()
    print('-' * 55)
    print(f'Ran {n_tests} tests in {total_time:.1f}s:')

    for status, n in sorted(results.items(), key=lambda s: s[0].priority):
        print(f'  {status.status_repr()}: {n}')



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run the Zipi test suite against cPython")

    parser.add_argument("--cpython", help="specify cPython interpreter")
    parser.add_argument("--zipi", help="specify Zipi compile-and-exec script")
    parser.add_argument("--pattern", help="run tests for files matching the given pattern")

    args = {k: v for k, v in vars(parser.parse_args()).items() if v is not None}

    run_all(**args)
