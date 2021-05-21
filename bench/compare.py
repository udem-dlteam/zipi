import argparse
import subprocess
import os

CSVLINE = "+!CSVLINE!+,"

def compute_ratio(left, right):
    try:
        return round(float(left) / float(right), 1)
    except ValueError:
        return float('nan')

def compute_ratios(results1, results2):
    lines1 = [line.split(',') for line in results1.split(CSVLINE) if line]
    lines2 = [line.split(',') for line in results2.split(CSVLINE) if line]

    result_table1 = {name.strip(): res.strip() for name, res in lines1}
    result_table2 = {name.strip(): res.strip() for name, res in lines2}

    ratios = {}

    for k in result_table1:
        ratios[k] = compute_ratio(result_table1[k], result_table2[k])

    return ratios

def print_ratios(system1, system2, results1, results2):
    name1 = os.path.basename(system1)
    name2 = os.path.basename(system2)

    ratios = compute_ratios(results1, results2)

    bench_column_title = "Benchmarks"
    bench_column_width = max(max(map(len, ratios)), len(bench_column_title)) + 1

    titles = f"{bench_column_title.center(bench_column_width)}| {name1}/{name2}"
    row_width = len(titles)

    def print_row(content):
        print("|" + content.ljust(row_width) + "|")

    print("+" + "="*row_width + "+")
    print_row(titles)
    print_row("="*bench_column_width + '+' + "="*(len(titles) - bench_column_width - 1))

    for k, v in ratios.items():
        print_row(f"{k.ljust(bench_column_width)}| {v}")

    print("+" + "="*row_width + "+")


def main(systems, filter=None):
    system1, system2 = systems

    print("executing benchmarks... this may take a while")
    stdout1 = subprocess.run(["make", "--no-print-directory", "run", f"system={system1}", f"filter={filter or ''}"], stdout=subprocess.PIPE, stderr=subprocess.PIPE).stdout.decode('utf-8')
    print(f"=== {system1} results ===")
    print(stdout1.replace(CSVLINE, ''))

    stdout2 = subprocess.run(["make", "--no-print-directory", "run", f"system={system2}", f"filter={filter or ''}"], stdout=subprocess.PIPE, stderr=subprocess.PIPE).stdout.decode('utf-8')
    print(f"=== {system2} results ===")
    print(stdout2.replace(CSVLINE, ''))

    print_ratios(system1, system2, stdout1, stdout2)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="compare zipi-benchamrks performance between systems")

    parser.add_argument('--systems', dest='systems', nargs=2, help="both systems to be compared (first/second)")
    parser.add_argument('--filter', dest='filter', nargs='?', const='', default='', help="pattern for benchmnarks to be executes")

    args = parser.parse_args()

    main(args.systems, args.filter)
