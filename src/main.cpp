#include <iostream>
#include "parser.h"
#include "symbol_table.h"

// get the result from the parser will extern the global variable
// and write to it in every AST node

extern SymbolTable idSymTable;

int main() {
    int yyresult = yyparse();
    idSymTable.showAll();
    return yyresult;
}
