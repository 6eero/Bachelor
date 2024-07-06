.data
primes:	.word 2, 3, 5, 7, 11, 13, 17, 23, 29, 31

.text
__main: ldr r9, =primes
	add r8, r9, #40
	ldr r0, [r9], #4
	bl sum	@sommatoria del vettore, risultato in r0
	mov r4, r0
	mov r1, #10
	bl division
	swi 0x11
sum:	ldr r1, [r9], #4
	cmp r9, r8
	bgt skip
	add r0, r0, r1
	b sum
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