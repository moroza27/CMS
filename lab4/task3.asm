.data

array: .word 12, 5, 27, 8, 19

.text
.globl main

main:
    la a0, array
    li a1, 5

    jal ra, find_max

    li a7, 1
    ecall

    li a7, 10
    ecall


find_max:
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)

    mv s0, a0
    mv s1, a1

    lw t0, 0(s0)

    li t1, 1

loop:
    bge t1, s1, done

    slli t2, t1, 2
    add t3, s0, t2
    lw t4, 0(t3)

    blt t0, t4, update_max

    addi t1, t1, 1
    j loop

update_max:
    mv t0, t4
    addi t1, t1, 1
    j loop

done:
    mv a0, t0

    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8

    ret