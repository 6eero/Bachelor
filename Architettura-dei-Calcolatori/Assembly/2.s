.data
numbers:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
nums: .word 5, 2

.text
main:
	;bl es2_1
	bl es2_2
	swi 0x11

es2_1:
	ldr r0, =numbers
	mov r9, #2
	ldr r8, [r0, #32]
	mov r7, #0

loop:
	add r7, r7, #1
	ldr r1, [r0]
	mul r2, r1, r9
	str r2, [r0], #4
	cmp r7, #10
	bne loop
	b skip

es2_2:
	ldr r0, =nums
	ldr r1, [r0]
	ldr r2, [r0, #4]
	mov r3, #0

divisione:        ;r1/r2 con risultato in r3 e resto in r1
  sub r1, r1, r2
	add r3, r3, #1
	cmp r1, r2
	bge divisione
	b skip

skip:
	mov pc, lr

.end
