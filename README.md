# Hello World in Assembly (x86-64 NASM)

This repository contains simple "Hello, World!" programs written in x86-64 assembly language using NASM for both **Linux** and **Windows**.


## Prerequisites

### Windows

- **NASM**
- **MinGW-w64**
- **Install MinGW and add it to your system PATH**


## Compilation and Execution

1. Assemble and link the code:
   
   `nasm -f win64 hello_win.asm -o hello_win.obj`

   `gcc hello_win.obj -o hello_win.exe -lkernel32 -luser32`

2. Run the program

   `hello_win.exe`


## Explanation

### Windows

- Calls the Windows API `MessageBoxA` to display `"Hello, World!"` in a dialog box.
- Exits using `ExitProcess`.
  
