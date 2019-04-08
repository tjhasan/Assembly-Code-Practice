.data
	#Output messages I will be using
	stringInput: .asciiz "Input string to change: \n"
	charInput: .asciiz "Input char to replace: \n"
	replaceInput: .asciiz "Input char to replace with: \n"
	
	stringOutput: .asciiz "Original string: "
	sub1: .asciiz "Substitution: "
	sub2: .asciiz " --> "
	stringResult: .asciiz "Result string: "
	
	#the amount of space alloted for characters and strings.
	buffer: .space 100
	charBuff: .space 4
	charBuff2: .space 4
	
.text

main:
	#Ask user for string
	li $v0, 4 
	la $a0, stringInput
	syscall
	
	#Get the string
	li $v0, 8
	li $a1, 100 #v0 8 requires 2 arguments, the a1 is the buffer which we have set to 100
	la $a0, buffer
	syscall

	#copy string for future use
	move $s0, $a0

	#Ask user for char to replace
	li $v0, 4
	la $a0, charInput
	syscall

	#Get the char
	li $v0, 8
	li $a1, 4 #setting buffer to 4 i.e one character
	la $a0, charBuff
	syscall

	#copy char for future use
	move $s1, $a0

	#Ask user for char to insert
	li $v0, 4
	la $a0, replaceInput
	syscall

	#Get the char
	li $v0, 8
	li $a1, 4 #setting buffer to 4 i.e one character
	la $a0, charBuff2
	syscall

	#copy string for future use
	move $s2, $a0

	#iterator which will start at 0
	li $t0, 0

	#Printing the original string (initial prompt)
	li $v0, 4
	la $a0, stringOutput
	syscall

	#Printing the original string
	li $v0, 4
	la $a0, ($s0)
	syscall

	#Printing the Substitution (part 1)
	li $v0, 4
	la $a0, sub1
	syscall

	#Printing the character instructed to replace
	la $a1, charBuff
	addiu $a1, $a1, 0
	lbu $a0, ($a1)
	li $v0, 11
	syscall

	#Printing the arrow
	li $v0, 4
	la $a0, sub2
	syscall

	#Printing the character to insert
	li $v0, 4
	la $a0, ($s2)
	syscall

	#Printing the final Result
	li $v0, 4
	la $a0, stringResult
	syscall

loop:
	#gets the current character at the appropriate iteration
    add $s3, $s0, $t0 #s0 holds our entire string, t0 holds the current "i" value, and s3 holds the character at "i"
    lb $t1, 0($s3) #loads the first character in the passed character (need to do this because it was taken as a string and not a char)
	lb $t2, 0($s1)

    beq $t1, $zero, exit #if we've reached the end of the string, then we exit

    beq $t2, $t1, matchFound #if we found a character we need to replace, we branch

    li $v0, 11 #if we don't branch we print out the current character
    la $a0, ($t1)
    syscall

	addi $t0, $t0, 1 #increase the current i value
	j loop #loop again
	
matchFound:
	#Prints the first character without the newline
	la $a1, charBuff2 #loads the word into a1
	addiu $a1, $a1, 0 #checks to make sure we are only storing the first character (not the newline)
	lbu $a0, ($a1) #sets the current address of the character as the argument for the print call
	li $v0, 11 #actually prints it
	syscall

	addi $t0, $t0, 1 #increases the current i value

	j loop #return to loop
	
exit:
	#end program
	li $v0, 10
	syscall