// Max-Heap data structure in C

#include <stdlib.h>
#include <stdio.h>
#include <limits.h>


int main() {

  int size = 10, len = 0;
  int *array = malloc(size * sizeof(int));

  char c;
	
	do{
		scanf("%d", &array[len]);
		if(++len == size) {
			size *= 2;
			array = realloc(array, size * sizeof(int));
		}
		
	}while(c=getc(stdin) != '\n');

  //for(int i=0 ; i<read ; i++)
  printf("%d ", len) ;


  return 0;
}