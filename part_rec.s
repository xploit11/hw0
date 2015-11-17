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
    MOV R4, R0		@ move value of R0 to register R1 
    BL  _scanf		@ calls scanf for first operand
    MOV R5, R0		@ move value of R0 to register R2 
    PUSH {R4}           @ store value to stack
    PUSH {R5}           @ store value to stack
    BL  _reg_dump       @ print register contents
    BL  _cpartision     @ compute the remainder of R1 / R2
    POP {R5}            @ restore values from stack
    POP {R4}            @ restore values from stack
    MOV R3, R0          @ copy PARTISION result to R3
    BL  _print          @ branch to print procedure with return
    B   _exit           @ branch to exit procedure with no return

_cpartision:
    PUSH {LR}
    
@@@ IF(n==0)
    CMP R4, #0
    MOVEQ R0, #1
    POPEQ {PC}

@@@ ELSE IF(n<0)
    CMP R4, #0
    MOVLT R0, #0
    POPLT {PC}

@@@ ELSE IF(m==0)
    CMP R5, #0
    MOVEQ R0, #0
    POPEQ {PC}

@@@ ELSE
    PUSH {R4}
    PUSH {R5}
    SUB R4, R4, R5          @ decrement the input argument N=N-M
    BL _cpartision          @a, b already in R1, R2
    POP {R5}
    POP {R4}
    PUSH {R0}
    SUB R5, R5, #1          @ decrement the input argument M=M-1
    BL _cpartision          @a, b already in R1, R2
    POP {R8}
    ADD R1, R0, R8    
    POP {PC}
   
_exit:  
    MOV R7, #4          @ write syscall, 4
    MOV R0, #1          @ output stream to monitor, 1
    MOV R2, #21         @ print string length
    LDR R1,=exit_str    @ string at label exit_str:
    SWI 0               @ execute syscall
    MOV R7, #1          @ terminate syscall, 1
    SWI 0               @ execute syscall
       
_scanf:
    PUSH {LR}               @ pushes LR in stack since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ pops PC

_print:
    MOV R4, LR          @ store LR since printf call overwrites
    LDR R0,=print_str   @ R0 contains formatted string address
    BL printf           @ call printf
    MOV PC, R4          @ return

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
format_str:     .asciz  "%d"
debug_str:	.asciz 	"R%-2d   0x%08X  %011d \n"
print_str:      .asciz 	"PARTISION OF %d USING INTEGERS UPTO %d = %d \n"
exit_str:	.ascii 	"Terminating program.\n"
