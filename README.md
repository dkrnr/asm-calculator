# Simple Calculator
A simple calculator using assembly (**nasm**), this is just a project to get a hold of assembly

## Currently Supports...
multi-digit calculations via two numbers for the following operators
- ### Addition  

## How to run
### in this repo
If u are using linux, u just install nasm and run
```bash
./run_asm.sh
```
This script basically runts the standard running procedure (mentioned below) for linux
### standard methods
- Linux:
```bash
nasm -f elf64 mycode.asm -o mycode.o # make likeable object
ld mycode.o -o mycode # make likeable object to linux binary(?)
./mycode # execute
```
- Windows (not checked): 
```batch
nasm -f win64 mycode.asm -o mycode.obj
gcc mycode.obj -o mycode.exe
./mycode.exe
```
- macOS (not checked):
```zsh
nasm -f macho64 mycode.asm -o mycode.o
gcc mycode.o -o mycode
./mycode
```
