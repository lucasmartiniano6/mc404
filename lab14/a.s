.section .bss
.align 4
isr_stack: # final da pilha ISR
.skip 1024
isr_stack_end: # base da pilha ISR

.align 4
user_stack: # final da pilha ISR
.skip 1024
user_stack_end: # base da pilha ISR

.section .data
.align 4
x:
  .word 0x00
y:
  .word 0x00
z:
  .word 0x00
interrupt_isr_table:
  .skip 40
  .word set_engine_and_steering
  .word set_hand_brake
  .word read_sensor
  .skip 8
  .word get_position

.section .text
.align 4

set_engine_and_steering:
  addi sp, sp, -16
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)

  li t0, 0xFFFF0100
  addi t1, t0, 0x20 # steering wheel
  sb a1, 0(t1)

  addi t1, t0, 0x21 # engine
  sb a0, 0(t1)

  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
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

  li t0, 0xFFFF0100
  addi t1, t0, 0x10 # x coord
  lw t2, 0(t1)
  addi t1, t0, 0x14 # y coord
  lw t3, 0(t1) 
  addi t1, t0, 0x18 # z coord
  lw t4, 0(t1)

  la t0, x
  sw t2, 0(t0)

  la t0, y
  sw t3, 0(t0)

  la t0, z
  sw t4, 0(t0)

  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  lw t2, 12(sp)
  lw t3, 16(sp)
  lw t4, 20(sp)
  addi sp, sp, 32
  ret


set_hand_brake:
  addi sp, sp, -16
  sw ra, 0(sp)
  sw t0, 4(sp)
  sw t1, 8(sp)

  li t0, 0xFFFF0100
  addi t1, t0, 0x22 # hand-brake
  sb a0, 0(t1)

  lw ra, 0(sp)
  lw t0, 4(sp)
  lw t1, 8(sp)
  addi sp, sp, 16
  ret

read_sensor:        

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

  # configurar mscratch
  la t0, isr_stack_end
  csrw mscratch, t0

  # configurar user stack
  la t0, user_stack_end
  mv sp, t0

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
  la t0, user_main
  csrw mepc, t0
  mret # PC <= MEPC ; mode <= MPP;

.globl control_logic
control_logic:
  # implement your control logic here, using only the defined syscalls
  li a0, 0
  li a7, 11 # set hand-brake ( 0 )
  ecall
  
  1:   
  li a0, 1    # forward
  li a1, -15  # -15
  li a7, 10   # set engine and steering-wheel
  ecall
    
  li a7, 15   # get positions
  ecall
  
  la t0, x
  lw t2, 0(t0)
  la t0, y
  lw t3, 0(t0)
  la t0, z
  lw t4, 0(t0)

  addi t2, t2, -73 
  mul t2, t2, t2
  addi t3, t3, -1
  mul t3, t3, t3
  addi t4, t4, +19 
  mul t4, t4, t4
  add s1, t2, t3
  add s1, s1, t4
  li s2, 225 

  bge s1, s2, 1b

  li a0, 1
  li a7, 11 # set hand-brake (1)
  ecall

  ret
