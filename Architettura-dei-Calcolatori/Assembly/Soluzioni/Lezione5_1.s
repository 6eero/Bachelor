.data
divisor:	.word 3
vector_mul_dim:	.word 10
vector_mul:	.word 20, 50, 9, 75 ,71 ,42 ,43, 256, 12, 26
vector_dim: .word 17

.text
__main:	
	ldr r0, =vector_dim
	ldr r1, [r0], #4
	bl eratostene
	swi 0x11

succ:	stmfd sp!, {r0, r1, r2, lr}
	mov r2, #0
succ_loop:	cmp r2, r1
	bgt succ_end
	str r2, [r0], #4
	add r2, r2, #1
	b succ_loop
succ_end:	ldmfd sp!, {r0, r1, r2, lr}
	mov pc, lr

del_mul_p: stmfd sp!, {r0, r1, r2, lr}
	mov r3, r0
	mov r0, r2
	mov r2, r1
	mov r1, r0
	ldr r0, [r3] 
del_mul_p_loop:	cmp r2, #0
	beq del_mul_p_end
	bl div
	cmp r0, #0
	streq r0, [r3]
	add r3, r3, #4
	ldr r0, [r3]
	sub r2, r2, #1
	b del_mul_p_loop
del_mul_p_end:	ldmfd sp!, {r0, r1, r2, lr}
	mov pc, lr

div:	@ divide r0 per r1 (interi positivi)
	@ resto in r0, risultato in r1
	stmfd sp!, {r1,r2,r3,lr}
	mov r3, #31
	mov r2, #0
div_loop:	mov r2, r2, lsl #1
	cmp r1, r0, lsr r3
	suble r0, r0, r1, lsl r3
	addle r2, r2, # 1
	subs r3, r3, # 1
	bge div_loop
	mov r1, r2
	b div_end
div_end:	ldmfd sp!, {r1,r2,r3,lr}
	mov pc, lr

eratostene:	stmfd sp!, {lr}
	bl succ
	add r0, r0, #4
	mov r2, #0
	str r2, [r0], #4
	ldr r2, [r0]
	sub r1, r1, #2
erat_loop:	cmp r1, #0
	beq erat_end
	add r0, r0, #4
	cmp r2, #0
	blne del_mul_p
	sub r1, r1, #1
	ldr r2, [r0]
	b erat_loop
erat_end:	ldmfd sp!, {lr}
	mov pc, lr
.end