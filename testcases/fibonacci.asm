addi x2 x0 0		#fib(n-2)
addi x3 x0 1 		#fib(n-1)
addi x4 x0 2		# i
addi x7 x0 0x00000000	# temp variable
addi x5 x0 9		# value of n
addi x6 x5 1		# value of n+1

jal x0 LOOP

LOOP: 
    beq x4 x6 EXIT
    add x7 x2 x3 # n
    addi x2 x3 0
    addi x3 x7 0
    addi x4 x4 1
    jal x0 LOOP
    	
EXIT:	


