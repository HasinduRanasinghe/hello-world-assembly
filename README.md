# Hello World in Assembly (x86-64 NASM)

This repository contains simple "Hello, World!" programs written in x86-64 assembly language using NASM for both **Linux** and **Windows** operating systems.

## Prerequisites

### Windows
- **NASM** ([Download](https://www.nasm.us/))
- **MinGW-w64** ([Download](https://www.mingw-w64.org/))
- **Install MinGW and add it to your system PATH**

### Linux
- **NASM**: Install via package manager
  - Debian/Ubuntu: `sudo apt install nasm`
  - Fedora/RHEL: `sudo dnf install nasm`
- **GCC**: Install via package manager
  - Debian/Ubuntu: `sudo apt install gcc`
  - Fedora/RHEL: `sudo dnf install gcc`

## Compilation and Execution

### Windows
1. Assemble and link the code:
   ```
   nasm -f win64 hello_win.asm -o hello_win.obj
   gcc hello_win.obj -o hello_win.exe -lkernel32 -luser32
   ```
2. Run the program:
   ```
   hello_win.exe
   ```

### Linux
1. Assemble and link the code:
   ```
   nasm -f elf64 hello_linux.asm -o hello_linux.o
   gcc hello_linux.o -o hello_linux -no-pie
   ```
2. Run the program:
   ```
   ./hello_linux
   ```

## Explanation

### Windows
- Creates a GUI application that displays a message box
- Calls the Windows API `MessageBoxA` to display `"Hello, World!"` in a dialog box
- Uses Windows x64 calling convention (fastcall)
- Exits using `ExitProcess`

### Linux
- Creates a console application that prints to stdout
- Uses the C library function `printf` to display `"Hello, World!"`
- Follows System V AMD64 ABI calling convention
- Exits using the C library function `exit`

## Key Differences Between Platforms

| Feature | Windows | Linux |
|---------|---------|-------|
| Output | GUI message box | Console text |
| Calling Convention | Windows x64 (RCX, RDX, R8, R9) | System V AMD64 (RDI, RSI, RDX, RCX, R8, R9) |
| Shadow Space | Required (32+ bytes) | Not required |
| System Libraries | Windows API (user32.dll, kernel32.dll) | C library (libc) or direct syscalls |
| Object Format | PE (Portable Executable) | ELF (Executable and Linkable Format) |

## Repository Structure

- `hello_win.asm` - Windows assembly source code
- `hello_linux.asm` - Linux assembly source code
- `README.md` - This main README file
- `README_WINDOWS.md` - Detailed Windows-specific readme
- `README_LINUX.md` - Detailed Linux-specific readme

For detailed explanations of each implementation, please refer to the platform-specific README files.
