.data

prompt: .asciiz "Unrecognized input"
input: .space 1001
string: .space 5

.text

main:
li $v0, 8						
la $a0, input						
li $a1, 1001					
syscall
