.data
num: .word 5
vet: .word 4, 2, 0, 6, 9

.text
main:
	;bl es4_2
	bl es4_3
	swi 0x11

es4_2:
	ldr r0, =num
	ldr r0, [r0]  ; r0 -> 5
  ldr r1, =vet

loop:
	add r8, r8, #1
	ldr r5, [r1, r3]

verifica: ; ris in r4, resto in r5
	sub r5, r5, #2
	add r4, r4, #1
  cmp r5, #2
  bge verifica
	cmp r5, #0
	beq azzera      ; numero pari
	add r3, r3, #4
	cmp r8, r0
	bne loop
	b skip

azzera:
	str r9, [r1, r3]
	add r3, r3, #4
  b loop

es4_3:
	ldr r0, =num
	ldr r0, [r0]  ; r0 -> 5
	ldr r1, =vet
	mov r3, #0

loop2:
	add r9, r9, #1
	cmp r9, r0
	beq skip
	ldr r5, [r1, r3]
	add r3, r3, #4
	cmp r5, #0
	beq label
	b loop2

label: ; n = 0
	ldr r5, [r1, r3]
	sub r4, r3, #4
	str r5, [r1, r4]
	str r2, [r1, r3]
	b loop2

skip:
	mov pc, lr

.end
