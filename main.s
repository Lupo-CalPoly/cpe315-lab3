@  Scott Fryslie
@  CPE 315-05 
@  Fall 2016

@ Driver function main lives here
@ Uses commandline arguments to do basic calculations

.syntax unified

    .arch armv6
    .fpu vfp 

    @ --------------------------------
    .global main
main:
      push    {r4, r5, r6, lr}
   loop:
      
    @ No error checking was done while scanning for integers
    @ I wasn't sure if I was supposed to, since it wasn't in spec.
    
    @ Gets the first number from the user
      ldr     r0, =string1
      bl      printf
      ldr     r0, =scannum
      mov     r1, sp
      bl      scanf
      ldr     r0, [sp]
      mov     r4, r0
      
    @ Gets the second number from the user  
      ldr     r0, =string2
      bl      printf
      ldr     r0, =scannum
      mov     r1, sp
      bl      scanf
      ldr     r0, [sp]
      mov     r5, r0
      
    @ Gets the operation to perform from the user  
      ldr     r0, =string3
      bl      printf
      ldr     r0, =scanchar
      mov     r1, sp
      bl      scanf
      ldrb    r6, [sp]
     
    @ Sets r0 and r1 to the numbers entered by the user
      mov     r0, r4
      mov     r1, r5

    @ Compares r6 (operation entered by user) 
    @ with +,-,* to see which operation is to be done
      ldr     r3, =plus
      ldrb    r3, [r3]
      cmp     r3, r6
      bne     subtracting
      bl      intadd
      b       result
      
   subtracting:
      ldr     r3, =minus
      ldrb    r3, [r3]
      cmp     r3, r6
      bne     multiplying 
      bl      intsub
      b       result
      
   multiplying:
      ldr     r3, =times
      ldrb    r3, [r3]
      cmp     r3, r6
      bne     invalidop
      bl      intmul
      b       result
      
    @ Prints error message if user enters a non-supported operation
   invalidop:
      ldr     r0, =stringerr1
      bl      printf
      b       again
      
    @ Prints out the result of the calculation, if done without error
   result:
      mov     r1, r0
      ldr     r0, =stringresult
      bl      printf
      
    @ Asks if the user wants to do another calculation
   again:
      ldr     r0, =stringredo
      bl      printf
      ldr     r0, =scanchar
      mov     r1, sp          @ Save stack pointer to r1, you must create space
      bl      scanf           @ Scan user's answer
      ldr     r1, =yes        @ Put address of 'y' in r1
      ldrb    r1, [r1]        @ Load the actual character 'y' into r1
      ldrb    r0, [sp]        @ Put the user's value in r0
      cmp     r0, r1          @ Compare user's answer to char 'y'
      beq     loop            @ branch to appropriate location
      
      ldr     r1, =no         @ Put address of 'n' in r1
      ldrb    r1, [r1]        @ Load the actual character 'n' into r1
      cmp     r0, r1          @ Compare user's answer to char 'n'
      beq     end             @ branch to terminate program, if 'n'
      
    @ Prints error message if user does not enter 'y' or 'n'
    @ then prompts user again for 'y' or 'n'
      ldr     r0, =stringerr2
      bl      printf
      b       again
      
   end:
      pop     {r4, r5, r6, pc}
      
      
yes:
    .byte   'y'
no:
    .byte   'n'
plus:
    .byte   '+'
minus:
    .byte   '-'
times:
    .byte   '*'
    

string1:
    .ascii  "Enter Number 1: \000"
string2:
    .ascii  "Enter Number 2: \000"
string3:
    .ascii  "Enter Operation: \000"
    

stringresult:
    .ascii  "Result is: %d\012\000"
stringredo:
    .ascii  "Again? \000"
    
stringerr1:
    .ascii  "Invalid Operation Entered.\012\000"
stringerr2:
    .ascii  "Invalid Response Entered. (y/n)\012\000"
    
 
scannum:
    .asciz  " %d"
scanchar:
    .asciz  " %c"
