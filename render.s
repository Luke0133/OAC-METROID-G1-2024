.text
##########################     RENDER IMAGE    ##########################
#     -----------           argument registers           -----------    #
#	a0 = Image Address						#
#	a1 = X coordinate where rendering will start (top left)		#
#	a2 = Y coordinate where rendering will start (top left)		#
#	a3 = width of rendering area (usually the size of the sprite)	#
# 	a4 = height of rendering area (usually the size of the sprite)	#
#	a5 = frame (0 or 1)						#
#	a6 = status of sprite (usually 0 for sprites that are alone)	#
#	a7 = operation (0 if normal printing, 1 cropped print)		#
# -- saved registers (recieved as arguments - only when on crop mode)-- #
#	s1 = X coordinate relative to sprite (top left)			#
#	s2 = Y coordinate relative to sprite (top left)     		#
#	s3 = sprite width			   	  		#
#     -----------          temporary registers           -----------    #
#	t0 = bitmap display printing address				#
#	t1 = image address						#
#	t2 = line counter						#
# 	t3 = column counter						#
# 	t4 = temporary operations					#
#########################################################################
RENDER:
beqz a7,NORMAL
	CROP_MODE:	# When rendering cropped sprite 	
		add a0,a0,s1	# Image address + X on sprite 
		mul t3,s3,s2	# t4 = sprite width * Y on sprite
		add a0,a0,t3	# a0 = Image address + X on sprite + sprite widht * Y on sprite
	NORMAL:		# Executed even if on crop mode
		mul t4,a6,a4	# Sprite offset (for files that have more than one sprite)
		mul t4,t4,a3	# Sprite Line offset (skips the first %width lines)
# not used #	addi a0,a0,8	# Skip image size info
		add a0,a0,t4	# Adds offset to image address

	#Propper rendering

	li t0,0x0FF0	#t0 = 0x0FF0
	add t0,t0,a5	# Rendering Address corresponds to 0x0FF0 + frame
	slli t0,t0,20	# Shifts 20 bits, making printing adress correct (0xFF00 0000 or 0xFF10 0000)
	add t0,t0,a1	# t0 = 0xFF00 0000 + X or 0xFF10 0000 + X
	li t1,320	# t1 = 320
	mul t1,t1,a2	# t1 = 320 * Y 
	add t0,t0,t1	# t0 = 0xFF00 0000 + X + (Y * 320) or 0xFF10 0000 + X + (Y * 320)
	
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
		
		beqz a7, NORMAL_RENDER	# If not on crop mode
		CROP_RENDER:
			add a0,a0,s3	# a0 += sprite width	
			sub a0,a0,a3	# a0 -= rendering width
		NORMAL_RENDER: 
			mv t3,zero		# t3 = 0 (Resets column counter)
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
		
###############################         RENDER MAP         ##############################
#    Takes a given map matrix and renders tiles acoording to the value stored on it   	#
#     ------------               argument registers              ------------      	#
#	a0 = Map Matrix Address						  	   	#
#	a1 = starting X on Matrix (top left)					   	#
#	a2 = starting Y on Matrix (top left)    				   	#	
#	a3 = X offset (0, 4, 8, 12)	  	   				   	#
#	a4 = Y offset (0, 4, 8, 12)	  	   				   	#	 		  
#	a5 = frame (0 or 1)						  	   	#
#     ------------          saved registers (uses stack)         ------------      	#
#	s0 = current X and Y address on Matrix				   	   	#
#	s1 = current X on Matrix			           		   	#
#	s2 = current Y on Matrix			   	  		   	#
#	s3 = Matrix Width				   	  		   	#			
#     ------------              temporary registers              ------------      	#
#	t0 = operacoes temporarias			           		   	#
#	t1 = tile a ser renderizado			   	  		   	#				
#	t2 = contador de linhas	(relativo a matriz)				   	#
#  	t3 = contador de colunas (relativo a matriz)				   	#
#  	t4 = temporary register for moving info						#
#  	t5 = temporary register for moving info					   	#
#  	t6 = temporary register for moving info					   	#
#########################################################################################
RENDER_MAP:
## DEBUG
#	mv t6, zero
#		mv t5,a0
#		li a0, 3000
#		li a7, 32
#		ecall
#		mv a0,t5
	##
	
