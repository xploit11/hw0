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
    VCVT.S32.S32 S0, S0
    VCVT.S64.S32 S0, S0
    BL  _scanf		            @ calls scanf for first operand
    MOV R5, R0		            @ move value of R0 to register R1 
    VLDR S1, [R0]           @ load the value into the VFP register
    VCVT.S32.S32 S1, S1
    VCVT.S64.S32 S0, S0
    VDIV.F64 D4, D2, D3     @ covert the result to double precision for printing
    VMOV R1, R2, D4         @ split the double VFP register into two ARM registers
    BL  _printf_result1      @ print the result
    BL  _printf_result2      @ print the result
    B   main               @ branch to exit procedure with no return
   
_scanf:
    PUSH {LR}               @ pushes LR in stack since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ pops PC

_printf_result1:
    PUSH {LR}               @ push LR to stack
    LDR R0, =result_str1     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ pop LR from stack and return
    
_printf_result2:
    PUSH {LR}               @ push LR to stack
    LDR R0, =result_str2     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ pop LR from stack and return

.data
result_str1:     .asciz      "%d / %d: "
result_str2:     .asciz      "%f\n"
format_str:     .asciz      "%d"
