.data
vector_dim:	.word 10
vector:	.word	20, 50, 9, 75 ,71 ,42 ,43, 256, 12, 26

.text
__main:	ldr r9, =vector
	ldr r8, =vector_dim
	ldr r8, [r8]
	mov r1, #1
loop:	cmp r8, #0
	beq fine
	ldr r0, [r9]
	mov r0, r0, lsl #31
	mov r0, r0, lsr #31
	ands r0, r1, r0
	streq r0, [r9]
	add r9, r9, #4
	sub r8, r8, #1
	b loop
fine:	swi 0x11

.end