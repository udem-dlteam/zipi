import subprocess
import argparse
import sys
from sys import stdout
import time
from time import sleep
import os

parser = argparse.ArgumentParser(description="Run cpython tests and collect information about the tests")
parser.add_argument('files', metavar="FILES", type=str, nargs="+", help="Path of the test files")
parser.add_argument('-c', '--complete', action="store_true", help="Show a complete report of the errors")
parser.add_argument('-zipi', '--path-zipi-executable', type=str, default="$ZIPIROOT/bin/zipi.gambit")
parser.add_argument('-zpc', '--path-zpc-executable', type=str, default="$ZIPIROOT/bin/zpc.gambit")
parser.add_argument('-t', "--timeout", type=str, default="5m", help="time each unittest has to compile. Otherwise, it will get terminated (using builtin timeout command)")

args = parser.parse_args()

bcolors = {
    'RED': '\033[91m',
    'GREEN': '\033[92m',
    'YELLOW': '\033[93m',
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



class Status():
    def __init__(self, short, long):
        self.short = short
        self.long = long


class OK(Status):
    priority = 0

    def __init__(self):
        pass

    def status_repr(self, complete = False):
        return colored('OK', 'GREEN')

    @staticmethod
    def is_success():
        return True

class AssertionFail(Status):
    priority = 3

    def status_repr(self, complete = False):
        if complete:
            return colored(self.long, 'YELLOW')
        else:
            return colored(self.short, 'YELLOW')

    @staticmethod
    def is_success():
        return False

class RuntimeFail(Status):
    priority = 1

    def status_repr(self, complete = False):
        if complete:
            return colored(self.long, 'RED')
        else:
            return colored(self.short, 'RED')

    @staticmethod
    def is_success():
        return False

class InitializationFail(Status):
    priority = 2

    def status_repr(self, complete = False):
        if complete:
            return colored(self.long.strip(), 'RED')
        else:
            return colored(self.short.strip(), 'RED')

    @staticmethod
    def is_success():
        return False

class TestSuite(Status):
    def __init__(self, sub_tests):
        self.sub_tests = sub_tests

    def status_repr(self, complete = False):
        if self.is_success():
            output = colored("OK\n", "GREEN")
        else:
            output = colored("FAIL\n", "YELLOW")


        for name, test in self.sub_tests.items():
            output += "   " + name + " : "+ test.status_repr(complete) + "\n"

        return output

    def is_success(self):
        for test in self.sub_tests.values():
            if not test.is_success():
                return False
        return True


class Collector():
    def __init__(self):
        self.test_suite_pass_count = 0
        self.test_suite_fail_count = 0
        self.test_pass_count = 0
        self.test_fail_count = 0
        self.initialization_fail_count = 0
        self.current_log = ""

        self.last_count = 0

    def print_status(self, status):
        final_line = "[{:s} ({:s}) | {:s} ({:s}) | {:s}] ".format(\
                colored(self.test_suite_pass_count, 'GREEN'),\
                colored(self.test_pass_count, "GREEN"), \
                colored(self.test_suite_fail_count, "YELLOW"), \
                colored(self.test_fail_count, "YELLOW"), \
                colored(self.initialization_fail_count, "RED"))

        # clear console
        print(chr(27) + "[2J")
        self.last_count = self.current_log.count("\n") + 2
        print(self.current_log + final_line + status, end = "", flush = True)


    def add_log(self, string):
        self.current_log += string + "\n"

dev_null = open(os.devnull, 'w')



def run_test_suite(col, test_suite):
    try:
        result = subprocess.check_output("timeout " + args.timeout + " " + args.path_zipi_executable+" "+ test_suite +" print_tests", shell = True, stderr=dev_null).decode("utf-8")
    except subprocess.CalledProcessError as e:
        error = "Compilation error"
        if(e.returncode == 124):
            error = "Compilation took more than " + args.timeout + " (exitcode=124)"
        return InitializationFail(error, error + "\n" + e.output.decode("utf-8"))
    except Exception as e:
        return InitializationFail("Compilation error 2", repr(e))

    lines = result.strip().split("\n")
    if lines[0] != "success":
        # probably an error with zpc... compilation error
        if lines[0].startswith(">") and lines[1].startswith("*** EOF again to exit"):
            result = "Compilation error\n" + result
            try:
                result_zpc = subprocess.check_output(args.path_zpc_executable+" "+ test_suite +" & wait $!", shell = True, stderr=dev_null).decode("utf-8")
            except subprocess.CalledProcessError as e:
                return InitializationFail("Compilation error", "Compilation error \n" + e.output.decode("utf-8"))
            if result_zpc.startswith("*** ERROR"):
                lines = result_zpc.strip().split("\n")
                result = "Error in ZPC\n" + result_zpc
        return InitializationFail(lines[0], result)
    else:
        all_tests = dict()
        for test in lines[1:]:
            col.print_status("Running " + test_suite + " - " + test + "...")
            test_status = run_test(col, test_suite, test)
            if test_status.is_success():
                col.test_pass_count += 1
            else:
                col.test_fail_count += 1
            all_tests[test] = test_status

        return TestSuite(all_tests)



def run_test(col, test, test_name):
    try:
        result = subprocess.check_output(args.path_zipi_executable + " " + test + " run_test " + test_name + "& wait $!", shell = True).decode("utf-8")
    except subprocess.CalledProcessError as e:
        return InitializationFail("Compilation Error", e.output.decode("utf-8"))
    except Exception as e:
        return InitializationFail("Compilation Error", repr(e))

    lines = result.strip().split("\n")
    last_line = lines[-1]

    if last_line.startswith("PASS"):
        status = OK()
    elif last_line.startswith("FAIL"):
        status = AssertionFail(lines[0], "\n".join(lines[0:-1]).strip())
    else:
        status = RuntimeFail(last_line, result)

    return status


def clear_cache():
    try:
        subprocess.check_output(args.path_zipi_executable+" -X reset", shell = True)
    except Exception as e:
        print("cannot clear cache, verify paths and environnement variable... exiting...")
        print(e)
        exit(1)

if __name__ == "__main__":
    tests = args.files
    if len(tests) == 0:
        print("0 test found... exiting")
        exit()

    col = Collector()

    col.print_status("Found %d tests" % len(tests))
    col.print_status("Clearing cache...")
    clear_cache()

    for test_suite in tests:
        #running test and displaying text
        col.print_status("Initializing " + test_suite + "...")

        test_suite_status = run_test_suite(col, test_suite)
        if(test_suite_status.is_success()):
            test_suite_pass_count += 1
        else:
            if type(test_suite_status) == InitializationFail:
                col.initialization_fail_count += 1
            else:
                col.test_suite_fail_count += 1
        col.add_log(f"{test_suite} : {test_suite_status.status_repr(args.complete)}")

    col.print_status("Tests finished")


