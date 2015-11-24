/******************************************************************************
* @FILE array.s
* @BRIEF simple array declaration and iteration example
*
* Simple example of declaring a fixed-width array and traversing over the
* elements for printing.
*
* @AUTHOR ANISH TIMILA
******************************************************************************/
 
.global main
.func main
   
main:
    BL  _scanf		            @ calls scanf for first operand
    MOV R7, R0
    MOV R0, #0              @ initialze index variable
generate:
    CMP R0, #20            @ check to see if we are done iterating
    BEQ writedone           @ exit loop if done
    LDR R1, =a_array              @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    ADD R8, R7, R0          @ R2 now has the element address
    STR R8, [R2]            @ write the address of a[i] to a[i]
    ADD R2, R2, #4          @ R2 now has the element address
    ADD R8, R8, #1          @ R2 now has the element address
    MUL R8, #0, R8          @ converting to negative value.
    STR R8, [R2]
    B generate           @ branch to next loop iteration
writedone:
    MOV R0, #0              @ initialze index variable

readloop//sorting function:
    CMP R0, #100            @ check to see if we are done iterating
    BEQ readdone            @ exit loop if done
    LDR R7, =b_array              @ get address of a(put b for array a)
    LSL R2, R0, #2          @ multiply index*4 to get array offset /////OFFSET TOO STORE STH TO B SAME
    ADD R2, R7, R2          @ R2 now has the element address //CHANGE TO ADDRESS OF B TWO REQUIRED 
    LDR R1, [R2]            @ read the array at address 
    
    ADD R0, R0, #1          @ increment index
    B   readloop            @ branch to next loop iteration
readdone:
    B _exit                 @ exit if done

_scanf:
    PUSH {LR}           @ pushes LR in stack since scanf call overwrites
    SUB SP, SP, #4      @ make room on stack
    LDR R0, =format_str @ R0 contains address of format string
    MOV R1, SP          @ move SP to R1 to store entry on stack
    BL scanf            @ call scanf
    LDR R0, [SP]        @ load value at SP into R0
    ADD SP, SP, #4      @ restore the stack pointer
    POP {PC}            @ pops PC

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

.balign 4
a:              .skip       80
printf_str:     .asciz      "a[%d] = %d\n"
exit_str:       .ascii      "Terminating program.\n"
