/*
Scrivere un programma C che conti il numero di parole
immesse sullo standard input (si considerino come delimitatori
di parola i whitespace characters).
*/

#include <stdio.h>

int main() {

    int str;
    int n = 1;

    while((str=getchar())!=EOF) {
        
        if (str == ' ' || str == '\t')
            n = n + 1;

        if (str == '\n') {
            printf("\nNumero di parole: %d\n\n------------\n", n);
            n = 0;
        }

    }
    
}