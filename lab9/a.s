
.globl _start
.data
number : .skip 6
out    : .skip 6

.text
read:
	li a0, 0  # file descriptor = 0 (stdin)
    la a1, number #  buffer to write the data
    li a2, 6  # size (reads only 1 byte)
    li a7, 63 # syscall read (63)
    ecall
	ret

write:
 	li a0, 1            # file descriptor = 1 (stdout)
    la a1, out          # buffer
    li a2, 6           # size
    li a7, 64           # syscall write (64)
    ecall    
	ret

get_number:
	# - 6 4 \n
	la t0, number
	lbu t1, 0(t0)
	li t2, 0x2d # '-'
	li t6, 1
	bne t1, t2, 1f
	addi t0, t0, 1 # skip minus sign
	li t6, -1 # multiply by -1 later
	1:
	# t0 start of number
	addi t1, t0, -1
	2:
	addi t1, t1, 1
	lbu t2, 0(t1)
	li t3, 0x0a
	bne t2, t3, 2b
	# t0 -> first digit addr
	# t1 -> \n addr

	li t2, 1
	li t4, 0
	li t5, 10
	3:
	addi t1, t1, -1	
	lbu a2, 0(t1)
	addi a2, a2, -48
	mul t3, a2, t2
	add t4, t4, t3
	mul t2, t2, t5
	bne t0, t1, 3b

	mul a0, t4, t6 # a0 final signed number
	ret

search:
	bne a0, zero, 1f
	addi a1, zero, -1
	ret
	1:
	addi a1, a1, 1
	lw t0, 0(a0)
	lw t1, 4(a0)
	lw t2, 8(a0)

	add t0, t0, t1
	mv a0, t2
	bne t0, s0, search
	ret

answer:
	li t0, -1
	bne a0, t0, 1f
	la t0, out
	li t1, 0x2d # '-'
	SB t1, 0(t0)
	li t1, 0x31 # '1'
	SB t1, 1(t0)
	li t1, 0x0a # '\n'
	SB t1, 2(t0)
	ret	

	1:
	li t0, 0
	li t1, 0
	li t2, 0
				
	li t3, 10
	rem t2, a0, t3
	div a0, a0, t3

	rem t1, a0, t3
	div a0, a0, t3

	rem t0, a0, t3
	div a0, a0, t3

	here:
	la t3, out
	beqz t0, 2f
	addi t0, t0, 48
	SB t0, 0(t3)
	addi t3, t3, 1
	2:
	beqz t1, 3f
	addi t1, t1, 48
	SB t1, 0(t3)
	addi t3, t3, 1
	3:		
	addi t2, t2, 48
	SB t2, 0(t3)
	addi t3, t3, 1
	
	li t2, 0x0a # '\n'
	SB t2, 0(t3)

	ret	

_start:
	# 0x 0a 34 36 2d
	#    \n 04 06 - 
	jal read
	jal get_number
	mv s0, a0
	
	la a0, head_node
	addi a1, zero, -1
	jal search

	mv a0, a1 
	jal answer
	jal write
