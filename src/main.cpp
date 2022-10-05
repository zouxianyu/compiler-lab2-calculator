#include <iostream>
#include "parser.h"

// get the result from the parser will extern the global variable
// and write to it in every AST node
std::string result;

int main() {
    int yyresult = yyparse();
    std::cout << result << std::endl;
    return yyresult;
}
