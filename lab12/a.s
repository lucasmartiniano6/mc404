.data
buffer: .skip 100
digit_to_char: .byte 0x30, 0x31, 0x32, 0x33, 0x34
               .byte 0x35, 0x36, 0x37, 0x38, 0x39
               .byte 0x41, 0x42, 0x43, 0x44, 0x45, 0x46
string: .skip 100
other:   .skip 100

.text
read:
  addi sp, sp, -16
  sw t0, 0(sp)
  sw t1, 4(sp)
  sw t2, 8(sp)

  li t0, 0xFFFF0100
  li t1, 1
  sb t1, 2(t0)
  1:
  lb t1, 2(t0)
  bnez t1, 1b
  
  lb t1, 3(t0)
  la t0, buffer
  sb t1, 0(t0)

  lw t0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  addi sp, sp, 16
  ret

write:
  addi sp, sp, -16
  sw t0, 0(sp)
  sw t1, 4(sp)
  sw t2, 8(sp)

  la t0, buffer
  lb t1, 0(t0)
  li t0, 0xFFFF0100
  sb t1, 1(t0)

  li t1, 1
  sb t1, 0(t0)
  1:
  lb t1, 0(t0)
  bnez t1, 1b
  
  lw t0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  addi sp, sp, 16
  ret


.globl exit
exit:
  li a7, 93
  ecall
  ret

.globl gets
gets: # a0: stdin "hello\n", a3 = [flag] -> ret : "hello\0"
  addi sp, sp, -16
  sw ra, 0(sp)
  sw s0, 4(sp)
  sw s1, 8(sp)
  sw s2, 12(sp)

  mv s2, a0
  mv s0, a0
  jal read 
  LBU s1, buffer
  li t0, 0x0a # "\n"
  bnez a3, 1f
  li t1, 0x20 # "[space]"
  1:
  beq s1, t0, 1f 
  beq s1, t1, 1f 
  sb s1, 0(s0)
  jal read
  LBU s1, buffer
  addi s0, s0, 1
  j 1b
  1:
  li s1, 0x00
  sb s1, 0(s0)

  mv a0, s2
  lw ra, 0(sp)
  lw s0, 4(sp)
  lw s1, 8(sp)
  lw s2, 12(sp)
  addi sp, sp, 16
  ret

.globl puts
puts: # a0 = "hello\0" -> prints "hello\n"
  addi sp, sp, -16
  sw ra, 0(sp)
  sw s0, 4(sp)
  sw s1, 8(sp)

  mv s0, a0
  lbu s1, 0(s0)
  1:
  beqz s1, 1f 
  SB s1, buffer, a3
  jal write
  addi s0, s0, 1
  lbu s1, 0(s0)
  j 1b
  1:
  li s1, 0x0a
  SB s1, buffer, a3
  jal write

  lw ra, 0(sp)
  lw s0, 4(sp)
  lw s1, 8(sp)
  addi sp, sp, 16
  ret

.globl atoi
atoi: # a0 = "__-23\0" ; ret =-23
  addi sp, sp, -16
  sw ra, 0(sp)
  sw s0, 4(sp)
  sw s1, 8(sp)
  sw s2, 12(sp)
 
  li s2, 0 # final number
  addi s0, a0, -1
  1:
  addi s0, s0, 1
  lbu s1, 0(s0)
  li t0, 0x20 # "[space]"
  beq s1, t0, 1b
  2:
  li t0, 0x2d # "-"
  bne s1, t0, 3f
  li t1, -1
  addi s0, s0, 1
  j 4f
  3:
  li t0, 0x2b # "+"
  li t1, 1
  bne s1, t0, 4f
  addi s0, s0, 1
  4:
  lbu s1, 0(s0)
  li t0, 0x30
  blt s1, t0, 5f
  li t0, 0x3a
  bge s1, t0, 5f
  li t0, 10 
  mul s2, s2, t0
  addi s1, s1, -48
  add s2, s2, s1  
  addi s0, s0, 1
  j 4b
  5:
  mul s2, s2, t1
  mv a0, s2 

  lw ra, 0(sp)
  lw s0, 4(sp)
  lw s1, 8(sp)
  lw s2, 12(sp)
  addi sp, sp, 16
  ret

