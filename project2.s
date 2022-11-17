.data

prompt: .asciiz "Unrecognized input"
input: .space 1001
string: .space 5

.text

main:
li $v0, 8						# loading call code to read the string
la $a0, input						# loading the address					
li $a1, 1001						
syscall

la $t1, input						

li $s6, 0						
li $t4, 0						# storing loop counter for four charcters in $s1 register
li $t8, 0
li $t3, 1

storing:
lb $t0, ($t1)
addi $t1, $t1, 1
beq $t0, 10, ender					
beq $t0, 0, ender					
beq $t0, 32, storing					
beq $t0, 9, storing

beq $t8, 1, error					# checking valid character
li $t8, 1
