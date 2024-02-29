.data
buffer: .skip 100
digit_to_char: .byte 0x30, 0x31, 0x32, 0x33, 0x34
               .byte 0x35, 0x36, 0x37, 0x38, 0x39
               .byte 0x41, 0x42, 0x43, 0x44, 0x45, 0x46

.text
read:
  li a0, 0      # file descriptor = 0 (stdin)
  la a1, buffer #  buffer to write the data
  li a2, 1      # size (reads only 1 byte)
  li a7, 63     # syscall read (63)
  ecall
  ret

write:
  li a0, 1      # file descriptor = 1 (stdout)
  la a1, buffer # buffer
  li a2, 1      # size
  li a7, 64     # syscall write (64)
  ecall
  ret

.globl exit
exit:
  li a7, 93
  ecall
  ret

.globl gets
gets: # stdin "hello\n" -> ret : "hello\0"
  addi sp, sp, -16
  sw ra, 0(sp)
  sw s0, 4(sp)
  sw s1, 8(sp)
  sw s2, 12(sp)

  mv s2, a0
  mv s0, a0
  jal read 
  LBU s1, buffer
  li t0, 0x0a
  1:
  beq s1, t0, 1f 
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
puts: # a0 = "hello\0"
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
  rem t1, t0, a2
  div t0, t0, a2
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
  rem t1, a0, a2
  div a0, a0, a2
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

.globl linked_list_search
linked_list_search: # a0 (head_node) , a1 (val)
  li t3, -1
  1:
  bne a0, zero, 2f
  li a0, -1
  ret
  2:
  addi t3, t3, 1
  lw t0, 0(a0)
  lw t1, 4(a0)
  lw t2, 8(a0)
  add t0, t0, t1
  mv a0, t2
  bne t0, a1, 1b
  mv a0, t3
  ret
