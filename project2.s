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

la $s1, string	

lb $t0, -1($t1)
sb $t0, 0($s1)						

lb $t0, 0($t1)
sb $t0, 1($s1)						

lb $t0, 1($t1)
sb $t0, 2($s1)

lb $t0, 2($t1)
sb $t0, 3($s1)						

addi $t1, $t1, 3					#  three characters stored so incremented by 3
j storing

ender:	
beq $t8, 0, error
la $s1, string+4		

handling:			
beq $t4, 4, ending
addi $t4, $t4, 1
addi $s1, $s1, -1
lb $t0, ($s1)

beq $t0, 10, handling 					
beq $t0, 32, tabandspace
beq $t0, 9, tabandspace			
beq $t0, 0, handling

li $t6, 1		

checker:					#to check if the character is valid or not	
addi $t5,$t5,1
bge $t0, 97, lowercase
bge $t0, 65, uppercase
bge $t0, 48, number

number:
bgt $t0, 57, error
ble $t0, 57, num

lowercase:
bgt $t0, 114, error
ble $t0, 114, lcase

uppercase:
bgt $t0, 82, error
ble $t0, 82, ucase

num:
addi $a0, $t0, -48
move $a2, $t3
j conversion

ucase:
addi $a0, $t0, -55
move $a2, $t3
j conversion

lcase:
addi $a0, $t0, -87
move $a2, $t3
j conversion
	
conversion:
jal subprogram
add $s6, $s6, $v0
mul $t3, $t3, 28
j handling

subprogram:
mul $v0, $a0, $a2
jr $ra

ending:
li $v0, 1				
add $a0,$zero,$t5
syscall

