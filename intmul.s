@  Scott Fryslie
@  CPE 315-05 
@  Fall 2016

@  Function to return the product of two integers, by
@  shifting and adding successive sums.

@  Function was derived from pseudocode "Shift-And-Add" algorithm
@  that was demonstrated in lecture.

.syntax unified

    .arch armv6
    .fpu vfp 
    
    @ --------------------------------
    .global intmul
intmul:
    
      push    {r4, r5, r6, lr}
      
      mov     r4, #0          @ product
      mov     r5, r0          @ multiplicand
      mov     r6, r1          @ multiplier

   multloop:
      cmp     r6, #0          
      beq     endmultloop     @ while (multiplier != 0)
      
      and     r2, r6, #1
      cmp     r2, #1
      
      bne     shifts          @ if LSB == 1, product += multiplicand
      mov     r0, r4
      mov     r1, r5
      bl      intadd
      mov     r4, r0
      
   shifts:
      lsr     r6, r6, #1      @ multiplier >>= 1
      lsl     r5, r5, #1      @ multiplicand <<= 1
      
      b       multloop


   endmultloop:      
      mov     r0, r4          @ move product to r0 to be returned
      pop     {r4, r5, r6, pc}
