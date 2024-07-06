/*
	Authors: Carpi Giulia, Gerotto Alessando, Marchiol Pietro, Mazzega Gabriele
	Date: 23/08/2022
	Project: Quick Select algorithm
*/

/*
	Best: 	 O(n)
	Average: O(n)
	Worst:   Θ(n^2)
*/

#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#define MAX_LINE_SIZE 10000   // maximum size of a line of input

int scanArray(int *);
int quickSelect(int *, int, int, int);
int partition(int *, int, int);
void swap(int *, int *);

int main() {

	int k, *array = malloc(MAX_LINE_SIZE * sizeof(int)), size;
	//char c;
	
	/*
	FUNZIONANTE SUI TEST ESEGUITI MANUALMENTE(SIA IN LOCALE CHE SU MOODLE), MA NON SU QUELLI ESEGUITI AUTOMATICAMENTE 
	do{
		scanf("%d", &array[read]);
		if(++read == size) {
			size *= 2;
			array = realloc(array, size * sizeof(int));
		}
		
	}while(c=getc(stdin) != '\n');
	*/
	
	size = scanArray(array);

	scanf("%d", &k);
	
	printf("%d\n", quickSelect(array, 0, size-1, k)); 
	
	free(array);

	return 0;
}

int quickSelect(int *array, int i, int j, int k) {
	
	//controllo se k e' effettivamente una posizione valida all'interno del vettore, altrimenti torno un valore non valido (INT_MIN)
	if(k > 0 && k <= j-i+1){
		//partiziono l'array ottendo la posizione dell'ultimo elemento se il vettore fosse ordinato
		int pivot = partition(array, i, j);
		
		
		//se la posizione trovata è la stessa di quella cercata ho terminato la ricerca, altrimenti in base al suo valore faccio una chiamata a dx o a sx del pivot
		if(pivot-i == k-1) {
			return array[pivot];
		}
		else if(pivot-i > k-1) {
			quickSelect(array, i, pivot-1, k);
		}
		else{
			quickSelect(array, pivot+1, j, k-pivot+i-1);
		}
	}
	else {
		return INT_MIN;
	}
}

/*
	La funzione ritorna l'indice della posizione che avrebbe il pivot scelto(per noi l'ultimo elemento del vettore) se il vettore fosse ordinato
*/
int partition(int *array, int l, int r){
	
	int pivot = array[r], i = l;
	
	for(int j=l; j<=r-1; j++) {
		if(array[j] <= pivot) {
			swap(&array[i], &array[j]);
			i++;
		}
	}
	swap(&array[i], &array[r]);
	return i;
}

void swap(int *x, int *y){
	
	int z = *x;
	*x = *y;
	*y = z;
}


int scanArray(int *a) {
    // scan line of text
    char line[MAX_LINE_SIZE];
    scanf("%[^\n]", line);

    // convert text into array
    int size = 0, offset = 0, numFilled, n;
    do {
    
        numFilled = sscanf(line + offset, "%d%n", &(a[size]), &n);
        if (numFilled > 0) {
            size++;
            offset += n;
        }
    } while (numFilled > 0);

    return size;
}

