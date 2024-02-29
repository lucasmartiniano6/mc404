.section .bss
.align 4
isr_stack: # final da pilha ISR
.skip 1024
isr_stack_end: # base da pilha ISR

.section .data
.align 4
interrupt_isr_table:
  .skip 40 # codes 0-9
  .word set_engine_and_steering # code 10
  .word set_hand_brake # code 11
  .word read_sensors # code 12
  .word read_sensor_distance # code 13
  .skip 4
  .word get_position # code 15
  .word get_rotation # code 16
  .word read_serial # code 17
  .word write_serial # code 18
  .skip 4
  .word get_systime # code 20

.section .text
.align 4

set_engine_and_steering:
  addi sp, sp, -16
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)

  # check invalid values
  # a0 = [-1, 0, 1]
  li t0, -1
  beq a0, t0, 1f
  li t0, 0
  beq a0, t0, 1f
  li t0, 1
  beq a0, t0, 1f
  j 2f
  1:
  # a1 = [-127, +127]  
  li t0, -127
  blt a1, t0, 2f
  li t0, 128
  bge a1, t0, 2f

  li t0, 0xFFFF0300 # base addr

  addi t1, t0, 0x21 # engine
  sb a0, 0(t1)

  addi t1, t0, 0x20 # steering wheel
  sb a1, 0(t1)

  li a0, 0 # success
  j 3f
  2:
  li a0, -1 # error

  3:
  # recover context
  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  addi sp, sp, 16
  ret


set_hand_brake:
  addi sp, sp, -16
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)

  li t0, 0xFFFF0300
  addi t1, t0, 0x22 # hand-brake
  sb a0, 0(t1)

  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  addi sp, sp, 16
  ret

read_sensors:        
  addi sp, sp, -32
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)
  sw t2, 12(sp)
  sw t3, 16(sp)

  li t0, 0xFFFF0300 # base
  li t1, 1
  sb t1, 1(t0) # trigger line-camera
  1:
  lb t1, 1(t0)
  bnez t1, 1b # wait for line-camera to finish

  li t0, 0
  li t1, 256
  li t2, 0xFFFF0300 # base
  addi t2, t2, 0x24 
  2:
  beq t0, t1, 3f
  
  lb t3, 0(t2)
  sb t3, 0(a0)

  addi t0, t0, 1
  addi t2, t2, 1
  addi a0, a0, 1
  j 2b
  3:
  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  lw t2, 12(sp)
  lw t3, 16(sp)
  addi sp, sp, 32
  ret

read_sensor_distance:
  addi sp, sp, -16
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)
  sw t2, 12(sp)

  li t0, 0xFFFF0300 # base
  li t1, 1
  sb t1, 2(t0) # trigger ultrasonic
  1:
  lb t1, 2(t0)
  bnez t1, 1b # wait for ultrasonic to finish

  addi t0, t0, 0x1c # distance
  lw a0, 0(t0)

  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  lw t2, 12(sp)
  addi sp, sp, 16
  ret


get_position:
  addi sp, sp, -32
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)
  sw t2, 12(sp)
  sw t3, 16(sp)
  sw t4, 20(sp)

  li t0, 0xFFFF0300 # base
  li t1, 1
  sb t1, 0(t0) # trigger gps
  1:
  lb t1, 0(t0)
  bnez t1, 1b # wait for gps to finish

  addi t1, t0, 0x10 # x coord
  lw t2, 0(t1)
  addi t1, t0, 0x14 # y coord
  lw t3, 0(t1) 
  addi t1, t0, 0x18 # z coord
  lw t4, 0(t1)

  sw t2, 0(a0) # x

  sw t3, 0(a1) # y

  sw t4, 0(a2) # z

  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  lw t2, 12(sp)
  lw t3, 16(sp)
  lw t4, 20(sp)
  addi sp, sp, 32
  ret

get_rotation:
  addi sp, sp, -32
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)
  sw t2, 12(sp)
  sw t3, 16(sp)
  sw t4, 20(sp)

  li t0, 0xFFFF0300 # base
  li t1, 1
  sb t1, 0(t0) # trigger gps
  1:
  lb t1, 0(t0)
  bnez t1, 1b # wait for gps to finish

  addi t1, t0, 0x04 # x euler
  lw t2, 0(t1)
  addi t1, t0, 0x08 # y euler
  lw t3, 0(t1) 
  addi t1, t0, 0x0c # z euler
  lw t4, 0(t1)

  sw t2, 0(a0) # x

  sw t3, 0(a1) # y

  sw t4, 0(a2) # z

  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  lw t2, 12(sp)
  lw t3, 16(sp)
  lw t4, 20(sp)
  addi sp, sp, 32
  ret

