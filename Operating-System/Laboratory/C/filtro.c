#include <stdio.h>
#define SIZE 150

int main(int argc, char **argv) {

    char str[SIZE], ch;
    int i = 0;
/*
    if (argc != 2) {
        printf("Invalid arguments");
        return 1;
    }
*/
    FILE *file;
    file = fopen("test.txt", "r");

    if (file == NULL) {
        printf("FIle can't be opened");
        return 2;
    }

   while (str[i] != EOF){
        fscanf(file, "%c", &str[i]);
        if (str[i]=='d')
            printf("%c", str[i]); 
        i++;
    }
}