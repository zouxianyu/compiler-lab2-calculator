#ifndef SIMPLE_LEXER_LEXER_H
#define SIMPLE_LEXER_LEXER_H

#include <optional>
#include <string>
#include <utility>

class Lexer {
    std::string rest;
public:
    explicit Lexer(std::string input) : rest(input) {}

    std::optional<std::pair<int, std::string>> getToken();
};

#endif //SIMPLE_LEXER_LEXER_H
