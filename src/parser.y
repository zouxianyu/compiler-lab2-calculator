%{
/****************************************************************************
parser.y
ParserWizard generated YACC file.

Date: 2022年10月5日
****************************************************************************/
#include <iostream>
#include <string>
#include <any>
#include "lexer.h"
#include "symbol_table.h"
#ifndef YYSTYPE
#define YYSTYPE std::any
#endif
int yylex();
extern int yyparse();
void yyerror(const char* s);

SymbolTable idSymTable;
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
%token ASSIGN
%token SIMICOLON

%left PLUS MINUS
%left TIMES DIVIDE
%right UMINUS

%%

/////////////////////////////////////////////////////////////////////////////
// rules section

// place your YACC rules here (there must be at least one)

program : program assign_stmt
	  | assign_stmt
	  ;

assign_stmt : IDENTIFIER ASSIGN expr SIMICOLON {
		  idSymTable.insert(std::any_cast<std::string>($1), std::any_cast<double>($3));
	      }
	    ;

expr : expr PLUS expr          { $$ = std::any_cast<double>($1) + std::any_cast<double>($3); }
     | expr MINUS expr         { $$ = std::any_cast<double>($1) - std::any_cast<double>($3); }
     | expr TIMES expr         { $$ = std::any_cast<double>($1) * std::any_cast<double>($3); }
     | expr DIVIDE expr        { $$ = std::any_cast<double>($1) / std::any_cast<double>($3); }
     | LPAREN expr RPAREN      { $$ = std::any_cast<double>($2); }
     | MINUS expr %prec UMINUS { $$ = -std::any_cast<double>($2); }
     | NUMBER	               { $$ = std::any_cast<double>($1); }
     | IDENTIFIER              {
                                 auto idName = std::any_cast<std::string>($1);
				 auto attribute = idSymTable.lookup(idName);
				 double value = 0.0;
				 if (!attribute) {
				     std::cerr << "Error: " << idName << " is not defined" << std::endl;
				 } else {
				     value = std::any_cast<double>(*attribute);
				 }
				 $$ = value;
			       }
     ;



%%

/////////////////////////////////////////////////////////////////////////////
// programs section

int yylex() {
    static std::string s(std::istreambuf_iterator(std::cin), {});
//    static Lexer lexer{"1+2-3*4/5+(1+2)"};
    static Lexer lexer{s};
    if (auto token = lexer.getToken()) {
        int type = token->first;
	switch (type) {
	case NUMBER:
	    yylval = std::stod(token->second);
	    break;
	case IDENTIFIER:
	    yylval = token->second;
	    break;
	}
	return type;
    }
    return YYEOF;
}

void yyerror(const char* s) {
    std::cerr << "Parse Error: " << s << std::endl;
    std::exit(1);
}