%{
    /* definizioni (opzionale) */
    #include <stdio.h>
    #include "lex.yy.c"
%}

/* regole */
%%
[0-9]+                  { return NUMERIC_CONSTANT; }
=                       { return ASSIGN; }
\+=                     { return INCREMENT_ASSIGN; }
if                      { return IF; }
else                    { return ELSE; }
while                   { return WHILE; }
;                       { return SEMICOLON; }
\{                      { return LEFT_BRACE; }
\}                      { return RIGHT_BRACE; }
[a-z][a-zA-Z0-9_-]*     { return IDENTIFIER; }

[ \t\n]                 ;  // Ignora spazi, tabulazioni e nuove righe
.                       ;  // Ignora altri caratteri
%%

/* funzioni ausiliari (opzionale) */
yywrap() {return 1;}

int main(int argc, char** argv) {
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
    return 0;
}%
