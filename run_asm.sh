#!/bin/bash

# One line for compiling and running
nasm -f elf64 main.asm -o main.o && ld main.o -o main && ./main

rm -rf main.o main
