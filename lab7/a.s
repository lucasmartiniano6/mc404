.globl _start

.data
buffer: .skip 0x8
bufsz:  .byte 0x5

.text
read:
    li a0, 0       # file descriptor = 0 (stdin)
    la a1, buffer  # buffer to write the data
    LB a2, bufsz   # size (reads n bytes)
    li a7, 63      # syscall read (63)
    ecall
	ret

write:
    li a0, 1       # file descriptor = 1 (stdout)
    la a1, buffer  # buffer
    LB a2, bufsz   # size (reads n bytes)
    li a7, 64      # syscall write (64)
    ecall    
	ret

exit:
    li a0, 0
    li a7, 93
    ecall

digits:
    la s0, buffer
    lb t0, 0(s0)
    lb t1, 1(s0)
    lb t2, 2(s0)
    lb t3, 3(s0)
    addi a1, t0, -48
    addi a2, t1, -48
    addi a3, t2, -48
    addi a4, t3, -48
    ret 
 
_start:
    li t0, 5
    SB t0, bufsz, t1
    la s0, buffer

    jal read
    jal digits   

    xor s1, a1, a2
    xor s1, s1, a4

    xor s2, a1, a3
    xor s2, s2, a4

    xor s3, a2, a3
    xor s3, s3, a4

    addi s1, s1, 48
    addi s2, s2, 48
    addi s3, s3, 48
    addi a1, a1, 48
    addi a2, a2, 48
    addi a3, a3, 48
    addi a4, a4, 48

    sb s1, 0(s0) 
    sb s2, 1(s0)
    sb a1, 2(s0)
    sb s3, 3(s0)
    sb a2, 4(s0)
    sb a3, 5(s0)
    sb a4, 6(s0)

    li t0, 10 # \n
    sb t0, 7(s0)
    
    li t0, 8
    SB t0, bufsz, t1
    jal write

segunda:
    jal read
    jal digits
    lb t0, 4(s0)
    lb t1, 5(s0)
    lb t2, 6(s0)
    addi a5, t0, -48
    addi a6, t1, -48
    addi a7, t2, -48


    xor s1, a3, a5
    xor s1, s1, a7

    xor s2, a3, a6
    xor s2, s2, a7

    xor s3, a5, a6
    xor s3, s3, a7

    xor s1, s1, a1
    xor s2, s2, a2
    xor s3, s3, a4

    or s1, s1, s2
    or s1, s1, s3

    addi a3, a3, 48
    addi a5, a5, 48
    addi a6, a6, 48
    addi a7, a7, 48
    sb a3, 0(s0) 
    sb a5, 1(s0)
    sb a6, 2(s0)
    sb a7, 3(s0)

    li t0, 10 # \n
    sb t0, 4(s0)
    
    li t0, 5
    SB t0, bufsz, t1
    jal write

    addi s1, s1, 48
    sb s1, 0(s0)

    li t0, 10 # \n
    sb t0, 1(s0)
    
    li t0, 2
    SB t0, bufsz, t1
    jal write

final:        
    jal exit
