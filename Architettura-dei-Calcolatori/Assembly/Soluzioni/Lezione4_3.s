.data
vector_dim:	.word 10
vector:	.word	20, 50, 0, 75, 71, 42, 0, 256, 12, 26

.text
__main:	ldr r9, =vector
	ldr r8, =vector_dim
	ldr r8, [r8]
loop:	cmp r8, #0
	beq fine
	ldr r0, [r9]
	cmp r0, #0
	bleq shift
	add r9, r9, #4
	sub r8, r8, #1
	b loop
fine:	swi 0x11

shift:	stmfd sp!, {r0, r9, lr}
	mov r2, r8
	mov r3, r9
shift_loop:	cmp r2, #1
	beq shift_end
	ldr r1, [r3, #4]!
	str r0, [r3]
	str r1, [r9], #4
	sub r2, r2, #1
	b shift_loop
shift_end:	ldmfd sp!, {r0, r9, lr}
	sub r8, r8, #1  @decrementa il contatore globale
	ldr r2, =vector_dim  @sezione che decrementa la dimensione del vetteore in memoria
	ldr r3, [r2]
	sub r3, r3, #1
	str r3, [r2] 
	mov pc, lr 
.end