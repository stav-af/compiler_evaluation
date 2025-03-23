import sys

def catalan(n):
    if n == 0:
        return 1
    return catalan_sum(n, 0)

def catalan_sum(n, i):
    if i == n:
        return 0
    return catalan(i) * catalan(n - 1 - i) + catalan_sum(n, i + 1)

if __name__ == "__main__":
    n = int(sys.argv[1])
    print(catalan(n))