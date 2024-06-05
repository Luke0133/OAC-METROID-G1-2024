######## INPUT ###########################
# Uso de Registradores temporarios
INPUT_CHECK:
        li t1,0xFF200000  	# KDMMIO Address
        lw t0, 0(t1)	  	# Reads the Keyboard Control bit
        andi t0, t0, 0x0001	  	# Masks the least significant bit
        bnez t0, CONTINUE_CHECK # if an input is detected, continue checking
        j NO_INPUT 		# otherwise no input was detected 
        
	CONTINUE_CHECK:
	lw t0, 4(t1) 	# Reads key value
        li t1, 'w'	# Loads ascii value of 'w' key
        bne t0, t1, CHECK_INPUT.A
        j INPUT.W	# If 'w' key was pressed
        
        CHECK_INPUT.A:
        li t1, 'a'	# Loads ascii value of 'a' key
        bne t0,t1, CHECK_INPUT.S
        j INPUT.A	# If 'a' key was pressed

        CHECK_INPUT.S:
        li t1, 's'	# Loads ascii value of 's' key
        bne t0, t1, CHECK_INPUT.D
        j INPUT.S	# If 's' key was pressed

        CHECK_INPUT.D:
        li t1, 'd'	# Loads ascii value of 'd' key
        bne t0,t1, CHECK_INPUT.SPACE
        
        j INPUT.D	# If 'd' key was pressed
        
        CHECK_INPUT.SPACE:
        li t1, 32	# Loads ascii value of space key
        bne t0,t1, CHECK_INPUT.K
        j INPUT.SPACE 	# If space key was pressed
        
        CHECK_INPUT.K:
        li t1, 'k'	# Loads ascii value of 'k' key
        bne t0,t1, CHECK_INPUT.T
        j INPUT.K 	# If 'k' key was pressed
        
        CHECK_INPUT.T:
        li t1, 't'	# Loads ascii value of 'k' key
        bne t0,t1, CHECK_INPUT.P
        j INPUT.T 	# If 'k' key was pressed

        CHECK_INPUT.P:
        li t1, 'p'	# Loads ascii value of 'k' key
        bne t0,t1, NO_INPUT
        j INPUT.P 	# If 'k' key was pressed


	NO_INPUT:
       		#j END_INPUT_CHECK
                j INPUT.ZERO

	INPUT.W:
	        j END_INPUT_CHECK
	
	INPUT.A: # Moves player left
	        la t0, PLYR_POS 
	        lh t1, 0(t0)
	        sh t1, 2(t0)
	        addi t1, t1, -4 
	        sh t1, 0(t0)

                
                la t0, PLYR_STATUS #pega o numero da sprite
                li t1,1
                sb t1, 2(t0) #olha pra esquerda
                lb t1, 0(t0) # carrega o numero da sprite
                li t2, 3 #aux pra sprite final

                beqz t1, asc_esq #se t1 = 0, vai ser asc
                beq t1,t2,desc_esq #t1 = 3 => desc

                la t2, desc 
                li t1,1
                sb t1,0(t2) #desc => 1


                #la t2, desc 
                #lb t1, 0(t2)
                #li t2, 1
                #bge t2,t1,desc # se desc=1, vai pra desc

                asc_esq: 
                la t2, desc 
                sb zero,0(t2) #desc => 0
                lb t1, 0(t0)
                addi t1,t1,1
                sb t1, 0(t0)

                j last_esq

                desc_esq: lb t1, 0(t0)
                addi t1,t1,-1
                sb t1, 0(t0)

                last_esq: la t0,last_key
                li t1,4
                sb t1,0(t0)

	        j END_INPUT_CHECK
	
	INPUT.S:
	        j END_INPUT_CHECK

	INPUT.D: # Moves player right
		la t0, PLYR_POS 
	        lh t1, 0(t0)
	        sh t1, 2(t0)
                addi t1, t1, 4
	        sh t1,0(t0)
		
		
                la t0, PLYR_STATUS #pega o numero da sprite
                sb zero, 2(t0) #olha pra direita
                lb t1, 0(t0) # carrega o numero da sprite
                li t2, 3 #aux pra sprite final

                beqz t1, asc_dir #se t1 = 0, vai ser asc
                beq t1,t2,desc_dir #t1 = 3 => desc

                la t2, desc 
                li t1,1
                sb t1,0(t2) #desc => 1


                #la t2, desc 
                #lb t1, 0(t2)
                #li t2, 1
                #bge t2,t1,desc # se desc=1, vai pra desc

                asc_dir: 
                la t2, desc 
                sb zero,0(t2) #desc => 0
                lb t1, 0(t0)
                addi t1,t1,1
                sb t1, 0(t0)

                j last_dir

                desc_dir: lb t1, 0(t0)
                addi t1,t1,-1
                sb t1, 0(t0)

                last_dir: la t0,last_key
                li t1,4
                sb t1,0(t0)

                j END_INPUT_CHECK
	
	INPUT.SPACE:
	        j END_INPUT_CHECK
	
	INPUT.K: # Shoots
	        j END_INPUT_CHECK
        
        INPUT.T: #for testing
                #call KILL_PLYR
                j END_INPUT_CHECK

        INPUT.P: #for testing
                la t0, PLYR_STATUS
                lb t1, 0(t0)
                addi t1,zero,1
                sb t1, 0(t0)
                j END_INPUT_CHECK
        
        INPUT.ZERO:
                #la t0, MOVEX 
          #      sh zero, 0(t0) # zera moveX, moveY
           #     sb zero, 4(t0) # zera jump
                j END_INPUT_CHECK

	END_INPUT_CHECK:
		ret		