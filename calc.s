/******************************************************************************
* @FILE calc.s
* @BRIEF simple calculator program
*
* Simple calculator to do arithmetic sum, difference, multiply and maximum.
*
* @AUTHOR ANISH TIMILA
******************************************************************************/
 
    .global main
    .func main

main:
    BL  _scanf		            @ calls scanf for first operand
    MOV R8, R0		            @ move value of R0 to register R8 
    BL _getchar             @ branch to getchar procedure with return
    MOV R10, R0		           @ move value of R0 to register R10
    BL _scanf		             @ calls scanf for second operand
    MOV R9, R0		            @ move value of R0 to register R9
    MOV R1, R10		           @ move value of R10 to register R10
    MOV R2, R8		            @ move value of R8 to register R2
    MOV R3, R9		            @ move value of R9 to register R3
    BL _compare		           @ branch link to compare
    MOV R1, R0 		           @ moves value of R0 to register R1
    BL _printf              @ calls printf
    B main                  @ calls main (to form a loop)

_printf:
    MOV R4, LR              @ store LR since printf call overwrites
    LDR R0, =printf_str     @ R0 contains formatted string address
    MOV R1, R1              @ R1 contains printf argument (redundant line)
    BL printf               @ call printf
    MOV PC, R4              @ return

_getchar:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R1, =read_char      @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R1]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return

_compare:
    CMP R1, #'+' 	          @ compare against the constant char '+'
    BEQ _add                @ branch to equal handler add
    CMP R1, #'-'	           @ compare against the constant char '-'
    BEQ _sub		              @ branch to equal handler sub
    CMP R1, #'*'	           @ compare against the constant char '*'
    BEQ _mul 		             @ branch to equal handler mul
    CMP R1, #'M'	           @ compare against the constant char 'M'
    BEQ _max		              @ branch to equal handlermax
    MOV PC, R4              @ return

_scanf:
    PUSH {LR}               @ pushes LR in stack since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ pops PC

_add:
    ADD R0, R2,R3	          @ add R2 and R3 and store the value in R0 
    MOV PC, LR		            @ return

_sub:
    SUB R0, R2, R3          @ subtract R3 from R2 and store the value in R0
    MOV PC, LR              @ return

_mul:
    MUL R0, R2, R3          @ multiply R2 and R3 and store the value in R0
    MOV PC, LR              @ return

_max:
    CMP R2, R3              @ compare R2 and R3 
    MOVGT R0, R2            @ Move Greater Than
    MOVLT R0, R3            @ Move Less Than
    MOV PC, LR              @ return
 
.data
format_str:     .asciz     "%d"
read_char:	     .asciz	    ""
printf_str:     .asciz     "The output based on the entered operation code is : %d\n **************************************** \n"
