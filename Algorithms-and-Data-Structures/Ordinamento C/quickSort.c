#include <stdlib.h>
#include <stdio.h>

void swap(int *, int, int);
void printArray(int *, int);
void quickSort(int *, int, int);
int partition(int *, int, int);

int main() {
    int A[] = {34, 3, 4, 32, 56, 2, 9, 234, 97, 43, 11, 49};

    quickSort(A, 0, 11);

    printArray(A, 12);
    
}

void quickSort(int* A, int p, int q){
    if (p < q) {
        int r = partition(A, p, q);
        quickSort(A, p, r-1);
        quickSort(A, r+1, q);
    }
}

int partition(int* A, int p, int q){
    int pivot = A[q];
    int i = p - 1;
    for (int j = p; j <= q; j++) {
        if (A[j] <= pivot) {
            i++;
            swap(A, i, j);
        }
    }
    return i;
}

void swap(int *A, int a, int b) {
	int temp;
	
	temp = A[a];
	A[a] = A[b];
	A[b] = temp;
}

void printArray(int* a, int n) {
    for (int i = 0; i < n; i++) {
        printf("%d ", a[i]);
    }
}