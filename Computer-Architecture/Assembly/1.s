.data
primes: .word 10, 4, 6, 12

.text
ldr r5, =primes
ldr r6, [r5]
ldr r7, [r5, #4]
ldr r8, [r5, #8]
ldr r9, [r5, #12]
bl zero

zero:               @somma dei valori
add r0, r6, r7
add r0, r0, r8
add r0, r0, r9

one:                @media dei valori
mov r1, r0, lsr #2

two:                @(2^10+1)*n1
mov r3, #2
mov r3, r3, lsl #9
add r3, r3, #1
mul r2, r3, r6
mov r3, #0

three:
mov r4, r6, lsr #5

four:
