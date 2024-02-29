	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0"
	.file	"a.c"
	.globl	read
	.p2align	2
	.type	read,@function
read:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a3, -12(s0)
	lw	a4, -16(s0)
	lw	a5, -20(s0)
	#APP
	mv	a0, a3	# file descriptor
	mv	a1, a4	# buffer 
	mv	a2, a5	# size 
	li	a7, 63	# syscall read (63) 
	ecall	
	mv	a3, a0
	#NO_APP
	sw	a3, -28(s0)
	lw	a0, -28(s0)
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	read, .Lfunc_end0-read

	.globl	write
	.p2align	2
	.type	write,@function
write:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a3, -12(s0)
	lw	a4, -16(s0)
	lw	a5, -20(s0)
	#APP
	mv	a0, a3	# file descriptor
	mv	a1, a4	# buffer 
	mv	a2, a5	# size 
	li	a7, 64	# syscall write (64) 
	ecall	
	#NO_APP
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	write, .Lfunc_end1-write

	.globl	exit
	.p2align	2
	.type	exit,@function
exit:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a1, -12(s0)
	#APP
	mv	a0, a1	# return code
	li	a7, 93	# syscall exit (64) 
	ecall	
	#NO_APP
.Lfunc_end2:
	.size	exit, .Lfunc_end2-exit

	.globl	hex_code
	.p2align	2
	.type	hex_code,@function
hex_code:
	addi	sp, sp, -48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	addi	s0, sp, 48
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	sw	a0, -28(s0)
	li	a0, 48
	sb	a0, -23(s0)
	li	a0, 120
	sb	a0, -22(s0)
	li	a0, 10
	sb	a0, -13(s0)
	li	a0, 9
	sw	a0, -36(s0)
	j	.LBB3_1
.LBB3_1:
	lw	a0, -36(s0)
	li	a1, 2
	blt	a0, a1, .LBB3_7
	j	.LBB3_2
.LBB3_2:
	lw	a0, -28(s0)
	andi	a0, a0, 15
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	li	a1, 10
	bltu	a0, a1, .LBB3_4
	j	.LBB3_3
.LBB3_3:
	lw	a0, -32(s0)
	addi	a0, a0, 55
	lw	a2, -36(s0)
	addi	a1, s0, -23
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB3_5
.LBB3_4:
	lw	a0, -32(s0)
	addi	a0, a0, 48
	lw	a2, -36(s0)
	addi	a1, s0, -23
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB3_5
.LBB3_5:
	lw	a0, -28(s0)
	srli	a0, a0, 4
	sw	a0, -28(s0)
	j	.LBB3_6
.LBB3_6:
	lw	a0, -36(s0)
	addi	a0, a0, -1
	sw	a0, -36(s0)
	j	.LBB3_1
.LBB3_7:
	li	a0, 1
	addi	a1, s0, -23
	li	a2, 11
	call	write
	lw	ra, 44(sp)
	lw	s0, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end3:
	.size	hex_code, .Lfunc_end3-hex_code

	.globl	strcmp_custom
	.p2align	2
	.type	strcmp_custom,@function
strcmp_custom:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	sw	a2, -24(s0)
	li	a0, 0
	sw	a0, -28(s0)
	j	.LBB4_1
.LBB4_1:
	lw	a0, -28(s0)
	lw	a1, -24(s0)
	bge	a0, a1, .LBB4_9
	j	.LBB4_2
