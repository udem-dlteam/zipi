# Make the script read and print itself
with open("open.py") as f:
    print(f.read())

def read_fun():
    # Do the same from within function
    with open("open.py") as f:
        print(f.read())
        
read_fun()