read_serial:
  addi sp, sp, -32
  sw t0, 0(sp)
  sw t1, 4(sp)
  sw t2, 8(sp)
  sw t3, 12(sp)
  sw t4, 16(sp)

  li t4, 0
  mv t3, a1
  2:
  beqz t3, 3f
  li t0, 0xFFFF0500
  li t1, 1
  sb t1, 2(t0)
  1:
  lb t1, 2(t0)
  bnez t1, 1b
  
  lb t1, 3(t0)
  beqz t1, 3f
  #la t0, buffer
  sb t1, 0(a0)
  addi a0, a0, 1
  addi t4, t4, 1
  addi t3, t3, -1
  j 2b

  3:
  mv a0, t4

  lw t0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  lw t3, 12(sp)
  lw t4, 16(sp)
  addi sp, sp, 32
  ret

write_serial:
  addi sp, sp, -16
  sw t0, 0(sp)
  sw t1, 4(sp)
  sw t2, 8(sp)
  sw t3, 12(sp)

  mv t3, a1
  2:
  beqz t3, 3f
  #la t0, buffer
  mv t0, a0
  lb t1, 0(t0)
  li t0, 0xFFFF0500
  sb t1, 1(t0)

  li t1, 1
  sb t1, 0(t0)
  1:
  lb t1, 0(t0)
  bnez t1, 1b

  addi a0, a0, 1
  addi t3, t3, -1
  j 2b

  3: 
  lw t0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  lw t3, 12(sp)
  addi sp, sp, 16
  ret

get_systime:
  addi sp, sp, -16
  sw t0, 0(sp)
  sw t1, 4(sp)
  sw ra, 8(sp)
  
  li t0, 1
  li t1, 0xFFFF0100
  sb t0, 0(t1)
  1:
  lb t0, 0(t1)
  bnez t0, 1b
  lw a0, 4(t1) # value read by gpt

  lw t0, 0(sp)
  lw t1, 4(sp)
  lw ra, 8(sp)
  addi sp, sp, 16
  ret

int_handler:
  ###### Syscall and Interrupts handler ######
  # save context
  csrrw sp, mscratch, sp
  addi sp, sp, -16
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)

  # handle syscall
  #csrr t0, mcause
  #andi t0, t0, 0x3f # isola EXCCODE
  mv t0, a7 # code
  slli t0, t0, 2
  la t1, interrupt_isr_table
  add t0, t0, t1
  lw t0, (t0)
  jalr t0
 
  # adjust PC to next instruction
  csrr t0, mepc  # load return address (address of 
                 # the instruction that invoked the syscall)
  addi t0, t0, 4 # adds 4 to the return address (to return after ecall) 
  csrw mepc, t0  # stores the return address back on mepc

  # recover context
  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  addi sp, sp, 16
  csrrw sp, mscratch, sp
  mret           # Recover remaining context (pc <- mepc)
   

.globl _start
_start:
  # registrando a ISR
  la t0, int_handler  # Load the address of the routine that will handle interrupts
  csrw mtvec, t0      # (and syscalls) on the register MTVEC to set
                      # the interrupt array.
  # Write here the code to change to user mode and call the function 
  # user_main (defined in another file). Remember to initialize
  # the user stack so that your program can use it.

  # configurar system stack - mscratch
  la t0, isr_stack_end
  csrw mscratch, t0

  # configurar user stack
  li sp, 0x07FFFFFC

  # habilitar interrupções externas
  csrr t1, mie
  li t2, 0x800
  or t1, t1, t2
  csrw mie, t1
  # habilitar interrupções global
  csrr t1, mstatus
  ori t1, t1, 0x8
  csrw mstatus, t1

  # change to user mode
  csrr t1, mstatus
  li t2, ~0x1800
  and t1, t1, t2
  csrw mstatus, t1

  # loads the user software entry point into mepc
  la t0, main
  csrw mepc, t0
  mret # PC <= MEPC ; mode <= MPP;