.LBB4_2:
	lw	a0, -16(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	lw	a1, -20(s0)
	add	a1, a1, a2
	lbu	a1, 0(a1)
	bge	a0, a1, .LBB4_4
	j	.LBB4_3
.LBB4_3:
	li	a0, -1
	sw	a0, -12(s0)
	j	.LBB4_10
.LBB4_4:
	lw	a0, -16(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	lbu	a1, 0(a0)
	lw	a0, -20(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	bge	a0, a1, .LBB4_6
	j	.LBB4_5
.LBB4_5:
	li	a0, 1
	sw	a0, -12(s0)
	j	.LBB4_10
.LBB4_6:
	j	.LBB4_7
.LBB4_7:
	j	.LBB4_8
.LBB4_8:
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB4_1
.LBB4_9:
	li	a0, 0
	sw	a0, -12(s0)
	j	.LBB4_10
.LBB4_10:
	lw	a0, -12(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	strcmp_custom, .Lfunc_end4-strcmp_custom

	.globl	dec_to_int
	.p2align	2
	.type	dec_to_int,@function
dec_to_int:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	lbu	a0, 0(a0)
	li	a1, 45
	bne	a0, a1, .LBB5_2
	j	.LBB5_1
.LBB5_1:
	li	a0, 1
	sw	a0, -20(s0)
	j	.LBB5_2
.LBB5_2:
	lw	a0, -20(s0)
	sw	a0, -28(s0)
	j	.LBB5_3
.LBB5_3:
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a2, 0
	li	a1, 48
	sw	a2, -32(s0)
	blt	a0, a1, .LBB5_5
	j	.LBB5_4
.LBB5_4:
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	slti	a0, a0, 58
	sw	a0, -32(s0)
	j	.LBB5_5
.LBB5_5:
	lw	a0, -32(s0)
	andi	a0, a0, 1
	li	a1, 0
	beq	a0, a1, .LBB5_7
	j	.LBB5_6
.LBB5_6:
	lw	a0, -24(s0)
	li	a1, 10
	mul	a0, a0, a1
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lw	a1, -12(s0)
	lw	a2, -28(s0)
	add	a1, a1, a2
	lbu	a1, 0(a1)
	add	a0, a0, a1
	addi	a0, a0, -48
	sw	a0, -24(s0)
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB5_3
.LBB5_7:
	lw	a0, -20(s0)
	li	a1, 1
	bne	a0, a1, .LBB5_9
	j	.LBB5_8
.LBB5_8:
	lw	a1, -24(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -24(s0)
	j	.LBB5_9
.LBB5_9:
	lw	a0, -28(s0)
	lw	a1, -16(s0)
	lw	a2, 0(a1)
	add	a0, a0, a2
	addi	a0, a0, 1
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end5:
	.size	dec_to_int, .Lfunc_end5-dec_to_int

	.globl	get_register
	.p2align	2
	.type	get_register,@function
get_register:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB6_1
.LBB6_1:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 120
	beq	a0, a1, .LBB6_3
	j	.LBB6_2
.LBB6_2:
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB6_1
.LBB6_3:
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	lw	a2, -20(s0)
	lw	a1, -16(s0)
	lw	a0, 0(a1)
	add	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lw	a1, -16(s0)
	call	dec_to_int
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end6:
	.size	get_register, .Lfunc_end6-get_register

	.globl	get_immediate
	.p2align	2
	.type	get_immediate,@function
get_immediate:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB7_1
.LBB7_1:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	blt	a0, a1, .LBB7_3
	j	.LBB7_2
.LBB7_2:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a2, 1
	li	a1, 58
	sw	a2, -24(s0)
	blt	a0, a1, .LBB7_4
	j	.LBB7_3
.LBB7_3:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	addi	a0, a0, -45
	seqz	a0, a0
	sw	a0, -24(s0)
	j	.LBB7_4
.LBB7_4:
	lw	a0, -24(s0)
	andi	a0, a0, 1
	li	a1, 0
	bne	a0, a1, .LBB7_6
	j	.LBB7_5
.LBB7_5:
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB7_1
.LBB7_6:
	lw	a2, -20(s0)
	lw	a1, -16(s0)
	lw	a0, 0(a1)
	add	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lw	a1, -16(s0)
	call	dec_to_int
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end7:
	.size	get_immediate, .Lfunc_end7-get_immediate

	.globl	rd_imm
	.p2align	2
	.type	rd_imm,@function
rd_imm:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	lw	a0, -12(s0)
	lw	a1, -24(s0)
	add	a0, a0, a1
	addi	a1, s0, -24
	sw	a1, -28(s0)
	call	get_register
	lw	a1, -28(s0)
	lw	a2, -16(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -24(s0)
	add	a0, a0, a2
	call	get_immediate
	lw	a1, -20(s0)
	sw	a0, 0(a1)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end8:
	.size	rd_imm, .Lfunc_end8-rd_imm

	.globl	r1_r2_imm
	.p2align	2
	.type	r1_r2_imm,@function
r1_r2_imm:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	sw	a4, -28(s0)
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	addi	a1, s0, -28
	sw	a1, -32(s0)
	call	get_register
	lw	a1, -32(s0)
	lw	a2, -16(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_register
	lw	a1, -32(s0)
	lw	a2, -20(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_immediate
	lw	a1, -24(s0)
	sw	a0, 0(a1)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end9:
	.size	r1_r2_imm, .Lfunc_end9-r1_r2_imm

	.globl	r1_imm_r2
	.p2align	2
	.type	r1_imm_r2,@function
r1_imm_r2:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	sw	a4, -28(s0)
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	addi	a1, s0, -28
	sw	a1, -32(s0)
	call	get_register
	lw	a1, -32(s0)
	lw	a2, -16(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_immediate
	lw	a1, -32(s0)
	lw	a2, -24(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_register
	lw	a1, -20(s0)
	sw	a0, 0(a1)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end10:
	.size	r1_imm_r2, .Lfunc_end10-r1_imm_r2

	.globl	r1_r2_r3
	.p2align	2
	.type	r1_r2_r3,@function
r1_r2_r3:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	sw	a4, -28(s0)
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	addi	a1, s0, -28
	sw	a1, -32(s0)
	call	get_register
	lw	a1, -32(s0)
	lw	a2, -16(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_register
	lw	a1, -32(s0)
	lw	a2, -20(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_register
	lw	a1, -24(s0)
	sw	a0, 0(a1)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end11:
	.size	r1_r2_r3, .Lfunc_end11-r1_r2_r3

	.globl	get_inst_data
	.p2align	2
	.type	get_inst_data,@function
get_inst_data:
	addi	sp, sp, -96
	sw	ra, 92(sp)
	sw	s0, 88(sp)
	addi	s0, sp, 96
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -52(s0)
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	sw	a0, -28(s0)
	sw	a0, -32(s0)
	sw	a0, -36(s0)
	sw	a0, -40(s0)
	sw	a0, -44(s0)
	li	a0, 1
	sw	a0, -48(s0)
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str)
	addi	a1, a1, %lo(.L.str)
	li	a2, 3
	call	strcmp_custom
	lw	a1, -52(s0)
	bne	a0, a1, .LBB12_2
	j	.LBB12_1
.LBB12_1:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -36
	li	a3, 3
	call	rd_imm
	li	a0, 55
	sw	a0, -20(s0)
	li	a0, 4
	sw	a0, -48(s0)
	j	.LBB12_110
.LBB12_2:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.1)
	addi	a1, a1, %lo(.L.str.1)
	li	a2, 6
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_4
	j	.LBB12_3
.LBB12_3:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -36
	li	a3, 5
	call	rd_imm
	li	a0, 23
	sw	a0, -20(s0)
	li	a0, 4
	sw	a0, -48(s0)
	j	.LBB12_109
.LBB12_4:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.2)
	addi	a1, a1, %lo(.L.str.2)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_6
	j	.LBB12_5
.LBB12_5:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -36
	li	a3, 3
	call	rd_imm
	li	a0, 111
	sw	a0, -20(s0)
	li	a0, 5
	sw	a0, -48(s0)
	j	.LBB12_108
.LBB12_6:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.3)
	addi	a1, a1, %lo(.L.str.3)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_8
	j	.LBB12_7
.LBB12_7:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_imm_r2
	li	a0, 103
	sw	a0, -20(s0)
	li	a0, 1
	sw	a0, -48(s0)
	j	.LBB12_107
.LBB12_8:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.4)
	addi	a1, a1, %lo(.L.str.4)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_10
	j	.LBB12_9
.LBB12_9:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -56(s0)
	call	r1_r2_imm
	lw	a0, -56(s0)
	li	a1, 99
	sw	a1, -20(s0)
	sw	a0, -48(s0)
	j	.LBB12_106
.LBB12_10:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.5)
	addi	a1, a1, %lo(.L.str.5)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_12
	j	.LBB12_11
.LBB12_11:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -60(s0)
	call	r1_r2_imm
	lw	a0, -60(s0)
	li	a1, 99
	sw	a1, -20(s0)
	li	a1, 1
	sw	a1, -40(s0)
	sw	a0, -48(s0)
	j	.LBB12_105
.LBB12_12:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.6)
	addi	a1, a1, %lo(.L.str.6)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_14
	j	.LBB12_13
.LBB12_13:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -64(s0)
	call	r1_r2_imm
	lw	a0, -64(s0)
	li	a1, 99
	sw	a1, -20(s0)
	li	a1, 4
	sw	a1, -40(s0)
	sw	a0, -48(s0)
	j	.LBB12_104
.LBB12_14:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.7)
	addi	a1, a1, %lo(.L.str.7)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_16
	j	.LBB12_15
.LBB12_15:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -68(s0)
	call	r1_r2_imm
	lw	a0, -68(s0)
	li	a1, 99
	sw	a1, -20(s0)
	li	a1, 5
	sw	a1, -40(s0)
	sw	a0, -48(s0)
	j	.LBB12_103
.LBB12_16:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.8)
	addi	a1, a1, %lo(.L.str.8)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_18
	j	.LBB12_17
.LBB12_17:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 99
	sw	a0, -20(s0)
	li	a0, 6
	sw	a0, -40(s0)
	li	a0, 3
	sw	a0, -48(s0)
	j	.LBB12_102
.LBB12_18:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.9)
	addi	a1, a1, %lo(.L.str.9)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_20
	j	.LBB12_19
.LBB12_19:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 99
	sw	a0, -20(s0)
	li	a0, 7
	sw	a0, -40(s0)
	li	a0, 3
	sw	a0, -48(s0)
	j	.LBB12_101
.LBB12_20:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.10)
	addi	a1, a1, %lo(.L.str.10)
	li	a2, 3
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_22
	j	.LBB12_21
.LBB12_21:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	call	r1_imm_r2
	li	a0, 3
	sw	a0, -20(s0)
	j	.LBB12_100
.LBB12_22:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.11)
	addi	a1, a1, %lo(.L.str.11)
	li	a2, 3
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_24
	j	.LBB12_23
