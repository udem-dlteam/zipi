import os
import time
import re
import argparse
import subprocess
import multiprocessing

# Console color codes
bcolors = {
    'FAIL': '\033[91m',
    'OKGREEN': '\033[92m',
    'ENDC': '\033[0m'
}


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


def run_one_test(path, cpython, zipi, tmp_output_file):
    """
    Run a single test a 'path' using the given commands to run 'cpython', 'zipi' and 'scheme'
    Use the 'tmp_output_file' as file name to store the compiled code from zipi
    Return True of the test succeeded and False of it failed

    To determine if a test succeeds, compare the stdout from cpython to the one from the scheme execution
    if cpython returns an error code 1, then compare the last line of stderr from cpython to the last line from scheme.
    We do this because full traceback will likely never be exactly identical between cpython and zipi
    """
    cpython_output = subprocess.run([cpython, path], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)

    zipi_output = subprocess.run([*zipi.split(), path], stdout=subprocess.PIPE)


    if cpython_output.returncode == 0:
        return cpython_output.stdout == zipi_output.stdout
    else:
        cpython_error = ""
        if cpython_output.stderr is not None:
            cpython_error = cpython_output.stderr.decode().strip().rsplit('\n', 1)[-1]
        zipi_error = ""
        if zipi_output.stderr is not None :
            zipi_error = zipi_output.stderr.decode().strip().rsplit('\n', 1)[-1]
        return cpython_error == zipi_error


def process_file(file, folder, cpython, zipi, shared_lst):
    """
    Wrapper to run the test at [folder]/[file] from a subprocess
    """
    tmp_output_file = f'./.tmp_zipi_output{multiprocessing.current_process().pid}.scm~'
    path = os.path.join(folder, file)
    success = run_one_test(path, cpython, zipi, tmp_output_file)
    status = colored('OK', 'OKGREEN') if success else colored('FAIL', 'FAIL')

    print(f'     {clean_name(file)}: {"." * (45 - len(file))} {status}')

    shared_lst.append(success)


def run_all(cpython='python3', zipi='../etc/py19 -t gambit', pattern=None):
    """
    Collects all tests and runs them in parallel with multiprocessing using the given commands to run 'cpython',
    'zipi' and 'scheme'.
    A 'pattern' can be provided, which will run only tests matching the pattern with re.match
    """
    start = time.time()

    test_files = collect_tests(pattern)
    n_tests = sum(len(tests) for tests in test_files.values())
    n_success = 0

    print(f"=== Zipi tests ({n_tests} tests) ===")

    for folder, folder_tests in test_files.items():
        print(f' - {clean_name(folder)} ({len(folder_tests)} tests)')

        with multiprocessing.Pool(4) as p:
            shared_lst = multiprocessing.Manager().list()
            p.starmap(process_file,
                      ((folder_test, folder, cpython, zipi, shared_lst) for folder_test in folder_tests))

        n_success += sum(shared_lst)

    total_time = time.time() - start

    print()
    print('-' * 55)
    print(f'Ran {n_tests} tests in {total_time:.1f}s  -  Passed: {n_success}  -  Failed: {n_tests - n_success}')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run the Zipi test suite against cPython")

    parser.add_argument("--cpython", help="specify cPython interpreter")
    parser.add_argument("--zipi", help="specify Zipi compiler")
    parser.add_argument("--pattern", help="run tests for files matching the given pattern")

    args = {k: v for k, v in vars(parser.parse_args()).items() if v is not None}

    run_all(**args)
