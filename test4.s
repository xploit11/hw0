	.global main
	.func main

main:
	BL _scanf
	MOV R8, R0
	BL _scanf
	MOV R9, R0
	VMOV S0, R8
	VMOV S1, R9
	MOV R1, R8
	MOV R2, R9
	BL _printf_1
	VCVT.F32.S32 S0, S0
	VCVT.F32.S32 S1, S1
	VDIV.F32 S2, S0, S1
	VCVT.F64.F32 D4, S2
	VMOV R1, R2, D4
	BL _printf_2
	B main	

_scanf:
	MOV R4, LR
	SUB SP, SP, #4
	LDR R0, =format_str
	MOV R1, SP
	BL scanf
	LDR R0, [SP]
	ADD SP, SP, #4
	MOV PC, R4


_printf_1:
	PUSH {LR}
	LDR R0, =str_print
	MOV R1, R1
	BL printf
	POP {PC}

_printf_2:
	PUSH {LR}
	LDR R0, =float_print
	BL printf
	POP {PC}

.data
str_print:	.asciz	"%d / %d = "
float_print:	.asciz	"%f\n"
format_str:	.asciz	"%d"