.globl itoa
itoa: # (int: 123, str, base:10) -> "123\0"
  addi sp, sp, -16
  sw ra, 0(sp)
  sw s0, 4(sp)
  sw s1, 8(sp)

  li s1, 1 # not negative flag
  mv t0, a0
  li t2, -1 # num offset
  1:
  li t5, 10 
  beq a2, t5, 2f
  remu t1, t0, a2
  divu t0, t0, a2
  j 3f
  2:
  rem t1, t0, a2
  div t0, t0, a2
  3:
  addi t2, t2, 1 
  bnez t0, 1b 
  # start addr += size of number
  add s0, a1, t2
  # if number is negative & base 10 (+1 offset)
  bge a0, zero, 1f
  li t0, 10
  bne a2, t0, 1f
  addi s0, s0, 1        
  li s1, 0 # set flag (negative number)
  1:
  # add \0 to end
  addi s0, s0, 1
  sb zero, 0(s0)
  addi s0, s0, -1
  2:
  li t5, 10
  beq a2, t5, 2f
  remu t1, a0, a2
  divu a0, a0, a2
  j 3f
  2:
  rem t1, a0, a2
  div a0, a0, a2
  3:
  bnez s1, 3f # if neg number
  li t3, 0xffffffff # 2**32 - 1
  sub t1, t3, t1
  addi t1, t1, 1
  3:
  la t2, digit_to_char
  add t2, t2, t1
  lbu t2, 0(t2)
  sb t2, 0(s0)
  addi s0, s0, -1
  bnez a0, 2b
  
  bnez s1, 4f # if neg number
  li t2, 0x2d
  sb t2, 0(s0) # print '-'
  addi s0, s0, -1
  4:
  addi s0, s0, 1
  mv a0, s0

  lw ra, 0(sp)
  lw s0, 4(sp)
  lw s1, 8(sp)
  addi sp, sp, 16
  ret

operation_1:
  la a0, string
  li a3, 1
  jal gets
  jal puts
  jal exit

operation_2:
  la a0, string
  li a3, 1
  jal gets
  addi a0, a0, 90
  1:
  addi a0, a0, -1
  lbu t1, 0(a0)
  beqz t1, 1b 
  la t2, other
  2:
  lbu t1, 0(a0)
  sb t1, 0(t2)
  addi t2, t2, 1
  addi a0, a0, -1
  la t3, string
  bge a0, t3, 2b
  li t1, 0xa
  sb t1, 0(t2) 
  la a0, other
  jal puts
  jal exit

operation_3:
  la a0, string
  jal gets
  jal atoi
  la a1, string
  li a2, 16
  jal itoa
  jal puts
  jal exit

operation_4:
  addi sp, sp, -16
  sw s0, 0(sp)
  sw s1, 0(sp)
  sw s2, 0(sp)

  la a0, string
  jal gets
  jal atoi
  mv s0, a0
  jal gets
  lbu s1, 0(a0)
  jal gets
  jal atoi
  mv s2, a0

  li t0, 0x2b # '+'
  bne s1, t0, 1f
  add s0, s0, s2
  1:
  li t0, 0x2d # '-'
  bne s1, t0, 1f
  sub s0, s0, s2
  1:
  li t0, 0x2a # '*'
  bne s1, t0, 1f
  mul s0, s0, s2
  1:
  li t0, 0x2f # '/'
  bne s1, t0, 1f
  div s0, s0, s2
  1:
  mv a0, s0
  la a1, string
  li a2, 10
  jal itoa
  jal puts

  lw s0, 0(sp)
  lw s1, 0(sp)
  lw s2, 0(sp)
  addi sp, sp, -16
  jal exit

.globl _start
_start:
  la a0, string
  jal gets
  lbu t0, 0(a0)
  
  li t1, 0x31
  beq t0, t1, operation_1
  li t1, 0x32
  beq t0, t1, operation_2
  li t1, 0x33
  beq t0, t1, operation_3
  li t1, 0x34
  beq t0, t1, operation_4

  jal exit