.LBB12_23:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	call	r1_imm_r2
	li	a0, 3
	sw	a0, -20(s0)
	li	a0, 1
	sw	a0, -40(s0)
	j	.LBB12_99
.LBB12_24:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.12)
	addi	a1, a1, %lo(.L.str.12)
	li	a2, 3
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_26
	j	.LBB12_25
.LBB12_25:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	sw	a4, -72(s0)
	call	r1_imm_r2
	lw	a0, -72(s0)
	li	a1, 3
	sw	a1, -20(s0)
	sw	a0, -40(s0)
	j	.LBB12_98
.LBB12_26:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.13)
	addi	a1, a1, %lo(.L.str.13)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_28
	j	.LBB12_27
.LBB12_27:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -76(s0)
	call	r1_imm_r2
	lw	a0, -76(s0)
	sw	a0, -20(s0)
	li	a0, 4
	sw	a0, -40(s0)
	j	.LBB12_97
.LBB12_28:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.14)
	addi	a1, a1, %lo(.L.str.14)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_30
	j	.LBB12_29
.LBB12_29:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -80(s0)
	call	r1_imm_r2
	lw	a0, -80(s0)
	sw	a0, -20(s0)
	li	a0, 5
	sw	a0, -40(s0)
	j	.LBB12_96
