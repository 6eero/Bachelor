.data
numbers:	.word 1, 2, 3, 4, 5

.text
main:
	bl es2_1
	swi 0x11

es2_1:
	ldr r1, =numbers

	ldr r2, [r1]
	ldr r3, [r1, #4]
	ldr r4, [r1, #8]
	ldr r5, [r1, #12]
	ldr r6, [r1, #16]

skip:
	swi 0x11

.end
