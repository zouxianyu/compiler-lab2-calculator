cmake_minimum_required(VERSION 3.22)
project(calculator)

set(CMAKE_CXX_STANDARD 17)

# bison target
find_package(BISON)
bison_target(Parser src/parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp
        DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/parser.h)

# compiler target
include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(src)
add_executable(calculator
        src/main.cpp
        src/lexer.cpp
        src/symbol_table.cpp
        ${BISON_Parser_OUTPUTS})

