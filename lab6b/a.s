.globl _start

.data
buffer: .skip 0x20
sz:     .skip 0x1

.text
read:
    li a0, 0       # file descriptor = 0 (stdin)
    la a1, buffer  # buffer to write the data
    LB a2, sz      # size (reads n bytes)
    li a7, 63      # syscall read (63)
    ecall
	ret

write:
    la a3, coords
    li a0, 1            # file descriptor = 1 (stdout)
    la a1, buffer       # buffer
    LB a2, sz           # size (reads n bytes)
    li a7, 64           # syscall write (64)
    ecall    
	ret

exit:
    li a0, 0
    li a7, 93
    ecall

str_dec:
    lbu a0, 0(s0)
    lbu a1, 1(s0)
    lbu a2, 2(s0)
    lbu a3, 3(s0) 

    addi a0, a0, -48
    addi a1, a1, -48
    addi a2, a2, -48
    addi a3, a3, -48

    li t0, 1000
    mul a0, a0, t0
    li t0, 100
    mul a1, a1, t0
    li t0, 10
    mul a2, a2, t0
    li t0, 1
    mul a3, a3, t0

    add a4, a0, a1
    add a4, a4, a2
    add a4, a4, a3

    ret

conv_num:
    # a4 numero , (a0,a1,a2,a3) digitos
    li t0, 10
    rem a3, a4, t0
    div a4, a4, t0

    rem a2, a4, t0
    div a4, a4, t0

    rem a1, a4, t0
    div a4, a4, t0

    rem a0, a4, t0
    div a4, a4, t0

    addi a3, a3, 48
    addi a2, a2, 48
    addi a1, a1, 48
    addi a0, a0, 48
 
    sb a0, 0(s0) #first digit
    sb a1, 1(s0) #
    sb a2, 2(s0) # 
    sb a3, 3(s0) # last digit

    add t0, a5, zero
    sb t0, 4(s0) # space(32) OR \n(10)

    ret

coords:
    add s5, ra, zero

    # first number
    la s0, buffer
    add a4, s1, zero
    li a5, 32
    jal conv_num

    # second number
    add s0, s0, 5
    add a4, s2, zero
    jal conv_num

    add ra, s5, zero
    ret


times:
    add s5, ra, zero

    # first number
    la s0, buffer
    add a4, s1, zero
    li a5, 32
    jal conv_num

    # second number
    add s0, s0, 5
    add a4, s2, zero
    jal conv_num

    # third number
    add s0, s0, 5
    add a4, s3, zero
    jal conv_num

    # fourth number
    add s0, s0, 5
    add a4, s4, zero
    li a5, 10
    jal conv_num

    add ra, s5, zero
    ret

sqrt:
    srli t0, a4, 1
    li t2, 10
repeat:
    divu t1, a4, t0
    add t0, t0, t1
    srli t0, t0, 1
    addi t2, t2, -1
    bnez t2, repeat
    add a4, t1, zero
    ret


_start:
    jal read
    li t0, 12
    SB t0, sz, t1

    la s0, buffer
    addi s0, s0, 1
    jal str_dec
    add s1, a4, zero

numero:
    addi s0, s0, 6
    jal str_dec
    add s2, a4, zero

    jal exit
