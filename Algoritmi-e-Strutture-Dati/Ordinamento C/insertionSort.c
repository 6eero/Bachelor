#include <stdlib.h>
#include <stdio.h>

void swap(int *, int, int);
void printArray(int *, int);
void inserionSort(int *);

int main() {
    int A[] = {34, 3, 4, 32, 56, 2, 9, 234, 97, 43, 11, 49};

    inserionSort(A);

    printArray(A, 12);
    
}

void inserionSort(int* A){

    int k, i;

    for (int j = 0; j <= 12; j++) {
        k = A[j];
        i = j - 1;
        while (i >= 0 && A[i] > k) {
            A[i+1] = A[i];
            i = i - 1;
        }
        A[i+1] = k;
    }
}

void printArray(int* a, int n) {
    for (int i = 0; i < n; i++) {
        printf("%d ", a[i]);
    }
}