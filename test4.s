	.global main
	.func main

main:
	BL _scanf
	MOV R6, R0
	BL _scanf
	MOV R7, R0

	#MOV R6, #2
	#MOV R7, #2

	VMOV S0, R6
	VMOV S1, R7

	MOV R1, R6
	MOV R2, R7
	BL _printf
	
	VCVT.F32.S32 S0, S0
	VCVT.F32.S32 S1, S1

	VDIV.F32 S2, S0, S1
	VCVT.F64.F32 D4, S2

	VMOV R1, R2, D4
	BL _printf_result

	B main	

_printf:
	PUSH {LR}
	LDR R0, =printf_str
	MOV R1, R1
	BL printf
	POP {PC}

_printf_result:
	PUSH {LR}
	LDR R0, =float_str
	BL printf
	POP {PC}

_scanf:
	MOV R4, LR
	SUB SP, SP, #4
	LDR R0, =format_str
	MOV R1, SP
	BL scanf
	LDR R0, [SP]
	ADD SP, SP, #4
	MOV PC, R4

.data
printf_str:	.asciz	"%d / %d = "
float_str:	.asciz	"%f\n"
format_str:	.asciz	"%d"
