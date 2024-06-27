/*
Scrivete tre programmi che utilizzino le funzioni scritte qui
sopra per invertire/ordinare/ecc... una sequenza di numeri
interi letti da standard input. 
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
    printf("\n\nAlgoritmo : ");
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
  printf("\n\nAlgoritmo ordinato: ");
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
  
  printf("\n\nAlgoritmo ordinato ricorsivamente: ");
}

// Function to print contents of an array
void print(int arr[], int dim) {

  printf("\n\n");

    for (int i = 0; i < dim; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n\n");
}

// Function to create an array
void inserimento (int *array, int dim) {

  for (int i = 0; i < dim; i++){
    printf("\nInserisci un intero da inserire nella posizione %d dell'array: ", i);
    scanf("%d", &array[i]);
  }
}

int main() {

  int dim = 5;
  int array[SIZE] = {};
 
  inserimento(array, dim);
  //reverse(array, dim);
  sort(array, dim);
  //qsort(array, dim);
  print(array, dim);
 
  return 0;
}