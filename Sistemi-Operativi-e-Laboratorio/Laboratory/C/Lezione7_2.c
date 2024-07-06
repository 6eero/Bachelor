/*
Scrivere un programma C che conti il numero di spazi, tab e
newline (whitespace characters) presenti nei caratteri immessi
sullo standard input.
*/

#include <stdio.h>
int main() {

    int c, tab, spazi, newline;
    tab=0; spazi=0; newline=0;

    while((c=getchar())!=EOF) {
        switch(c) {
            case ' ':
                spazi++;
                break;
            case '\t':
                tab++;
                break;
            case '\n':
                newline++;
            break;
        }
    }
printf("Spazi: %d\nTabulazioni: %d\nNewline: %d\n",spazi,tab,newline);
}