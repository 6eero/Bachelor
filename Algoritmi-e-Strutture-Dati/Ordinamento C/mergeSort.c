#include <stdlib.h>
#include <stdio.h>

void swap(int *, int, int);
void printArray(int *, int);
void inserionSort(int *, int, int);
void merge(int *, int, int, int);

int main() {
    int A[] = {34, 3, 4, 32, 56, 2, 9, 234, 97, 43, 11, 49};

    inserionSort(A, 0, 11);

    printArray(A, 12);
    
}

void inserionSort(int* A, int p, int q){
    if (p < q) {
        int r = p + (q - p) / 2;
        inserionSort(A, p, r);
        inserionSort(A, r+1, q);
        merge(A, p, r, q);
    }
}

void merge(int arr[], int p, int q, int r) {
    int i, j, k;
    int leftLen = q - p + 1, rightLen = r - q;
    int leftArray[leftLen], rightArray[rightLen];
 
    // Copy data to temp arrays
    for (i = 0; i < leftLen; i++)
        leftArray[i] = arr[p + i];

    for (j = 0; j < rightLen; j++)
        rightArray[j] = arr[q + 1 + j];
 
    // Merge the temp arrays back into arr[]
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = p; // Initial index of merged subarray
    
    while (i < leftLen && j < rightLen) {
        if (leftArray[i] <= rightArray[j]) {
            arr[k] = leftArray[i];
            i++;
        }
        else {
            arr[k] = rightArray[j];
            j++;
        }
        k++;
    }
 
    /* Copy the remaining elements of L[], if there are any */
    while (i < leftLen) {
        arr[k] = leftArray[i];
        i++;
        k++;
    }
 
    /* Copy the remaining elements of R[], if there are any */
    while (j < rightLen) {
        arr[k] = rightArray[j];
        j++;
        k++;
    }
}

void printArray(int* a, int n) {
    for (int i = 0; i < n; i++) {
        printf("%d ", a[i]);
    }
}