%{
/****************************************************************************
parser.y
ParserWizard generated YACC file.

Date: 2022年10月5日
****************************************************************************/
#include <iostream>
#include <string>
#include "lexer.h"
#ifndef YYSTYPE
#define YYSTYPE std::string
#endif
int yylex();
extern int yyparse();
void yyerror(const char* s);
extern std::string result;
%}

/////////////////////////////////////////////////////////////////////////////
// declarations section

// place any declarations here

%token NUMBER
%token PLUS
%token MINUS
%token TIMES
%token DIVIDE
%token LPAREN
%token RPAREN
%token IDENTIFIER

%left PLUS MINUS
%left TIMES DIVIDE
%right UMINUS

%%

/////////////////////////////////////////////////////////////////////////////
// rules section

// place your YACC rules here (there must be at least one)

expr : expr PLUS expr          { result = $$ = $1 + " " + $3 + " " + "+"; }
     | expr MINUS expr         { result = $$ = $1 + " " + $3 + " " + "-"; }
     | expr TIMES expr         { result = $$ = $1 + " " + $3 + " " + "*"; }
     | expr DIVIDE expr        { result = $$ = $1 + " " + $3 + " " + "/"; }
     | LPAREN expr RPAREN      { result = $$ = $2; }
//     | MINUS expr %prec UMINUS { result = $$ = -$2; } // do not support unary minus here
     | NUMBER	               { result = $$ = $1; }
     | IDENTIFIER              { result = $$ = $1; }
     ;

%%

/////////////////////////////////////////////////////////////////////////////
// programs section

int yylex() {
    static std::string s(std::istreambuf_iterator(std::cin), {});
//    static Lexer lexer{"1+2-3*4/5+(1+2)"};
    static Lexer lexer{s};
    if (auto token = lexer.getToken()) {
	yylval = token->second;
	return token->first;
    }
    return YYEOF;
}

void yyerror(const char* s) {
    // fprintf(stderr, "Parse Error: %s\n", s);
    std::cerr << "Parse Error: " << s << std::endl;
    std::exit(1);
}