## Pratush  Kc 
## Link to your recording: 
## EECE.3170: Microprocessors I
## UMass Lowell
## Spring 2021 final exam programming problem
## You are open to having your design of the solution based on your interpretation
/*****
  TODO:
  You must change this program so that:
    1. Create the following variables:
      array_s1 = [1,3,3,2];
      n1 = 4;   // number of element of array_s1
      m1 = 2;   // array index
    2. Your program should detect each press of S1 using switch interrupt.
     
    3. The program changes the state of LED1 based on the following conditions:
       If S1 is pressed the same number of times as the value of array_s1 at m1 index, LED1 turns on
     
       For example, since m1 is 2, which means 3 is the m1-th element (2nd) of array_s1. So LED1 should be turned on only when S1 is pressed 3 times.
       
    4. If S1 is pressed 4 times, LED1 blinks with period 0x0FFF and Prescaler 256.

*****/
      
    .globl  __vector_dispatch_9   
    .section .vector_9, code, keep
    .align 2
    .set nomips16
    .ent __vector_dispatch_9
__vector_dispatch_9:
    j  isrvector9	    
    nop
    .end __vector_dispatch_9
    .size __vector_dispatch_9, .-__vector_dispatch_9
    
    .data
    array_s1:	.word	 1,3,3,2
    n1:		.word	 4	// number of element of array_s1
    m1:		.word	 2      //index to be tested 
    
    
    .text		
    .set noreorder	
    .globl main		
    .ent main		
    

#include <xc.h>
    
main:
   
    sw	    zero, TRISA		    
    sw	    zero, ANSELA	    
    li	    t0, _PORTB_RB7_MASK
    ori	    t0, t0, _PORTB_RB13_MASK
    sw	    t0, TRISB		    
    sw	    zero, ANSELB	     
    sw	    zero, TRISC		    
    sw	    zero, ANSELC	    

    li	    t4, _PORTB_RB7_MASK	    
    
    
    
    lui	    t3, 0x0001			
					
    ori	    t3, t3, _INTCON_MVEC_MASK   
    sw	    t3, INTCON
    
    li	    t3, _IPC2_CNBIP_MASK    
    sw	    t3, IPC2		    
    
    li	    t3, _IEC0_CNBIE_MASK    
    sw	    t3, IEC0		    

    add	    t3, t4, zero	    
    or	    t3, t3, t6		    
    sw	    t3, CNEN1B		    
    sw	    zero, CNEN0B	    
    
    li	    t3, _CNCONB_ON_MASK		    
    ori	    t3, t3, _CNCONB_CNSTYLE_MASK    
    sw	    t3, CNCONB
    li	    s7, 0
    
    lw	    t7, n1
    lw	    t8, m1
    la	    t9, array_s1	    
    
    ei				    

    
   nop 
    sll   s5, t8, 2
    add	  s6, t9, s5
    lw	  s3, 0(s6)
    li	  s4, 0
    
    li	    t2, _PORTA_RA0_MASK	   
    
    
    addi  sp, sp, -4
    sw	  s4, 0(sp)
nop    
mainloop:
    
 
    lw	  s4, 0(sp)
    
    
    beq	  s4, s3, ledOn
    nop
    
    beq   s4, 4, ledBlink
    nop
    
    beq	  s4, 5, End
    nop 
   
    j	mainloop
    nop
    
    
    ledOn:
    sw	t2, LATASET 
    j	mainloop
    nop
    
    ledBlink:
    
    sw	t2, LATAINV
   
    jal delay
    nop
   
    
    jal delay
    nop
    
   
    j	mainloop
    nop
    
    
    j	    mainloop
    nop
    
    End:
    sw	t2, LATACLR
    
    j	End
    nop 
    
    .end main
    

    
    
    .global isrvector9
    .ent isrvector9
isrvector9:   
    li	    t4, _PORTB_RB7_MASK	   
  
    sw	    t4, CNFBCLR		    
   
    li	    t2, _PORTA_RA0_MASK	    
    
    lw	  s4, 0(sp)
    
    addi  s4, s4, 1
    
    sw	  s4, 0(sp)
    
    li	    t3, _IFS0_CNBIF_MASK    
    sw	    t3, IFS0CLR		    
    eret		    
    .end isrvector9   
    
.ent delay

delay:
    li	    t1, 0x555500		  
				    
	
loop:

    addi    t1, t1, -1		    
    bne	    t1, zero, loop	   
    nop				    
    jr	    ra
    nop
    
.end delay