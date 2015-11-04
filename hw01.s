
/******************************************************************************
* @FILE hw1
* @BRIEF simple calculator for the Raspbian OS using ARM assembly
*
* Simple program to find sum, difference, product and maximum out of 2 numbers
*
* @AUTHOR Anish Timila
******************************************************************************/    
    
    
    
    .global main
    .func main

main:
    BL _Operand                         @ Branch _Operand procedure with return
    MOV R5, R0                          @ moves return value from R0 to R5
    BL _Operation_Code                  @ branch to _Operation_Code procedure with return
    MOV R6, R0                          @ move return value from R0 to R6
    BL _Operand                         @ branch to _Operand procedure with return
    MOV R7, R0                          @ move return value from R0 to R7
    MOV R1, R5                          @ move R5 to R1
    MOV R3, R6                          @ move R6 to R3
    MOV R2, R7                          @ move R7 to R2
    BL _Compare                         @ branch to _Compare procedure with return
    MOV R1, R0                          @ move R0 to R1
    LDR R0, =Printf_Output              @ R0 contains formatted string address
    BL printf                           @ call printf
    B main                              @ call main (to form a loop)
    
_Operand:
    MOV R4, LR                          @ store LR since printf call overwrites
    SUB SP, SP, #4                       @ make room for stack
    LDR R0, =Operand_Prompt             @ RO contains formatted string address
    BL printf                           @ call printf
    LDR R0, =Input_Value                @ R0 contains formatted string address
    MOV R1, SP                          @ move SP to R1 to store entry of stack
    BL scanf                            @ call scanf
    LDR R0, [SP]                        @ load value at SP into R0
    ADD SP, SP, #4                      @ remove value from stack
    MOV PC, R4                          @ return
    
_Operation_Code:
    MOV R4, LR                          @ store LR since printf call overwrites
    SUB SP, SP, #4                       @ make room for stack
    LDR R0, =Operation_Code_Prompt      @ R0 contains formatted string address
    BL printf                           @ call printf
    LDR R0, =Input_Operator             @ R0 contains formatted string address
    MOV R1, SP                          @ move SP to R1 to store entry of stack
    BL scanf                            @ call scanf
    LDR R0, [SP]                        @ load value at SP into R0
    ADD SP, SP, #4                      @ remove value from stack
    MOV PC, R4                          @ return
    
_Compare:
    CMP R3, # '-'                       @ compare with the constant character '-'
    BEQ _Difference                     @ branch to equal handler
    CMP R3, # '+'                       @ compare with the constant character '+'
    BEQ _Sum                            @ branch to equal handler
    CMP R3, # '*'                       @ compare with the constant character '*'
    BEQ _Product                        @ branch to equal handler
    CMP R3, # 'M'                       @ compare with the constant character 'M'
    BEQ _Max                            @ branch to equal handler
   
_Difference:
    SUB R0, R1, R2                      @ subtract R2 from R1 and store the value in R0
    MOV PC, LR                          @ return

_Sum:
    ADD R0, R1, R2                      @ add R1 and R2 and store the value in R0
    MOV PC, LR                          @ return
    
_Product:                           
    MUL R0, R1, R2                      @ multiply R1 and R2 and store the value in R0
    MOV PC, LR                          @ return

_Max:
    CMP R1, R2                          @ compare R1 and R2 
    MOVGT R0, R1                        @ Move Greater Than
    MOVLT R0, R2                        @ Move Less Than
    MOV PC, LR                          @ return
    
.data
Operand_Prompt: .asciz "Please enter a number: "
Input_Value: .asciz "%d"
Operation_Code_Prompt: .asciz "Please enter one of the operation code from (+,-,*): "
Input_Operator: .asciz "%s"
Printf_Output: .asciz "The output based on the entered operation code is : %d\n"
    
    
    