.LBB12_30:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.15)
	addi	a1, a1, %lo(.L.str.15)
	li	a2, 3
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_32
	j	.LBB12_31
.LBB12_31:
	lw	a0, -12(s0)
	addi	a1, s0, -32
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	sw	a4, -84(s0)
	call	r1_imm_r2
	lw	a0, -84(s0)
	li	a1, 35
	sw	a1, -20(s0)
	sw	a0, -48(s0)
	j	.LBB12_95
.LBB12_32:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.16)
	addi	a1, a1, %lo(.L.str.16)
	li	a2, 3
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_34
	j	.LBB12_33
.LBB12_33:
	lw	a0, -12(s0)
	addi	a1, s0, -32
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	sw	a4, -88(s0)
	call	r1_imm_r2
	lw	a0, -88(s0)
	li	a1, 35
	sw	a1, -20(s0)
	li	a1, 1
	sw	a1, -40(s0)
	sw	a0, -48(s0)
	j	.LBB12_94
.LBB12_34:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.17)
	addi	a1, a1, %lo(.L.str.17)
	li	a2, 3
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_36
	j	.LBB12_35
.LBB12_35:
	lw	a0, -12(s0)
	addi	a1, s0, -32
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	sw	a4, -92(s0)
	call	r1_imm_r2
	lw	a0, -92(s0)
	li	a1, 35
	sw	a1, -20(s0)
	sw	a0, -40(s0)
	sw	a0, -48(s0)
	j	.LBB12_93
.LBB12_36:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.18)
	addi	a1, a1, %lo(.L.str.18)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_38
	j	.LBB12_37
.LBB12_37:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	j	.LBB12_92
.LBB12_38:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.19)
	addi	a1, a1, %lo(.L.str.19)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_40
	j	.LBB12_39
.LBB12_39:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	li	a0, 2
	sw	a0, -40(s0)
	j	.LBB12_91
.LBB12_40:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.20)
	addi	a1, a1, %lo(.L.str.20)
	li	a2, 6
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_42
	j	.LBB12_41
.LBB12_41:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	li	a0, 3
	sw	a0, -40(s0)
	j	.LBB12_90
.LBB12_42:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.21)
	addi	a1, a1, %lo(.L.str.21)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_44
	j	.LBB12_43
.LBB12_43:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	sw	a4, -96(s0)
	call	r1_r2_imm
	lw	a0, -96(s0)
	li	a1, 19
	sw	a1, -20(s0)
	sw	a0, -40(s0)
	j	.LBB12_89
.LBB12_44:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.22)
	addi	a1, a1, %lo(.L.str.22)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_46
	j	.LBB12_45
.LBB12_45:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	li	a0, 6
	sw	a0, -40(s0)
	j	.LBB12_88
.LBB12_46:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.23)
	addi	a1, a1, %lo(.L.str.23)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_48
	j	.LBB12_47
.LBB12_47:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	li	a0, 7
	sw	a0, -40(s0)
	j	.LBB12_87
