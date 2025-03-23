section .data
    title db "Message", 0   ; Window title
    message db "Hello, World!", 0  ; Message text

section .text
    global main
    extern MessageBoxA, ExitProcess  ; Import Windows API functions

main:
    sub rsp, 40               ; Allocate shadow space for function calls

    mov rcx, 0                ; hWnd (NULL)
    mov rdx, message          ; Message text
    mov r8, title             ; Window title
    mov r9, 0                 ; MB_OK (OK button)
    call MessageBoxA          ; Call MessageBoxA function

    mov ecx, 0                ; Exit code 0
    call ExitProcess          ; Call ExitProcess to terminate program
