/******************************************************************************
* @FILE FINAL.s
* @BRIEF simple array declaration and iteration example wth min, max and sum.
*
* Simple example of declaring a fixed-width array and traversing over the
* elements for printing and calculation of minimum, maximum, and sum.
*
* @AUTHOR ANISH TIMILA
******************************************************************************/
 
.global main
.func main
   
main:
    MOV R0, #0              @ initialze index variable
    MOV R4, #0              @ initialization of R4 to 0
    SUB R9, R0, #1000       @storing mimum value in R9
    MOV R10, #1000          @storing maximum value in R10
writeloop:
    CMP R0, #10             @ check to see if we are done iterating
    BEQ writedone           @ exit loop if done
    PUSH {R0}               @ backing up R0
    BL _scanf               @ get a number from console
    MOV R8, R0              @ moving the input to R8
    ADD R4, R4, R8          @ calculation for sum
    BL _min                 @ branch link to  _min
    BL _max                 @ branch link to _max
    POP {R0}                @ restoring value of R0
    LDR R1, =a              @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    STR R8, [R2]            @ write the address of a[i] to a[i]
    ADD R0, R0, #1          @ increment index
    B   writeloop           @ branch to next loop iteration
writedone:
    MOV R0, #0              @ initialze index variable
 
readloop:
    CMP R0, #10             @ check to see if we are done iterating
    BEQ readdone            @ exit loop if done
    LDR R1, =a              @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    LDR R1, [R2]            @ read the array at address 
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
    B   readloop            @ branch to next loop iteration
readdone:
    MOV R1, R10             @ moving value of R10 to R1
    BL _printmin            @ calling _printmin function
    MOV R1, R9              @ moving value of R9 to R1
    BL _printmax            @ calling _printmin function
    MOV R1, R4              @ moving value of R4 to R1
    BL _printsum            @ calling _printmin function
    B _exit                 @ exit if done
    
_max:
    CMP R8, R9              @ compare R2 and R3 
    MOVGT R9, R8            @ Move Greater Than
    MOV PC, LR              @ return

_min:
    CMP R8, R10             @ compare R2 and R3 
    MOVLT R10, R8           @ Move Less Than
    MOV PC, LR              @ return

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
    
_printsum:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_sum     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
 
 _printmin:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_min     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
 
 _printmax:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_max     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
   
 _scanf:
    PUSH {LR}               @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ return
 
 
.data

.balign 4
a:              .skip       40
format_str:     .asciz      "%d"
printf_str:     .asciz      "array_a[%d] = %d\n"
printf_sum:     .asciz      "sum = %d\n"
printf_min:     .asciz      "minimum = %d\n" 
printf_max:     .asciz      "maximum = %d\n" 
exit_str:       .ascii      "Terminating program.\n"
