#include <stdio.h>

void main(){
    int x, y;

    while (scanf("%d %*d %d %*d", &x, &y) != EOF) {
        printf("%d %d\n", x, y);
    }
}