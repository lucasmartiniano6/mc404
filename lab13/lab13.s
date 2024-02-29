.globl _start
.globl play_note
.globl _system_time

.section .data
_system_time: .word 0x00

.section .bss
.align 4
isr_stack: # final pilha
.skip 1024
isr_stack_end: # base pilha

.section .text
.align 2
play_note:
  addi sp, sp, -16  
  sw t0, 0(sp)

  li t0, 0xFFFF0300
  sb a0, 0(t0)
  sh a1, 2(t0)
  sb a2, 4(t0)
  sb a3, 5(t0)
  sh a4, 6(t0)

  lw t0, 0(sp)
  addi sp, sp, 16  
  ret   

.align 2
main_isr:
  # save context
  csrrw sp, mscratch, sp
  addi sp, sp, -128
  sw t0, 0(sp)
  sw t1, 4(sp)
  
  # handle it
  li t0, 1
  li t1, 0xFFFF0100
  sb t0, 0(t1)
  1:
  lb t0, 0(t1)
  bnez t0, 1b
  lw t0, 4(t1) # value read by gpt
  la t1, _system_time
  sw t0, 0(t1)
  # set gpt interruption again
  li t0, 100 # 100 ms
  li t1, 0xFFFF0100
  sw t0, 8(t1) # sets gpt to generate interruption

  # recover context
  lw t0, 0(sp)
  lw t1, 4(sp)
  addi sp, sp, 128
  csrrw sp, mscratch, sp
  mret

.align 2
_start:
  # registrando a ISR
  la t0, main_isr  
  csrw mtvec, t0

  # configurar mscratch
  la t0, isr_stack_end
  csrw mscratch, t0

  # configurar perifericos (MMIO)
  li t0, 100 # 100 ms
  li t1, 0xFFFF0100
  sw t0, 8(t1) # sets gpt to generate interruption

  # habilitar interrupções externas
  csrr t1, mie
  li t2, 0x800
  or t1, t1, t2
  csrw mie, t1
  # habilitar interrupções global
  csrr t1, mstatus
  ori t1, t1, 0x8
  csrw mstatus, t1

  # chamar main
  jal main


