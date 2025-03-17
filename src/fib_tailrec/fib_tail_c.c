#include <stdio.h>
#include <stdlib.h>

typedef unsigned long long int lli;

lli fib_helper(lli n, lli a, lli b) {
    if (n == 0) return a;
    if (n == 1) return b;
    return fib_helper(n - 1, b, a + b);
}

lli fib(lli n) {
    return fib_helper(n, 0, 1);
}

int main(int argc, char** argv) {
    lli n = (lli) atoi(argv[1]);
    printf("%llu\n", fib(n));
    return 0;
}