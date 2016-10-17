@  Scott Fryslie
@  CPE 315-05 
@  Fall 2016

@  Function to return the difference of two integers, x and y by
@  getting the "Two's Complement" of y, then
@  calling addition function to perform x + -y.

.syntax unified

    .arch armv6
    .fpu vfp
    
    @ --------------------------------
    .global intsub
intsub:
    
      push    {r4, lr}

      mov     r4, r0          @ Save r0 while doing Two's Complement of r1

      mvns    r0, r1          @ Two's Complement of r1
      mov     r1, #1
      bl      intadd
   
      mov     r1, r4          @ Perform Addition with negative of original r1
      bl      intadd     
      
      pop     {r4, pc}
