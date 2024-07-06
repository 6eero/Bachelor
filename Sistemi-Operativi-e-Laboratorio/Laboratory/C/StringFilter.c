/*Scrivere il codice di un programma C che prenda come argomento sulla linea di
comando il percorso di un file di testo e stampi a video il suo contenuto, applicando
il seguente filtro: devono essere rimossi dal testo tutti i caratteri eccetto le
lettere dell’alfabeto (maiuscole e minuscole). Si gestiscano inoltre gli eventuali
errori (numero di argomenti errato, file non leggibile, ecc.).*/

// to execute: gcc StringFilter.c -o StringFilter && ./StringFilter file.txt

#include <stdio.h>
#define SIZE 150

int filter(char *line) {
    int i, j;

    for(i = 0; line[i] != '\0'; ++i) {

        while (!( (line[i] >= 'a' && line[i] <= 'z') ||
                  (line[i] >= 'A' && line[i] <= 'Z') ||
                  (line[i] == '\0')
                )) {

            for(j = i; line[j] != '\0'; ++j) {
                line[j] = line[j+1];
            }
            line[j] = '\0';
        }
    }
    puts(line);
}

int main(int argc, char **argv) {

    char line[SIZE];

    if (argc < 2) {
        printf("Missing argument!\n");
        return 1;

    } else if (argc > 2) {
        printf("Too much arguments!\n");
        return 2;

    }
        
    FILE *textfile;
    textfile = fopen(argv[1], "r");

    while (fgets(line, SIZE, textfile) != NULL) {
        filter(line);
    }
        
    fclose(textfile);
    return 0;
}