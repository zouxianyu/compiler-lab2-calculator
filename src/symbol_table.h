#ifndef CALCULATOR_SRC_SYMBOL_TABLE_H
#define CALCULATOR_SRC_SYMBOL_TABLE_H

#include <unordered_map>
#include <string>
#include <utility>
#include <any>
#include <optional>

class SymbolTable {
    std::unordered_map<std::string, std::any> map;
public:
    void insert(const std::string& name, const std::any& attributes);
    std::optional<std::any> lookup(const std::string& name);
    void showAll();
};

#endif //CALCULATOR_SRC_SYMBOL_TABLE_H
