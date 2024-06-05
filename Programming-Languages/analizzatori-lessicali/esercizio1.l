/*
Utilizzando Flex realizzare un analizzatore lessicale che risolva il problema:

Riconoscere in un file di testo le seguenti classi di lessemi

- parole chiave: var, function, procedure, while, do, if then, else, for
- identificatori: stringhe che iniziano con una lettere minuscola dell’alfabeto
  seguite da lettere, cifre, e i simboli ’_‘,’-’.
- costanti numeriche: sequenze di cifre,
- operatori: “+”, “++”, “-”, “–”, “=”, “==”,
*/

%{
    /* definizioni (opzionale) */
    #include <stdio.h>
    int idenifierCount = 0;
    int keywordCount = 0;
%}

/* regole */
%%
var         { printf("var\n"); keywordCount++;}
function    { printf("function\n"); keywordCount++;}
procedure   { printf("procedure\n"); keywordCount++;}
while       { printf("while\n"); keywordCount++;}
do          { printf("do\n"); keywordCount++;}
if          { printf("if\n"); keywordCount++;}
then        { printf("then\n"); keywordCount++;}
else        { printf("else\n"); keywordCount++;}
for         { printf("for\n"); keywordCount++;}

[a-z][a-zA-Z0-9_-]*     { printf("%s e' un identificatore\n", yytext); idenifierCount++;}
[0-9]+                  { printf("%s e' una sequenza di cifre\n", yytext); }

"+"         { printf("piu\n"); }
"++"        { printf("piu piu\n"); }
"-"         { printf("meno\n"); }
"--"        { printf("meno meno\n"); }
"="         { printf("uguale\n"); }
"=="        { printf("uguale uguale\n"); }

[;\(\)\{\}]     { /* Ignora i ;, le () e le { } */ }
[ \t\n]         { /* Ignora gli spazi, tabulazioni e newline */ }

%%

/* funzioni ausiliari (opzionale) */
yywrap() {}

int main(int argc, char** argv) {
    yyin = fopen(argv[1], "r");
    yylex();
    printf("\n\nci sono %d identificatori e %d keywords\n", idenifierCount, keywordCount);

    fclose(yyin);
    return 0;
}%    
