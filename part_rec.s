 /******************************************************************************
* @FILE RECURSIVE PARTISION.s
* @BRIEF simple mod operations example
*
* Recursive program for computing the total no. of partisions possible up to the given number.
*
* @AUTHOR Anish Timila
******************************************************************************/
 
    .global main
    .func main
   
main:
    BL  _scanf		@ calls scanf for first operand
    MOV R1, R0		@ move value of R0 to register R1 
    PUSH {R1}		@ store value to stack
    BL  _scanf		@ calls scanf for first operand
    MOV R2, R0		@ move value of R0 to register R2 
    POP {R1}		@ store value to stack
    PUSH {R1}           @ store value to stack
    PUSH {R2}           @ store value to stack
    BL  _cpartision     @ compute the remainder of R1 / R2
    POP {R2}            @ restore values from stack
    POP {R1}            @ restore values from stack
    MOV R6, R0          @ copy PARTISION result to R3
    MOV R7, R1          @ move R1 to R7
    MOV R8, R2          @ move R2 to R8
    MOV R1, R8          @ move R8 to R1
    MOV R2, R6          @ move R6 to R2
    MOV R3, R7          @ move R7 to R3
    BL  _print          @ branch to print procedure with return
    B   main           @ branch to exit procedure with no return

_cpartision:
    PUSH {LR}		@ store value to stack
    
@@@ IF(n==0)
    CMP R1, #0		@ compare R1 to 0
    MOVEQ R0, #1	@ move if equals and set value 1
    POPEQ {PC}		@ return value 1.

@@@ ELSE IF(n<0)
    CMP R1, #0		@ compare R1 to 0
    MOVLT R0, #0	@ move if less than and set value 0
    POPLT {PC}		@ return value 0.

@@@ ELSE IF(m==0)
    CMP R2, #0		@ compare R1 to 0
    MOVEQ R0, #0	@ move if equals and set value 0
    POPEQ {PC}		@ return to main.

@@@ ELSE
    PUSH {R1}		@ store value to stack
    PUSH {R2}		@ store value to stack
    SUB R1, R1, R2      @ decrement the input argument N=N-M
    BL _cpartision      @ a, b already in R1, R2
    POP {R2}		@ restore value of R2
    POP {R1}		@ restore value of R1
    PUSH {R0}		@ store value to stack
    SUB R2, R2, #1      @ decrement the input argument M=M-1
    BL _cpartision      @ a, b already in R1, R2
    POP {R8}		@ restore value to R8
    ADD R1, R0, R8	@ add value of R0 and R8 to R1
    MOV R0, R1		@ move R1 value to R0
    POP {PC}		@ return to main.
   
_exit:  
    MOV R7, #4          @ write syscall, 4
    MOV R0, #1          @ output stream to monitor, 1
    MOV R2, #21         @ print string length
    LDR R1,=exit_str    @ string at label exit_str:
    SWI 0               @ execute syscall
    MOV R7, #1          @ terminate syscall, 1
    SWI 0               @ execute syscall
       
_scanf:
    PUSH {LR}           @ pushes LR in stack since scanf call overwrites
    SUB SP, SP, #4      @ make room on stack
    LDR R0, =format_str @ R0 contains address of format string
    MOV R1, SP          @ move SP to R1 to store entry on stack
    BL scanf            @ call scanf
    LDR R0, [SP]        @ load value at SP into R0
    ADD SP, SP, #4      @ restore the stack pointer
    POP {PC}            @ pops PC

_print:
    MOV R4, LR          @ store LR since printf call overwrites
    LDR R0,=print_str   @ R0 contains formatted string address
    BL printf           @ call printf
    MOV PC, R4          @ return

.data
format_str:     .asciz  "%d"
print_str:      .asciz 	"THERE ARE %d PARTISION OF %d USING INTEGERS UPTO %d\n"
exit_str:	.ascii 	"Terminating program.\n"
