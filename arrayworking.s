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
    BL  _scanf		    @ calls scanf for first operand
    MOV R7, R0
    MOV R0, #0              @ initialze index variable
    BL  _reg_dump	    @ print register contents
generate:
    CMP R0, #20             @ check to see if we are done iterating
    BEQ writedone           @ exit loop if done
    LDR R1, =a_array        @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    ADD R8, R7, R0          @ R8 now has the value n+i
    STR R8, [R2]            @ write the address of a[i] to a[i]
    ADD R2, R2, #4          @ R2 now has the element address
    ADD R8, R8, #1          @ R2 now has the element address
    MOV R12, #0
    SUB R8, R12, R8         @ converting to negative value.
    ADD R0, R0, #2          @ increment index
    STR R8, [R2]
    B generate              @ branch to next loop iteration
writedone:
    MOV R0, #0              @ initialze index variable

sorting:
    CMP R0, #20             @ check to see if we are done iterating
    BEQ sortdone            @ exit loop if done
    LDR R7, =a_array        @ get address of a(put b for array a)
    LSL R2, R0, #2          @ multiply index*4 to get array offset /////OFFSET TOO STORE STH TO B SAME
    ADD R2, R7, R2          @ R2 now has the element address //CHANGE TO ADDRESS OF B TWO REQUIRED 
    LDR R1, [R2]
    PUSH {R0}               @ backup register before printf
    PUSH {R1}               @ backup register before printf
    PUSH {R2}               @ backup register before printf
    MOV R2, R1              @ move array value to R2 for printf
    MOV R1, R0              @ move array index to R1 for printf
    BL  _printf             @ branch to print procedure with return
    POP {R2}                @ restore register
    POP {R1}                @ restore register
    POP {R0}                @ restore register
    ADD R0, R0, #1          @ increment index
    B sorting            @ branch to next loop iteration
sortdone:
    B _exit

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
    
_reg_dump:
    PUSH {LR}           @ backup registers
    PUSH {R0}           @ backup registers
    PUSH {R1}           @ backup registers
    PUSH {R2}           @ backup registers
    PUSH {R3}           @ backup registers
    
    PUSH {R14}          @ push registers for printing
    PUSH {R13}          @ push registers for printing
    PUSH {R12}          @ push registers for printing
    PUSH {R11}          @ push registers for printing
    PUSH {R10}          @ push registers for printing
    PUSH {R9}           @ push registers for printing
    PUSH {R8}           @ push registers for printing
    PUSH {R7}           @ push registers for printing
    PUSH {R6}           @ push registers for printing
    PUSH {R5}           @ push registers for printing
    PUSH {R4}           @ push registers for printing
    PUSH {R3}           @ push registers for printing
    PUSH {R2}           @ push registers for printing
    PUSH {R1}           @ push registers for printing
    PUSH {R0}           @ push registers for printing
	
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #0          @ prepare R0 print
    POP {R2}            @ prepare R0 print
    MOV R3, R2          @ prepare R0 print
    BL printf           @ print R0 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #1          @ prepare R1 print
    POP {R2}            @ prepare R1 print
    MOV R3, R2          @ prepare R1 print
    BL printf           @ print R1 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #2          @ prepare R2 print
    POP {R2}            @ prepare R2 print
    MOV R3, R2          @ prepare R2 print
    BL printf           @ print R2 value prior to reg_dump call
 
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #3          @ prepare R3 print
    POP {R2}            @ prepare R3 print
    MOV R3, R2          @ prepare R3 print
    BL printf           @ print R3 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #4          @ prepare R4 print
    POP {R2}            @ prepare R4 print
    MOV R3, R2          @ prepare R4 print
    BL printf           @ print R4 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #5          @ prepare R5 print
    POP {R2}            @ prepare R5 print
    MOV R3, R2          @ prepare R5 print
    BL printf           @ print R5 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #6          @ prepare R6 print
    POP {R2}            @ prepare R6 print
    MOV R3, R2          @ prepare R6 print
    BL printf           @ print R6 value prior to reg_dump call
 
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #7          @ prepare R7 print
    POP {R2}            @ prepare R7 print
    MOV R3, R2          @ prepare R7 print
    BL printf           @ print R7 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #8          @ prepare R8 print
    POP {R2}            @ prepare R8 print
    MOV R3, R2          @ prepare R8 print
    BL printf           @ print R8 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #9          @ prepare R9 print
    POP {R2}            @ prepare R9 print
    MOV R3, R2          @ prepare R9 print
    BL printf           @ print R9 value prior to reg_dump call
    
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #10          @ prepare R10 print
    POP {R2}            @ prepare R10 print
    MOV R3, R2          @ prepare R10 print
    BL printf           @ print R10 value prior to reg_dump call
    
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #11         @ prepare R11 print
    POP {R2}            @ prepare R11 print
    MOV R3, R2          @ prepare R11 print
    BL printf           @ print R11 value prior to reg_dump call
    
    LDR R0,=debug_str   @ prepare register print
    MOV R1, #12         @ prepare R12 print
    POP {R2}            @ prepare R12 print
    MOV R3, R2          @ prepare R12 print
    BL printf           @ print R12 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #13         @ prepare R13 print
    POP {R2}            @ prepare R13 print
    MOV R3, R2          @ prepare R13 print
    BL printf           @ print R13 value prior to reg_dump call

    LDR R0,=debug_str   @ prepare register print
    MOV R1, #14         @ prepare R14 print
    POP {R2}            @ prepare R14 print
    MOV R3, R2          @ prepare R14 print
    BL printf           @ print R14 value prior to reg_dump call
    
    POP {R3}            @ restore register
    POP {R2}            @ restore register
    POP {R1}            @ restore register
    POP {R0}            @ restore regsiter
    POP {PC}            @ return
 



.data
.balign 4
a_array:        .skip       80
b_array:        .skip       80
format_str:     .asciz      "%d"
debug_str:      .asciz      "R%-2d   0x%08X  %011d \n"
printf_str:     .asciz      "a[%d] = %d"
exit_str:       .ascii      "Terminating program.\n"
