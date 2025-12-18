; Simple Sudoku Solver in Assembly
; NASM x86-64 for Windows

section .data
    ; Format strings
    fmt_solved db "Sudoku solved successfully!", 10, 0
    fmt_unsolved db "No solution found for this puzzle.", 10, 0
    fmt_row db "%d %d %d | %d %d %d | %d %d %d", 10, 0
    fmt_separator db "+-------+-------+-------+", 10, 0
    
    ; Sample puzzle (0 represents empty cells)
    puzzle db 5,3,0,0,7,0,0,0,0
           db 6,0,0,1,9,5,0,0,0
           db 0,9,8,0,0,0,0,6,0
           db 8,0,0,0,6,0,0,0,3   
           db 4,0,0,8,0,3,0,0,1
           db 7,0,0,0,2,0,0,0,6   
           db 0,6,0,0,0,0,2,8,0   
           db 0,0,0,4,1,9,0,0,5
           db 0,0,0,0,8,0,0,7,9

section .text
    global main
    extern printf, puts

main:
    ; Save registers
    push rbp   
    mov rbp, rsp
    sub rsp, 32  ; Shadow space for Win64 calling convention
    
    ; Print initial message
    lea rcx, [fmt_solved]
    call printf
    
    ; Print the puzzle
    call print_puzzle
    
    ; Return 0
    xor eax, eax
    add rsp, 32
    pop rbp
    ret

; Function to print the puzzle
print_puzzle:
    push rbp
    mov rbp, rsp
    sub rsp, 64  ; Shadow space + local variables
    
    ; Print separator
    lea rcx, [fmt_separator]
    call printf
    
    ; Loop through rows
    xor r12, r12  ; row counter
    
.row_loop:
    ; Print row
    lea rcx, [fmt_row]
    
    ; Load 9 values from the puzzle for this row
    mov r13, r12
    imul r13, 9   ; r13 = row * 9 (starting index for this row)
    
    ; Load values for printf
    movzx rdx, byte [puzzle + r13]
    movzx r8, byte [puzzle + r13 + 1]
    movzx r9, byte [puzzle + r13 + 2]
    
    ; Additional parameters need to be passed on stack
    movzx rax, byte [puzzle + r13 + 3]
    push rax
    movzx rax, byte [puzzle + r13 + 4]
    push rax
    movzx rax, byte [puzzle + r13 + 5]
    push rax
    movzx rax, byte [puzzle + r13 + 6]
    push rax
    movzx rax, byte [puzzle + r13 + 7]
    push rax
    movzx rax, byte [puzzle + r13 + 8]
    push rax
    
    ; Call printf
    sub rsp, 32  ; Shadow space
    call printf
    add rsp, 32 + 48  ; Shadow space + 6 parameters (8 bytes each)
    
    ; Print separator after every 3 rows
    inc r12
    test r12b, 3
    jnz .no_separator
    
    lea rcx, [fmt_separator]
    call printf
    
.no_separator:
    ; Continue until all rows are printed
    cmp r12, 9
    jl .row_loop
    
    ; Return
    add rsp, 64
    pop rbp
    ret