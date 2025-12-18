; =====================================================
; Sudoku Solver in Assembly (x86-64 Windows, NASM)
; Author: Onkar Gawade
; -----------------------------------------------------
; Build:
;   nasm -f win64 solver.asm -o solver.obj
;   gcc solver.obj puzzles.obj -o solver.exe
; Run:
;   solver.exe
; =====================================================

global main
extern printf
extern puts
extern puzzle1
extern puzzle2
extern GetStdHandle
extern WriteConsoleA

section .data
fmt_num db "%d ", 0
fmt_nl  db 10, 0
msg_solved db "Solved Sudoku:", 13,10, 0
msg_nosol db "No solution found.", 13,10, 0
msg_puzzle1 db "Solving Puzzle 1:", 13,10, 0
msg_puzzle2 db "Solving Puzzle 2:", 13,10, 0
msg_separator db "+-------+-------+-------+", 13,10, 0
out2 db 0, ' '
nl db 13,10

section .text

; -----------------------------------------------------
; main
; -----------------------------------------------------
main:
    push rbp
    mov rbp, rsp

    ; Solve puzzle 1
    lea rcx, [rel msg_puzzle1]
    sub rsp, 32
    call printf
    add rsp, 32
    
    lea rcx, [rel puzzle1]
    sub rsp, 32
    call solve
    add rsp, 40
    cmp eax, 1
    jne .no_solution1

    lea rcx, [rel msg_solved]
    sub rsp, 32
    call printf
    add rsp, 32
    lea rcx, [rel puzzle1]
    sub rsp, 32
    call print_board_formatted
    add rsp, 40
    jmp .solve_puzzle2

.no_solution1:
    lea rcx, [rel msg_nosol]
    sub rsp, 32
    call printf
    add rsp, 32

.solve_puzzle2:
    ; Add a newline for separation
    lea rcx, [rel fmt_nl]
    sub rsp, 32
    call printf
    add rsp, 32
    
    ; Solve puzzle 2
    lea rcx, [rel msg_puzzle2]
    sub rsp, 32
    call printf
    add rsp, 32
    
    lea rcx, [rel puzzle2]
    sub rsp, 32
    call solve
    add rsp, 40
    cmp eax, 1
    jne .no_solution2

    lea rcx, [rel msg_solved]
    sub rsp, 32
    call printf
    add rsp, 32
    lea rcx, [rel puzzle2]
    sub rsp, 32
    call print_board_formatted
    add rsp, 40
    jmp .done

.no_solution2:
    lea rcx, [rel msg_nosol]
    sub rsp, 32
    call printf
    add rsp, 32

.done:
    mov eax, 0
    pop rbp
    ret

; -----------------------------------------------------
; solve(board_ptr)
; RCX = pointer to board (81 bytes)
; returns EAX = 1 if solved, 0 otherwise
; -----------------------------------------------------
solve:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14

    mov rbx, rcx
    mov rcx, rbx
    sub rsp, 32
    call find_empty
    add rsp, 40
    cmp eax, -1
    je .solved_all

    mov r12d, eax            ; empty index
    mov r13d, 1              ; number = 1

.try_next:
    cmp r13d, 10
    jge .fail

    mov rcx, rbx
    mov edx, r12d
    mov r8d, r13d
    sub rsp, 32
    call is_valid
    add rsp, 40
    cmp eax, 0
    je .next_num

    mov byte [rbx + r12], r13b    ; place number

    mov rcx, rbx
    sub rsp, 32
    call solve
    add rsp, 40
    cmp eax, 1
    je .ok

    mov byte [rbx + r12], 0  ; backtrack
.next_num:
    inc r13d
    jmp .try_next

.fail:
    mov eax, 0
    jmp .done
.ok:
    mov eax, 1
    jmp .done

.solved_all:
    mov eax, 1

.done:
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

; -----------------------------------------------------
; find_empty(board_ptr)
; RCX = board_ptr
; Returns EAX = index (0..80) or -1
; -----------------------------------------------------
find_empty:
    xor rax, rax
    xor rdx, rdx
.loop:
    cmp edx, 81
    jge .none
    mov al, [rcx + rdx]
    cmp al, 0
    je .found
    inc edx
    jmp .loop
.found:
    mov eax, edx
    ret
.none:
    mov eax, -1
    ret

; -----------------------------------------------------
; is_valid(board_ptr, index, num)
; RCX=board_ptr, EDX=index, R8D=num
; Returns EAX=1 (valid) or 0 (invalid)
; -----------------------------------------------------
is_valid:
    push rbp
    mov rbp, rsp
    push rbx
    push r9
    push r10
    push r11

    mov rbx, rcx
    mov r9d, edx        ; index
    mov r10d, r8d       ; num

    mov eax, r9d
    mov edx, 0
    mov ecx, 9
    div ecx
    mov r11d, eax       ; row = idx / 9
    mov r8d, edx        ; col = idx % 9

