.data
radix:	.word 111

.text
__main:	ldr r9, =radix
	ldr r1, [r9]
	mov r0, #0
	mov r2, #0
rad:	cmp r2, r1
	bgt	fine
	add r0, r0, #1
	mul r2, r0, r0
	b rad
fine:	sub r0, r0, #1
	swi 0x11