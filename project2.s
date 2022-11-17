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


