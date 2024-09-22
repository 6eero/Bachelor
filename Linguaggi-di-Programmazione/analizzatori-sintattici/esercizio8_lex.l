%{
#include "y.tab.h"
%}

%%
[a-zA-Z_][a-zA-Z0-9_]*    { yylval.s = strdup(yytext); return IDENTIFIER; }

[0-9]+                    { yylval.i = atoi(yytext); return NUMBER; }

"+"                       { return PLUS; }
"-"                       { return MINUS; }
"*"                       { return MULTIPLY; }
"="                       { return EQUAL; }

"let"                     { return LET; }
"case"                    { return CASE; }

[ \t\n]+                  { /* Ignora */ }
";.*"                     { /* Ignora commenti */ }
.                         { fprintf(stderr, "Carattere non riconosciuto: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}
