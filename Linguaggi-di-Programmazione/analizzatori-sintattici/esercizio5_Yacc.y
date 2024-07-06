/* PROLOGO */
%{
#include "lex.yy.c"

void yyerror(const char *str) {
  fprintf(stderr,"errore: %s\n",str);
}

int yywrap() {return 1;}
int main() { yyparse();}
%}
/* DEFINIZIONI */
%token NUM
%left '-' '+'
%left '*' '/'
%left NEG /* meno unario */%
