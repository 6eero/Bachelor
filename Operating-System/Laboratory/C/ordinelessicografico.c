#include <stdio.h>
#include <string.h>

int main (int argc, char **argv) {

    char *temp;
    
    if (argc < 2) {
        printf("Too few arguments!\n");
        return 1;

    } else if (argc == 2) {
        printf("%s\n", argv[1]);
        return 0;
    }

    for (int i=1; i<=argc-1; i++) {
        for (int j=i+1; j<argc; j++) {

            if (strcasecmp(argv[i], argv[j]) > 0){
                temp = argv[i];
                argv[i] = argv[j];
                argv[j] = temp;
            }
        }
    }
    printf ( "\nIn lexicographical order: \n" );

    for (int i = 1; i < argc; i++) {
        puts(argv[i]);
    }

    return 0;
}