# Guarda na pilha
	addi sp,sp,-16
	sw s3,12(sp)
	sw s2,8(sp)
	sw s1,4(sp)
	sw s0,0(sp)

# 	renderizar tile
#	     - checar offset p/ determinar coordenadas e corte (apenas nas laterais/topo e chao)
# 	se acabou a coluna, voltaate acabar numero de colunas
# 	se acabou a linha, reseta coluna e volta ate acabar numero de linhas
	mv s1,a1
	mv s2,a2
	addi s0,a0,3 	# skips first 3 bytes of information (goes to the actual matrix)
	add s0, s0, s1 	# s0 = Matrix Address + Current X on Matrix
	lbu s3,1(a0)	# s3 = matrix width
	mul t0,s3,s2	# t0 = Matrix Width x Current Y on Matrix
	add s0, s0, t0	# s0 = Address to current X and Y on Matrix

	mv t2,zero	# t2 = 0 (Resets line counter)
	mv t3,zero	# t3 = 0 (Resets column counter)
RENDER_MAP_LOOP:
#	mv t5,a0
#	li a0, 1000
#	li a7, 32
#	ecall
#	mv a0,t5

	lbu t1,0(s0)	# loads byte stored on matrix for checking what is the tile
	
	bnez t1,NotBackground
	j CONTINUE_RENDER_MAP
	NotBackground:
	li t0,74
	bne t1,t0, NotBreakBlock
	la t0, BreakBlock
	j CONTINUE_RENDER_MAP
	NotBreakBlock:
	li t0,126
	bne t1,t0, NotBush2A
	la t0, Bush2A
	j CONTINUE_RENDER_MAP
	NotBush2A:
	li t0,127
	bne t1,t0, NotBush2B
	la t0, Bush2B
	j CONTINUE_RENDER_MAP
	NotBush2B:
	li t0,14
	bne t1,t0, NotDoorLeftTop
#	# la t0, DoorLeftTop
	li t1,0
	j CONTINUE_RENDER_MAP
	NotDoorLeftTop:
	li t0,12
	bne t1,t0, NotDoorLeft
#	# la t0, DoorLeft
	li t1,0
	j CONTINUE_RENDER_MAP
	NotDoorLeft:
	li t0,6
	bne t1,t0, NotDoorRightTop
#	# la t0, DoorRightTop
	li t1,0
	j CONTINUE_RENDER_MAP
	NotDoorRightTop:
	li t0, 4 
	bne t1,t0, NotDoorRight
