/*
Scrivere un programma che legga dallo standard input dei
numeri e ne stampi la somma totale.
*/

#include <stdio.h>

int main() {

    int x, y, z = 0;

    printf("Inserisci tre numeri interi:\n");
    scanf("%d%d%d", &x, &y, &z);

    printf("La somma dei numeri inseriti è %d\n\n", x+y+z);
}