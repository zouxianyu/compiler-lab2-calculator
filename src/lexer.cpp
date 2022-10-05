#include <optional>
#include <string>
#include <regex>
#include <utility>
#include "lexer.h"

// because we cannot declare an enum here
// so just include the parser header file
#include "parser.h"

inline static std::regex getRegex(const std::string &regex) {
    // remove all prefix whitespace
    std::string fullRegex{R"(^\s*)" + regex};
    return std::regex{fullRegex};
}

static std::pair<int, std::regex> tokenArray[]{
        {NUMBER, getRegex(R"((\d+(:?\.\d+)?))")},
        {PLUS,   getRegex(R"((\+))")},
        {MINUS,  getRegex(R"((-))")},
        {TIMES,  getRegex(R"((\*))")},
        {DIVIDE, getRegex(R"((\/))")},
        {LPAREN, getRegex(R"((\())")},
        {RPAREN, getRegex(R"((\)))")},
};

std::optional<std::pair<int, std::string>> Lexer::getToken() {
    for (const auto &pair: tokenArray) {
        std::smatch match;
        if (std::regex_search(rest, match, pair.second)) {
            // use deep copy here because match[1] is a reference
            // of the original string
            const std::string &matchStr = match.str(1);
            std::string copy{matchStr.c_str(), matchStr.length()};
            rest = match.suffix();
            return std::make_pair(pair.first, copy);
        }
    }
    return std::nullopt;
}