#	# la t0, DoorRight
	li t1,0
	j CONTINUE_RENDER_MAP
	NotDoorRight:
	li t0, 198 
	bne t1,t0, NotDoorFrame
	la t0, DoorFrame
	j CONTINUE_RENDER_MAP
	NotDoorFrame:
	li t0, 64 
	bne t1,t0, NotGround1A
	la t0, Ground1A
	j CONTINUE_RENDER_MAP
	NotGround1A:
	li t0, 72 
	bne t1,t0, NotGround1B
	la t0, Ground1B
	j CONTINUE_RENDER_MAP
	NotGround1B:
	li t0, 80 
	bne t1,t0, NotGround1C
	la t0, Ground1C
	j CONTINUE_RENDER_MAP
	NotGround1C:
	li t0, 88 
	bne t1,t0, NotGround1D
	la t0, Ground1D
	j CONTINUE_RENDER_MAP
	NotGround1D:
	li t0, 98 
	bne t1,t0, NotGround2A
	la t0, Ground2A
	j CONTINUE_RENDER_MAP
	NotGround2A:
	li t0, 106 
	bne t1,t0, NotGround2B
	la t0, Ground2B
	j CONTINUE_RENDER_MAP
	NotGround2B:
	li t0, 114 
	bne t1,t0, NotGround2C
	la t0, Ground2C
	j CONTINUE_RENDER_MAP
	NotGround2C:
	li t0, 84 
	bne t1,t0, NotGround3A
	la t0, Ground3A
	j CONTINUE_RENDER_MAP
	NotGround3A: 
	li t0, 92 
	bne t1,t0, NotGround3B
	la t0, Ground3B
	j CONTINUE_RENDER_MAP
	NotGround3B:
	li t0, 100 
	bne t1,t0, NotGround3C
	la t0, Ground3C
	j CONTINUE_RENDER_MAP
	NotGround3C:
	li t0, 128 
	bne t1,t0, NotItemHolderA
	la t0, ItemHolderA
	j CONTINUE_RENDER_MAP
	NotItemHolderA:
	li t0, 136 
	bne t1,t0, NotItemHolderB
	la t0, ItemHolderB
	j CONTINUE_RENDER_MAP
	NotItemHolderB:
	li t0, 144 
	bne t1,t0, NotItemHolderC
	la t0, ItemHolderC
	j CONTINUE_RENDER_MAP
	NotItemHolderC:
	li t0, 152 
	bne t1,t0, NotItemHolderD
	la t0, ItemHolderD
	j CONTINUE_RENDER_MAP
	NotItemHolderD:
	li t0, 160 
	bne t1,t0, NotItemHolderE
	la t0, ItemHolderE
	j CONTINUE_RENDER_MAP
	NotItemHolderE:
	li t0, 168 
	bne t1,t0, NotItemHolderF
	la t0, ItemHolderF
	j CONTINUE_RENDER_MAP
	NotItemHolderF:
	li t0, 176
	bne t1,t0, NotItemHolderG
	la t0, ItemHolderG
	j CONTINUE_RENDER_MAP
	NotItemHolderG:
	li t0, 94
	bne t1,t0, NotLavaB
	la t0, LavaB
	j CONTINUE_RENDER_MAP
	NotLavaB:
	li t0, 102
	bne t1,t0, NotLavaT
	la t0, LavaT
	j CONTINUE_RENDER_MAP
	NotLavaT:
	li t0, 90
	bne t1,t0, NotPipe1H
	la t0, Pipe1H
	j CONTINUE_RENDER_MAP
	NotPipe1H:
	li t0, 82
	bne t1,t0, NotPipe1V
	la t0, Pipe1V
	j CONTINUE_RENDER_MAP
	NotPipe1V:
	li t0, 68
	bne t1,t0, NotPipe2H
	la t0, Pipe2H
	j CONTINUE_RENDER_MAP
	NotPipe2H:
	li t0, 122
	bne t1,t0, NotPipe2V
	la t0, Pipe2V
	j CONTINUE_RENDER_MAP
	NotPipe2V:
	li t0, 118
	bne t1,t0, NotPipe3V2
	la t0, Pipe3V2
	j CONTINUE_RENDER_MAP
	NotPipe3V2:
	li t0, 110
	bne t1,t0, NotPipe3V
	la t0, Pipe3V
	j CONTINUE_RENDER_MAP
	NotPipe3V:
	li t0, 96
	bne t1,t0, NotSlide1L
	la t0, Slide1L
	j CONTINUE_RENDER_MAP
	NotSlide1L:
	li t0, 104
	bne t1,t0, NotSlide1R
	la t0, Slide1R
	j CONTINUE_RENDER_MAP
	NotSlide1R:
	li t0, 78
	bne t1,t0, NotSpikeL
	la t0, SpikeL
	j CONTINUE_RENDER_MAP
	NotSpikeL:
	li t0, 86
	bne t1,t0, NotSpikeR
	la t0, SpikeR
	j CONTINUE_RENDER_MAP
	NotSpikeR:
	li t0, 120
	bne t1,t0, NotTile1A
	la t0, Tile1A
	j CONTINUE_RENDER_MAP
	NotTile1A:
	li t0, 66
	bne t1,t0, NotTile1B
	la t0, Tile1B
	j CONTINUE_RENDER_MAP
	NotTile1B:
	li t0, 76
	bne t1,t0, NotTile2A
	la t0, Tile2A
	j CONTINUE_RENDER_MAP
	NotTile2A:
	li t0, 116
	bne t1,t0, NotTile3A
	la t0, Tile3A
	j CONTINUE_RENDER_MAP
	NotTile3A:
	li t0, 124
	bne t1,t0, NotTile3B
	la t0, Tile3B
	j CONTINUE_RENDER_MAP
	NotTile3B:
	li t0, 70 
	bne t1,t0, NoTile
	la t0, Tile3C
	
	NoTile:
	li t1,0
	CONTINUE_RENDER_MAP:
	# Guarda na pilha
	addi sp,sp,-44
	sw s3,40(sp)
	sw s2,36(sp)
	sw s1,32(sp)
	sw a4,28(sp)
	sw a3,24(sp)
	sw a2,20(sp)
	sw a1,16(sp)
	sw a0,12(sp)
	sw t2,8(sp)
	sw t3,4(sp)
	sw ra,0(sp)
	
	mv a0, t0
