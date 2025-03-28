import sys

def fib(n, a=0, b=1):
    if n == 0:
        return a
    if n == 1:
        return b
    return fib(n - 1, b, a + b)

def main():
    n = int(sys.argv[1])
    print(fib(n))

if __name__ == "__main__":
    main()