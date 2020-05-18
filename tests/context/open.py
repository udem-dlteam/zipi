# Make the script read and print itself
with open("test.txt") as f:
    print(f.read())

def read_fun():
    # Do the same from within function
    with open("test.txt") as f:
        print(f.read())

read_fun()
