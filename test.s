.data
	prompt: .asciiz "hello"
	message: .asciiz "your number is: "
	
.text
main:
	# Prompt user
	li $v0, 4
	la $a0, prompt
	syscall
	
	#get data
	li $v0, 5
	syscall
	
	#store data
	move $t0, $v0
	
	#display data
	li $v0, 4
	la $a0, message
	syscall
	
	#print data
	li $v0, 1
	move $a0, $t0
	syscall
	
	#end program
	li $v0, 10
	syscall