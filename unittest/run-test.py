import subprocess
import argparse
import sys

parser = argparse.ArgumentParser(description="Run cpython tests and collect information about the tests")
parser.add_argument('files', metavar="FILES", type=str, nargs="+", help="Path of the test files")
parser.add_argument('-c', '--complete', action="store_true", help="Show a complete report of the errors")
parser.add_argument('-o', '--out', type=str, help="Write the report (complete or partial depending on the value of --complete) to the file FILE")
parser.add_argument('-z', '--path-zipi-executable', type=str, default="$ZIPIROOT/zpc/run-zipi", help="Write the report (complete or partial depending on the value of --complete) to the file FILE")

args = parser.parse_args()

class Collector():
    def __init__(self):
        self.attr_names = ["PASS", "FAIL", "compile_error", "import_error", "attribute_error", "other_error"]
        # initialize all attributes
        for attr_name in self.attr_names:
            self.__dict__[attr_name] = []


    def writeReport(self, stream, write_complete_report):
        if write_complete_report:
            stream.write("\n==== COMPLETE REPORT ====\n")
        else:
            stream.write("\n==== PARTIAL REPORT ====\n")

        for attr_name in self.attr_names:
            stream.write("\n--- " +  attr_name + " ---\n")
            attr = getattr(self, attr_name)
            for arr in attr:
                if write_complete_report:
                    stream.write(arr[0] +"\n")
                    stream.write("    " + arr[1].replace("\n", "\n    ")+ "\n")
                else:
                    stream.write(arr[0] + " " + arr[-1] + "\n")

            if len(attr) == 0:
                stream.write("No entry\n")

    def writeStatistics(self, stream, number_of_tests):
        stream.write("\n==== STATISTICS ====\n")
        stream.write("\nRan " + repr(number_of_tests) + " tests\n")
        for attr_name in self.attr_names:
            stream.write(attr_name + " : " +repr(len(getattr(self, attr_name))) +"\n")


def run_test(test, collector):
    try:
        result = subprocess.check_output(args.path_zipi_executable+" "+test +" & wait $!", shell = True)
    except Exception as e:
        collector.compile_error.append([test, repr(e), ""])
        return "Compiling error"

    result = result.decode("utf-8")
    last_line = result.split("\n")[-2]
    if result.startswith("ModuleNotFound"):
        collector.import_error.append([test, result, last_line])
        return "Raised "+last_line
    elif result.startswith("AttributeError"):
        collector.attribute_error.append([test, result, last_line])
        return "Raised "+last_line
    elif last_line.startswith("PASS"):
        collector.PASS.append([test, result, last_line])
        return last_line
    elif last_line.startswith("FAIL"):
        collector.FAIL.append([test, result, last_line])
        return last_line
    else:
        collector.other_error.append([test, result, last_line])
        return "Unnexpected Error" + last_line


def get_tests():
    return " ".join(args.files).split(" ")

def clear_cache():
    try:
        subprocess.check_output(args.path_zipi_executable + " --clear-cache", shell=True)
    except Exception as e:
        print("Cannot clear zipi cache")
        print("Make sure ZIPICACHE environnement variable is set correctly")
        print("Error thrown :", e)
        exit()

if __name__ == "__main__":
    tests = get_tests()
    if len(tests) == 0:
        print("0 tests found")
        exit()

    print("Found", len(tests), "tests")
    print("Clearing cache...")
    clear_cache()
    collector = Collector()

    print("Running tests...")
    for test in tests:
        #running test and displaying text
        print("Running", test, ":", run_test(test,collector))

    if args.out is not None:
        if args.complete:
            print("Writing complete report to " + args.out)
        else:
            print("Writing partial report to " + args.out)

        stream = open(args.out, "a")
        collector.writeStatistics(stream, len(tests))
        collector.writeReport(stream, args.complete)
        stream.close()
    else:
        collector.writeReport(sys.stdout, args.complete)
    collector.writeStatistics(sys.stdout, len(tests))



else:
    print("Not running as main")
    parser.help()



