section .data
    msg db 'Hello, World!', 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp
    
    lea rcx, [msg]
    sub rsp, 32
    call printf
    add rsp, 32
    
    mov eax, 0
    pop rbp
    ret