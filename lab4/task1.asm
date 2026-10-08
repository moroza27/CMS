.data

message: .asciz "Hello, RISC-V!\n"

.text
.globl main

main:
    la a0, message
    li a7, 4
    ecall

    li a0, 42
    li a7, 1
    ecall

    li a7, 10
    ecall
