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

conv:
  # a0 = x
  # a1 = y
  # s0 addr @ buffer[x][y]
  # s1 = result of conv
  # s2 = dir[0]
  # s3 = dir[1]
  # s4 = multiplier

  # CASO : i+dir[0] , j+dir[1]
  add t3, a0, s2
  add t4, a1, s3

  #check indices
  li t6, 0
  blt t3, t6, 1f # if i < 0
  blt t4, t6, 1f # if j < 0
  li t6, 10
  bge t3, t6, 1f # if i >= 10
  bge t4, t6, 1f # if j >= 10
    # -

  li t5, 10
  mul t3, t3, t5
  add t3, t3, t4
  la t5, buffer # 0x12202
  addi t5, t5, 13
  add t5, t5, t3
  lbu t5, 0(t5) # pixel @ t3*10 + t4

  mv t6, s4
  mul t6, t5, t6
  add s1, s1, t6
  1:
 
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
  mv a0, a3 # x
  mv a1, a4 # y
  li s1, 0  # result of conv

  first:
  # first line
  li s2, -1 # x dir
  li s3, -1 # y dir
  li s4, -1 # conv multiplier
  jal conv

  li s2, -1 # x dir
  li s3,  0 # y dir
  li s4, -1 # conv multiplier
  jal conv

  li s2, -1 # x dir
  li s3,  1 # y dir
  li s4, -1 # conv multiplier
  jal conv

  second:
  # second line
  li s2,  0 # x dir
  li s3, -1 # y dir
  li s4, -1 # conv multiplier
  jal conv

  li s2,  0 # x dir
  li s3,  0 # y dir
  li s4,  8 # conv multiplier
  jal conv

  li s2,  0 # x dir
  li s3,  1 # y dir
  li s4, -1 # conv multiplier
  jal conv

  third:
  # third line
  li s2,  1 # x dir
  li s3, -1 # y dir
  li s4, -1 # conv multiplier
  jal conv

  li s2,  1 # x dir
  li s3,  0 # y dir
  li s4,  -1 # conv multiplier
  jal conv

  li s2,  1 # x dir
  li s3,  1 # y dir
  li s4, -1 # conv multiplier
  jal conv
  # ----
  # s1 has the final result of conv
  here:
  mv t1, s1
  # clip t1 to be in (0,255)
  li t2, 256
  blt t1, t2, 1f # if t1 < 256
  li t1, 255      
  j 2f
  1:
  li t2, 0
  bge t1, t2, 2f # if t1 >= 0
  li t1, 0
  # --------
  2:
  # zerar a borda
  bne a0, zero, 3f # a0 != 0
  li t1, 0
  3:
  bne a1, zero, 4f # a1 != 0
  li t1, 0
  4:
  li t2, 9
  bne a0, t2, 5f # a0 != 9
  li t1, 0
  5:
  bne a1, t2, 6f # a1 != 9
  li t1, 0 

  6:
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
