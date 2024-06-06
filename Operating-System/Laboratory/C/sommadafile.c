#include <stdio.h>
#include <string.h>
#include <unistd.h>
#define SIZE 150

int main(int argc, char **argv) {
/*
    if (argc != 2) {
        printf("There is an error with the input\n");
        return 1;
    }
*/
    int num_op=0, i=0, pointer=0, add1=0, add2=0;
    char ch;
    int numberArray[SIZE];

    FILE *textfile;
    textfile=fopen("file.txt", "r");

    if (textfile == NULL) {
        printf("File can't be opened\n");
        return 2;
    }
/*
    // Count number of operators
    while (ch != EOF) {
        ch = fgetc(textfile);
        if ((ch == '\n')){
            num_op++; 
        }     
    }
    num_op=num_op*2;
 */ 

    for (i=0; i<12; i++){
        fscanf(textfile, "%d,'\n'", &numberArray[i]);
    }

    for (i=0; i<12; i++){
        printf("%d, ", numberArray[i]);
    }
    printf("\n\n");
    
    for (int i=0; i<12; i++) {
        add1=numberArray[i];
        add2=numberArray[++i];

        printf("%d + %d = %d\n", add1, add2, add1+add2);
    }

    fclose(textfile);
    return 0;
}