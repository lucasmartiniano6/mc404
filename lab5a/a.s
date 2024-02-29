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
	bne	a0, a1, .LBB4_2
	j	.LBB4_1
.LBB4_1:
	li	a0, 1
	sw	a0, -12(s0)
	j	.LBB4_5
.LBB4_2:
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
	beq	a0, a1, .LBB4_4
	j	.LBB4_3
.LBB4_3:
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	mul	a0, a0, a1
	sw	a0, -24(s0)
	j	.LBB4_4
.LBB4_4:
	lw	a0, -24(s0)
	sw	a0, -12(s0)
	j	.LBB4_5
.LBB4_5:
	lw	a0, -12(s0)
	lw	ra, 28(sp)
	lw	s0, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	fexp, .Lfunc_end4-fexp

	.globl	main
	.p2align	2
	.type	main,@function
main:
	addi	sp, sp, -112
	sw	ra, 108(sp)
	sw	s0, 104(sp)
	addi	s0, sp, 112
	li	a0, 0
	sw	a0, -72(s0)
	sw	a0, -12(s0)
	lui	a1, %hi(buffer)
	addi	a1, a1, %lo(buffer)
	li	a2, 30
	call	read
	li	a0, 2
	sw	a0, -84(s0)
	li	a1, 3
	sw	a1, -76(s0)
	call	fexp
	mv	a1, a0
	lw	a0, -84(s0)
	addi	a1, a1, -1
	sw	a1, -32(s0)
	li	a1, 8
	call	fexp
	mv	a1, a0
	lw	a0, -84(s0)
	addi	a1, a1, -1
	sw	a1, -28(s0)
	li	a1, 5
	sw	a1, -88(s0)
	call	fexp
	lw	a1, -88(s0)
	mv	a2, a0
	lw	a0, -84(s0)
	addi	a2, a2, -1
	sw	a2, -24(s0)
	call	fexp
	mv	a1, a0
	lw	a0, -84(s0)
	addi	a1, a1, -1
	sw	a1, -20(s0)
	li	a1, 11
	sw	a1, -80(s0)
	call	fexp
	lw	a2, -80(s0)
	lw	a1, -76(s0)
	mv	a3, a0
	lw	a0, -72(s0)
	addi	a3, a3, -1
	sw	a3, -16(s0)
	li	a3, 21
	sw	a3, -36(s0)
	li	a3, 16
	sw	a3, -40(s0)
	sw	a2, -44(s0)
	sw	a1, -48(s0)
	sw	a0, -52(s0)
	sw	a0, -56(s0)
	sw	a0, -60(s0)
	j	.LBB5_1
.LBB5_1:
	lw	a1, -60(s0)
	li	a0, 29
	blt	a0, a1, .LBB5_10
	j	.LBB5_2
.LBB5_2:
	li	a0, 0
	sw	a0, -64(s0)
	lw	a0, -60(s0)
	addi	a0, a0, 1
	sw	a0, -68(s0)
	j	.LBB5_3
.LBB5_3:
	lw	a1, -68(s0)
	lw	a0, -60(s0)
	addi	a0, a0, 4
	blt	a0, a1, .LBB5_6
	j	.LBB5_4
.LBB5_4:
	lw	a1, -68(s0)
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	addi	a0, a0, -48
	sw	a0, -92(s0)
	lw	a0, -60(s0)
	sub	a0, a0, a1
	addi	a1, a0, 4
	li	a0, 10
	call	fexp
	mv	a1, a0
	lw	a0, -92(s0)
	mul	a1, a0, a1
	lw	a0, -64(s0)
	add	a0, a0, a1
	sw	a0, -64(s0)
	j	.LBB5_5
.LBB5_5:
	lw	a0, -68(s0)
	addi	a0, a0, 1
	sw	a0, -68(s0)
	j	.LBB5_3
.LBB5_6:
	lw	a1, -60(s0)
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 45
	bne	a0, a1, .LBB5_8
	j	.LBB5_7
.LBB5_7:
	lw	a1, -64(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -64(s0)
	j	.LBB5_8
.LBB5_8:
	lw	a0, -64(s0)
	lw	a1, -60(s0)
	lui	a2, 174763
	addi	a2, a2, -1365
	sw	a2, -100(s0)
	mulh	a1, a1, a2
	srli	a2, a1, 31
	add	a1, a1, a2
	slli	a2, a1, 2
	addi	a1, s0, -32
	sw	a1, -96(s0)
	add	a1, a1, a2
	lw	a1, 0(a1)
	and	a0, a0, a1
	call	hex_code
	lw	a3, -100(s0)
	lw	a1, -96(s0)
	lw	a0, -64(s0)
	lw	a2, -60(s0)
	mulh	a2, a2, a3
	srli	a3, a2, 31
	add	a2, a2, a3
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a1, 0(a1)
	and	a0, a0, a1
	addi	a1, s0, -52
	add	a1, a1, a2
	lw	a1, 0(a1)
	sll	a1, a0, a1
	lw	a0, -56(s0)
	or	a0, a0, a1
	sw	a0, -56(s0)
	j	.LBB5_9
.LBB5_9:
	lw	a0, -60(s0)
	addi	a0, a0, 6
	sw	a0, -60(s0)
	j	.LBB5_1
.LBB5_10:
	lw	a0, -56(s0)
	call	hex_code
	lw	a0, -12(s0)
	lw	ra, 108(sp)
	lw	s0, 104(sp)
	addi	sp, sp, 112
	ret
.Lfunc_end5:
	.size	main, .Lfunc_end5-main

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
.Lfunc_end6:
	.size	_start, .Lfunc_end6-_start

	.type	buffer,@object
	.bss
	.globl	buffer
buffer:
	.zero	30
	.size	buffer, 30

	.type	.L__const.main.shift,@object
	.section	.rodata,"a",@progbits
	.p2align	2
.L__const.main.shift:
	.word	0
	.word	3
	.word	11
	.word	16
	.word	21
	.size	.L__const.main.shift, 20

	.ident	"Ubuntu clang version 15.0.7"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym exit
	.addrsig_sym hex_code
	.addrsig_sym fexp
	.addrsig_sym main
	.addrsig_sym buffer
