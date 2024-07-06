.equ SWI_Open, 0x66  @ open a file
.equ SWI_Close,0x68  @ close a file
.equ SWI_RdInt,0x6c  @ Read an Integer from a file

.data
InFileName:	  .asciiz "Lezione7_2.txt"
InFileHandle:	.skip 4

.text
main:
  ldr r0, =InFileName
  bl es7_2
  swi 0x11

es7_2:
  stmfd sp!, {r1-r3, lr}
  mov r1, #0             @ r1 = input
  swi SWI_Open           @ apre quello che c'é in r0 con il modo descritto da r1 (input)
  ldr r1, =InFileHandle
  str r0, [r1]
RLoop:
  ldr r0, =InFileHandle
  ldr r0, [r0]
  swi SWI_RdInt
  bcs loop_end
  mov r1, r0, lsl #31
  mov r1, r1, lsr #31
  cmp r1, #1
  addeq r2, r2, r0
  bal es7_2
loop_end:
mov r0, r2
b skip

skip:
  mov pc, lr

.end
