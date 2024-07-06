/*
Riconoscere, in un file di testo, le sequenze di caratteri che rappresentano un numero in uno dei seguenti formati:

- numero intero: stringa di cifre decimali, eventualmente precedute dal segno (+/-)
- numero frazionari: coppia di stringhe di cifre divise da un punto ed eventualmente precedute dal segno.
                     Una delle due stringe, ma non entrambe, può essere vuota.
- floating point: numero intero o frazionario, seguito da “e”, oppure “E”, seguito da un numero intero.

Per ciascuna sequenza riconosciuta, stampare in uscita: la sequenza stessa, il tipo di numero rappresentato, il numero di cifre usate nella rappresentazione.
*/

%{
    /* definizioni (opzionale) */
    #include <stdio.h>
    int intCount = 0;
    int fracCount = 0;
    int floatCount = 0;
%}

DIGIT           [0-9]
SIGN            [+-]
INTERO          {SIGN}?{DIGIT}+
FRAZIONARIO     {SIGN}?({DIGIT}+.|.{DIGIT}+|{DIGIT}+.{DIGIT}+)

/* regole */
%%
{INTERO}                              { printf("%s e' un numero intero lungo %d caratteri.\n", yytext, yyleng); intCount += yyleng; }
{FRAZIONARIO}                         { printf("%s e' un numero frazionario lungo %d caratteri.\n", yytext, yyleng); fracCount += yyleng; }
{FRAZIONARIO}?[eE]{SIGN}?{DIGIT}+     { printf("%s e' un numero Floating point lungo %d caratteri.\n", yytext, yyleng); floatCount += yyleng; }

\n                                    /* Ignora i caratteri di nuova riga */
[ \t]                                 /* Ignora gli spazi e le tabulazioni */
.                                     /* Ignora qualsiasi altro carattere */
%%

/* funzioni ausiliari (opzionale) */
yywrap() {}

int main(int argc, char** argv) {
    yyin = fopen(argv[1], "r");
    yylex();

    fclose(yyin);
    return 0;
}%
