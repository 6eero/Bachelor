.equ SWI_PrStr, 0x69    @ Write a null-ending string 
.equ SWI_PrInt, 0x6b    @ Write an Integer
.equ Stdout, 1 			@ Set output target to be Stdout
.equ SWI_Exit, 0x11     @ Stop execution
.equ SWI_Alloc, 0x12


.data
vector:	.word 1, 2, 3, 4, 5, 6, 7
vector_dim: .word 7
list:	.skip 8
matrix:	.word 11,2,33,4, 55,6,77,8, 99,1,19,72
dim_mat: .word 3, 4
space:	.asciiz "\ "
new_line:	.asciiz "\n "        

.text
__main:
	@ldr r0, =matrix
	@ldr r1, =dim_mat
	@ldr r2, [r1, #4]
	@ldr r1, [r1]
	@bl print_matrix
	ldr r0, =vector
	ldr r1, =vector_dim
	ldr r1, [r1]
	bl make_list
	bl print_list
	swi SWI_Exit


@=============== Lezione8_1 ==================

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

@=============== Lezione8_2 ==================

make_list:
	stmfd sp!, {r0-r3, lr}
	mov r2, r0   		@sposto in r2 il puntatore al vettore
	ldr r3, =list
	mov r0, r1  		@sposto in r0 la dim del vettore
	str r0, [r3], #4	@copio la dim del vettore in head della lista
	mov r0, #8
	swi SWI_Alloc		@alloco spazio per il prossimo elemento della lista
	str r0, [r3]		@salvo il puntatore di nextElem nella seconda posizione di head
	mov r3, r0  		@sposto il punt al nuovo elemento in r3
make_loop:
	cmp r1, #0
	beq make_end
	bl list_loop
	sub r1, r1, #1
	b make_loop
list_loop:
	stmfd sp!, {r1, lr}
	ldr r1, [r2], #4
	str r1, [r3], #4
	mov r0, #8
	swi SWI_Alloc 
	str r0, [r3]
	mov r3, r0
	ldmfd sp!, {r1, lr}
	mov pc, lr
make_end:
	ldmfd sp!, {r0-r3, lr}
	ldr r0, =list
	mov pc, lr

@=============== Lezione8_3 ==================
print_list:
	stmfd sp!, {r0-r3, lr}
	ldr r2, [r0], #4     	@carico in r2 la dim della lista
	ldr r3, [r0] 			@carico in r3 il nextElem
	mov r0, #Stdout
	ldr r1, =new_line
	swi SWI_PrStr
print_list_loop:
	cmp r2, #0
	beq print_list_loop_end
	ldr r1, [r3]
	swi SWI_PrInt
	ldr r1, =new_line
	swi SWI_PrStr
	ldr r3, [r3, #4]
	sub r2, r2, #1
	b print_list_loop
print_list_loop_end:
	ldmfd sp!, {r0-r3, lr}
	mov pc, lr


.end 