.data

array: .word 3, 8, 11, 6, 9

.text
.globl main

main:
    la a0, array
    li a1, 5

    jal ra, count_even

    li a7, 1
    ecall

    li a7, 10
    ecall


count_even:
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)

    mv s0, a0
    mv s1, a1

    li t0, 0

    li t1, 0

loop:
    bge t1, s1, done

    slli t2, t1, 2
    add t3, s0, t2
    lw t4, 0(t3)

    andi t5, t4, 1
    bne t5, zero, not_even

    addi t0, t0, 1

not_even:
    addi t1, t1, 1
    j loop

done:
    mv a0, t0

    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8

    ret