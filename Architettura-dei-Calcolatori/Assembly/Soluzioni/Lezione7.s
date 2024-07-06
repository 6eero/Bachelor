.equ SWI_Open, 0x66        @open a file
.equ SWI_Close,0x68        @close a file
.equ SWI_PrChr,0x00        @ Write an ASCII char to Stdout
.equ SWI_PrStr, 0x69       @ Write a null-ending string 
.equ SWI_PrInt,0x6b        @ Write an Integer
.equ SWI_RdInt,0x6c        @ Read an Integer from a file
.equ Stdout,  1            @ Set output target to be Stdout
.equ SWI_Exit, 0x11        @ Stop execution

.data
string:	.asciiz "Quindi, devo?"
alfa:	.asciiz "abcderfghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZèéòàùì"
InFileName:	.asciiz "Lezione7_2.txt"
OutFileName: .asciiz "Lezione7_3.txt"
.align
OutFileHandle:	.word 0
.align
InFileHandle:	.skip 4
ColonSpace:     .asciz": "
isOdd:          .asciz   "is Odd! \n "        @ new line 

.text
__main:	
	@ ldr r0, =string
	@ bl onlyAlfa
	@ldr r0,=InFileName        @ set Name for input file
	@bl sum_odds
	ldr r0,=InFileName        @ set Name for input file
	ldr r1,=OutFileName        @ set Name for input file
	bl copy_even
	swi SWI_Exit

@================ Lezione7_1 =======================

onlyAlfa:	stmfd sp!, {r0-r3, lr}
	mov r1, r0
only_loop:	ldrb r0, [r1], #1
	cmp r0, #0
	beq only_end
	bl compare
	b only_loop
only_end:	ldmfd sp!, {r0-r3, lr}
	mov pc, lr
compare:	stmfd sp!, {r0-r3, lr}
	ldr r2, =alfa
	ldrb r3, [r2]
comp_loop:	cmp r3, #0
	beq comp_end
	cmp r3, r0
	beq match_so_write
	ldrb r3, [r2], #1
	b comp_loop
match_so_write:	mov r0, r3
	swi SWI_PrChr
	b comp_end
comp_end:	ldmfd sp!, {r0-r3, lr} 
	mov pc, lr

@================ Lezione7_2 =======================

sum_odds:	
	stmfd sp!, {r1-r3, lr}
	mov r1,#0                 @ mode is input
	swi SWI_Open              @ open file for input
@ Save the file handle in memory:
	ldr r1,=InFileHandle   
	str r0,[r1]               @ save the file handle
RLoop:
	ldr r0,=InFileHandle   @ load input file handle
	ldr r0,[r0]
	swi SWI_RdInt             @ read the integer into R0
	bcs loop_end       		@ Check Carry-Bit (C): if= 1 then EOF reached
@ if isOdd? then r2 + integer
	mov r1, r0, lsl #31               
	mov r1, r1, lsr #31
	cmp r1, #1
	addeq r2, r2, r0
	bal RLoop                 @ keep reading till end of file
loop_end:
	ldr R0, =InFileHandle     @ get address of file handle
	ldr R0, [R0]              @ get value at address
	swi SWI_Close
	mov r0, r2
	ldmfd sp!, {r1-r3, lr}
	mov pc, lr

@================ Lezione7_3 =======================

copy_even:	
	stmfd sp!, {r0-r3, lr}
	mov r3, r1
	mov r1,#0                 @ mode is input
	swi SWI_Open              @ open file for input
	mov r2, r0 				  @ sposto il primo handle in r2
	mov r0, r3                @ sposto il nome del secondo file in r0
	swi SWI_Open
	mov r1, r0
	mov r0, r2
@ Save the file handle in memory:
	ldr r2,=InFileHandle   
	str r0,[r2]             
	ldr r3,=OutFileHandle
	str r1,[r3]
even_loop:
	ldr r0,=InFileHandle   @ load input file handle
	ldr r0,[r0]
	swi SWI_RdInt             @ read the integer into R0
	bcs even_end       		@ Check Carry-Bit (C): if= 1 then EOF reached
@ if isEven? then r2 + integer
	mov r1, r0, lsl #31               
	mov r1, r1, lsr #31
	cmp r1, #0
	bne even_loop                 @ keep reading till end of file
	mov r1, r0
	ldr r0, =OutFileHandle
	ldr r0, [r0]
	swi SWI_PrInt
	b even_loop
even_end:
	ldr r0, =InFileHandle     @ get address of file handle
	ldr r0, [r0]              @ get value at address
	swi SWI_Close
	ldr r0, =OutFileHandle
	ldr r0, [r0]
	swi SWI_Close
	ldmfd sp!, {r0-r3, lr}
	mov pc, lr
.end