.data
primes:	.word 1, 3, 5, 7, 11

.text
__main: bl zero

zero:	ldr r8, =primes
		add r9, r8, #20
		ldr r0, [r8], #4
loop:	ldr r1, [r8], #4
	cmp r8, r9
	bgt first
	add r0, r0, r1
	b loop

first:	mov r8, r0
	mov r7, #5
	bl divisione
	mov r1, r7

second: mov r3, #1
	add r3, r3, r3, lsl #10
	ldr r9, =primes
	ldr r8, [r9]
	mul r2, r3, r8

third:	ldr r8, [r9]
	mov r7, #16
	bl divisione
	mov r3, r8

fourth: ldr r9, =primes
	ldr r8, [r9]
	mov r7, #-1
	muls r4, r8, r7
	bmi then
	mov r4, #1
	b end_if
then:	mov r4, #0
end_if:
	swi 0x11

skip:	mov pc, lr
divisione:	@ divide r8 per r7 (interi positivi)
	@ resto in r8, risultato in r7
	mov r9, #31
	mov r6, #0
loop_div:	mov r6, r6, lsl #1
	cmp r7, r8, lsr r9
	suble r8, r8, r7, lsl r9
	addle r6, r6, # 1
	subs r9, r9, # 1
	bge loop_div
	mov r7, r6
	b skip
.end
