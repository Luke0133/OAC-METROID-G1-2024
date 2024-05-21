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
	        addi t1, t1, -4 
	        sh t1, 0(t0)
	        j END_INPUT_CHECK
	
	INPUT.S:
	        j END_INPUT_CHECK

	INPUT.D: # Moves player right
		la t0, PLYR_POS 
	        lh t1, 0(t0)

                la a0, Map2 		# Map Address
                li a1, 0		# starting X on Matrix (top left)
                li a2, 29		# starting Y on Matrix (top left)		
                li a3, 0		# X offset (0, 4, 8, 12)
                li a4, 8		# Y offset (0, 4, 8, 12)	
                li a5, 0		# Frame = 0
                li a6, m_screen_width	# Screen Width = 20
                li a7, m_screen_height	# Screen Height = 15
                mv t3, t1		# Starting X for rendering (top left, related to Matrix)
                lb t2, 4(t0)
                call RENDER_MAP

                la a0, Map2 		# Map Address
                li a1, 0		# starting X on Matrix (top left)
                li a2, 29		# starting Y on Matrix (top left)		
                li a3, 0		# X offset (0, 4, 8, 12)
                li a4, 8		# Y offset (0, 4, 8, 12)	
                li a5, 1		# Frame = 1
                li a6, m_screen_width	# Screen Width = 20
                li a7, m_screen_height	# Screen Height = 15
                mv t3, t1		# Starting X for rendering (top left, related to Matrix)
                lb t2,4(t0)
                call RENDER_MAP

                addi t1, t1, 4
	        sh t1,0(t0)

                la t0, PLYR_STATUS
                lb t1, 0(t0)
                addi t1,zero,1
                sb t1, 0(t0)

                								
                la a0, sam_walk_vertical 		# Gets sprite address# Endereco do mapa
                la t0,PLYR_POS
                lh a1, 0(t0)		# Topo esquerdo X
                lb a2, 4(t0)		# Topo esquerdo Y		
                li a3, 20		# Largura da imagem
                li a4, 32		# Altura da imagem	
                mv a5, s0		# Frame
                la t0, PLYR_STATUS
                lb a6, 0(t0) 
                li a7, 0
                
                call RENDER					
                                                                                
                li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
                sw s0,0(t0)
                
                ##### LIMPEZA DE RASTRO
                
                mv a5, s0		# Frame
                mv a5,s0		# carrega o frame atual (que esta na tela em a3)
                xori a5,a5,1		# inverte a3 (0 vira 1, 1 vira 0)
                
                la a0, sam_walk_vertical 	# Gets sprite address
                la t0,PLYR_POS
                lh a1, 0(t0)		# Topo esquerdo X
                lb a2, 4(t0)		# Topo esquerdo Y		
                li a3, 20		# Largura da imagem
                li a4, 32		# Altura da imagem	
                mv a5, s0		# Frame
                la t0, PLYR_STATUS
                lb a6, 0(t0) 
                li a7, 0
                
                call RENDER
                
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
                sh zero, 0(t0) # zera moveX, moveY
                sb zero, 4(t0) # zera jump
                j END_INPUT_CHECK

	END_INPUT_CHECK:
		ret		