# Hello World in Assembly (Linux x86-64 NASM)

This repository contains a simple **Linux console "Hello, World!"** program written in **x86-64 assembly** using NASM. The program prints "Hello, World!" to the standard output using the C library's `printf` function.

## **Code Explanation**

### **1. Data Section**
```assembly
section .data
    message db "Hello, World!", 10, 0  ; Message text with newline (10) and null terminator (0)
```
- Stores a **null-terminated string** with a newline character:
  - `message`: `"Hello, World!\n\0"`, where `\n` (ASCII 10) is the newline and `\0` (ASCII 0) is the string terminator.

---

### **2. Code Section & C Library Import**
```assembly
section .text
    global main
    extern printf, exit       ; Import C library functions
```
- Declares the **main function** (`global main`) so the linker can find it.
- Declares `extern printf, exit` to use **C library functions**.

---

### **3. Function Implementation (`main`)**
```assembly
main:
    ; Save base pointer
    push rbp
    mov rbp, rsp
```
- Follows the **System V AMD64 ABI** (Linux x86-64 calling convention).
- Sets up the stack frame by saving the base pointer.

---

### **4. Calling `printf`**
```assembly
    ; Call printf("Hello, World!\n")
    mov rdi, message          ; First argument: format string
    xor rax, rax              ; Zero RAX (no floating point arguments)
    call printf               ; Call printf function
```
- **Function prototype**:  
  ```c
  int printf(const char *format, ...);
  ```
  - `rdi = message` → Pointer to `"Hello, World!\n"` (first argument is the format string).
  - `rax = 0` → Indicates no floating-point arguments (required by System V ABI).
- Calls `printf` to display the message on the console.

---

### **5. Calling `exit`**
```assembly
    ; Call exit(0)
    xor rdi, rdi              ; Exit code 0
    call exit                 ; Call exit to terminate program
```
- `exit(int status);`
- `rdi = 0` → Exit code **0 (success)**.
- Terminates the program **cleanly**.

---

### **6. Alternative Direct Syscall Implementation**
The code includes a section that shows how to achieve the same result using direct Linux syscalls:

```assembly
    mov rax, 1              ; syscall number for write
    mov rdi, 1              ; file descriptor 1 (stdout)
    mov rsi, message        ; buffer address
    mov rdx, 14             ; message length (13 + newline)
    syscall                 ; invoke the syscall
     
    mov rax, 60             ; syscall number for exit
    xor rdi, rdi            ; exit code 0
    syscall                 ; invoke the syscall
```

This demonstrates the lower-level approach that bypasses the C library entirely.

---

## **Compilation & Execution (Linux)**
### **Prerequisites**
- Install **NASM**: `sudo apt install nasm` (Debian/Ubuntu) or `sudo dnf install nasm` (Fedora).
- Ensure you have **GCC** installed: `sudo apt install gcc` or `sudo dnf install gcc`.

### **Commands**
```bash
nasm -f elf64 hello_linux.asm -o hello_linux.o
gcc hello_linux.o -o hello_linux -no-pie
./hello_linux
```
- **Assemble**: `nasm -f elf64` → Generates an object file (`.o`).
- **Link**: `gcc` links with the C library.
- **Run**: `./hello_linux` → Displays "Hello, World!" in the terminal.

---

## **Execution Flow**
1. **Sets up the stack frame**.
2. **Passes the message string to `printf`**.
3. **Displays "Hello, World!" in the console**.
4. **Calls `exit(0)`** to terminate the program.

---

## **Summary**
- Uses **C library functions** for console output.
- Demonstrates **Linux function calls, stack management, and calling conventions**.
- A **minimalist, low-level** way to output text in Linux.
- Includes commented alternative using direct **Linux syscalls**.

## **Key Differences from Windows Version**
- Uses **console output** instead of a GUI message box.
- Follows the **System V AMD64 ABI** instead of Windows x64 calling convention.
- Uses **C library functions** (`printf`, `exit`) instead of Windows API functions (`MessageBoxA`, `ExitProcess`).
- Does not require shadow space allocation on the stack.
- Different register usage: `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9` for the first six arguments.
