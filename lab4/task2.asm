.data

array: .word 12, 5, 27, 8, 19

.text
.globl main

main:
    la t0, array       
    li t1, 5           
    lw t2, 0(t0)       
    li t3, 1           

loop:
    bge t3, t1, done   

    slli t4, t3, 2     
    add t5, t0, t4     
    lw t6, 0(t5)       

    blt t2, t6, update_max   

    addi t3, t3, 1     
    j loop

update_max:
    mv t2, t6          
    addi t3, t3, 1    
    j loop

done:
    mv a0, t2          
    li a7, 1           
    ecall

    li a7, 10          
    ecall