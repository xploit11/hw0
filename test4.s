/******************************************************************************
* @FILE floathw.s
* @BRIEF simple example of scalar multiplication using the FPU
*
* Simple example of using the ARM FPU to compute the division result of
* two float values
*
* @AUTHOR Anish Timila
******************************************************************************/

	.global main
	.func main

main:
	BL _scanf			@ calls scanf for first operand
	MOV R8, R0			@ move value of R0 to register R8 
	BL _scanf			@ calls scanf for first operand
	MOV R9, R0			@ move value of R0 to register R9 
	VMOV S0, R8			@ move value of R8 to signed register S0 
	VMOV S1, R9			@ move value of R9 to signed register S1 
	MOV R1, R8			@ move value of R8 to register R1 
	MOV R2, R9			@ move value of R9 to register R2 
	BL _printf_1			@ print the first part with two numbers
	VCVT.F32.S32 S0, S0		@ covert the S0 to float
	VCVT.F32.S32 S1, S1		@ covert the S1 to float
	VDIV.F32 S2, S0, S1		@ computes S2= S0 / S1
	VCVT.F64.F32 D4, S2		@ covert the result to double precision in 64bit
	VMOV R1, R2, D4			@ split the double VFP register into two ARM registers
	BL _printf_2			@ print the float result
	B main				@ branch to main

_scanf:
	MOV R4, LR			@ move LR to R4 
	SUB SP, SP, #4			@ make room on stack
	LDR R0, =format_str		@ R0 contains address of format string
	MOV R1, SP			@ move SP to R1 to store entry on stack
	BL scanf			@ call scanf
	LDR R0, [SP]			@ load value at SP into R0
	ADD SP, SP, #4			@ restore the stack pointer
	MOV PC, R4			@ move R4 to PC


_printf_1:
	PUSH {LR}			@ push LR to stack
	LDR R0, =str_print		@ R0 contains formatted string address
	BL printf			@ call printf
	POP {PC}			@ pop LR from stack and return

_printf_2:
	PUSH {LR}			@ push LR to stack
	LDR R0, =float_print		@ R0 contains formatted string address
	BL printf			@ call printf
	POP {PC}			@ pop LR from stack and return

.data
str_print:	.asciz	"%d / %d = "
float_print:	.asciz	"%f\n"
format_str:	.asciz	"%d"
