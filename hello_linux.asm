section .data
    message db "Hello, World!", 10, 0  ; Message text with newline (10) and null terminator (0)

section .text
    global main
    extern printf, exit       ; Import C library functions

main:
    ; Save base pointer
    push rbp
    mov rbp, rsp
    
    ; Call printf("Hello, World!\n")
    mov rdi, message          ; First argument: format string
    xor rax, rax              ; Zero RAX (no floating point arguments)
    call printf               ; Call printf function
    
    ; Call exit(0)
    xor rdi, rdi              ; Exit code 0
    call exit                 ; Call exit to terminate program
    
    ; Restore base pointer
    mov rsp, rbp
    pop rbp
    
    ; Alternative Linux syscall version
    ; mov rax, 1              ; syscall number for write
    ; mov rdi, 1              ; file descriptor 1 (stdout)
    ; mov rsi, message        ; buffer address
    ; mov rdx, 14             ; message length (13 + newline)
    ; syscall                 ; invoke the syscall
    ; 
    ; mov rax, 60             ; syscall number for exit
    ; xor rdi, rdi            ; exit code 0
    ; syscall                 ; invoke the syscall
    
    ret