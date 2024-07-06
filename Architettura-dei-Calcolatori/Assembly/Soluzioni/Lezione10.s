.equ SWI_PrStr, 0x69    @ Write a null-ending string 
.equ SWI_PrInt, 0x6b    @ Write an Integer
.equ Stdout, 1 			@ Set output target to be Stdout
.equ SWI_Exit, 0x11     @ Stop execution
.equ SWI_Alloc, 0x12

.data
string:	.asciiz "abiba"
matrix:	.word 1,2,3,4, 5,6,7,8, 9,10,11,12
matrix_dim:	.word 3,4
matrix_T:	.skip 48
space:	.asciiz "\ "
new_line:	.asciiz "\n "  

.text
__main:
	ldr r0, =string
	bl palind
	ldr r0, =matrix
	ldr r1, =matrix_dim
	ldr r2, =matrix_T
	bl transpose_matrix
	mov r0, r2
	ldr r2, [r1]
	ldr r1, [r1, #4]
	bl print_matrix
	swi SWI_Exit

@================ Lezione 10_1 ===============

palind:
	stmfd sp!, {r1-r3, lr}
	mov r1, r0
	bl count
pal_loop:
	cmp r0, #0
	beq pal_end
	ldrb r2, [r1]
	bl search_pal
	cmp r2, #1
	bne pal_end
	add r1, r1, #1
	cmp r0, #1
	subeq r0, r0, #1
	subne r0, r0, #2
	b pal_loop
search_pal:
	stmfd sp!, {r0-r1, lr}
search_loop:
	cmp r0, #0
	beq search_end
	ldrb r3, [r1], #1
	sub r0, r0, #1
	b search_loop
search_end:
	cmp r2, r3
	moveq r2, #1
	movne r2, #0
	ldmfd sp!, {r0-r1, lr}
	mov pc, lr
pal_end:
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmfd sp!, {r1-r3, lr}
	mov pc, lr

count:
	stmfd sp!, {r1-r3, lr}
	mov r1, #0
count_loop:
	ldrb r2, [r0], #1
	cmp r2, #0
	beq count_end
	add r1, r1, #1
	b count_loop
count_end:
	mov r0, r1
	ldmfd sp!, {r1-r3, lr}
	mov pc, lr

@================ Lezione 10_2 ===============

transpose_matrix:
	stmfd sp!, {r0-r4, lr}
	mov r3, r2
	ldr r2, [r1]
	ldr r1, [r1, #4]
	mov r4, #4
	mul r4, r1, r4 			@determino il fattore di spostamento 
n_loop:	
	cmp r1, #0
	beq transpose_end
	bl m_sub
	sub r1, r1, #1
	add r0, r0, #4
	b n_loop
m_sub:
	stmfd sp!, {r0-r2, lr}
m_loop:
	cmp r2, #0
	beq m_end
	ldr r1, [r0]
	add r0, r0, r4
	str r1, [r3], #4
	sub r2, r2, #1
	b m_loop
m_end:
	ldmfd sp!, {r0-r2, lr}
	mov pc, lr
transpose_end:
	ldmfd sp!, {r0-r4, lr}
	mov pc, lr


@=============== Lezione8_1 - r0 addr matrix, r1 row, r2 col ==================

print_matrix:
	stmfd sp!, {r0-r3, lr}
	mov r3, #4
	mul r3, r2, r3
print_loop:
	cmp r1, #0
	beq print_end
	bl print_line
	add r0, r0, r3
	sub r1, r1, #1
	b print_loop
print_end:
	ldmfd sp!, {r0-r3, lr}
	mov pc, lr
print_line:
	stmfd sp!, {r0-r3, lr}
	mov r3, r0
	mov r0, #Stdout
	ldr r1, =new_line
	swi SWI_PrStr
line_loop:
	cmp r2, #0
	beq line_end
	ldr r1, [r3], #4
	cmp r1, #10		@discriminante per le doppie cifre
	bllt insert_space
	swi SWI_PrInt
	bl insert_space
	sub r2, r2, #1
	b line_loop
insert_space:
	stmfd sp!, {r0-r3, lr}
	ldr r1, =space
	swi SWI_PrStr
	ldmfd sp!, {r0-r3, lr}
	mov pc, lr
line_end:
	ldmfd sp!, {r0-r3, lr}
	mov pc, lr
.end