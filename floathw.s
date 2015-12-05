/******************************************************************************
* @FILE float.s
* @BRIEF simple example of scalar multiplication using the FPU
*
* Simple example of using the ARM FPU to compute the multiplication result of
* two float values
*
* @AUTHOR Anish Timila
******************************************************************************/
 
    .global main
    .func main
   
main:
    BL  _scanf		            @ calls scanf for first operand
    MOV R4, R0		            @ move value of R0 to register R1 
    VLDR S0, [R0]           @ load the value into the VFP register
    FSITO<S/D> S0, R0
    BL  _scanf		            @ calls scanf for first operand
    MOV R5, R0		            @ move value of R0 to register R1 
    VLDR S1, [R0]           @ load the value into the VFP register
    FSITO<S/D> S1, R0
    VDIV.F32 S2, S0, S1     @ compute S2 = S0 * S1
    VCVT.F64.F32 D4, S2     @ covert the result to double precision for printing
    VMOV R1, R2, D4         @ split the double VFP register into two ARM registers
    BL  _printf_result      @ print the result
    B   _exit               @ branch to exit procedure with no return
   
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall

_scanf:
    PUSH {LR}               @ pushes LR in stack since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ pops PC

_printf_result:
    PUSH {LR}               @ push LR to stack
    LDR R0, =result_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ pop LR from stack and return

.data
result_str:     .asciz      "Multiplication result = %f \n"
format_str:     .asciz      "%d"
exit_str:       .ascii      "Terminating program.\n"
val1:           .float      3.14159
val2:           .float      0.100
