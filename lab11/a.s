.globl _start

.text
exit:
    li a7, 93
    ecall 
    ret

_start:
    li s0, 0xFFFF0100 #base

    li t0, 0x00
    addi t1, s0, 0x22 # hand brake
    sb t0, 0(t1) 

    li t0, 0xf1 # -15
    addi t1, s0, 0x20 # steering-wheel
    sb t0, 0(t1)

    1:
    li t0, 0x01
    addi t1, s0, 0x21 # engine
    sb t0, 0(t1)

    addi t1, s0, 0x10 # x coord
    lw t2, 0(t1)
    addi t1, s0, 0x14 # y coord
    lw t3, 0(t1)
    addi t1, s0, 0x18 # z coord
    lw t4, 0(t1)

    addi t2, t2, -73
    mul t2, t2, t2
    addi t3, t3, -1
    mul t3, t3, t3
    addi t4, t4, +19
    mul t4, t4, t4
    add s1, t2, t3
    add s1, s1, t4
    li s2, 255

    bge s1, s2, 1b

    li t0, 1
    addi t1, s0, 0x22 # hand brake
    sb t0, 0(t1) 

    j exit

