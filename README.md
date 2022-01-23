# Microprocessors-Arrays-and-Interrupts

This assignment utlizes a PIC32MM microcontroller to carry out the instructions written in the provided source code. The assignment details are as follows:

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

In this program, a built in button on the PIC32MM and interrupts are used to iterate though an array which contains specific settings for the program. 