#	s0 = current X and Y address on Matrix				   	   #
#	s1 = current X on Matrix			           		   #
#	s2 = current Y on Matrix			   	  		   #
#	s3 = Matrix Width				   	  		   #	
#	a1 = starting X on Matrix (top left)					   #
#	a2 = starting Y on Matrix (top left)    				   #	
#	a3 = X offset (0, 4, 8, 12)	  	   				   #
#	a4 = Y offset (0, 4, 8, 12)	  	   				   #	 
	
	# Defining rendering coordinates
	li t0, tile_size 	# Tile size = 16
	sub t4,s1,a1		# t4 = Current X on matrix - Starting X on matrix
	mul t4,t4,t0		# t4 gets the X value relative to the screen
#	addi t0, t0,-1		# For some reason, getting Y related to screen needs to be tile size - 1 (t0 = 15)
	sub t5,s2,a2		# t5 = Current Y on matrix - Starting Y on matrix
	mul t5,t5,t0		# t5 gets the Y value relative to the screen
	# Obs.: don't use t4 and t5 until stack is saved, unless it's related to rendering coordinates
	li t6,0
	bnez a3, X_Offset 	# If there's a X offset
	j NoOffset
	X_Offset:
		bne s1,a1, TryRightOffset # Left Border
		li t6,1
		j NoOffset
		TryRightOffset:
		addi t0, a1, 20
		bne s1, t0, NoX_Offset
		li t6,2
		NoX_Offset:
		j NoOffset
	beqz a4, Y_Offset		# Or a Y offset, go to offset operations
	j NoOffset
	Y_Offset:
		bne s2,a2, TryBottomOffset
		li t6,1
		j NoOffset
		TryBottomOffset:
		addi t0, a2, 15
		bne s2, t0, NoY_Offset
		li t6,2
		NoY_Offset:
		j NoOffset		# Otherwise, jump to NoOffset
	
	NoOffset:
	bnez t1,NormalRender
	# Color Render
		li a0, 0x00 		# Black
		mv a1, t4		# Top Left X
		mv a2, t5		# Top Left Y	
		# a5 doesn't change
		bnez t6, CropColor 
		j NoCropColor
		CropColor:
		addi t6,t6,-1
		bnez t6, RightBottomColorCrop
			LeftTopColorCrop:
				li t0, tile_size	
				sub a3,t0, a3		# a3 will hold rendering widht that is equal to the tile size (16) - X offset
				sub a4,t0, a4		# a4 will hold rendering height that is equal to the tile size (16) - Y offset
				j StartColorRender
			RightBottomColorCrop:	
				sub a1,a1,a3		# a1 will shift left the ammount of a3 (currently X offset) 
				sub a2,a2,a4		# a2 will shift up the ammount of a4 (currently Y offset)
				CheckXColor:
				bnez a3, CheckYColor # If X offset (a3) isn't zero, the widht for rendering the cropped tile will be the X offset
				li a3, tile_size	    # otherwise, it'll be the tile size
				CheckYColor:
				bnez a4, EndRightBottomCropColor # If Y offset (a4) isn't zero, the widht for rendering the cropped tile will be the Y offset
				li a4, tile_size	    # otherwise, it'll be the tile size
				EndRightBottomCropColor:
				j StartColorRender
		NoCropColor:
			sub a1,a1,a3		# a1 will shift left the ammount of a3 (currently X offset) 
			sub a2,a2,a4		# a2 will shift up the ammount of a4 (currently Y offset)	
			li a3, tile_size	# Tile Width (Screen)
			li a4, tile_size	# Tile Height (Screen)	
		
		StartColorRender:
		call RENDER_COLOR
		j EndRender
	
	NormalRender:
		# a0 has the tile address
		mv a1, t4		# Top Left X where tile will start rendering
		mv a2, t5		# Top Left Y where tile will start rendering			
		li a6, 0		# Tiles only have one image, thus their status is allways 0
		# If no offset is taken into account, will skip unecessary parameters  
		bnez t6, Continue_Crop 
		j Skip_Offset
		Continue_Crop : 
		li a7,1			# Cropped Render operations
		addi t6,t6,-1		# After this, t6 = 0 or t6 = 1
		bnez t6, RightBottomCrop
		LeftTopCrop:	 # Will crop tile from the left or from the top
			mv s1, a3		# s1 will store the X offset (where rendering will start from)
			mv s2, a4		# s2 will store the Y offset (where rendering will start from)
			li s3, tile_size	# s3 = 16
			sub a3,s3, s1		# a3 will hold rendering widht that is equal to the tile size (16) - X offset
			sub a4,s3, s2		# a4 will hold rendering height that is equal to the tile size (16) - Y offset
			j Start_NormalRender
		RightBottomCrop: # Will crop tile from the right or bottom
			li s1, 0		# s1 = 0 (rendering will start from the left)
			li s2, 0		# s2 = 0 (rendering will start from the top)
			li s3, tile_size	# s3 = 16
			sub a1,a1,a3		# a1 will shift left the ammount of a3 (currently X offset) 
			sub a2,a2,a4		# a2 will shift up the ammount of a4 (currently Y offset)
			CheckX:
			bnez a3, CheckY # If X offset (a3) isn't zero, the widht for rendering the cropped tile will be the X offset
			li a3, tile_size	    # otherwise, it'll be the tile size
			CheckY:
			bnez a4, EndRightBottomCrop # If Y offset (a4) isn't zero, the widht for rendering the cropped tile will be the Y offset
			li a4, tile_size	    # otherwise, it'll be the tile size
			EndRightBottomCrop:
			j Start_NormalRender
		# If no offset is taken into account, a3 and a4 will be overriten with the deffault tile size (16)  
		Skip_Offset:
		sub a1,a1,a3		# a1 will shift left the ammount of a3 (currently X offset) 
		sub a2,a2,a4		# a2 will shift up the ammount of a4 (currently Y offset) 
		li a3, tile_size	# Tile Width (Relative to Screen)
		li a4, tile_size	# Tile Height (Relative to Screen)
		li a7, 0		# Normal Render operations
		Start_NormalRender:
		call RENDER
	
	EndRender:
	lw s3,40(sp)
	lw s2,36(sp)
	lw s1,32(sp)
	lw a4,28(sp)
	lw a3,24(sp)
	lw a2,20(sp)
	lw a1,16(sp)
	lw a0,12(sp)
	lw t2,8(sp)
	lw t3,4(sp)
	lw ra,0(sp)
	addi sp,sp,44
			
	addi t3,t3,1		# increments column counter
	addi s1,s1,1		# increments 1 to Current X
	addi s0,s0,1		# Goes to next byte
	li t0, 20 		# Largura da matriz para o tamanho de uma tela (320 pixels de largura)
	beqz a3, No_X_Offset
	addi t0,t0,1
	No_X_Offset:
	bge t3,t0,CONTINUE_LINE	# if column counter >= width, repeat
	j RENDER_MAP_LOOP	# if column counter < width, repeat
	CONTINUE_LINE:
	## DEBUG
