#include <stdlib.h>
#include <stdio.h>

int parent(int);
int left(int);
int right(int);
void heapify(int[], int, int);
void buildHeap(int[], int);
void heapSort(int[], int);
void swap(int*, int*);
void printArray(int*, int);

void main() {
    
    int arr[] = {4, 10, 3, 5, 1};
    int N = sizeof(arr)/sizeof(arr[0]); 

    buildHeap(arr, N);
    heapSort(arr, N);

    printArray(arr, N);

}

int parent(int i) {return i/2;}
int left(int i) { return 2*i;}
int right(int i) {return 2*i+1;}

void heapify(int arr[], int N, int i) {

    int largest = i;
    int l = left(i);
    int r = right(i);

    if(l < N && arr[l] > arr[largest]){
        largest = l;
    }

    if(r < N && arr[r] > arr[largest]){
        largest = r;
    }

    if(largest != i) {
        swap(&arr[i], &arr[largest]);
        heapify(arr, N, largest);
    }
}

void buildHeap(int arr[], int N) {
    for (int i = N / 2 - 1; i >= 0; i--) {
        heapify(arr, N, i);
    }
}

void heapSort(int arr[], int N) {
    for (int i = N - 1; i >= 0; i--) {
        swap(&arr[0], &arr[i]);
        heapify(arr, i, 0);
    }
}

void swap(int* a, int* b) {
 
    int temp = *a;
    *a = *b;
    *b = temp;
}

void printArray(int* H, int n) {

    printf("\n");

    for (int i = 0; i <n; i++) {
        printf("%d ", H[i]);
    }
}