.LBB12_48:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.24)
	addi	a1, a1, %lo(.L.str.24)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_50
	j	.LBB12_49
.LBB12_49:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	lw	a0, -36(s0)
	srai	a1, a0, 31
	srli	a1, a1, 27
	add	a1, a0, a1
	andi	a1, a1, -32
	sub	a0, a0, a1
	sw	a0, -36(s0)
	li	a0, 1
	sw	a0, -40(s0)
	j	.LBB12_86
.LBB12_50:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.25)
	addi	a1, a1, %lo(.L.str.25)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_52
	j	.LBB12_51
.LBB12_51:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	lw	a0, -36(s0)
	srai	a1, a0, 31
	srli	a1, a1, 27
	add	a1, a0, a1
	andi	a1, a1, -32
	sub	a0, a0, a1
	sw	a0, -36(s0)
	li	a0, 5
	sw	a0, -40(s0)
	j	.LBB12_85
.LBB12_52:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.26)
	addi	a1, a1, %lo(.L.str.26)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_54
	j	.LBB12_53
.LBB12_53:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	lw	a0, -36(s0)
	srai	a1, a0, 31
	srli	a1, a1, 27
	add	a1, a0, a1
	andi	a1, a1, -32
	sub	a0, a0, a1
	addi	a0, a0, 1024
	sw	a0, -36(s0)
	li	a0, 5
	sw	a0, -40(s0)
	li	a0, 32
	sw	a0, -44(s0)
	j	.LBB12_84
.LBB12_54:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.27)
	addi	a1, a1, %lo(.L.str.27)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_56
	j	.LBB12_55
.LBB12_55:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_83
.LBB12_56:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.28)
	addi	a1, a1, %lo(.L.str.28)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_58
	j	.LBB12_57
.LBB12_57:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 32
	sw	a0, -44(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_82
.LBB12_58:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.29)
	addi	a1, a1, %lo(.L.str.29)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_60
	j	.LBB12_59
.LBB12_59:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 1
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_81
.LBB12_60:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.30)
	addi	a1, a1, %lo(.L.str.30)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_62
	j	.LBB12_61
.LBB12_61:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 2
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_80
.LBB12_62:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.31)
	addi	a1, a1, %lo(.L.str.31)
	li	a2, 5
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_64
	j	.LBB12_63
.LBB12_63:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 4
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 3
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_79
.LBB12_64:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.32)
	addi	a1, a1, %lo(.L.str.32)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_66
	j	.LBB12_65
.LBB12_65:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 4
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_78
.LBB12_66:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.33)
	addi	a1, a1, %lo(.L.str.33)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_68
	j	.LBB12_67
.LBB12_67:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 5
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_77
.LBB12_68:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.34)
	addi	a1, a1, %lo(.L.str.34)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_70
	j	.LBB12_69
.LBB12_69:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 5
	sw	a0, -40(s0)
	li	a0, 32
	sw	a0, -44(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_76
.LBB12_70:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.35)
	addi	a1, a1, %lo(.L.str.35)
	li	a2, 3
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_72
	j	.LBB12_71
.LBB12_71:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 2
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 6
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_75
.LBB12_72:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.36)
	addi	a1, a1, %lo(.L.str.36)
	li	a2, 4
	call	strcmp_custom
	li	a1, 0
	bne	a0, a1, .LBB12_74
	j	.LBB12_73
.LBB12_73:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 7
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_74
.LBB12_74:
	j	.LBB12_75
.LBB12_75:
	j	.LBB12_76
.LBB12_76:
	j	.LBB12_77
.LBB12_77:
	j	.LBB12_78
.LBB12_78:
	j	.LBB12_79
.LBB12_79:
	j	.LBB12_80
.LBB12_80:
	j	.LBB12_81
.LBB12_81:
	j	.LBB12_82
.LBB12_82:
	j	.LBB12_83
.LBB12_83:
	j	.LBB12_84
.LBB12_84:
	j	.LBB12_85
.LBB12_85:
	j	.LBB12_86
.LBB12_86:
	j	.LBB12_87
.LBB12_87:
	j	.LBB12_88
.LBB12_88:
	j	.LBB12_89
.LBB12_89:
	j	.LBB12_90
.LBB12_90:
	j	.LBB12_91
.LBB12_91:
	j	.LBB12_92
.LBB12_92:
	j	.LBB12_93
.LBB12_93:
	j	.LBB12_94
.LBB12_94:
	j	.LBB12_95
.LBB12_95:
	j	.LBB12_96
.LBB12_96:
	j	.LBB12_97
.LBB12_97:
	j	.LBB12_98
.LBB12_98:
	j	.LBB12_99
.LBB12_99:
	j	.LBB12_100
.LBB12_100:
	j	.LBB12_101
.LBB12_101:
	j	.LBB12_102