#		mv t5,a0
#		li a0, 3000
#		li a7, 32
#		ecall
#		mv a0,t5
	##
	
		add s0,s0,s3			# s0 = Current Address on Matrix + Matrix Width
		sub s0,s0,t0			# s0 = New Current Address on Matrix 
		mv s1,a1
		
		mv t3,zero			# t3 = 0 (resets column counter)
		addi t2,t2,1			# increments line counter
		addi s2,s2,1			# increments 1 to Current Y
		
		li t0, 15 			# Altura da matriz para o tamanho de uma tela (240 pixels de altura)
		beqz a4, No_Y_Offset
		addi t0,t0,1
		No_Y_Offset:
		bge t2,t0,CONTINUE_COLUMN	# if height > line counter, repeat
		
		j RENDER_MAP_LOOP
		CONTINUE_COLUMN:
		# Operacao finalizada
			lw s3,12(sp)
			lw s2,8(sp)
			lw s1,4(sp)
			lw s0,0(sp)
			addi sp,sp,16		
			ret

#	la a0, DoorFrame 		# Gets sprite address# Endereco do mapa
#	li a1, 80		# Topo esquerdo X
#	li a2, 80		# Topo esquerdo Y		
#	li a3, 16		# Largura da imagem
#	li a4, 4		# Altura da imagem	
#	mv a5, s0		# Frame
#	li a6, 0
#	li a7, 1
#	li s1, 0
#	li s2, 12
#	li s3, 16
#	call RENDER
