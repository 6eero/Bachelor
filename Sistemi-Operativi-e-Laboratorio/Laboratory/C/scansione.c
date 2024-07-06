#include <stdio.h>

void main(){
    int a, b;

    while (scanf("%d %d", &a, &b)==2) {        
	    printf("%d\n", a-b);
    }
}