@  Scott Fryslie
@  CPE 315-05 
@  Fall 2016

.syntax unified
    
    .arch armv6
    .fpu vfp 
    
    @ --------------------------------
    .global intadd
intadd:
      push    {r4, lr}        @ r4 is not needed, dummy value
                              @ maintains eight-byte stack alignment
   addloop:
      and     r2, r0, r1      @ "and" to see where carries will occur
      eor     r3, r0, r1      @ "xor" to add without doing carries
      
      lsl     r0, r2, #1      @ left-shift (carry) the carries over
      
      mov     r1, r3          @ result without carries will add (xor)
                              @ with the carries from previous iteration
      
      cmp     r2, #0          @ if no carries left, terminate loop
      bne     addloop
      
      mov     r0, r1          @ move final result into r0 to be returned
      pop     {r4, pc}
