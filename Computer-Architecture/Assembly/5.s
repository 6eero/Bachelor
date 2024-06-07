.data
len: .word 30
vet: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
p: .word 2

.text
main:
	bl es5_1
  bl es5_2
	swi 0x11

es5_1:
	ldr r0, =vet
  ldr r1, =len
  ldr r1, [r1]
loop:
  cmp r2, r1
  beq skip
	b inserimento
inserimento:
  add r2, r2, #1
  str r3, [r0, r4]
  add r4, r4, #4
  add r3, r3, #1
  b loop

es5_2:
  ldr r0, =vet
  ldr r1, =len
  ldr r1, [r1]
  ldr r2, =p
  ldr r2, [r2] ; numero p
  mov r3, #0
  mov r4, #0
  mov r5, r2
loop2:
  cmp r1, r6
  beq avanti
  add r6, r6, #1
  cmp r3, r5
  beq azzera
  add r3, r3, #1
  add r4, r4, #4
  b loop2
azzera:
  cmp r5, r2
  strne r9, [r0, r4]
  add r3, r3, #1
  add r4, r4, #4
  add r5, r5, r2
  b loop2
avanti:
  add r2, r2, #1
  mov r3, #0
  mov r4, #0
  mov r5, r2
  mov r6, #0
  b loop2

skip:
	mov pc, lr

  .end
