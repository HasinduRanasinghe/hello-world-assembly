# Hello World in Assembly (Windows x86-64 NASM)

This repository contains a simple **Windows GUI "Hello, World!"** program written in **x86-64 assembly** using NASM. Instead of printing to the console, it creates a pop-up message box using the `MessageBoxA` function from the Windows API.

## **Code Explanation**

### **1. Data Section**
```assembly
section .data
    title db "Message", 0   ; Window title
    message db "Hello, World!", 0  ; Message text
```
- Stores **two null-terminated strings**:
  - `title`: `"Message"` (title of the message box).
  - `message`: `"Hello, World!"` (text inside the message box).

---

### **2. Code Section & Windows API Import**
```assembly
section .text
    global main
    extern MessageBoxA, ExitProcess  ; Import Windows API functions
```
- Declares the **main function** (`global main`) so the linker can find it.
- Declares `extern MessageBoxA, ExitProcess` to use **Windows API functions**.

---

### **3. Function Implementation (`main`)**
```assembly
main:
    sub rsp, 40               ; Allocate shadow space for function calls
```
- **Windows x86-64 calling convention (fastcall)** requires **at least 32 bytes of shadow space**.
- `sub rsp, 40` ensures **stack alignment**.

---

### **4. Calling `MessageBoxA`**
```assembly
    mov rcx, 0                ; hWnd (NULL)
    mov rdx, message          ; Message text
    mov r8, title             ; Window title
    mov r9, 0                 ; MB_OK (OK button)
    call MessageBoxA          ; Call MessageBoxA function
```
- **Function prototype**:  
  ```c
  int MessageBoxA(HWND hWnd, LPCSTR lpText, LPCSTR lpCaption, UINT uType);
  ```
  - `rcx = 0` → No parent window (`NULL`).
  - `rdx = message` → `"Hello, World!"` (message content).
  - `r8 = title` → `"Message"` (window title).
  - `r9 = 0` → `MB_OK` (just an "OK" button).
- Calls `MessageBoxA` to display a **popup message box**.

---

### **5. Calling `ExitProcess`**
```assembly
    mov ecx, 0                ; Exit code 0
    call ExitProcess          ; Call ExitProcess to terminate program
```
- `ExitProcess(UINT uExitCode);`
- `ecx = 0` → Exit code **0 (success)**.
- Terminates the program **cleanly**.

---

## **Compilation & Execution (Windows)**
### **Prerequisites**
- Install **NASM** ([Download](https://www.nasm.us/)).
- Install **MinGW-w64** ([Download](https://www.mingw-w64.org/)).

### **Commands**
```cmd
nasm -f win64 hello_win.asm -o hello_win.obj
gcc hello_win.obj -o hello_win.exe -lkernel32 -luser32
hello_win.exe
```
- **Assemble**: `nasm -f win64` → Generates an object file (`.obj`).
- **Link**: `gcc` links with `kernel32.dll` and `user32.dll`.
- **Run**: `hello_win.exe` → Displays the message box.

---

## **Execution Flow**
1. **Allocates stack space** for Windows function calls.
2. **Passes arguments to `MessageBoxA`**.
3. **Displays "Hello, World!" message box**.
4. **Calls `ExitProcess(0)`** to exit.

---

## **Summary**
- Uses **WinAPI** for a **GUI message box**.
- Demonstrates **Windows function calls, stack management, and calling conventions**.
- A **minimalist, low-level** way to interact with Windows.
