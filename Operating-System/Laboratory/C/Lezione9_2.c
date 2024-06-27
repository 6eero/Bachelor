/*
Scrivere le seguenti funzioni che manipolino un array passato
come argomento (nei modi visti):

- Una funzione reverse() per invertire l’ordine degli elementi in
  un array.

- Una funzione sort() per ordinare un array di numeri interi
  (riutilizzare quanto scritto per l’esercizio 3 della Lezione 8).

- Scrivere una funzione qsort() che implementi un algoritmo di
  ordinamento in maniera ricorsiva. 
*/

#include <stdio.h>
#define SIZE 100

// Function to reverse contents of an array
void reverse(int *array, int dim) {
  
  int temp;

    for(int i = 0; i < dim/2; i++) {
        temp = array[i];
        array[i] = array[dim-i-1];
        array[dim-i-1] = temp;
    }
}

// Function to order contents of an array
void sort(int *array, int dim){

  int i, key, j;

  for (i = 1; i < dim; i++) {
    key = array[i];
    j = i - 1;
 
    while (j >= 0 && array[j] > key) {

      array[j + 1] = array[j];
      j = j - 1;
    }

    array[j + 1] = key;
  }
}

// Function to recursive order contents of an array
void qsort(int *array, int dim){

  if (dim <= 1) {
    return;
  }

  qsort(array, dim-1);

  int key = array[dim-1];
  int j = dim-2;

   while (j >= 0 && array[j] > key){
      array[j+1] = array[j];
      j--;
   }

   array[j+1] = key;
  
}

// Function to print contents of an array
void print(int arr[], int dim)
{
    for (int i = 0; i < dim; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n\n");
}

int main() {

    int array[SIZE] = {34, 21, 78, 43, 32};
    int dim = 5;
 
    reverse(array, dim);
    printf("The reversed array is: ");
    print(array, dim);

    sort(array, dim);
    printf("The sorted array is: ");
    print(array, dim);

    qsort(array, dim);
    printf("The qsorted array is: ");
    print(array, dim);
 
    return 0;
}