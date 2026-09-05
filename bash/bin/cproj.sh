#!/bin/bash

# cproj - Minimal C/C++ project generator

if [[ $# -ne 2 ]]; then
    echo "Usage: cproj <c|cpp> <project>"
    exit 1
fi

lang="$1"
project="$2"

if [[ "$lang" != "c" && "$lang" != "cpp" ]]; then
    echo "Error: language must be 'c' or 'cpp'."
    exit 1
fi

if [[ -e "$project" ]]; then
    echo "Error: '$project' already exists."
    exit 1
fi

# Ask for a numbered choice
ask_choice() {
    local prompt="$1"
    local valid="$2"
    local answer

    while true; do
        echo "$prompt"
        read -r answer

        if [[ "$answer" =~ ^[$valid]$ ]]; then
            REPLY="$answer"
            return
        fi

        echo "Invalid choice. Try again."
    done
}

# Ask for yes/no
ask_yes_no() {
    local prompt="$1"
    local answer

    while true; do
        echo "$prompt"
        read -r answer

        case "$answer" in
            y|Y|"")
                REPLY="y"
                return
                ;;
            n|N)
                REPLY="n"
                return
                ;;
            *)
                echo "Invalid choice. Enter y or n."
                ;;
        esac
    done
}

ask_choice "Project type: [1] executable [2] library" "12"
type="$REPLY"

ask_choice "Build system: [1] make [2] cmake [3] none" "123"
build="$REPLY"

ask_yes_no "Create .gitignore? [Y/n]"
ignore="$REPLY"

ask_yes_no "Create README.md? [Y/n]"
readme="$REPLY"

ask_yes_no "Create MIT LICENSE? [Y/n]"
license="$REPLY"

ask_yes_no "Initialize git? [Y/n]"
git="$REPLY"

mkdir -p "$project/src" "$project/include"

if [[ "$lang" == "c" ]]; then
    ext="c"
else
    ext="cpp"
fi

# Source
if [[ "$type" == "1" ]]; then

    if [[ "$lang" == "c" ]]; then
        cat > "$project/src/main.c" <<'EOF'
#include <stdio.h>

int main(void)
{
    printf("Hello, world!\n");
    return 0;
}
EOF
    else
        cat > "$project/src/main.cpp" <<'EOF'
#include <iostream>

int main()
{
    std::cout << "Hello, world!\n";
    return 0;
}
EOF
    fi

else

    if [[ "$lang" == "c" ]]; then
        cat > "$project/include/$project.h" <<EOF
#ifndef ${project^^}_H
#define ${project^^}_H

void ${project}_hello(void);

#endif
EOF

        cat > "$project/src/$project.c" <<EOF
#include "$project.h"
#include <stdio.h>

void ${project}_hello(void)
{
    printf("Hello from $project!\\n");
}
EOF

    else
        cat > "$project/include/$project.hpp" <<EOF
#ifndef ${project^^}_HPP
#define ${project^^}_HPP

void ${project}_hello();

#endif
EOF

        cat > "$project/src/$project.cpp" <<EOF
#include "$project.hpp"
#include <iostream>

void ${project}_hello()
{
    std::cout << "Hello from $project!\\n";
}
EOF
    fi

fi

# .gitignore
if [[ "$ignore" == "y" ]]; then
    cat > "$project/.gitignore" <<'EOF'
build/
*.o
EOF
fi

# README
if [[ "$readme" == "y" ]]; then
    cat > "$project/README.md" <<EOF
# $project
EOF
fi

# MIT License
if [[ "$license" == "y" ]]; then
    cat > "$project/LICENSE" <<EOF
MIT License

Copyright (c) $(date +%Y) <COPYRIGHT HOLDER>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
fi

# Makefile
if [[ "$build" == "1" ]]; then

    if [[ "$lang" == "c" ]]; then
        compiler="gcc"
        flags="-Wall -Wextra -std=c17"
    else
        compiler="g++"
        flags="-Wall -Wextra -std=c++17"
    fi

    cat > "$project/Makefile" <<EOF
CC = $compiler
CFLAGS = $flags

TARGET = $project
SRC = \$(wildcard src/*.$ext)

all:
	mkdir -p build
	\$(CC) \$(CFLAGS) \$(SRC) -Iinclude -o build/\$(TARGET)

clean:
	rm -rf build
EOF

fi

# CMake
if [[ "$build" == "2" ]]; then

    if [[ "$lang" == "c" ]]; then
        standard="C"
    else
        standard="CXX"
    fi

    cat > "$project/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.10)

project($project)

set(CMAKE_${standard}_STANDARD 17)

file(GLOB SOURCES "src/*.$ext")

add_executable($project \${SOURCES})

target_include_directories($project PRIVATE include)
EOF

fi

# Git
if [[ "$git" == "y" ]]; then
    (
        cd "$project" || exit
        git init >/dev/null
    )
fi

echo
echo "Created '$project/'"