.LBB12_102:
	j	.LBB12_103
.LBB12_103:
	j	.LBB12_104
.LBB12_104:
	j	.LBB12_105
.LBB12_105:
	j	.LBB12_106
.LBB12_106:
	j	.LBB12_107
.LBB12_107:
	j	.LBB12_108
.LBB12_108:
	j	.LBB12_109
.LBB12_109:
	j	.LBB12_110
.LBB12_110:
	lw	a0, -20(s0)
	lw	a1, -16(s0)
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	sw	a0, 4(a1)
	lw	a0, -28(s0)
	lw	a1, -16(s0)
	sw	a0, 8(a1)
	lw	a0, -32(s0)
	lw	a1, -16(s0)
	sw	a0, 12(a1)
	lw	a0, -36(s0)
	lw	a1, -16(s0)
	sw	a0, 16(a1)
	lw	a0, -40(s0)
	lw	a1, -16(s0)
	sw	a0, 20(a1)
	lw	a0, -44(s0)
	lw	a1, -16(s0)
	sw	a0, 24(a1)
	lw	a0, -48(s0)
	lw	a1, -16(s0)
	sw	a0, 28(a1)
	lw	ra, 92(sp)
	lw	s0, 88(sp)
	addi	sp, sp, 96
	ret
.Lfunc_end12:
	.size	get_inst_data, .Lfunc_end12-get_inst_data

	.globl	fexp
	.p2align	2
	.type	fexp,@function
fexp:
	addi	sp, sp, -32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	addi	s0, sp, 32
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	lw	a0, -20(s0)
	li	a1, 0
	bne	a0, a1, .LBB13_2
	j	.LBB13_1
.LBB13_1:
	li	a0, 1
	sw	a0, -12(s0)
	j	.LBB13_5
.LBB13_2:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	srli	a1, a1, 1
	call	fexp
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	mul	a0, a0, a0
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	andi	a0, a0, 1
	li	a1, 0
	beq	a0, a1, .LBB13_4
	j	.LBB13_3
.LBB13_3:
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	mul	a0, a0, a1
	sw	a0, -24(s0)
	j	.LBB13_4
.LBB13_4:
	lw	a0, -24(s0)
	sw	a0, -12(s0)
	j	.LBB13_5
