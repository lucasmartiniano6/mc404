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
	li	a7, 63	# syscall write code (63) 
	ecall		# invoke syscall 
	mv	a3, a0	# move return value to ret_val

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
	bne	a0, a1, .LBB3_2
	j	.LBB3_1
.LBB3_1:
	li	a0, 1
	sw	a0, -12(s0)
	j	.LBB3_5
.LBB3_2:
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
	beq	a0, a1, .LBB3_4
	j	.LBB3_3
.LBB3_3:
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	mul	a0, a0, a1
	sw	a0, -24(s0)
	j	.LBB3_4
.LBB3_4:
	lw	a0, -24(s0)
	sw	a0, -12(s0)
	j	.LBB3_5
.LBB3_5:
	lw	a0, -12(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end3:
	.size	fexp, .Lfunc_end3-fexp

	.globl	base2_complement
	.p2align	2
	.type	base2_complement,@function
base2_complement:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	addi	s0, sp, 16
	sw	a0, -12(s0)
	li	a0, -1
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	lw	a1, -12(s0)
	sub	a0, a0, a1
	addi	a0, a0, 1
	lw	ra, 12(sp)
	lw	s0, 8(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end4:
	.size	base2_complement, .Lfunc_end4-base2_complement

	.globl	digit_to_hex
	.p2align	2
	.type	digit_to_hex,@function
digit_to_hex:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	li	a1, 10
	bne	a0, a1, .LBB5_2
	j	.LBB5_1
.LBB5_1:
	li	a0, 97
	sw	a0, -12(s0)
	j	.LBB5_18
.LBB5_2:
	lw	a0, -12(s0)
	li	a1, 11
	bne	a0, a1, .LBB5_4
	j	.LBB5_3
.LBB5_3:
	li	a0, 98
	sw	a0, -12(s0)
	j	.LBB5_17
.LBB5_4:
	lw	a0, -12(s0)
	li	a1, 12
	bne	a0, a1, .LBB5_6
	j	.LBB5_5
.LBB5_5:
	li	a0, 99
	sw	a0, -12(s0)
	j	.LBB5_16
.LBB5_6:
	lw	a0, -12(s0)
	li	a1, 13
	bne	a0, a1, .LBB5_8
	j	.LBB5_7
.LBB5_7:
	li	a0, 100
	sw	a0, -12(s0)
	j	.LBB5_15
.LBB5_8:
	lw	a0, -12(s0)
	li	a1, 14
	bne	a0, a1, .LBB5_10
	j	.LBB5_9
.LBB5_9:
	li	a0, 101
	sw	a0, -12(s0)
	j	.LBB5_14
.LBB5_10:
	lw	a0, -12(s0)
	li	a1, 15
	bne	a0, a1, .LBB5_12
	j	.LBB5_11
.LBB5_11:
	li	a0, 102
	sw	a0, -12(s0)
	j	.LBB5_13
.LBB5_12:
	lw	a0, -12(s0)
	addi	a0, a0, 48
	sw	a0, -12(s0)
	j	.LBB5_13
.LBB5_13:
	j	.LBB5_14
.LBB5_14:
	j	.LBB5_15
.LBB5_15:
	j	.LBB5_16
.LBB5_16:
	j	.LBB5_17
.LBB5_17:
	j	.LBB5_18
.LBB5_18:
	lbu	a0, -12(s0)
	lw	ra, 12(sp)
	lw	s0, 8(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end5:
	.size	digit_to_hex, .Lfunc_end5-digit_to_hex

	.globl	hex_to_digit
	.p2align	2
	.type	hex_to_digit,@function
hex_to_digit:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	addi	s0, sp, 16
	sb	a0, -9(s0)
	lbu	a0, -9(s0)
	li	a1, 97
	bne	a0, a1, .LBB6_2
	j	.LBB6_1
.LBB6_1:
	li	a0, 10
	sw	a0, -16(s0)
	j	.LBB6_18
.LBB6_2:
	lbu	a0, -9(s0)
	li	a1, 98
	bne	a0, a1, .LBB6_4
	j	.LBB6_3
.LBB6_3:
	li	a0, 11
	sw	a0, -16(s0)
	j	.LBB6_17
.LBB6_4:
	lbu	a0, -9(s0)
	li	a1, 99
	bne	a0, a1, .LBB6_6
	j	.LBB6_5
.LBB6_5:
	li	a0, 12
	sw	a0, -16(s0)
	j	.LBB6_16
.LBB6_6:
	lbu	a0, -9(s0)
	li	a1, 100
	bne	a0, a1, .LBB6_8
	j	.LBB6_7
.LBB6_7:
	li	a0, 13
	sw	a0, -16(s0)
	j	.LBB6_15
.LBB6_8:
	lbu	a0, -9(s0)
	li	a1, 101
	bne	a0, a1, .LBB6_10
	j	.LBB6_9
.LBB6_9:
	li	a0, 14
	sw	a0, -16(s0)
	j	.LBB6_14
.LBB6_10:
	lbu	a0, -9(s0)
	li	a1, 102
	bne	a0, a1, .LBB6_12
	j	.LBB6_11
.LBB6_11:
	li	a0, 15
	sw	a0, -16(s0)
	j	.LBB6_13
.LBB6_12:
	lbu	a0, -9(s0)
	addi	a0, a0, -48
	sw	a0, -16(s0)
	j	.LBB6_13
.LBB6_13:
	j	.LBB6_14
.LBB6_14:
	j	.LBB6_15
.LBB6_15:
	j	.LBB6_16
.LBB6_16:
	j	.LBB6_17
.LBB6_17:
	j	.LBB6_18
.LBB6_18:
	lw	a0, -16(s0)
	lw	ra, 12(sp)
	lw	s0, 8(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end6:
	.size	hex_to_digit, .Lfunc_end6-hex_to_digit

	.globl	change_base
	.p2align	2
	.type	change_base,@function
change_base:
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
	li	a1, 0
	beq	a0, a1, .LBB7_3
	j	.LBB7_2
.LBB7_2:
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	remu	a0, a0, a1
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	divu	a0, a0, a1
	sw	a0, -12(s0)
	lw	a0, -24(s0)
	call	digit_to_hex
	lw	a2, -20(s0)
	lui	a1, %hi(digits)
	addi	a1, a1, %lo(digits)
	add	a1, a1, a2
	sb	a0, 0(a1)
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB7_1
.LBB7_3:
	lw	a0, -20(s0)
	lui	a1, %hi(tamanho)
	sw	a0, %lo(tamanho)(a1)
	lw	a1, -20(s0)
	lui	a0, %hi(digits)
	addi	a0, a0, %lo(digits)
	add	a1, a0, a1
	li	a0, 10
	sb	a0, 0(a1)
	li	a0, 0
	sw	a0, -28(s0)
	j	.LBB7_4
.LBB7_4:
	lw	a0, -28(s0)
	lw	a1, -20(s0)
	srli	a2, a1, 31
	add	a1, a1, a2
	srai	a1, a1, 1
	bge	a0, a1, .LBB7_7
	j	.LBB7_5
.LBB7_5:
	lw	a0, -28(s0)
	lui	a1, %hi(digits)
	addi	a2, a1, %lo(digits)
	add	a0, a2, a0
	lb	a0, 0(a0)
	sb	a0, -29(s0)
	lw	a0, -20(s0)
	lw	a1, -28(s0)
	sub	a0, a0, a1
	add	a0, a0, a2
	lb	a0, -1(a0)
	add	a1, a2, a1
	sb	a0, 0(a1)
	lb	a0, -29(s0)
	lw	a1, -20(s0)
	lw	a3, -28(s0)
	sub	a1, a1, a3
	add	a1, a1, a2
	sb	a0, -1(a1)
	j	.LBB7_6
.LBB7_6:
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB7_4
.LBB7_7:
	lw	a0, -20(s0)
	addi	a2, a0, 1
	lui	a0, %hi(digits)
	addi	a1, a0, %lo(digits)
	li	a0, 1
	call	write
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end7:
	.size	change_base, .Lfunc_end7-change_base

	.globl	main
	.p2align	2
	.type	main,@function
main:
	addi	sp, sp, -144
	sw	ra, 140(sp)
	sw	s0, 136(sp)
	addi	s0, sp, 144
	li	a0, 0
	sw	a0, -116(s0)
	sw	a0, -12(s0)
	addi	a1, s0, -48
	li	a2, 20
	call	read
	mv	a1, a0
	lw	a0, -116(s0)
	sw	a1, -52(s0)
	sw	a0, -56(s0)
	lbu	a0, -48(s0)
	li	a1, 48
	bne	a0, a1, .LBB8_28
	j	.LBB8_1
.LBB8_1:
	lbu	a0, -47(s0)
	li	a1, 120
	bne	a0, a1, .LBB8_28
	j	.LBB8_2
.LBB8_2:
	li	a0, 0
	sw	a0, -60(s0)
	j	.LBB8_3
.LBB8_3:
	lw	a0, -60(s0)
	addi	a1, s0, -48
	add	a0, a0, a1
	lbu	a0, 2(a0)
	li	a1, 10
	beq	a0, a1, .LBB8_5
	j	.LBB8_4
.LBB8_4:
	lw	a0, -60(s0)
	addi	a0, a0, 1
	sw	a0, -60(s0)
	j	.LBB8_3
.LBB8_5:
	lw	a0, -60(s0)
	addi	a0, a0, 1
	sw	a0, -68(s0)
	j	.LBB8_6
.LBB8_6:
	lw	a0, -68(s0)
	li	a1, 2
	blt	a0, a1, .LBB8_27
	j	.LBB8_7
.LBB8_7:
	lw	a1, -68(s0)
	addi	a0, s0, -48
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 97
	bne	a0, a1, .LBB8_9
	j	.LBB8_8
.LBB8_8:
	li	a0, 10
	sw	a0, -64(s0)
	j	.LBB8_25
.LBB8_9:
	lw	a1, -68(s0)
	addi	a0, s0, -48
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 98
	bne	a0, a1, .LBB8_11
	j	.LBB8_10
.LBB8_10:
	li	a0, 11
	sw	a0, -64(s0)
	j	.LBB8_24
.LBB8_11:
	lw	a1, -68(s0)
	addi	a0, s0, -48
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 99
	bne	a0, a1, .LBB8_13
	j	.LBB8_12
.LBB8_12:
	li	a0, 12
	sw	a0, -64(s0)
	j	.LBB8_23
.LBB8_13:
	lw	a1, -68(s0)
	addi	a0, s0, -48
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 100
	bne	a0, a1, .LBB8_15
	j	.LBB8_14
.LBB8_14:
	li	a0, 13
	sw	a0, -64(s0)
	j	.LBB8_22
.LBB8_15:
	lw	a1, -68(s0)
	addi	a0, s0, -48
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 101
	bne	a0, a1, .LBB8_17
	j	.LBB8_16
.LBB8_16:
	li	a0, 14
	sw	a0, -64(s0)
	j	.LBB8_21
.LBB8_17:
	lw	a1, -68(s0)
	addi	a0, s0, -48
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 102
	bne	a0, a1, .LBB8_19
	j	.LBB8_18
.LBB8_18:
	li	a0, 15
	sw	a0, -64(s0)
	j	.LBB8_20
.LBB8_19:
	lw	a1, -68(s0)
	addi	a0, s0, -48
	add	a0, a0, a1
	lbu	a0, 0(a0)
	addi	a0, a0, -48
	sw	a0, -64(s0)
	j	.LBB8_20
.LBB8_20:
	j	.LBB8_21
.LBB8_21:
	j	.LBB8_22
.LBB8_22:
	j	.LBB8_23
.LBB8_23:
	j	.LBB8_24
.LBB8_24:
	j	.LBB8_25
.LBB8_25:
	lw	a0, -64(s0)
	sw	a0, -120(s0)
	lw	a0, -60(s0)
	lw	a1, -68(s0)
	sub	a0, a0, a1
	addi	a1, a0, 1
	li	a0, 16
	call	fexp
	mv	a1, a0
	lw	a0, -120(s0)
	mul	a1, a0, a1
	lw	a0, -56(s0)
	add	a0, a0, a1
	sw	a0, -56(s0)
	j	.LBB8_26
.LBB8_26:
	lw	a0, -68(s0)
	addi	a0, a0, -1
	sw	a0, -68(s0)
	j	.LBB8_6
.LBB8_27:
	j	.LBB8_40
.LBB8_28:
	li	a0, 0
	sw	a0, -72(s0)
	sw	a0, -76(s0)
	lbu	a0, -48(s0)
	li	a1, 45
	bne	a0, a1, .LBB8_30
	j	.LBB8_29
.LBB8_29:
	li	a0, 1
	sw	a0, -76(s0)
	j	.LBB8_30
.LBB8_30:
	j	.LBB8_31
.LBB8_31:
	lw	a0, -72(s0)
	lw	a1, -76(s0)
	add	a1, a0, a1
	addi	a0, s0, -48
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 10
	beq	a0, a1, .LBB8_33
	j	.LBB8_32
.LBB8_32:
	lw	a0, -72(s0)
	addi	a0, a0, 1
	sw	a0, -72(s0)
	j	.LBB8_31
.LBB8_33:
	lw	a0, -72(s0)
	lw	a1, -76(s0)
	add	a0, a0, a1
	addi	a0, a0, -1
	sw	a0, -80(s0)
	j	.LBB8_34
.LBB8_34:
	lw	a0, -80(s0)
	lw	a1, -76(s0)
	blt	a0, a1, .LBB8_37
	j	.LBB8_35
.LBB8_35:
	lw	a0, -80(s0)
	addi	a1, s0, -48
	add	a1, a1, a0
	lbu	a1, 0(a1)
	addi	a1, a1, -48
	sw	a1, -124(s0)
	lw	a1, -72(s0)
	lw	a2, -76(s0)
	add	a1, a1, a2
	not	a0, a0
	add	a1, a0, a1
	li	a0, 10
	call	fexp
	mv	a1, a0
	lw	a0, -124(s0)
	mul	a1, a0, a1
	lw	a0, -56(s0)
	add	a0, a0, a1
	sw	a0, -56(s0)
	j	.LBB8_36
.LBB8_36:
	lw	a0, -80(s0)
	addi	a0, a0, -1
	sw	a0, -80(s0)
	j	.LBB8_34
.LBB8_37:
	lw	a0, -76(s0)
	li	a1, 0
	beq	a0, a1, .LBB8_39
	j	.LBB8_38
.LBB8_38:
	lw	a0, -56(s0)
	call	base2_complement
	sw	a0, -56(s0)
	j	.LBB8_39
.LBB8_39:
	j	.LBB8_40
.LBB8_40:
	lui	a0, 6
	addi	a0, a0, 560
	sh	a0, -82(s0)
	li	a0, 1
	addi	a1, s0, -82
	li	a2, 2
	sw	a2, -128(s0)
	call	write
	lw	a1, -128(s0)
	lw	a0, -56(s0)
	call	change_base
	li	a1, 45
	sb	a1, -82(s0)
	lbu	a0, -48(s0)
	bne	a0, a1, .LBB8_42
	j	.LBB8_41
.LBB8_41:
	addi	a1, s0, -82
	li	a2, 1
	mv	a0, a2
	call	write
	lw	a0, -56(s0)
	call	base2_complement
	li	a1, 10
	call	change_base
	j	.LBB8_45
.LBB8_42:
	lw	a0, -56(s0)
	sw	a0, -132(s0)
	li	a0, 2
	li	a1, 31
	call	fexp
	mv	a1, a0
	lw	a0, -132(s0)
	bltu	a0, a1, .LBB8_44
	j	.LBB8_43
.LBB8_43:
	addi	a1, s0, -82
	li	a2, 1
	mv	a0, a2
	call	write
	j	.LBB8_44
.LBB8_44:
	lw	a0, -56(s0)
	li	a1, 10
	call	change_base
	j	.LBB8_45
.LBB8_45:
	li	a0, 48
	sb	a0, -82(s0)
	li	a0, 120
	sb	a0, -81(s0)
	li	a0, 1
	addi	a1, s0, -82
	li	a2, 2
	call	write
	lw	a0, -56(s0)
	li	a1, 16
	call	change_base
	li	a0, 10
	sb	a0, -84(s0)
	lui	a0, 197379
	addi	a0, a0, 48
	sw	a0, -88(s0)
	sw	a0, -92(s0)
	lui	a0, %hi(tamanho)
	lw	a1, %lo(tamanho)(a0)
	li	a0, 8
	sub	a0, a0, a1
	sw	a0, -96(s0)
	j	.LBB8_46
.LBB8_46:
	lw	a1, -96(s0)
	li	a0, 7
	blt	a0, a1, .LBB8_49
	j	.LBB8_47
.LBB8_47:
	lw	a2, -96(s0)
	lui	a0, %hi(tamanho)
	lw	a0, %lo(tamanho)(a0)
	add	a0, a0, a2
	lui	a1, %hi(digits)
	addi	a1, a1, %lo(digits)
	add	a0, a0, a1
	lb	a0, -8(a0)
	addi	a1, s0, -92
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB8_48
.LBB8_48:
	lw	a0, -96(s0)
	addi	a0, a0, 1
	sw	a0, -96(s0)
	j	.LBB8_46
.LBB8_49:
	li	a0, 0
	sw	a0, -100(s0)
	j	.LBB8_50
.LBB8_50:
	lw	a1, -100(s0)
	li	a0, 3
	blt	a0, a1, .LBB8_53
	j	.LBB8_51
.LBB8_51:
	lw	a0, -100(s0)
	addi	a1, s0, -92
	sw	a1, -136(s0)
	add	a0, a1, a0
	lb	a0, 0(a0)
	sb	a0, -101(s0)
	lw	a2, -100(s0)
	sub	a0, a1, a2
	lb	a0, 6(a0)
	add	a2, a1, a2
	sb	a0, 0(a2)
	lb	a0, -101(s0)
	lw	a2, -100(s0)
	sub	a2, a1, a2
	sb	a0, 6(a2)
	lw	a0, -100(s0)
	add	a0, a0, a1
	lb	a0, 1(a0)
	sb	a0, -101(s0)
	lw	a2, -100(s0)
	sub	a0, a1, a2
	lb	a0, 7(a0)
	add	a2, a2, a1
	sb	a0, 1(a2)
	lb	a0, -101(s0)
	lw	a2, -100(s0)
	sub	a1, a1, a2
	sb	a0, 7(a1)
	j	.LBB8_52
.LBB8_52:
	lw	a0, -100(s0)
	addi	a0, a0, 2
	sw	a0, -100(s0)
	j	.LBB8_50
.LBB8_53:
	li	a0, 1
	sw	a0, -140(s0)
	addi	a1, s0, -82
	li	a2, 2
	call	write
	lw	a0, -140(s0)
	addi	a1, s0, -92
	li	a2, 9
	call	write
	li	a0, 0
	sw	a0, -56(s0)
	sw	a0, -108(s0)
	li	a0, 7
	sw	a0, -112(s0)
	j	.LBB8_54
.LBB8_54:
	lw	a0, -112(s0)
	li	a1, 0
	blt	a0, a1, .LBB8_75
	j	.LBB8_55
.LBB8_55:
	lw	a1, -112(s0)
	addi	a0, s0, -92
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 97
	bne	a0, a1, .LBB8_57
	j	.LBB8_56
.LBB8_56:
	li	a0, 10
	sw	a0, -108(s0)
	j	.LBB8_73
.LBB8_57:
	lw	a1, -112(s0)
	addi	a0, s0, -92
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 98
	bne	a0, a1, .LBB8_59
	j	.LBB8_58
.LBB8_58:
	li	a0, 11
	sw	a0, -108(s0)
	j	.LBB8_72
.LBB8_59:
	lw	a1, -112(s0)
	addi	a0, s0, -92
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 99
	bne	a0, a1, .LBB8_61
	j	.LBB8_60
.LBB8_60:
	li	a0, 12
	sw	a0, -108(s0)
	j	.LBB8_71
.LBB8_61:
	lw	a1, -112(s0)
	addi	a0, s0, -92
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 100
	bne	a0, a1, .LBB8_63
	j	.LBB8_62
.LBB8_62:
	li	a0, 13
	sw	a0, -108(s0)
	j	.LBB8_70
.LBB8_63:
	lw	a1, -112(s0)
	addi	a0, s0, -92
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 101
	bne	a0, a1, .LBB8_65
	j	.LBB8_64
.LBB8_64:
	li	a0, 14
	sw	a0, -108(s0)
	j	.LBB8_69
.LBB8_65:
	lw	a1, -112(s0)
	addi	a0, s0, -92
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 102
	bne	a0, a1, .LBB8_67
	j	.LBB8_66
.LBB8_66:
	li	a0, 15
	sw	a0, -108(s0)
	j	.LBB8_68
.LBB8_67:
	lw	a1, -112(s0)
	addi	a0, s0, -92
	add	a0, a0, a1
	lbu	a0, 0(a0)
	addi	a0, a0, -48
	sw	a0, -108(s0)
	j	.LBB8_68
.LBB8_68:
	j	.LBB8_69
.LBB8_69:
	j	.LBB8_70
.LBB8_70:
	j	.LBB8_71
.LBB8_71:
	j	.LBB8_72
.LBB8_72:
	j	.LBB8_73
.LBB8_73:
	lw	a0, -108(s0)
	sw	a0, -144(s0)
	lw	a1, -112(s0)
	li	a0, 7
	sub	a1, a0, a1
	li	a0, 16
	call	fexp
	mv	a1, a0
	lw	a0, -144(s0)
	mul	a1, a0, a1
	lw	a0, -56(s0)
	add	a0, a0, a1
	sw	a0, -56(s0)
	j	.LBB8_74
.LBB8_74:
	lw	a0, -112(s0)
	addi	a0, a0, -1
	sw	a0, -112(s0)
	j	.LBB8_54
.LBB8_75:
	lw	a0, -56(s0)
	li	a1, 10
	call	change_base
	li	a0, 0
	lw	ra, 140(sp)
	lw	s0, 136(sp)
	addi	sp, sp, 144
	ret
.Lfunc_end8:
	.size	main, .Lfunc_end8-main

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
.Lfunc_end9:
	.size	_start, .Lfunc_end9-_start

	.type	digits,@object
	.bss
	.globl	digits
digits:
	.zero	36
	.size	digits, 36

	.type	tamanho,@object
	.section	.sbss,"aw",@nobits
	.globl	tamanho
	.p2align	2
tamanho:
	.word	0
	.size	tamanho, 4

	.type	.L__const.main.base,@object
	.section	.rodata,"a",@progbits
.L__const.main.base:
	.ascii	"0b"
	.size	.L__const.main.base, 2

	.type	.L__const.main.swap,@object
.L__const.main.swap:
	.ascii	"00000000\n"
	.size	.L__const.main.swap, 9

	.ident	"Ubuntu clang version 15.0.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym exit
	.addrsig_sym fexp
	.addrsig_sym base2_complement
	.addrsig_sym digit_to_hex
	.addrsig_sym change_base
	.addrsig_sym main
	.addrsig_sym digits
	.addrsig_sym tamanho