; check row
    xor ecx, ecx
.row_loop:
    cmp ecx, 9
    jge .check_col
    mov eax, r11d
    imul eax, 9
    add eax, ecx
    mov dl, [rbx + rax]
    cmp dl, r10b
    je .row_conflict
    inc ecx
    jmp .row_loop
.row_conflict:
    mov eax, 0
    jmp .done

; check column
.check_col:
    xor ecx, ecx
.col_loop:
    cmp ecx, 9
    jge .check_box
    mov eax, ecx
    imul eax, 9
    add eax, r8d
    mov dl, [rbx + rax]
    cmp dl, r10b
    je .col_conflict
    inc ecx
    jmp .col_loop
.col_conflict:
    mov eax, 0
    jmp .done

; check 3x3 box
.check_box:
    mov eax, r11d
    mov edx, 0
    mov ecx, 3
    div ecx
    imul eax, 3
    mov r11d, eax        ; box row start
    mov eax, r8d
    mov edx, 0
    mov ecx, 3
    div ecx
    imul eax, 3
    mov r8d, eax         ; box col start

    xor ecx, ecx
.box_i:
    cmp ecx, 3
    jge .valid
    xor edx, edx
.box_j:
    cmp edx, 3
    jge .next_i
    mov eax, r11d
    add eax, ecx
    imul eax, 9
    add eax, r8d
    add eax, edx
    mov bl, [rbx + rax]
    cmp bl, r10b
    je .box_conflict
    inc edx
    jmp .box_j
.next_i:
    inc ecx
    jmp .box_i
.box_conflict:
    mov eax, 0
    jmp .done

.valid:
    mov eax, 1
.done:
    pop r11
    pop r10
    pop r9
    pop rbx
    pop rbp
    ret

; -----------------------------------------------------
; print_board_formatted(board_ptr)
; RCX = board_ptr
; Prints the board in a formatted way with separators
; -----------------------------------------------------
print_board_formatted:
    push rbp
    mov rbp, rsp
    push rbx
    push rsi
    push rdi

    mov rbx, rcx
    xor rsi, rsi          ; row counter

.row_loop:
    ; Print separator after every 3 rows (and at the beginning)
    mov eax, esi
    xor edx, edx
    mov ecx, 3
    div ecx
    test edx, edx
    jne .no_separator_top
    lea rcx, [rel msg_separator]
    sub rsp, 32
    call printf
    add rsp, 32
.no_separator_top:

    ; Print row with vertical separators
    xor rdi, rdi          ; column counter

.col_loop:
    ; Print vertical separator before columns 0, 3, 6
    mov eax, edi
    xor edx, edx
    mov ecx, 3
    div ecx
    test edx, edx
    jne .no_separator_left
    lea rcx, [rel out2]   ; print "| "
    mov byte [rel out2], '|'
    sub rsp, 32
    call printf
    add rsp, 32
.no_separator_left:

    ; Print the number
    ; Calculate index = row * 9 + col
    mov eax, esi
    imul eax, 9
    add eax, edi
    movzx eax, byte [rbx + rax]
    lea rcx, [rel fmt_num]
    mov edx, eax
    sub rsp, 32
    call printf
    add rsp, 32

    inc rdi
    cmp rdi, 9
    jl .col_loop

    ; Print closing vertical separator
    lea rcx, [rel out2]
    mov byte [rel out2], '|'
    sub rsp, 32
    call printf
    add rsp, 32

    ; Print newline
    lea rcx, [rel fmt_nl]
    sub rsp, 32
    call printf
    add rsp, 32

    inc rsi
    cmp rsi, 9
    jl .row_loop

    ; Print final separator
    lea rcx, [rel msg_separator]
    sub rsp, 32
    call printf
    add rsp, 32

    pop rdi
    pop rsi
    pop rbx
    pop rbp
    ret

; -----------------------------------------------------
; print_board(board_ptr)
; RCX = board_ptr
; Prints the board in simple format (deprecated but kept for compatibility)
; -----------------------------------------------------
print_board:
    push rbp
    mov rbp, rsp
    push rbx
    push rsi
    push rdi

    mov rbx, rcx
    xor rsi, rsi

.simple_loop:
    movzx eax, byte [rbx + rsi]
    lea rcx, [rel fmt_num]
    mov edx, eax
    sub rsp, 32
    call printf
    add rsp, 32

    inc rsi
    mov eax, esi
    mov ecx, 9
    xor edx, edx
    div ecx
    cmp edx, 0
    jne .continue_simple

    lea rcx, [rel fmt_nl]
    sub rsp, 32
    call printf
    add rsp, 32

.continue_simple:
    cmp rsi, 81
    jl .simple_loop

    pop rdi
    pop rsi
    pop rbx
    pop rbp
    ret
