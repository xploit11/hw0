/******************************************************************************
* @FILE array.s
* @BRIEF simple array declaration and iteration example
*
* Simple example of declaring a fixed-width array and traversing over the
* elements for printing.
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/
 
.global main
.func main
   
main:
    MOV R0, #0              @ initialze index variable            // initialize R0= i to 0.
writeloop:
    CMP R0, #20            @ check to see if we are done iterating     //for loop (i<100)
    BEQ writedone           @ exit loop if done                         //
    LDR R1, =a              @ get address of a                        //store base address of a in R1 (R1=&a)
    LSL R2, R0, #2          @ multiply index*4 to get array offset    //logical shift left (offset) :this is like multiply but faster than multiply
    ADD R2, R1, R2          @ R2 now has the element address      // R2= base address +offset (R2=&a[i]
    STR R2, [R2]            @ write the address of a[i] to a[i]    // write to that value in R2 address/memory location.
    ADD R0, R0, #1          @ increment index                       //increment i (i++).
    B   writeloop           @ branch to next loop iteration
writedone:
    MOV R0, #0              @ initialze index variable
readloop:
    CMP R0, #20            @ check to see if we are done iterating     //loop
    BEQ readdone            @ exit loop if done                       //loop
    LDR R1, =a              @ get address of a                      //
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address         //same as above write loop.
    LDR R1, [R2]            @ read the array at address             // like dereferencing pointer
    PUSH {R0}               @ backup register before printf        //block for printf
    PUSH {R1}               @ backup register before printf
    PUSH {R2}               @ backup register before printf
    MOV R2, R1              @ move array value to R2 for printf     
    MOV R1, R0              @ move array index to R1 for printf
    BL  _printf             @ branch to print procedure with return
    POP {R2}                @ restore register
    POP {R1}                @ restore register
    POP {R0}                @ restore register                //block for printf ends
    ADD R0, R0, #1          @ increment index         //increment
    B   readloop            @ branch to next loop iteration   
readdone:
    B _exit                 @ exit if done
    
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
       
_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
   
.data

.balign 4     //byte allign to make divisible by 4 
a:              .skip       80      //Defining array. 100 slots *4 byte= 400.
b:              .skip       80
printf_str:     .asciz      "a[%d] = %d      b=%d"
exit_str:       .ascii      "Terminating program.\n"
