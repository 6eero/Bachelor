/*
Ripetere l’esercizio 2 o 3 della Lezione 7, definendo però una
funzione is_whitespace() per controllare se un carattere è
di spazio bianco oppure no.
*/
  
#include <stdio.h>

int is_whitespace(int *str[100]){

    if (*str != ' ')
        return EOF;
    else 
        return 0;
}

int main() {

    int str, n, i;
    n=0;

    while((str=getchar())!=EOF) {
        
        if(!is_whitespace(str) && str!='\t' && str!='\n')
            n++;
        else {
            for(i=0; i<n; i++)
                printf("-");

            if(n>0)
                printf("\n");

            n=0;  // azzera n e aspetta un nuovo input
        }
    }
}