.data #contains all the prints I will need
	numOfInts: .asciiz "Enter number of ints: "
	numActual: .asciiz "Enter a number: "
	sumP1: .asciiz "The sum of the "
	sumP2: .asciiz " integers is "
	max: .asciiz "The maximum value is: "
	min: .asciiz "The minimum value is: "
	empty: .asciiz "\n"

.text
#t0 - Number of ints that the user will enter
#t1 - Base address of the int array
#t2 - Variable to be used for loops
#t3 - Array that will be traversed in loops
#t4 - Sum of the int array
#t5 - Max int of the array
#t6 - Min int of the array
#t7 - Loaded word from the array
#t8 - Holds the less than/greater than value from slt
#t9 - Holds the value of 0 used for calls that cannot be used with immediate values
main:
	#Prompting user for number of ints
	li $v0, 4 
	la $a0, numOfInts
	syscall
	
	#getting the number of ints
	li $v0, 5 #storing the int into v0
	syscall
	
	#moving the int to a temp register
	move $t0, $v0 #t0 now holds the number of ints that will be entered
	
	#creating variables that will be needed; setting them all to 0
	move $t4, $zero
	move $t5, $zero
	move $t6, $zero
	addi $t9, $zero, 1 #setting this to 1 to use for compare beq calls
	
	#creating array
	sll $a0, $v0, 2
	li $v0, 9 #allocating heap memory
	syscall
	
	move $t1, $v0 #moving the address of the allocated memory into $t1
	move $t3, $t1 #copying into t3 to preserve base location
	
	#clearing the register that will be used for "i"
	move $t2, $zero
	
#Prompting user for numbers and storing them
loopGetInts:
	beq $t0, $t2, exit1 #checking to see if t2 ("i") and t0 are equal. If so, exit the loop
	
	li $v0, 4 #printing the prompt
	la $a0, numActual
	syscall
	
	li $v0, 5 #getting the number
	syscall
	sw $v0, 0($t3)
	
	addi $t2, $t2, 1 #incrementing counter by 1
	addi $t3, $t3, 4 #moving to the next position in the array
	j loopGetInts
	
#Calculating the sum
exit1:
	move $t2, $zero #clearing t2 for loop again
	move $t3, $t1 #restoring base locaton
	
loopFindSum:
	beq $t0, $t2, exit2 #checking to make sure we go through the entire array
	
	lw $t7, 0($t3) #loading the current index into t7
	add $t4, $t4, $t7 #adding to the sum
	addi $t2, $t2, 1 #incrementing the i by 1
	addi $t3, $t3, 4 #going to the next index
	j loopFindSum
	
exit2:
	li $v0, 4 #printing the prompt
	la $a0, sumP1
	syscall
	
	li $v0, 1 #printing the number of ints entered at the beginning
	la $a0, ($t0)
	syscall
	
	li $v0, 4 #printing the prompt
	la $a0, sumP2
	syscall
	
	li $v0, 1 #printing the sum
	la $a0, ($t4)
	syscall
	
	li $v0, 4 #printing the prompt
	la $a0, empty
	syscall
	
	move $t2, $zero #clearing t2 for loop again
	move $t3, $t1 #restoring base locaton
	lw $t5, 0($t3) #setting a starting value of the first element in the array

loopGetMax:
	beq $t0, $t2, exit3
	
	lw $t7, 0($t3) #loading the current index into t7
	slt $t8, $t5, $t7 #if the max is smaller than the index value, then t8 = 1
	beq $t8, $t9, maxIsLess #if max is smaller, then branch
	
	addi $t2, $t2, 1 #incrementing the i by 1
	addi $t3, $t3, 4 #going to the next index
	j loopGetMax
	
maxIsLess:
	lw $t5, 0($t3) #replaces the max with the current index 
	
	addi $t2, $t2, 1 #incrementing the i by 1
	addi $t3, $t3, 4 #going to the next index
	j loopGetMax #return to the loop
	
exit3:
	li $v0, 4 #printing the prompt
	la $a0, max
	syscall
	
	li $v0, 1 #printing the number of ints entered at the beginning
	la $a0, ($t5)
	syscall
	
	li $v0, 4 #printing the prompt
	la $a0, empty
	syscall

	move $t2, $zero #clearing t2 for loop again
	move $t3, $t1 #restoring base locaton
	lw $t6, 0($t3) #setting a starting value of the first element in the array
	move $t9, $zero #resetting t9 to 0 for next loop
	
loopGetMin:
	beq $t0, $t2, exitTrue
	
	lw $t7, 0($t3) #loading the current index into t7
	slt $t8, $t6, $t7 #if the min is smaller than the index value, then t8 = 1
	beq $t8, $t9, minIsGreater #if min is bigger, then branch
	
	addi $t2, $t2, 1 #incrementing the i by 1
	addi $t3, $t3, 4 #going to the next index
	j loopGetMin
	
minIsGreater:
	lw $t6, 0($t3) #replaces the max with the current index 
	
	addi $t2, $t2, 1 #incrementing the i by 1
	addi $t3, $t3, 4 #going to the next index
	j loopGetMin #return to the loop
	
	
exitTrue:	
	li $v0, 4 #printing the prompt
	la $a0, min
	syscall
	
	li $v0, 1 #printing the number of ints entered at the beginning
	la $a0, ($t6)
	syscall
	
	li $v0, 4 #printing the prompt
	la $a0, empty
	syscall
	
	#end program
	li $v0, 10
	syscall