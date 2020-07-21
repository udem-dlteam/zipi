import subprocess

class Collector():
    def __init__(self):
        self.PASS = []
        self.FAIL = []
        self.compile_error = []
        self.import_error = []
        self.attribute_error = []
        self.other_error = []

    def print(self):
        print("\n==== RESULTS ====")
        attr_names = ["PASS", "FAIL", "compile_error", "import_error", "attribute_error", "other_error"]
        for attr_name in attr_names:
            print("\n---", attr_name, "---")
            attr = getattr(self, attr_name)
            for arr in attr:
                print(arr[0]," ", arr[-1])
            if len(attr) == 0:
                print("No entry")

        print("\n==== STATISTICS ====\n")
        for attr_name in attr_names:
            print(attr_name, len(getattr(self, attr_name)))




def run_test(test, collector):
    try:
        result = subprocess.check_output("$ZIPIROOT/zpc/run-zipi "+test +" & wait $!", shell = True)
    except Exception as e:
        collector.compile_error.append([test, e, ""])
        return "Compiling error"

    result = result.decode("utf-8")
    last_line = result.split("\n")[-2]
    if result.startswith("ModuleNotFound"):
        collector.import_error.append([test, result, last_line])
        return "Raised "+last_line
    elif result.startswith("AttributeError"):
        collector.attribute_error.append([test, result, ""])
        return "Raised AttributeError"
    elif last_line.startswith("PASS"):
        collector.PASS.append([test, result, last_line])
        return last_line
    elif last_line.startswith("FAIL"):
        collector.FAIL.append([test, result, last_line])
        return last_line
    else:
        collector.other_error.append([test, result, last_line])
        return "Unnexpected Error" + last_line


def get_test():
    try:
        files = subprocess.check_output("echo test_suite/test_*", shell=True)
    except Exception as e:
        print("error thrown : ", e)
        exit()

    return files.decode("utf8").replace("\n", "").split(" ")

def clear_cache():
    try:
        subprocess.check_output("$ZIPIROOT/zpc/run-zipi --clear-cache", shell=True)
    except Exception as e:
        print("Cannot clear zipi cache")
        print("Make sure ZIPICACHE environnement variable is set correctly")
        print("Error thrown :", e)
        exit()

if __name__ == "__main__":
    tests = get_test()
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

    collector.print()



