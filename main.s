    // Template main.s file for Lab 3
    // partner names here

    .arch armv8-a

fp .req x29
lr .req x30

    // --------------------------------
    .global main
   /* Include a register usage plan in this comment before the function
    *   ** or ** give each register a meaningful alias using the syntax:
    * arg0 .req x0
    *
    * If you add additional functions remember to include register usage
    * plans for them as well.
    */


.equ MAIN_STACK_SIZE, 32
main:
    // driver function main lives here, modify this for your other functions
    stp fp, lr, [sp, -MAIN_STACK_SIZE]!
    mov fp, sp



.lloop: 

    // You'll need to scan characters for the operation and to determine
    // if the program should repeat.
    // To scan a character, and compare it to another, do the following
    // NOTE: You will need to do something similar to read the input values and operation
    //  There are lots of ways to do this, understand how it works in C, in particular where values are being stored

    ldr x0, =againstr
    bl printf
    
    ldr     w0, =scanchar
    add     x1, sp, 16      // Save stack pointer to x1, you must create space
    bl      scanf           // Scan user's answer
    ldrb    w0, [sp, 16]    // Put the user's value in r0
    cmp     w0, 'y'         // Compare user's answer to char 'y'
    beq    .lloop           // branch to appropriate location

   
    ldp fp, lr, [sp], MAIN_STACK_SIZE 
    ret

scanchar:
    .asciz  " %c"
scanint:
    .asciz  " %d"
againstr:
    .asciz "Again? "

