.equ SWI_PrStr, 0x69    @ Write a null-ending string 
.equ SWI_PrInt, 0x6b    @ Write an Integer
.equ Stdout, 1 			@ Set output target to be Stdout
.equ SWI_Exit, 0x11     @ Stop execution
.equ SWI_Alloc, 0x12


.data
vector1:	.word 1, 2, 3, 4
vector1_dim: .word 4
vector2:	.word 73, 2, 4, 3
vector2_dim: .word 4
list1:	.skip 8
list2:	.skip 8
new_line:	.asciiz "\n "        

.text
__main:
	ldr r0, =vector1
	ldr r1, =vector1_dim
	ldr r1, [r1]
	bl make_list 			@creo lista 1
	mov r2, r0 				@salvo il puntatore della lista 1 in r2
	ldr r0, =vector2
	ldr r1, =vector2_dim
	ldr r1, [r1]
	bl make_list 			@creo lista 2
	mov r1, r0 				@sposto il puntatore della lista 2 in r1
	mov r0, r2				@sposto il puntatore della lista 1 in r0
	bl concat_list			@concateno le due liste
	bl even_odd_lists
	bl print_list
	mov r0, r1
	bl print_list
	swi SWI_Exit




@=============== Lezione 9.1 ==================
concat_list:
	stmfd sp!, {r1-r3, lr}
	bl find_last 		@ritorna in r2 il puntatore a LastElem di lista1
	bl sum_dim 			@somma le dimensioni delle liste e le salva in HeadList1, ritorna in r1 il puntatore di firstElem2
	str r1, [r2, #4]	@concatena le liste
	ldmfd sp!, {r1-r3, lr}
	mov pc, lr
sum_dim:
	stmfd sp!, {r0, r2, lr}
	ldr r2, [r0]
	ldr r3, [r1]
	add r2, r2, r3
	str r2, [r0]
	ldr r1, [r1, #4]
	ldmfd sp!, {r0, r2, lr}
	mov pc, lr
find_last:
	stmfd sp!, {r0-r1, lr}
	ldr r1, [r0] 		@carico dim lista in r2
	ldr r0, [r0, #4] 	@carico puntatore al primo elemento in r1
find_loop:				@trovo ultimo elemento e carico il puntatore in r0
	cmp r1, #1
	beq find_end
	ldr r0, [r0, #4]
	sub r1, r1, #1
	b find_loop
find_end:
	mov r2, r0 			@sposto il puntatore a LastElem in r2
	ldmfd sp!, {r0-r1, lr}
	mov pc, lr


@=============== Lezione 9.2 ==================
even_odd_lists:
	stmfd sp!, {r2-r3, lr}
	ldr r1, [r0]		@carico dim lista
	ldr r0, [r0, #4]	@carico il puntatore al primo elemento effettivo della lista
	bl make_odd_list	@ritorna in r2 la lista dei soli elementi dispari
	mov r2, r3 			@sposto il puntatore della odd list in r2
	bl make_even_list
	mov r1, r3
	mov r0, r2
	ldmfd sp!, {r2-r3, lr}
	mov pc, lr

make_odd_list:
	stmfd sp!, {r0-r2, lr}
	mov r2, r0 	@sposto il puntatore della lista input in r2
	bl odd_list
	mov r3, r0 	@salvo il puntatore della odd list in r3
	ldmfd sp!, {r0-r2, lr}
	mov pc, lr
odd_list:
	stmfd sp!, {r1, r3, lr}
odd_list_loop:
	cmp r1, #0
	beq odd_list_end
	ldr r0, [r2]			@carico valore lista
	mov r0, r0, lsl #31		
	mov r0, r0, lsr #31		
	cmp r0, #1				@controllo se è dispari
	ldrne r2, [r2, #4]
	subne r1, r1, #1
	bne odd_list_loop
	@alloca memoria per lista e la sposta in r3
	mov r0, #8
	swi SWI_Alloc
	mov r3, r0
	@salva il valore dispari nella lista appena allocata
	ldr r0, [r2]
	str r0, [r3]
	@crea HeadList con dimensione 1 e lo mette in testa alla lista appena creata. ritorna la lista in r3
	mov r0, #8
	swi SWI_Alloc
	str r3, [r0, #4]
	mov r3, r0 		@sposta la nuova lista in r3
	mov r0, #1
	str r0, [r3]
	ldr r2, [r2, #4]	@puntatore successivo
	sub r1, r1, #1
	bl odd_list
	@cmp r0, #0
	@blne concat
	cmp r1, #0
	mov r1, r0
	mov r0, r3
	blne concat_list
odd_list_end:
	ldmfd sp!, {r1, r3, lr}
	mov pc, lr
concat:
	stmfd sp!, {lr}
	cmp r1, #0
	mov r1, r0
	mov r0, r3
	blne concat_list
	ldmfd sp!, {lr}
	mov pc, lr

make_even_list:
	stmfd sp!, {r0-r2, lr}
	mov r2, r0 	@sposto il puntatore della lista input in r2
	bl even_list
	mov r3, r0 	@salvo il puntatore della odd list in r3
	ldmfd sp!, {r0-r2, lr}
	mov pc, lr
even_list:
	stmfd sp!, {r1, r3, lr}
even_list_loop:
	cmp r1, #0
	beq even_list_end
	ldr r0, [r2]			@carico valore lista
	mov r0, r0, lsl #31		
	mov r0, r0, lsr #31		
	cmp r0, #0				@controllo se è pari
	ldrne r2, [r2, #4]
	subne r1, r1, #1
	bne even_list_loop
	@alloca memoria per lista e la sposta in r3
	mov r0, #8
	swi SWI_Alloc
	mov r3, r0
	@salva il valore dispari nella lista appena allocata
	ldr r0, [r2]
	str r0, [r3]
	@crea HeadList con dimensione 1 e lo mette in testa alla lista appena creata. ritorna la lista in r3
	mov r0, #8
	swi SWI_Alloc
	str r3, [r0, #4]
	mov r3, r0 		@sposta la nuova lista in r3
	mov r0, #1
	str r0, [r3]
	ldr r2, [r2, #4]	@puntatore successivo
	sub r1, r1, #1
	bl even_list
	cmp r0, #1
	mov r1, r0
	mov r0, r3
	blne concat_list
even_list_end:
	ldmfd sp!, {r1, r3, lr}
	mov pc, lr



@=============== Crea lista da vettore - indirizzo vettore r0, dim vettore r1 ==================
@=============== HeadList contiene la dimensione della lista, quindi la lista è lunga dim vettore + 1 ==================

make_list:
	stmfd sp!, {r1-r3, lr}
	mov r2, r0   		@sposto in r2 il puntatore al vettore
	mov r0, #8
	swi SWI_Alloc		@creo il puntatore a head in r0
	bl init_list
	ldmfd sp!, {r1-r3, lr}
	mov pc, lr
init_list:
	stmfd sp!, {r0, lr}
	mov r3, r0
	mov r0, r1  		@sposto in r0 la dim del vettore
	str r0, [r3], #4	@copio la dim del vettore in head della lista
	mov r0, #8
	swi SWI_Alloc		@alloco spazio per il prossimo elemento della lista
	str r0, [r3]		@salvo il puntatore di nextElem nella seconda posizione di head
	mov r3, r0  		@sposto il punt al nuovo elemento in r3
make_loop:
	cmp r1, #0
	beq make_end
	bl list_build
	sub r1, r1, #1
	b make_loop
list_build:
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
	ldmfd sp!, {r0, lr}
	mov pc, lr

@=============== Leggi lista - indirizzo in r0 ==================
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