
#include <stdio.h>
#include <stdlib.h>

typedef unsigned long long int lli;

lli fib(lli n){
    if(n < 2ull)
        return n;
    else
        return fib(n - 1ull) + fib(n - 2ull);
}

int main(int argc, char** argv){
    lli n = (lli) atoi(argv[1]);
    printf("%llu", fib(n));
}