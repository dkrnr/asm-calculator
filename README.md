# Simple Calculator
A simple calculator using assembly, this is just a project to get a hold of assembly

## How to run
```
nasm -f elf64 hello.asm -o hello.o 	# make assembly file
ld hello.o -o hello 			# make executable(?)
./hello 				# execute
```
- Windows (not checked): 
```bash
nasm -f win64 mycode.asm -o mycode.obj
gcc mycode.obj -o mycode.exe
```
- Linux:
```batch
nasm -f elf64 mycode.asm -o mycode.o
ld mycode.o -o mycode
```
- macOS (not checked):
```bash
nasm -f macho64 mycode.asm -o mycode.o
gcc mycode.o -o mycode
```