.LBB13_5:
	lw	a0, -12(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end13:
	.size	fexp, .Lfunc_end13-fexp

	.globl	main
	.p2align	2
	.type	main,@function
main:
	addi	sp, sp, -144
	sw	ra, 140(sp)
	sw	s0, 136(sp)
	addi	s0, sp, 144
	li	a0, 0
	sw	a0, -96(s0)
	sw	a0, -12(s0)
	addi	a1, s0, -53
	sw	a1, -100(s0)
	li	a2, 41
	call	read
	lw	a0, -100(s0)
	addi	a1, s0, -88
	call	get_inst_data
	lw	a1, -96(s0)
	sw	a1, -92(s0)
	lw	a0, -60(s0)
	bne	a0, a1, .LBB14_2
	j	.LBB14_1
.LBB14_1:
	lw	a1, -88(s0)
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -84(s0)
	slli	a1, a0, 7
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -68(s0)
	slli	a1, a0, 12
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -80(s0)
	slli	a1, a0, 15
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -76(s0)
	slli	a1, a0, 20
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -64(s0)
	slli	a1, a0, 25
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	j	.LBB14_17
.LBB14_2:
	lw	a0, -60(s0)
	li	a1, 1
	bne	a0, a1, .LBB14_4
	j	.LBB14_3
.LBB14_3:
	lw	a1, -88(s0)
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -84(s0)
	slli	a1, a0, 7
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -68(s0)
	slli	a1, a0, 12
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -80(s0)
	slli	a1, a0, 15
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -72(s0)
	sw	a0, -104(s0)
	li	a0, 2
	li	a1, 12
	call	fexp
	mv	a1, a0
	lw	a0, -104(s0)
	addi	a1, a1, -1
	and	a0, a0, a1
	slli	a1, a0, 20
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	j	.LBB14_16
.LBB14_4:
	lw	a0, -60(s0)
	li	a1, 2
	bne	a0, a1, .LBB14_6
	j	.LBB14_5
.LBB14_5:
	lw	a1, -88(s0)
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -72(s0)
	sw	a0, -108(s0)
	li	a0, 2
	li	a1, 5
	call	fexp
	mv	a1, a0
	lw	a0, -108(s0)
	addi	a1, a1, -1
	and	a0, a0, a1
	slli	a1, a0, 7
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -68(s0)
	slli	a1, a0, 12
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -80(s0)
	slli	a1, a0, 15
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -76(s0)
	slli	a1, a0, 20
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -72(s0)
	andi	a0, a0, 96
	slli	a1, a0, 25
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	j	.LBB14_15
.LBB14_6:
	lw	a0, -60(s0)
	li	a1, 3
	bne	a0, a1, .LBB14_8
	j	.LBB14_7
.LBB14_7:
	lw	a1, -88(s0)
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -72(s0)
	sw	a0, -120(s0)
	li	a0, 2
	sw	a0, -116(s0)
	li	a1, 11
	call	fexp
	lw	a1, -120(s0)
	mv	a2, a0
	lw	a0, -116(s0)
	and	a1, a1, a2
	slli	a2, a1, 7
	lw	a1, -92(s0)
	or	a1, a1, a2
	sw	a1, -92(s0)
	lw	a1, -72(s0)
	andi	a1, a1, 30
	slli	a2, a1, 8
	lw	a1, -92(s0)
	or	a1, a1, a2
	sw	a1, -92(s0)
	lw	a1, -68(s0)
	slli	a2, a1, 12
	lw	a1, -92(s0)
	or	a1, a1, a2
	sw	a1, -92(s0)
	lw	a1, -80(s0)
	slli	a2, a1, 15
	lw	a1, -92(s0)
	or	a1, a1, a2
	sw	a1, -92(s0)
	lw	a1, -76(s0)
	slli	a2, a1, 20
	lw	a1, -92(s0)
	or	a1, a1, a2
	sw	a1, -92(s0)
	lw	a1, -72(s0)
	andi	a1, a1, 96
	slli	a2, a1, 25
	lw	a1, -92(s0)
	or	a1, a1, a2
	sw	a1, -92(s0)
	lw	a1, -72(s0)
	sw	a1, -112(s0)
	li	a1, 12
	call	fexp
	mv	a1, a0
	lw	a0, -112(s0)
	and	a0, a0, a1
	slli	a1, a0, 30
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	j	.LBB14_14
.LBB14_8:
	lw	a0, -60(s0)
	li	a1, 3
	bne	a0, a1, .LBB14_10
	j	.LBB14_9
.LBB14_9:
	lw	a1, -88(s0)
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -84(s0)
	slli	a1, a0, 7
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -72(s0)
	sw	a0, -124(s0)
	li	a0, 2
	li	a1, 21
	call	fexp
	mv	a1, a0
	lw	a0, -124(s0)
	addi	a1, a1, -1
	and	a0, a0, a1
	slli	a1, a0, 12
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	j	.LBB14_13
.LBB14_10:
	lw	a0, -60(s0)
	li	a1, 5
	bne	a0, a1, .LBB14_12
	j	.LBB14_11
.LBB14_11:
	lw	a1, -88(s0)
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -84(s0)
	slli	a1, a0, 7
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -72(s0)
	lui	a1, 255
	and	a0, a0, a1
	slli	a1, a0, 12
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	lw	a0, -72(s0)
	sw	a0, -136(s0)
	li	a0, 2
	sw	a0, -132(s0)
	li	a1, 11
	call	fexp
	lw	a1, -136(s0)
	mv	a2, a0
	lw	a0, -132(s0)
	and	a1, a1, a2
	slli	a2, a1, 20
	lw	a1, -92(s0)
	or	a1, a1, a2
	sw	a1, -92(s0)
	lw	a1, -72(s0)
	andi	a1, a1, 2046
	slli	a2, a1, 21
	lw	a1, -92(s0)
	or	a1, a1, a2
	sw	a1, -92(s0)
	lw	a1, -72(s0)
	sw	a1, -128(s0)
	li	a1, 20
	call	fexp
	mv	a1, a0
	lw	a0, -128(s0)
	and	a0, a0, a1
	slli	a1, a0, 30
	lw	a0, -92(s0)
	or	a0, a0, a1
	sw	a0, -92(s0)
	j	.LBB14_12
.LBB14_12:
	j	.LBB14_13
.LBB14_13:
	j	.LBB14_14
.LBB14_14:
	j	.LBB14_15
.LBB14_15:
	j	.LBB14_16
.LBB14_16:
	j	.LBB14_17
.LBB14_17:
	lw	a0, -92(s0)
	call	hex_code
	li	a0, 0
	lw	ra, 140(sp)
	lw	s0, 136(sp)
	addi	sp, sp, 144
	ret
.Lfunc_end14:
	.size	main, .Lfunc_end14-main

	.globl	_start
	.p2align	2
	.type	_start,@function
_start:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	addi	s0, sp, 16
	call	main
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	call	exit
.Lfunc_end15:
	.size	_start, .Lfunc_end15-_start

	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"lui"
	.size	.L.str, 4

	.type	.L.str.1,@object
.L.str.1:
	.asciz	"auipc "
	.size	.L.str.1, 7

	.type	.L.str.2,@object
.L.str.2:
	.asciz	"jal "
	.size	.L.str.2, 5

	.type	.L.str.3,@object
.L.str.3:
	.asciz	"jalr "
	.size	.L.str.3, 6

	.type	.L.str.4,@object
.L.str.4:
	.asciz	"beq "
	.size	.L.str.4, 5

	.type	.L.str.5,@object
.L.str.5:
	.asciz	"bne "
	.size	.L.str.5, 5

	.type	.L.str.6,@object
.L.str.6:
	.asciz	"blt "
	.size	.L.str.6, 5

	.type	.L.str.7,@object
.L.str.7:
	.asciz	"bge "
	.size	.L.str.7, 5

	.type	.L.str.8,@object
.L.str.8:
	.asciz	"bltu "
	.size	.L.str.8, 6

	.type	.L.str.9,@object
.L.str.9:
	.asciz	"bgeu "
	.size	.L.str.9, 6

	.type	.L.str.10,@object
.L.str.10:
	.asciz	"lb "
	.size	.L.str.10, 4

	.type	.L.str.11,@object
.L.str.11:
	.asciz	"lh "
	.size	.L.str.11, 4

	.type	.L.str.12,@object
.L.str.12:
	.asciz	"lw "
	.size	.L.str.12, 4

	.type	.L.str.13,@object
.L.str.13:
	.asciz	"lbu "
	.size	.L.str.13, 5

	.type	.L.str.14,@object
.L.str.14:
	.asciz	"lhu "
	.size	.L.str.14, 5

	.type	.L.str.15,@object
.L.str.15:
	.asciz	"sb "
	.size	.L.str.15, 4

	.type	.L.str.16,@object
.L.str.16:
	.asciz	"sh "
	.size	.L.str.16, 4

	.type	.L.str.17,@object
.L.str.17:
	.asciz	"sw "
	.size	.L.str.17, 4

	.type	.L.str.18,@object
.L.str.18:
	.asciz	"addi "
	.size	.L.str.18, 6

	.type	.L.str.19,@object
.L.str.19:
	.asciz	"slti "
	.size	.L.str.19, 6

	.type	.L.str.20,@object
.L.str.20:
	.asciz	"sltiu "
	.size	.L.str.20, 7

	.type	.L.str.21,@object
.L.str.21:
	.asciz	"xori "
	.size	.L.str.21, 6

	.type	.L.str.22,@object
.L.str.22:
	.asciz	"ori "
	.size	.L.str.22, 5

	.type	.L.str.23,@object
.L.str.23:
	.asciz	"andi "
	.size	.L.str.23, 6

	.type	.L.str.24,@object
.L.str.24:
	.asciz	"slli "
	.size	.L.str.24, 6

	.type	.L.str.25,@object
.L.str.25:
	.asciz	"srli "
	.size	.L.str.25, 6

	.type	.L.str.26,@object
.L.str.26:
	.asciz	"srai "
	.size	.L.str.26, 6

	.type	.L.str.27,@object
.L.str.27:
	.asciz	"add "
	.size	.L.str.27, 5

	.type	.L.str.28,@object
.L.str.28:
	.asciz	"sub "
	.size	.L.str.28, 5

	.type	.L.str.29,@object
.L.str.29:
	.asciz	"sll "
	.size	.L.str.29, 5

	.type	.L.str.30,@object
.L.str.30:
	.asciz	"slt "
	.size	.L.str.30, 5

	.type	.L.str.31,@object
.L.str.31:
	.asciz	"sltu "
	.size	.L.str.31, 6

	.type	.L.str.32,@object
.L.str.32:
	.asciz	"xor "
	.size	.L.str.32, 5

	.type	.L.str.33,@object
.L.str.33:
	.asciz	"srl "
	.size	.L.str.33, 5

	.type	.L.str.34,@object
.L.str.34:
	.asciz	"sra "
	.size	.L.str.34, 5

	.type	.L.str.35,@object
.L.str.35:
	.asciz	"or "
	.size	.L.str.35, 4

	.type	.L.str.36,@object
.L.str.36:
	.asciz	"and "
	.size	.L.str.36, 5

	.ident	"Ubuntu clang version 15.0.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym exit
	.addrsig_sym hex_code
	.addrsig_sym strcmp_custom
	.addrsig_sym dec_to_int
	.addrsig_sym get_register
	.addrsig_sym get_immediate
	.addrsig_sym rd_imm
	.addrsig_sym r1_r2_imm
	.addrsig_sym r1_imm_r2
	.addrsig_sym r1_r2_r3
	.addrsig_sym get_inst_data
	.addrsig_sym fexp
	.addrsig_sym main
