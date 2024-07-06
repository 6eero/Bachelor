.data
vet: .word 1, 0, 5, 0, 8, 6, 0, 8, 0, 0, 1, 8, 0, 0, 0, 5
vet2: .skip 32
len: .word 16
n:   .word 5

.text
main:
;bl es6_1
;mov r0, r4
ldr r0, =n
ldr r0, [r0]
ldr r1, =vet2
bl es6_3
swi 0x11

es6_1:
ldr r0, =len
ldr r0, [r0]  ; r0 -> 5
ldr r1, =vet
mov r2, #0
mov r3, #4
loop2:
add r9, r9, #1
cmp r9, r0
beq skip
ldr r5, [r1, r2]
ldr r6, [r1, r3]
cmp r6, r0
beq skip
cmp r5, #0
beq label
add r2, r2, #4
add r3, r3, #4
add r4, r4, #1
b loop2
label:
cmp r6, #0
beq label2
str r6, [r1, r2]
str r8, [r1, r3]
add r2, r2, #4
add r3, r3, #4
add r4, r4, #1
b loop2
label2:
add r3, r3, #4
ldr r6, [r1, r3]
b label

es6_3:
stmfd sp!, {r1-r3, lr} ;si basa su sub_bit quindi deve avere 32 bit in memoria disponibili
ldr r1, =vet2
bl sud_bit
mov r0, #0
mov r3, #0
par_loop:
cmp r0, #32
beq par_end
ldrb r2, [r1], #1
cmp r2, #1
addeq r3, r3, #1
add r0, r0, #1
b par_loop
par_end:
mov r0, r3
mov r1, #2
bl div
cmp r0, #0
movne r0, #1
ldmfd sp!, {r1-r3, lr}
mov pc, lr
sud_bit:
stmfd sp!, {r0-r3, lr}
mov r2, #0
div:  ; resto in r0, risultato in r1
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

skip:
mov pc, lr

.end
