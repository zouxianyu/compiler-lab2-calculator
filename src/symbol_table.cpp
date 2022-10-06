#include <optional>
#include <iostream>
#include "symbol_table.h"

void SymbolTable::insert(const std::string &name, const std::any& attributes) {
    map.insert({name, attributes});
}

std::optional<std::any> SymbolTable::lookup(const std::string &name) {
    auto item = map.find(name);
    if (item == map.end()) {
        return std::nullopt;
    }
    return item->second;
}

void SymbolTable::showAll() {
    for (const auto &item: map) {
        std::cout << item.first << " = " << std::any_cast<double>(item.second) << std::endl;
    }
}
