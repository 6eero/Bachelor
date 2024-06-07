.data
numbers:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 
num_div:	.word 20, 3

.text
__main: bl es2_1
	bl es2_2
	swi 0x11

es2_1:	mov r9, #2	
	ldr r0, =numbers
	add r8, r0, #40
loop:	ldr r1, [r0]
	mul r2, r1, r9 
	str r2, [r0], #4
	cmp r0, r8
	bne loop
	b skip

es2_2:	ldr r9, =num_div
	ldr r0, [r9], #4
	ldr r1, [r9]
	b division

division:	@ divide r0 per r1 (interi positivi)
	@ resto in r0, risultato in r1
	mov r3, #31
	mov r2, #0
div_loop:	mov r2, r2, lsl #1
	cmp r1, r0, lsr r3
	suble r0, r0, r1, lsl r3
	addle r2, r2, # 1
	subs r3, r3, # 1
	bge div_loop
	mov r1, r2
	b skip

skip:	mov pc, lr
.end