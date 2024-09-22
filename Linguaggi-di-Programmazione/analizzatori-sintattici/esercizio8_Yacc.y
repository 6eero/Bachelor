%{
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    char* type;
    struct Node* left;
    struct Node* right;
} Node;

Node* newNode(char* type, Node* left, Node* right) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->type = type;
    node->left = left;
    node->right = right;
    return node;
}

void yyerror(const char* s);
int yylex();
%}

%union {
    char* s;  // Stringa per identificatori e tipi
    int i;    // Interi per numeri
}

%token <s> IDENTIFIER
%token <i> NUMBER
%token PLUS MINUS MULTIPLY EQUAL LET CASE
%type <s> expression let_expression case_expression

%%

// Regole grammaticali
program:
    | program expression
    ;

expression:
      IDENTIFIER                        { $$ = newNode($1, NULL, NULL); }
    | NUMBER                            { $$ = newNode("number", NULL, NULL); }
    | expression PLUS expression        { $$ = newNode("plus", $1, $3); }
    | expression MINUS expression       { $$ = newNode("minus", $1, $3); }
    | expression MULTIPLY expression    { $$ = newNode("multiply", $1, $3); }
    | EQUAL expression expression       { $$ = newNode("equal", $2, $3); }
    | let_expression
    | case_expression
    ;

let_expression:
    LET IDENTIFIER expression { $$ = newNode("let", newNode($2, NULL, NULL), $3); }
    ;

case_expression:
    CASE expression { $$ = newNode("case", $2, NULL); }
    ;
%%

void yyerror(const char* s) {
    fprintf(stderr, "Errore: %s\n", s);
}

int main() {
    return yyparse();
}
