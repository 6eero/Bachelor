.data
numbers:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
num: .word 16

.text
main:
	;bl es3_1
	bl es3_2
	swi 0x11

es3_1:
  ldr r0, =numbers

loop: ; somma dei primi 10 numeri
	add r7, r7, #1
	ldr r1, [r0]
	add r3, r3, r1
	str r2, [r0], #4
	cmp r7, #10
	bne loop
  mov r0, #0

divisione:
  sub r3, r3, #10
  add r0, r0, #1
  cmp r3, #10
  bge divisione
  b skip

es3_2:
  ldr r0, =num
  ldr r0, [r0]
  mov r1, r0, lsr #1

test:
  mul r3, r1, r1
  cmp r3, r0
  ble label
  sub r1, r1, #1
  b test

label:
  mov r0, r3

skip:
	mov pc, lr

.end
