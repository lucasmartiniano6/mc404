.globl _start

.data
input_file: .asciz "image.pgm"
buffer:     .skip 115  # buffer

.text
open:
	la a0, input_file    # address for the file path
	li a1, 0             # flags (0: rdonly
	li a2, 0             # mode
	li a7, 1024          # syscall open 
	ecall
  ret 

read:
	# li a0, 0  # file descriptor = 0 (stdin)
	la a1, buffer        #  buffer to write the data
	li a2, 115  # size (reads only 1 byte)
	li a7, 63 # syscall read (63)
	ecall
  ret 

setPixel:
  add a0, a4, zero # x coord
  add a1, a3, zero # y coord
	add a2, a5, zero   # black pixel
	li a7, 2200 # syscall setPixel (2200)
	ecall
  ret 

setCanvaSize:
  li a0, 10
  li a1, 10
  li a7, 2201
  ecall
  ret

_start:
	jal open
	jal read 
  jal setCanvaSize

  li t0, 10
  li a3, -1 # x
  la s0, buffer
  addi s0, s0, 13
for:
  addi a3, a3, 1
  bge a3, t0, sair
  
  li a4, 0
inner:
  bge a4, t0, for
  lbu t1, 0(s0)
  addi s0, s0, 1
  add t2, zero, zero
shift:
  slli t2, t1, 8
  slli t1, t1, 16
  add t2, t2, t1
  slli t1, t1, 8
  add t2, t2, t1
  addi t2, t2, 0xFF
	# li a5, 0x000000FF # black pixel
  mv a5, t2
  jal setPixel
  addi a4, a4, 1
  j inner

sair:
