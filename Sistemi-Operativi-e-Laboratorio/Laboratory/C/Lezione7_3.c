/*
Scrivere un programma C che stampi un istogramma
orizzontale (utilizzando il carattere ’-’) raffigurante le
lunghezze delle parole (delimitate da whitespace characters)
immesse sullo standard input (parola per parola).
*/
  
#include <stdio.h>

int main() {

    int str, n, i;
    n=0;

    while((str=getchar())!=EOF) {
        
        if(str!=' ' && str!='\t' && str!='\n')
            n++;
        else {
            for(i=0; i<n; i++)
                printf("-");

            if(n>0)
                printf("\n");

            n=0;                   // azzera n e aspetta un nuovo input
        }
    }
}