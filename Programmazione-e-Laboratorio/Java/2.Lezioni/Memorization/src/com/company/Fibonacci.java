package com.company;

/**
 *                             fib(5)
 *                        /                \
 *                  fib(4)                fib(3)
 *                /        \              /       \
 *            fib(3)      fib(2)         fib(2)   fib(1)
 *           /    \       /    \        /      \
 *     fib(2)   fib(1)  fib(1) fib(0) fib(1) fib(0)
 *     /     \
 *   fib(1) fib(0)
 *
 */

public class Fibonacci {

    public static int fib(int n){

        if (n <= 1)
            return n;
        else
            return fib(n-1) + fib(n-2);
    }

    public static int fibopt(int n){

        int[] f = new int[n+1];

        f[0] = 0;
        f[1] = 1;

        for (int i=2; i<=n; i++){

            f[i] = f[i-1] + f[i-2];
        }
        return f[n];
    }
}