.data
num:	.word 2, 17

.text
__main: ldr r9, =num
	mov r0, #0
	mov r3, #0
	ldr r1, [r9], #4
	ldr r2, [r9]
loop: cmp r3, r2
	bgt fine
	add r0, r0, #1
	bl power
	b loop
fine: sub r0, r0, #1
	swi 0x11

power:	stmfd sp!, {r0-r2, lr}
	mov r2, r1
pow_loop:	cmp r0, #1
	beq pow_end
	mul r3, r2, r1
	mov r2, r3
	sub r0, r0, #1
	b pow_loop
pow_end:	ldmfd sp!, {r0-r2, lr}
	mov pc, lr
.end