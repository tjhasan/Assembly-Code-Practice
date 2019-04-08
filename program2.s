.data
	ogString: .asciiz "Enter a String: "
	charSearch: .asciiz "Enter a char to search: "
	out1: .asciiz "Character "
	out2: .asciiz "occurs in the string "
	out3: .asciiz " times \n"
	
	buffer: .space 100
	charBuff: .space 4

.text

main:
	li $t0, 0 #number of occurences
	
	#Ask user for string
	li $v0, 4 
	la $a0, ogString
	syscall
	
	#Get the string
	li $v0, 8
	li $a1, 100 #v0 8 requires 2 arguments, the a1 is the buffer which we have set to 100
	la $a0, buffer
	syscall
	
	#copy string for future use
	move $t9, $a0
	
	#Ask user for char
	li $v0, 4
	la $a0, charSearch
	syscall

	#Get the char
	li $v0, 8
	li $a1, 4 #setting buffer to 4 i.e one character
	la $a0, charBuff
	syscall
	
	#stores the first character of the string into t3..
	la $t3, buffer
	lb $a2, ($t3) #... and settng the a2 to the address of that character
	
	#Stores the character location into t8
	la $t8, charBuff
	lb $t7, ($t8) #sets the base address to location to t7 (easier to manipulate)

loop:
	beq $a2, $zero, exit #checks to see if there are no more characters to check i.e reached end of the string
	beq $a2, $t7, matchFound #if there is a match, then it branches
	addi $t3, $t3, 1 #increments to the next character
	lb $a2, ($t3) #resetting the base address to a2 incremented to the next character
	j loop

matchFound:
	addi $t2, $t2, 1 #increments the counter by 1 
	addi $a2, $a2, 1 #increments to the next character
	j loop

exit:
	li $v0, 4 #printing the prompt
	la $a0, out1
	syscall
	
	li $v0, 4 #Printing the character
	la $a0, ($t8)
	syscall
	
	li $v0, 4 #printing the prompt2
	la $a0, out2
	syscall
	
	li $v0, 4 #Printing the original string
	la $a0, ($t9)
	syscall
	
	li $v0, 1 #Printing the number of occurences
	la $a0, ($t2)
	syscall
	
	li $v0, 4 
	la $a0, out3
	syscall
	
	#resetting t2 for the next execution of the program
	move $t2, $zero
	
	#end program
	li $v0, 10
	syscall