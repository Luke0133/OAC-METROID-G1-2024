##########################     RENDER IMAGE    ##########################
#     -----------           instruction count            -----------    #
#	RENDER uses 22 instructions					#
#     -----------           argument registers           -----------    #
#	a0 = Image Address						#
#	a1 = X coordinate where rendering will start (top left)		#
#	a2 = Y coordinate where rendering will start (top left)		#
#	a3 = width of printing area (usually the size of the sprite)	#
# 	a4 = height of printing area (usually the size of the sprite)	#
#	a5 = frame (0 or 1)						#
# --->	a6 = status of sprite (usually 0 for sprites that are alone)	#
# --->	a7 = operation (0 if normal printing, 1 if replacing trail)	#
#     -----------          temporary registers           -----------    #
# --->	t0 = bitmap display printing address				#
# --->	t1 = image address						#
# --->	t2 = line counter						#
# --->	t3 = column counter						#
# --->	t4 = temporary operations					#
#########################################################################
RENDER:
	li t0,0xFF0	# t0 = 0xFF0
	add t0,t0,a5	# Rendering Address corresponds to 0x0FF0 + frame
	slli t0,t0,20	# Shifts 20 bits, making printing adress correct (0xFF00 0000 or 0xFF10 0000)
	
	add t0,t0,a1	# t0 = 0xFF00 0000 + X or 0xFF10 0000 + X
	
	li t1,320	# t1 = 320
	mul t1,t1,a2	# t1 = 320 * Y 
	add t0,t0,t1	# t0 = 0xFF00 0000 + X + (Y * 320) or 0xFF10 0000 + X + (Y * 320)
	
	addi a0,a0,8			# t1 = a0 + 8
	
	mv t2,zero	# t2 = 0 (Resets line counter)
	mv t3,zero	# t3 = 0 (Resets column counter)
	
	PRINT_LINE:
		lw t4,0(a0)	# loads word(4 pixels) on t4
		sw t4,0(t0)	# prints 4 pixels from t4
		
		addi t0,t0,4	# increments bitmap address
		addi a0,a0,4	# increments image address
		
		addi t3,t3,4		# increments column counter
		blt t3,a3,PRINT_LINE	# if column counter < width, repeat
		
		addi t0,t0,320	# goes to next line on bitmap display
		sub t0,t0,a3	# goes to right X on bitmap display (current address - width)
		
		mv t3,zero		# t3 = 0
		addi t2,t2,1		# increments line counter
		bgt a4,t2,PRINT_LINE	# if height > line counter, repeat
		ret	

############################## RENDER COLOR #############################
#		 Renders a given color on a given space			#
#     -----------           instruction count            -----------    #
#	RENDER_COLOR uses 23 instructions				#
#     -----------           argument registers           -----------    #
#	a0 = color		    					#
#	a1 = X coordinate where rendering will start (top left)	   	#	
#	a2 = Y coordinate where rendering will start (top left)	   	#
#	a3 = width of printing area (usually the size of the sprite)	#
# 	a4 = height of printing area (usually the size of the sprite)	#
#	a5 = frame (0 or 1)						#
#     -----------          temporary registers           -----------    #
# 	t0 = bitmap display printing address				#
#	t1 = temporary operations					#
#	t2 = line counter						#
#	t3 = column counter						#
#########################################################################
RENDER_COLOR:
	li t0,0xFF0	# t0 = 0xFF0
	add t0,t0,a5	# Rendering Address corresponds to 0x0FF0 + frame
	slli t0,t0,20	# Shifts 20 bits, making printing adress correct (0xFF00 0000 or 0xFF10 0000)
	
	add t0,t0,a1	# t0 = 0xFF00 0000 + X or 0xFF10 0000 + X
	
	li t1,320	# t1 = 320
	mul t1,t1,a2	# t1 = 320 * Y 
	add t0,t0,t1	# t0 = 0xFF00 0000 + X + (Y * 320) or 0xFF10 0000 + X + (Y * 320)
	
	mv t2,zero	# t2 = 0 (Resets line counter)
	mv t3,zero	# t3 = 0 (Resets column counter)
	
	slli t1,a0,8	# Shifts 8 bits on a0
	add a0,a0,t1	# a0 now stores two bytes of the same color (e.g.: 0x000000FF -> 0x0000FFFF)
	slli t1,a0,16	# Shifts 16 bits on a0
	add a0,a0,t1	# a0 now stores four bytes of the same color (e.g.: 0x0000FFFF -> 0xFFFFFFFF)
	
	PRINT_LINE_COLOR:
		sw a0,0(t0)	# Renders four color pixels at once
		addi t0,t0,4	# increments bitmap address
		
		addi t3,t3,4		# increments column counter
		blt t3,a3,PRINT_LINE_COLOR	# if column counter < width, repeat
		
		addi t0,t0,320	# goes to next line on bitmap display
		sub t0,t0,a3	# goes to right X on bitmap display (current address - width)
		
		mv t3,zero			# t3 = 0 (resets column counter)
		addi t2,t2,1			# increments line counter
		bgt a4,t2,PRINT_LINE_COLOR	# if height > line counter, repeat
		ret	
		
