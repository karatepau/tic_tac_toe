SECTION .data
    msg_vic_x  db "X has won!", 10
    msg_vic_o  db "O has won!", 10
    len_vic  equ $ - msg_vic_o

SECTION .bss
    print_buffer resb 32
    buffer resb 32

SECTION .text
    global _start

_start:
    xor ebx, ebx
    xor r8d, r8d
    mov r8d, 16
    xor rbx, rbx
    mov rcx, 9

    mov byte [rel print_buffer+1], '|'
    mov byte [rel print_buffer+3], '|'
    mov word [rel print_buffer+5], 10 | (' ' << 8)
    mov dword [rel print_buffer+7], '---'  | (10 << 24)
    mov byte [rel print_buffer+12], '|'
    mov byte [rel print_buffer+14], '|'    
    mov word [rel print_buffer+16], 10 | (' ' << 8)
    mov dword [rel print_buffer+18], '---'  | (10 << 24)
    mov byte [rel print_buffer+23], '|'
    mov byte [rel print_buffer+25], '|'
    mov word [rel print_buffer+27], 10 | (' ' << 8)
    mov dword [rel print_buffer+29], '---'  | (10 << 24)

    start:
    mov r9, rcx
    call print
    call move
    call vic
    mov rcx, r9
    loop start
    call print
    xor rdi, rdi
    mov rax, 60
    syscall

vic:
    mov eax, ebx
    xor r8d, 16
    mov ecx, r8d
    shr eax, cl
    
    mov edx, eax
    and edx, 7
    cmp edx, 7
    je won

    mov edx, eax
    and edx, 56
    cmp edx, 56
    je won

    mov edx, eax
    and edx, 448
    cmp edx, 448
    je won

    mov edx, eax
    and edx, 73
    cmp edx, 73
    je won

    mov edx, eax
    and edx, 146
    cmp edx, 146
    je won

    mov edx, eax
    and edx, 292
    cmp edx, 292
    je won

    mov edx, eax
    and edx, 273
    cmp edx, 273
    je won

    mov edx, eax
    and edx, 84
    cmp edx, 84
    je won

    v0:
    mov rcx, 0
    xor r8d, 16
    ret

    won:
    mov rax, 1
    mov rdx, len_vic
    mov rdi, 1   
    bt r8d, 4
    jc vx
    mov rsi, msg_vic_o
    jmp v1
    vx:
    mov rsi, msg_vic_x
    v1:
    syscall
    jmp v0


 move:
    xor rax, rax
    xor rdi, rdi
    mov rdx, 32
    mov rsi, buffer
    syscall

    movzx ecx, byte [rel buffer]
    sub ecx, '1'

    mov eax, ebx
    shr eax, 16
    or eax, ebx

    bt eax, ecx
    jc move
    add ecx, r8d
    
    bts ebx, ecx
    xor r8d, 16
    ret

print:
    bt ebx, 0
    jc o0
    bt ebx, 16
    jc x0
    mov byte [rel print_buffer], ' '
    jmp i0
    o0:
    mov byte [rel print_buffer], 'o'
    jmp i0
    x0:
    mov byte [rel print_buffer], 'x'
    i0:

    bt ebx, 1
    jc o1
    bt ebx, 17
    jc x1
    mov byte [rel print_buffer+2], ' '
    jmp i1
    o1:
    mov byte [rel print_buffer+2], 'o'
    jmp i1
    x1:
    mov byte [rel print_buffer+2], 'x'
    i1:

    bt ebx, 2
    jc o2
    bt ebx, 18
    jc x2
    mov byte [rel print_buffer+4], ' '
    jmp i2
    o2:
    mov byte [rel print_buffer+4], 'o'
    jmp i2
    x2:
    mov byte [rel print_buffer+4], 'x'
    i2:

    bt ebx, 3
    jc o3
    bt ebx, 19
    jc x3
    mov byte [rel print_buffer+11], ' '
    jmp i3
    o3:
    mov byte [rel print_buffer+11], 'o'
    jmp i3
    x3:
    mov byte [rel print_buffer+11], 'x'
    i3:

    bt ebx, 4
    jc o4
    bt ebx, 20
    jc x4
    mov byte [rel print_buffer+13], ' '
    jmp i4
    o4:
    mov byte [rel print_buffer+13], 'o'
    jmp i4
    x4:
    mov byte [rel print_buffer+13], 'x'
    i4:

    bt ebx, 5
    jc o5
    bt ebx, 21
    jc x5
    mov byte [rel print_buffer+15], ' '
    jmp i5
    o5:
    mov byte [rel print_buffer+15], 'o'
    jmp i5
    x5:
    mov byte [rel print_buffer+15], 'x'
    i5:

    bt ebx, 6
    jc o6
    bt ebx, 22
    jc x6
    mov byte [rel print_buffer+22], ' '
    jmp i6
    o6:
    mov byte [rel print_buffer+22], 'o'
    jmp i6
    x6:
    mov byte [rel print_buffer+22], 'x'
    i6:

    bt ebx, 7
    jc o7
    bt ebx, 23
    jc x7
    mov byte [rel print_buffer+24], ' '
    jmp i7
    o7:
    mov byte [rel print_buffer+24], 'o'
    jmp i7
    x7:
    mov byte [rel print_buffer+24], 'x'
    i7:

    bt ebx, 8
    jc o8
    bt ebx, 24
    jc x8
    mov byte [rel print_buffer+26], ' '
    jmp i8
    o8:
    mov byte [rel print_buffer+26], 'o'
    jmp i8
    x8:
    mov byte [rel print_buffer+26], 'x'
    i8:

    mov rax, 1
    mov rdx, 28
    mov rdi, 1
    mov rsi, print_buffer

    syscall
    ret