###########################        RENDER MAP	    ################################
# Takes a given map matrix and renders tiles acoording to the value stored on it   #
#     -----------           argument registers           -----------       	   #
#	a0 = map address						  	   #
#	a1 = X matriz								   #
#	a2 = Y matriz	    	   						   #	
#	a3 = X offset (0, 4, 8, 12)	  	   				   #
#	a4 = Y offset (0, 4, 8, 12)	  	   				   #	 		  
#	a5 = frame (0 ou 1)						  	   #
#     -----------          temporary registers           -----------       	   #
#	t0 = operacoes temporarias			           	   #
#	t1 = tile a ser renderizado			   	   #				
#	t2 = contador de linhas	(relativo a matriz)					   	   #
#  	t3 = contador de colunas (relativo a matriz)					  	   #
				   	   #
####################################################################################
RENDER_MAP:


# 	renderizar tile
#	     - checar offset p/ determinar coordenadas e corte (apenas nas laterais/topo e chao)
# 	se acabou a coluna, voltaate acabar numero de colunas
# 	se acabou a linha, reseta coluna e volta ate acabar numero de linhas
	mv t2,zero	# t2 = 0 (Resets line counter)
	mv t3,zero	# t3 = 0 (Resets column counter)
RENDER_MAP_LOOP:
	lbu t1,0(a0)
	
	bnez t1,NotBackground
	j Background
	NotBackground:
	li t0,74
	bne t1,t0, NotBreakBlock
	j BreakBlock
	NotBreakBlock:
	li t0,126
	bne t1,t0, NotBush2A
	j Bush2A
	NotBush2A:
	li t0,127
	bne t1,t0, NotBush2B
	j Bush2B
	NotBush2B:
	li t0,14
	bne t1,t0, NotDoorLeftTop
	j DoorLeftTop
	NotDoorLeftTop:
	li t0,12
	bne t1,t0, NotDoorLeft
	j DoorLeft
	NotDoorLeft:
	li t0,6
	bne t1,t0, NotDoorRightTop
	j DoorRightTop
	NotDoorRightTop:
	li t0, 4 
	bne t1,t0, NotDoorRight
	j DoorRight
	NotDoorRight:
	li t0, 198 
	bne t1,t0, NotDoorFrame
	j DoorFrame
	NotDoorFrame:
	li t0, 64 
	bne t1,t0, NotGround1A
	j Ground1A
	NotGround1A:
	li t0, 72 
	bne t1,t0, NotGround1B
	j Ground1B
	NotGround1B:
	li t0, 80 
	bne t1,t0, NotGround1C
	j Ground1C
	NotGround1C:
	li t0, 88 
	bne t1,t0, NotGround1D
	j Ground1D
	NotGround1D:
	li t0, 98 
	bne t1,t0, NotGround2A
	j Ground2A
	NotGround2A:
	li t0, 106 
	bne t1,t0, NotGround2B
	j Ground2B
	NotGround2B:
	li t0, 114 
	bne t1,t0, NotGround2C
	j Ground2C
	NotGround2C:
	li t0, 84 
	bne t1,t0, NotGround3A
	j Ground3A
	NotGround3A: 
	li t0, 92 
	bne t1,t0, NotGround3B
	j Ground3B
	NotGround3B:
	li t0, 100 
	bne t1,t0, NotGround3C
	j Ground3C
	NotGround3C:
	li t0, 128 
	bne t1,t0, NotItemHolderA
	j ItemHolderA
	NotItemHolderA:
	li t0, 136 
	bne t1,t0, NotItemHolderB
	j ItemHolderB
	NotItemHolderB:
	li t0, 144 
	bne t1,t0, NotItemHolderC
	j ItemHolderC
	NotItemHolderC:
	li t0, 152 
	bne t1,t0, NotItemHolderD
	j ItemHolderD
	NotItemHolderD:
	li t0, 160 
	bne t1,t0, NotItemHolderE
	j ItemHolderE
	NotItemHolderE:
	li t0, 168 
	bne t1,t0, NotItemHolderF
	j ItemHolderF
	NotItemHolderF:
	li t0, 176
	bne t1,t0, NotItemHolderG
	j ItemHolderG
	NotItemHolderG:
	li t0, 94
	bne t1,t0, NotLavaB
	j LavaB
	NotLavaB:
	li t0, 102
	bne t1,t0, NotLavaT
	j LavaT
	NotLavaT:
	li t0, 90
	bne t1,t0, NotPipe1H
	j Pipe1V
	NotPipe1H:
	li t0, 82
	bne t1,t0, NotPipe1V
	j Pipe1V
	NotPipe1V:
	li t0, 68
	bne t1,t0, NotPipe2H
	j Pipe2H
	NotPipe2H:
	li t0, 122
	bne t1,t0, NotPipe2V
	j Pipe2V
	NotPipe2V:
	li t0, 118
	bne t1,t0, NotPipe3V2
	j Pipe3V2
	NotPipe3V2:
	li t0, 110
	bne t1,t0, NotPipe3V
	j Pipe3V
	NotPipe3V:
	li t0, 96
	bne t1,t0, NotSlide1L
	j Slide1L
	NotSlide1L:
	li t0, 104
	bne t1,t0, NotSlide1R
	j Slide1R
	NotSlide1R:
	li t0, 78
	bne t1,t0, NotSpikeL
	j SpikeL
	NotSpikeL:
	li t0, 86
	bne t1,t0, NotSpikeR
	j SpikeR
	NotSpikeR:
	li t0, 120
	bne t1,t0, NotTile1A
	j Tile1A
	NotTile1A:
	li t0, 66
	bne t1,t0, NotTile1B
	j Tile1B
	NotTile1B:
	li t0, 76
	bne t1,t0, NotTile2A
	j Tile2A
	NotTile2A:
	li t0, 116
	bne t1,t0, NotTile3A
	j Tile3A
	NotTile3A:
	li t0, 124
	bne t1,t0, NotTile3B
	j Tile3B
	NotTile3B:
	li t0, 70 
	bne t1,t0, Background
	j Tile3C
	
	Background:
	
	BreakBlock:
	Bush2A:
	Bush2B:
	DoorLeftTop:
	DoorLeft:
	DoorRightTop:
	DoorRight:
	DoorFrame:
	Ground1A:
	Ground1B:
	Ground1C:
	Ground1D:
	Ground2A:
	Ground2B:
	Ground2C:
	Ground3A:
	Ground3B:
	Ground3C:
	ItemHolderA:
	ItemHolderB:
	ItemHolderC:
	ItemHolderD:
	ItemHolderE:
	ItemHolderF:
	ItemHolderG:
	LavaB:
	LavaT:
	Pipe1H:
	Pipe1V:
	Pipe2H:
	Pipe2V:
	Pipe3V2:
	Pipe3V:
	Slide1L:
	Slide1R:
	SpikeL:
	SpikeR:
	Tile1A:
	Tile1B:
	Tile2A:
	Tile3A:
	Tile3B:
	Tile3C:
		la a0,
	# Renderizar tile
	bnez t3  
	j Continua
	# 16 - offset
	Continua:
	
	# Guarda na pilha
	addi sp,sp,-32
	sw a4,28(sp)
	sw a3,24(sp)
	sw a2,20(sp)
	sw a1,16(sp)
	sw a0,12(sp)
	sw t2,8(sp)
	sw t3,4(sp)
	sw ra,0(sp)
	
	bnez t1,NormalRender
	li a0, 0x66 		# Endereco do mapa
	li a1, 0		# Topo esquerdo X
	li a2, 0		# Topo esquerdo Y		
	li a3, 320		# Largura da imagem
	li a4, 240		# Altura da imagem	
	# a5 permanece igual
	call RENDER_COLOR
	NormalRender:
	call RENDER
	
	lw a4,28(sp)
	lw a3,24(sp)
	lw a2,20(sp)
	lw a1,16(sp)
	lw a0,12(sp)
	lw t2,8(sp)
	lw t3,4(sp)
	lw ra,0(sp)
	addi sp,sp,32
	
	addi t3,t3,1		# increments column counter
	li t0, 20 		# Largura da matriz para o tamanho de uma tela (320 pixels de largura)
	blt t0,t3,CONTINUE_LINE	# if column counter < width, repeat
	j RENDER_MAP_LOOP	
	CONTINUE_LINE:
		mv t3,zero			# t3 = 0 (resets column counter)
		addi t2,t2,1			# increments line counter
		li t0, 15 			# Altura da matriz para o tamanho de uma tela (240 pixels de altura)
		blt t0,t2,CONTINUE_COLUMN
		j RENDER_MAP_LOOP
		CONTINUE_COLUMN:
		# Operacao finalizada
			ret
