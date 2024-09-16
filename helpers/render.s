.text
# ----> Summary: render.s stores rendering related procedures
# 1 - RENDER (Renders image when address is given. It renders byte by byte (slow))
# 2 - RENDER WORD (Renders image when address is given. It renders word by word )
# 3 - RENDER COLOR (Renders a given color on a given space)
# 4 - RENDER PLAYER (Renders player based on its PLAYER_STATUS)

# N-2 - RENDER DOOR UPDATE (will render door after update is requested)
# N-1 - RENDER DOOR FRAMES (will render door frames over player)
# N - RENDER MAP (Takes a given map matrix and renders tiles acoording to the value stored on it)



#############################     RENDER     ############################
#   Renders image when address is given. It renders byte by byte (slow) #
#     -----------           argument registers           -----------    #
#       a0 = Image Address                                              #
#       a1 = X coordinate where rendering will start (top left)         #
#       a2 = Y coordinate where rendering will start (top left)         #
#       a3 = width of rendering area (usually the size of the sprite)   #
#       a4 = height of rendering area (usually the size of the sprite)  #
#       a5 = frame (0 or 1)                                             #
#       a6 = status of sprite (usually 0 for sprites that are alone)    #
#       a7 = operation (0 if normal printing, 1 cropped print)          #
# -- saved registers (recieved as arguments - only when on crop mode)-- #
#       s1 = X coordinate relative to sprite (top left)                 #
#       s2 = Y coordinate relative to sprite (top left)                 #
#       s3 = sprite width                                               #
#       s4 = sprite height                                              #
#     -----------          temporary registers           -----------    #
#       t0 = bitmap display printing address                            #
#       t1 = image address                                              #
#       t2 = line counter                                               #
#       t3 = column counter                                             #
#       t4 = temporary operations                                       #
#########################################################################
RENDER:
beqz a7,NORMAL
	CROP_MODE:	# When rendering cropped sprite 				
		add a0,a0,s1	# Image address + X on sprite 
		mul t3,s3,s2	# t3 = sprite width * Y on sprite
		add a0,a0,t3	# a0 = Image address + X on sprite + sprite widht * Y on sprite
		mul t4,a6,s4	# t4 = sprite status x height of rendering area (for files that have more than one sprite)
		mul t4,t4,s3	# t4 = sprite status x height of rendering area x sprite's width
		j START_RENDER
	NORMAL:
		mul t4,a6,a4	# t4 = sprite status x height of rendering area (for files that have more than one sprite)
		mul t4,t4,a3	# t4 = sprite status x height of rendering area x width of rendering area (on NORMAL_RENDER: a3 = sprite's width)
	
	START_RENDER:
		add a0,a0,t4	# Adds the dislocation calculated on t4 to the sprite's address
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
		lb t4,0(a0)	# loads byte(1 pixel) on t4
		
		# Comparing if samus is on missile mode
		li t5,green # Loads 32 (value of green pixel in samus)
		bne t5,t4,SKIP_SWITCH
			la t5, PLYR_INFO_2    # Loads address to PLYR_INFO_2
			lbu t5,0(t5)          # Loads missile enable byte
			beqz t5,SKIP_SWITCH   # If player isn't in missile mode
				li t4 cyan        # Otherwise render cyan instead of green
		SKIP_SWITCH:
		
		sb t4,0(t0)	# prints 1 pixel from t4
		
		addi t0,t0,1	# increments bitmap address
		addi a0,a0,1	# increments image address
		
		addi t3,t3,1		# increments column counter
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

###########################    RENDER WORD    ###########################
#   Renders image when address is given. It renders word by word        #
#     -----------           argument registers           -----------    #
#       a0 = Image Address                                              #
#       a1 = X coordinate where rendering will start (top left)         #
#       a2 = Y coordinate where rendering will start (top left)         #
#       a3 = width of rendering area (usually the size of the sprite)   #
#       a4 = height of rendering area (usually the size of the sprite)  #
#       a5 = frame (0 or 1)                                             #
#       a6 = status of sprite (usually 0 for sprites that are alone)    #
#       a7 = operation (0 if normal printing, 1 cropped print)          #
# -- saved registers (recieved as arguments - only when on crop mode)-- #
#       s1 = X coordinate relative to sprite (top left)                 #
#       s2 = Y coordinate relative to sprite (top left)                 #
#       s3 = sprite width                                               #
#       s4 = sprite height                                              #
#     -----------          temporary registers           -----------    #
#       t0 = bitmap display printing address                            #
#       t1 = image address                                              #
#       t2 = line counter                                               #
#       t3 = column counter                                             #
#       t4 = temporary operations                                       #
#########################################################################
RENDER_WORD:
beqz a7,NORMAL_WORD
	CROP_MODE_WORD:	# When rendering cropped sprite	
		add a0,a0,s1	# Image address + X on sprite 
		mul t3,s3,s2	# t3 = sprite width * Y on sprite
		add a0,a0,t3	# a0 = Image address + X on sprite + sprite widht * Y on sprite
		mul t4,a6,s4	# t4 = sprite status x height of rendering area (for files that have more than one sprite)
		mul t4,t4,s3	# t4 = sprite status x height of rendering area x sprite's width
		j START_RENDER_WORD
	NORMAL_WORD:		# Executed even if on crop mode
		mul t4,a6,a4	# t4 = sprite status x height of rendering area (for files that have more than one sprite)
		mul t4,t4,a3	# t4 = sprite status x height of rendering area x width of rendering area (on NORMAL_RENDER: a3 = sprite's width)

	START_RENDER_WORD:
		add a0,a0,t4	# Adds the dislocation calculated on t4 to the sprite's address
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
	
	
	PRINT_LINE_WORD:	
		lb t4,0(a0)	# loads word(4 pixels) on t4
		sb t4,0(t0)	# prints 4 pixels from t4
		
		addi t0,t0,1	# increments bitmap address
		addi a0,a0,1	# increments image address
		
		addi t3,t3,1		# increments column counter
		blt t3,a3,PRINT_LINE_WORD	# if column counter < width, repeat
		
		addi t0,t0,320	# goes to next line on bitmap display
		sub t0,t0,a3	# goes to right X on bitmap display (current address - width)
		
		beqz a7, NORMAL_RENDER_WORD	# If not on crop mode
		CROP_RENDER_WORD:
			add a0,a0,s3	# a0 += sprite width	
			sub a0,a0,a3	# a0 -= rendering width

		NORMAL_RENDER_WORD: 
			mv t3,zero		# t3 = 0 (Resets column counter)
			addi t2,t2,1		# increments line counter
			bgt a4,t2,PRINT_LINE_WORD	# if height > line counter, repeat
			ret



############################## RENDER COLOR #############################
#                Renders a given color on a given space                 #
#     -----------           argument registers           -----------    #
#       a0 = color                                                      #
#       a1 = X coordinate where rendering will start (top left)         #	
#       a2 = Y coordinate where rendering will start (top left)         #
#       a3 = width of printing area (usually the size of the sprite)    #
#       a4 = height of printing area (usually the size of the sprite)   #
#       a5 = frame (0 or 1)                                             #
#       a6 = operation (0 - rendering 4 pixels at once;                 #
#                       1 -  rendering 2 pixels at once)                #	
#     -----------          temporary registers           -----------    #
#       t0 = bitmap display printing address                            #
#       t1 = temporary operations                                       #
#       t2 = line counter                                               #
#       t3 = column counter                                             # 
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
	
	bnez a6, PRINT_LINE_COLOR_HALF # If not printing 4 pixels at once
		slli t1,a0,16	       # Shifts 16 bits on a0
		add a0,a0,t1	       # a0 now stores four bytes of the same color (e.g.: 0x0000FFFF -> 0xFFFFFFFF)
		j PRINT_LINE_COLOR_WORD
		
	PRINT_LINE_COLOR_HALF:	
		sh a0,0(t0)	# Renders two color pixels at once
		addi t0,t0,2	# increments bitmap address by 2 bytes
		
		addi t3,t3,2			# increments column counter
		blt t3,a3,PRINT_LINE_COLOR_HALF	# if column counter < width, repeat
		
		addi t0,t0,320	# goes to next line on bitmap display
		sub t0,t0,a3	# goes to right X on bitmap display (current address - width)
		
		mv t3,zero			# t3 = 0 (resets column counter)
		addi t2,t2,1			# increments line counter
		bgt a4,t2,PRINT_LINE_COLOR_HALF	# if height > line counter, repeat
		ret			
		
	PRINT_LINE_COLOR_WORD:
		sw a0,0(t0)	# Renders four color pixels at once
		addi t0,t0,4	# increments bitmap address by 4 bytes
		
		addi t3,t3,4			# increments column counter
		blt t3,a3,PRINT_LINE_COLOR_WORD	# if column counter < width, repeat
		addi t0,t0,320	# goes to next line on bitmap display
		sub t0,t0,a3	# goes to right X on bitmap display (current address - width)
		
		mv t3,zero			# t3 = 0 (resets column counter)
		addi t2,t2,1			# increments line counter
		bgt a4,t2,PRINT_LINE_COLOR_WORD	# if height > line counter, repeat
		ret
		
##########################      RENDER PLAYER      ###########################
#                Renders player based on its PLAYER_STATUS                   #
#     -----------             argument registers             -----------     #
#       a0 = 0 - render player sprite; 1 - render player's trail             #	
#       a1 = 0 - render full image                                           #
#            1 - get 16 pixels to the left; 2 - get 16 tiles to the right    #
#                                                                            #
#     -----------            temporary registers             -----------     #
#       tp =  stores a1                                                      #
#       t0 =  PLYR STATUS                                                    #
#       t1 =  HORIZONTAL DIRECTION                                           #
#       t2 =  MOVEX                                                          #
#       t3 =  MOVEY                                                          # 
#		t4 =  VERTICAL DIRECTION                                             #
#		t5 =  ATTACKING STATUS                                               #
#                                                                            #
##############################################################################	

RENDER_PLAYER:
	mv tp,a1  # tp gets value from a1

	la t1, PLYR_INFO_2	 # Loads address of the second part of PLYR_INFO
    lbu t0,3(t1)         # and damage cooldown
	beqz t0,RENDER_PLAYER_SKIP_DAMAGE
		lbu t0,7(t1)     # Loads render byte
		xori t2,t0,1     # inverts it
		sb t2,7(t1)      # and stores it
		bnez t0,RENDER_PLAYER_SKIP_DAMAGE # If it wasn't 0, render
		ret	# Otherwise, finish procedure
    RENDER_PLAYER_SKIP_DAMAGE:
	la t0, PLYR_STATUS # Loads PLAYER_STATUS address
	la t2,PLYR_POS	# Loads PLYR_POS address
	# Loading informations for Rendering Sprite
	lh a1, 0(t2)	# Loads top left X coordinate related to sprite
	lbu a2, 4(t2)	# Loads top left Y coordinate related to sprite	

	mv a5, s0		# Gets frame 
	lbu a6, 0(t0)   # Loads Player's sprite status
	mv a7,zero 		# Operation (0 - normal operation)
	
	beqz a0, RENDER_PLAYER_NORMAL # If a0 = 0,  then player will be rendered normally
	j RENDER_PLAYER_TRAIL         # Otherwise (a0 = 1) render player's trail
	RENDER_PLAYER_NORMAL:
		# Storing Registers on Stack
		addi sp,sp,-20
		sw s1,0(sp)
		sw s2,4(sp)
		sw s3,8(sp)
		sw s4,12(sp)
		sw ra,16(sp)
		# End of Stack Operations

		# Loading informations for Checking Sprite
		lbu t1, 1(t0)	# Loads Player's horizontal direction (0 = Right, 1 = Left)
		lbu t2, 4(t0)   # Loads Player's morph ball status
		
		beqz t2, RENDER_PLAYER_STAND # If player isn't on morph ball, go to RENDER_PLAYER_STAND
		j RENDER_PLAYER_BALL         # Otherwise, go to RENDER_PLAYER_BALL
		
	RENDER_PLAYER_STAND:
		lbu t2, 6(t0)   # Loads Player's MOVE_X value (-1 left, 1 right, 0 not moving on X axis)
		lbu t3, 7(t0)   # Loads Player's MOVE_Y value (-1 up, 1 right, 0 not moving on Y axis)
		lbu t4, 2(t0)	# Loads Player's vertical direction (0 = Normal, 1 = Up)
		lbu t5, 5(t0)	# Loads Player's attacking status (0 - no, 1 - yes)

		beqz t1, RENDER_PLYR_RIGHT # Checks if player is looking right
		j RENDER_PLYR_LEFT	   # If player is looking left

		RENDER_PLYR_RIGHT:
			add t1, t2, t3  # t1 will be 0 if t2 (MOVE_X) = 0 and t3 (MOVE_Y) = 0
			beqz t1,RENDER_IDLE_RIGHT # If t1 = 0, player isn't moving (go to RENDER_IDLE_RIGHT)
				la t1,PLYR_INPUT # Otherwise, load PLYR_INPUT address
				lbu t1,0(t1)     # and get its value
				addi t1,t1,-2    # subtracts 2 from it
				beqz t1, RENDER_IDLE_RIGHT # if the result is 0 (t1 would've been 2, so player couldn't move) go to idle
					j NOT_IDLE_RIGHT	   # Otherwise, go to NOT_IDLE_RIGHT

			RENDER_IDLE_RIGHT:
				li a3, 20   # Sprite's Widht
				mv a6, t5	# Idle sprites have their status set to 1 if player is attacking
				bnez t4, RENDER_IDLE_RIGHT_UP # If player is looking up

				# Otherwise, render normal idle 
				la a0, Samus_Right_Idle # Loads Player's Image Address 
				li a4, 32  # Sprite's Height
				j START_RENDER_PLAYER # Start rendering player

				RENDER_IDLE_RIGHT_UP:
				addi a2,a2, -6 # Offseting sprite's Y so that it renders in propper place
				la a0, Samus_Right_Idle_Up # Loads Player's Image Address 
				li a4, 38  # Sprite's Height
				j START_RENDER_PLAYER # Start rendering player

			NOT_IDLE_RIGHT:
				bnez t3, RENDER_JUMP_RIGHT
				j NOT_JUMP_RIGHT

				RENDER_JUMP_RIGHT:
					#### STATUS 0,1 when jumping normally go to STATUS 1 of IDLE RIGHT/ ATK
					#### STATUS 2 when jumping normally go to STATUS 1 of MOVE RIGHT/ ATK
					#### STATUS 3 when jumping normally go to STATUS 0 (or 1) of JUMP RIGHT
					
					# CHECK SPIN JUMP?
					
					addi a1,a1, -4 # Offseting sprite's X so that it renders in propper place
					addi a2,a2, -6 # Offseting sprite's Y so that it renders in propper place
					li a4, 32  # Sprite's Height
					mv a6, t5	# Jump sprites have their status set to 1 if player is attacking
					bnez t4, RENDER_JUMP_RIGHT_UP	# If player is looking up
					# Otherwise, render normal jump 
						li a3, 24  # Sprite's Widht
						la a0, Samus_Right_Jump # Loads Player's Image Address 
						j START_RENDER_PLAYER   # Start rendering player

					RENDER_JUMP_RIGHT_UP:
						li a3, 20  # Sprite's Widht
						la a0, Samus_Right_Jump_Up # Loads Player's Image Address 
						j START_RENDER_PLAYER      # Start rendering player

				NOT_JUMP_RIGHT:
					beqz t4, RENDER_MOVEMENT_RIGHT
					j RENDER_MOVEMENT_RIGHT_UP

					RENDER_MOVEMENT_RIGHT:
						li a4, 32  # Sprite's Height
						beqz t5, RENDER_MOVEMENT_RIGHT_NORMAL
						j RENDER_MOVEMENT_RIGHT_ATTACK

						RENDER_MOVEMENT_RIGHT_NORMAL:
							la a0, Samus_Right	   # Loads Player's Image Address 
							li a3, 20              # Sprite's Widht
							j START_RENDER_PLAYER  # Start rendering player

						RENDER_MOVEMENT_RIGHT_ATTACK:
							la a0, Samus_Right_Attack  # Loads Player's Image Address 
							li a3, 28                  # Sprite's Widht
							j START_RENDER_PLAYER      # Start rendering player

					RENDER_MOVEMENT_RIGHT_UP:
						addi a2,a2, -6 # Offseting sprite's X so that it renders in propper place
						li a3, 20      # Sprite's Widht
						li a4, 38      # Sprite's Height
						beqz t5, RENDER_MOVEMENT_RIGHT_UP_NORMAL
						j RENDER_MOVEMENT_RIGHT_UP_ATTACK

						RENDER_MOVEMENT_RIGHT_UP_NORMAL:
							la a0, Samus_Right_Up  # Loads Player's Image Address
							j START_RENDER_PLAYER  # Start rendering player

						RENDER_MOVEMENT_RIGHT_UP_ATTACK:
							la a0, Samus_Right_Up_Attack  # Loads Player's Image Address
							j START_RENDER_PLAYER         # Start rendering player

		RENDER_PLYR_LEFT:
			addi a1,a1, -4 # Offseting sprite's X so that it renders in propper place
			add t1, t2, t3  # t1 will only be 0 if player isn't moving 
			beqz t1,RENDER_IDLE_LEFT # Checks if player is mooving or not
				la t1,PLYR_INPUT # Otherwise, load PLYR_INPUT address
				lbu t1,0(t1)     # and get its value
				addi t1,t1,-2    # subtracts 2 from it
				beqz t1, RENDER_IDLE_LEFT # if the result is 0 (t1 would've been 2, so player couldn't move) go to idle
			j NOT_IDLE_LEFT	  # If player is moving or not

			RENDER_IDLE_LEFT:
				li a3, 20  # Sprite's Widht
				mv a6, t5	# Idle sprites have their status set to 1 if player is attacking
				bnez t4, RENDER_IDLE_LEFT_UP	# If player is looking up
					
				# Otherwise, render normal idle 
					la a0, Samus_Left_Idle # Loads Player's Image Address 
					li a4, 32  # Sprite's Height
					j START_RENDER_PLAYER # Start rendering player
				
				RENDER_IDLE_LEFT_UP:
					addi a2,a2, -6 # Offseting sprite's Y so that it renders in propper place
					la a0, Samus_Left_Idle_Up # Loads Player's Image Address 
					li a4, 38  # Sprite's Height
					j START_RENDER_PLAYER # Start rendering player

			NOT_IDLE_LEFT:
				bnez t3, RENDER_JUMP_LEFT
				j NOT_JUMP_LEFT

				RENDER_JUMP_LEFT:
					#### STATUS 0,1 when jumping normally go to STATUS 1 of IDLE LEFT/ ATK
					#### STATUS 2 when jumping normally go to STATUS 1 of MOVE LEFT/ ATK
					#### STATUS 3 when jumping normally go to STATUS 0 (or 1) of JUMP LEFT
					# CHECK SPIN JUMP?
					

					addi a1,a1, -4 # Offseting sprite's X so that it renders in propper place
					addi a2,a2, -6 # Offseting sprite's Y so that it renders in propper place
					li a3, 24  # Sprite's Widht
					li a4, 32  # Sprite's Height
					mv a6, t5	# Jump sprites have their status set to 1 if player is attacking
					bnez t4, RENDER_JUMP_LEFT_UP	# If player is looking up
					
					
					
					# Otherwise, render normal jump 
					la a0, Samus_Left_Jump # Loads Player's Image Address 
					j START_RENDER_PLAYER   # Start rendering player
					
					RENDER_JUMP_LEFT_UP:
						la a0, Samus_Left_Jump_Up # Loads Player's Image Address 
						j START_RENDER_PLAYER      # Start rendering player

				NOT_JUMP_LEFT:
					beqz t4, RENDER_MOVEMENT_LEFT
					j RENDER_MOVEMENT_LEFT_UP

					RENDER_MOVEMENT_LEFT:
						addi a1,a1, -8 # Offseting sprite's X so that it renders in propper place
						li a4, 32      # Sprite's Height
						beqz t5, RENDER_MOVEMENT_LEFT_NORMAL
						j RENDER_MOVEMENT_LEFT_ATTACK
						
						RENDER_MOVEMENT_LEFT_NORMAL:
							la a0, Samus_Left	   # Loads Player's Image Address 
							li a3, 28              # Sprite's Widht
							j START_RENDER_PLAYER  # Start rendering player
						
						RENDER_MOVEMENT_LEFT_ATTACK:
							la a0, Samus_Left_Attack  # Loads Player's Image Address 
							li a3, 28                  # Sprite's Widht
							j START_RENDER_PLAYER      # Start rendering player

					RENDER_MOVEMENT_LEFT_UP:
						addi a2,a2, -6 # Offseting sprite's X so that it renders in propper place
						li a3, 20      # Sprite's Widht
						li a4, 38      # Sprite's Height
						beqz t5, RENDER_MOVEMENT_LEFT_UP_NORMAL
						j RENDER_MOVEMENT_LEFT_UP_ATTACK
						
						RENDER_MOVEMENT_LEFT_UP_NORMAL:
							la a0, Samus_Left_Up  # Loads Player's Image Address
							j START_RENDER_PLAYER  # Start rendering player
						
						RENDER_MOVEMENT_LEFT_UP_ATTACK:
							la a0, Samus_Left_Up_Attack  # Loads Player's Image Address
							j START_RENDER_PLAYER         # Start rendering player
		
		RENDER_PLAYER_BALL:
			la a0, Morph_Ball # Loads morph ball image address
			addi a2, a2, tile_size # Adds 16 to Player's Y
			li a3, 16 # Loads 16 to width of rendering area
			li a4, 16 # Loads 16 to height of rendering area	
			# j START_RENDER_PLAYER

		START_RENDER_PLAYER:
			beqz tp, RENDER_PLAYER_SKIP_CROP # If tp is 0, don't crop image
				li t0,1    # To compare with tp (16 pixels to the left)
				beq t0,tp, RENDER_PLAYER_CROP_LEFT
				# RENDER_PLAYER_CROP_RIGHT:
				# Renders 16 pixels to the right
					mv s3,a3         # Moves sprite's width to s3
					mv s4,a4         # Moves sprite's height to s4
					li a3,tile_size  # New width of rendering area
					li a7,1          # Sets to crop mode
					sub s1,s3,a3     # Sets starting X to be 16 pixels before width of sprite's width
					li s2,0          # Sets starting Y on sprite to 0
					add a1,a1,s1     # Corrects player's starting X to be dislocated to the cropped X
					j RENDER_PLAYER_SKIP_CROP
				RENDER_PLAYER_CROP_LEFT:
				# Renders 16 pixels to the left
					mv s3,a3         # Moves sprite's width to s3
					mv s4,a4         # Moves sprite's height to s4
					li a3,tile_size  # New width of rendering area
					li a7,1          # Sets to crop mode
					li s1,0          # Sets starting X on sprite to 0 
					li s2,0          # Sets starting Y on sprite to 0	
			
			RENDER_PLAYER_SKIP_CROP:
				# Comparing if samus is on missile mode
				la t5, PLYR_INFO_2    # Loads address to PLYR_INFO_2
				lbu t5,0(t5)          # Loads missile enable byte
				beqz t5,RENDER_PLAYER_SKIP_MISSILE   # If player isn't in missile mode
					call RENDER    # Otherwise, render sprite byte by byte (to change color)
					j END_RENDER_PLAYER
				RENDER_PLAYER_SKIP_MISSILE:
					call RENDER_WORD	# Calls RENDER_WORD procedure
				END_RENDER_PLAYER:
				# Procedure finished: Loading Registers from Stack
					lw s1,0(sp)
					lw s2,4(sp)
					lw s3,8(sp)
					lw s4,12(sp)
					lw ra,16(sp)
					addi sp,sp,20
				# End of Stack Operations
					ret	   # End of procedure
		
	RENDER_PLAYER_TRAIL:
		xori a5,s0,1	# Gets oposite frame

		la t0, PLYR_MATRIX  # Loads PLYR_MATRIX address
		lbu t3, 1(t0) # Loads Player's old X related to matrix (Starting X for rendering (top left, related to Matrix))
		lbu t2, 3(t0) # Loads Player's old Y related to matrix (Starting Y for rendering (top left, related to Matrix))

		li a6, 2	    # Width (Number of Tiles) = 2
		li a7, 2	    # Height (Number of Tiles) = 2
		
		lbu t1,11(t0)    # Loads player's MOVE_Y
		sltu t1,zero,t1  # t1 != 0 ? t1 = 1 : t1 = 0
		lb t4,12(t0)     # Loads player's JUMP
		bge t4,zero,SKIP_JUMP_CORRECTION      # t4 < 0 ? t4 = 1 : t4 = 0
			li t1,1        # Will add 1 to the height
			sb zero,12(t0) # Sets JUMP to 0
		SKIP_JUMP_CORRECTION:
		add a7,a7,t1     # If player is moving vertically (t0 != 0), the height will increase by 1 
		
		lbu t0, 8(t0)   # Loads Player's morph ball status
		beqz t3,SKIP_MOVE_Y_RENDER_PLAYER_TRAIL   # If player is on leftmost side, don't increase the width
		# otherwise, move the trail area by 1 tile left and check if player isn't on rightmost side of map
		# in order to change the trail rendering width as needed 
			addi t3,t3,-1     # Moves X left by 1 tile
			la t1 CURRENT_MAP # Loads CURRENT_MAP address
			lw t1,0(t1)       # Gets current map's address
			lbu t1,1(t1)      # Gets current map's width
			sub t1,t1,t3      # t1 = Map's width - Player's old X related to matrix
			li t4,4           # t2 is used for comparing
			blt t1,t4,SET_NEW_WIDTH_RENDER_PLAYER_TRAIL # If t1 < 4, set the width to t1
			# Otherwise, set a6 to 3/4 (trail width limit)
			xori t1,t0,1	# If player is on morph ball (t0 = 1), t1 = 0 and vice versa
			addi a6,t1,3    # Width (Number of Tiles) = 3 (on morph ball) or 4 (not on morph ball)
			j SKIP_MOVE_Y_RENDER_PLAYER_TRAIL
			SET_NEW_WIDTH_RENDER_PLAYER_TRAIL:
				mv a6,t1    # Width (Number of Tiles) = t1 (t1 < 4)
		SKIP_MOVE_Y_RENDER_PLAYER_TRAIL:
		beqz t0, RENDER_PLAYER_TRAIL_STAND  # If player isn't on morph ball, go to RENDER_PLAYER_TRAIL_STAND
		j START_RENDER_PLAYER_TRAIL         # otherwise, player is on morph ball and go to START_RENDER_PLAYER_TRAIL
		
		RENDER_PLAYER_TRAIL_STAND:
			addi t2,t2,-1   # Moves Y up by 1 tile
			addi a7,a7,1    # Height (Number of Tiles) = 3 (if not jumping) or 4 (if jumping)
			j START_RENDER_PLAYER_TRAIL

		START_RENDER_PLAYER_TRAIL:
			mv s11, ra	# Moves ra to s11 -- so that we don't need to use the stack
			call SCENE_RENDER	# Calls SCENE_RENDER procedure
			mv ra, s11  # Returns s11 to ra -- so that we don't need to use the stack
			ret			# End of procedure

##########################    RENDER UI    ##########################
#              Renders life and weapons based on its usages                #
#     -----------           argument registers           -----------    #
#       a0,t0 = PLYR_HEALTH        #	
#		a1 = column
#		a2 = row
# 	    a3 = colors
#		a4 = frame
#		a7 = syscall for 'print integer'
#     -----------          temporary registers           -----------    #
#
# 	 ----------------------- description --------------------------
# 		this procedure is similar to a finite state machine, where samus 
# 		life points can be render according to her PLYR_HEALTH
#########################################################################	

RENDER_UI: 
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations

	la a0, Energy_UI    # Image address
	li a1,24            # Starting X (24)
	li a2,32            # Starting Y (32)
	li a3,24            # Gets width
	li a4,8             # Gets height
	mv a5,s0            # Gets frame
	li a6,0             # Only one sprite, so there's no status
	li a7,0             # Normal render
	call RENDER_WORD

	la t0, PLYR_INFO
	lb a0, 0(t0)          # Loads player's health
	bge a0,zero,SKIP_LIFE_CORRECTION
		li a0,0
	SKIP_LIFE_CORRECTION:
	li a1,48              # a1 = column
	li a2,32              # a2 = row 
	li a3,0xc7ff          # a3 = colors 
	mv a4,s0              # a4 = frame
	li a5,1               # Font
	li a7,101 # syscal for 'print integer'
	ecall

# Procedure finished: Loading Registers from Stack
	lw ra,0(sp)
	addi sp,sp,4
# End of Stack Operations   
	ret

##################            RENDER ENTITY             ##################
#                Renders entity, cropping if necessary                   #	
#        Note that, if a0 = 1, it will render the entities trail         #
#               and will take another set of arguments                   #
#                                                                        #		
#  ------------     argument registers (Normal Render)    -------------  #
#    a0 = Image Address                                                  #
#    a1 = X coordinate where rendering will start (top left)  -- screen  #
#    a2 = Y coordinate where rendering will start (top left)  -- screen  #
#    a3 = width of rendering area (usually the size of the sprite)       #
#    a4 = height of rendering area (usually the size of the sprite)      #
#    a5 = frame (0 or 1)                                                 #
#    a6 = status of sprite (usually 0 for sprites that are alone)        #
#    a7 = 0 - normal render or 1 - render trail                          #
#                                                                        #
#  -------------     argument registers (Render Trail)    -------------  #
#    a1 = old X coordinate related to matrix (top left)                  #
#    a2 = old X coordinate related to matrix (top left)                  #
#    a3 = width (Related to Matrix) of rendering area                    #
#    a4 = height (Related to Matrix) of rendering area                   #
#    a7 = 0 - normal render or 1 - render trail                          #
#                                                                        #		
#  ----------------           registers used           ----------------  #
#    a7 = operation (0 if normal printing, 1 cropped print)              #
#    s1 = X coordinate relative to sprite (top left)                     #
#    s2 = Y coordinate relative to sprite (top left)                     #
#    s3 = sprite width                                                   #
#    t0,t1 --> temporary registers                                       #
#                                                                        #
##########################################################################

RENDER_ENTITY:
bnez a7,RENDER_ENTITY_TRAIL # If a0 != 0, render trail
	li a7,0     # at the beginning, sprite doesn't need to be cropped
	li s1,0     # Setting s1 to 0, in case needs to crop but skips horizontal crop
	li s2,0     # Setting s2 to 0, in case needs to crop but skips vertical crop
	mv s3,a3    # Storing sprite's width in (in case needs to crop but skips horizontal crop)
	mv s4,a4    # Storing sprite's width in (in case needs to crop but skips horizontal crop)

	# Checking horizontal arguments (a1 - X and a3 - width)
	add t0,a1,a3   # t0 (rightmost X + 1) = top left X related to screen + rendering area width 
	bge zero,t0, END_RENDER_ENTITY # If t0 <= 0, sprite's outside of screen (don't try to render >:[ )
	li t1,screen_width # t1 = 320
	bge a1,t1, END_RENDER_ENTITY # If a1 >= 320, sprite's outside of screen (don't try to render >:[ )
	# Otherwise, sprite's X is inside screen, but there are two more X cases that need to be checked
		# 1 - is the top left X outside of left range?
		blt a1,zero,CORRECT_X_LEFT # If so, crop the image
		# 2 - is the top right X outside of right range?
		blt t1,t0,CORRECT_X_RIGHT # If so, crop the image
		j RENDER_ENTITY_CHECK_VERTICAL# Otherwise, the a1 and a3 arguments are already defined correctly, go check vertical		
		
		CORRECT_X_LEFT:
			li a7,1         # Sprite will need to be cropped
			sub s1,zero,a1  # s1 (X in sprite where rendering starts) will be the absolute value of a1

			add a3,a3,a1    # Since a1 will be negative, a3 will be reduced to a smaller width
			li a1,0         # and a1 will be set to 0 (leftmost X)  
			j RENDER_ENTITY_CHECK_VERTICAL # Go check vertical arguments		
			
		CORRECT_X_RIGHT:
			li a7,1         # Sprite will need to be cropped
			
			# a1 is inside the range, so it doesn't change
			sub t0,t0,t1  # t0 will hold the excess width (what passes through the right border)
			sub a3,a3,t0  # take away from width (a3) the excess
			# j RENDER_ENTITY_CHECK_VERTICAL # Go check vertical arguments

	RENDER_ENTITY_CHECK_VERTICAL:
		# Checking vertical arguments (a2 - Y and a4 - height)
		add t0,a2,a4   # t0 (lowermost Y + 1) = top left Y related to screen + rendering area height 
		bge zero,t0, END_RENDER_ENTITY # If t0 <= 0, sprite's outside of screen (don't try to render >:[ )
		li t1,screen_height # t1 = 240
		addi t1,t1,tile_size
		bge a2,t1, END_RENDER_ENTITY # If a2 >= 240, sprite's outside of screen (don't try to render >:[ )
		# Otherwise, sprite's Y is inside screen, but there are two more Y cases that need to be checked
			# 1 - is the topmost Y outside of upper range?
			blt a2,zero,CORRECT_Y_TOP # If so, crop the image
			# 2 - is the lowermost Y outside of bottom range?
			blt t1,t0,CORRECT_Y_BOTTOM # If so, crop the image
			j RENDER_ENTITY_START # Otherwise, the a2 and a4 arguments are already defined correctly, render	
			
			CORRECT_Y_TOP:
				li a7,1         # Sprite will need to be cropped
				sub s2,zero,a2  # s2 (Y in sprite where rendering starts) will be the absolute value of a2

				add a4,a4,a2    # Since a2 will be negative, a4 will be reduced to a smaller height
				li a2,0         # and a1 will be set to 0 (topmost Y)  
				j RENDER_ENTITY_START # render	
			
			CORRECT_Y_BOTTOM:
				li a7,1         # Sprite will need to be cropped
				
				# a2 is inside the range, so it doesn't change
				sub t0,t0,t1  # t0 will hold the excess height (what passes through the bottom border)
				sub a4,a4,t0  # take away from height (a4) the excess
				# j RENDER_ENTITY_START # render	
		
		RENDER_ENTITY_START:
			# All the arguments have already been adjusted beforehand, so begin rendering
		# Storing Registers on Stack
			addi sp,sp,-4
			sw ra,0(sp)
		# End of Stack Operations
			call RENDER 
		# Procedure finished: Loading Registers from Stack
			lw ra,0(sp)
			addi sp,sp,4
		# End of Stack Operations
			j END_RENDER_ENTITY

RENDER_ENTITY_TRAIL:
	li a0,0         # So that it renders map's trail
	xori a5,s0,1	# Gets oposite frame
	
	# Moving arguments
	mv t3,a1   # column where rendering will begin (X related to Matrix)
	mv t2,a2   # line where rendering will begin (Y related to Matrix)
	mv a6,a3   # width (Related to Matrix) of rendering area
	mv a7,a4   # height (Related to Matrix) of rendering area

	la tp,CURRENT_MAP # Loads CURRENT_MAP's address
	# Checking horizontal arguments (a1 - X and a3 - width)
	lbu t0,6(tp)   # loads map's current X  
	add t1,a1,a3   # t1 (rightmost X + 1) = top left X related to matrix + rendering area width 
	bge t0,t1, END_RENDER_ENTITY # If t1 <= map's current X, area is outside of screen (don't try to render >:[ )
	addi t4,t0,m_screen_width    # t1 = map's current X + 20
	blt a1,t4, END_RENDER_ENTITY # If a1 > map's current X + 20, area is outside of screen (don't try to render >:[ )
	#	slt t4,a1,t4    # X < current map's X ? t4 = 1 : t4 = 0
	#	lbu t5,8(tp)    # loads map's X offset 
	#	slt t5,zero,t5  # 0 < x offset ? t5 = 1 : t5 = 0
	#	xori t5,t5,1    # 0 < x offset ? t5 = 0 : t5 = 1 
	#	add t5,t5,t4    # t5 will only be 0 if both t4 and t5 were 0
	#bnez t5,END_RENDER_ENTITY # if not, finish procedure
	## Otherwise, continue rendering
	#	# t3 is already defined
	#	li a6,1  # since tile is at its limit, render only one horizontally
	#	j RENDER_ENTITY_TRAIL_CHECK_VERTICAL  # Check vertically
	
	#CONTINUE_RENDER_ENTITY_TRAIL:
	# Old X is inside screen, but there are two more X cases that need to be checked
		# 1 - is the left X outside of left range?
		blt a1,t0,CORRECT_X_LEFT_TRAIL # If so, reduce width
		# 2 - is the right X outside of right range?
		blt t4,t1,CORRECT_X_RIGHT_TRAIL # If so, reduce width
		j RENDER_ENTITY_TRAIL_CHECK_VERTICAL # Otherwise, the a1 and a3 arguments are already defined correctly, go check vertical		
		
		CORRECT_X_LEFT_TRAIL:
			sub t4,t0,a1    # t4 will have map's current X - Old X
			sub a6,a6,t4    # Reduce width
			mv t3,t0        # t3 will recieve map's current X  
			j RENDER_ENTITY_TRAIL_CHECK_VERTICAL  # Go check vertical arguments		
		
		CORRECT_X_RIGHT_TRAIL:
			# t3 is inside the range, so it doesn't change
			sub t4,t4,t1    # t4 = map's current X + 20 - (top left X related to matrix + rendering area width) 
			sub a6,a6,t4    # Reduce width
			lbu t4,8(tp)    # loads map's X offset 
			slt t4,zero,t4  # 0 < x offset ? t4 = 1 : t4 = 0
			add a6,a6,t4    # add 1 to width if offset != 0
			beqz a6, END_RENDER_ENTITY # if width is 0, end procedure
			# j RENDER_ENTITY_TRAIL_CHECK_VERTICAL # Go check vertical arguments

	RENDER_ENTITY_TRAIL_CHECK_VERTICAL:
		# Checking vertical arguments (a2 - Y and a4 - height)
		lbu t0,7(tp)   # loads map's current Y  
		add t1,a2,a4   # t1 (rightmost Y + 1) = top left Y related to matrix + rendering area width 
		bge t0,t1, END_RENDER_ENTITY # If t1 <= map's current Y, area is outside of screen (don't try to render >:[ )
		addi t4,t0,m_screen_height   # t1 = map's current Y + 15
		blt a2,t4, END_RENDER_ENTITY # If a2 > map's current Y + 15, area is outside of screen (don't try to render >:[ )
		# Old Y is inside screen, but there are two more Y cases that need to be checked
			# 1 - is the left Y outside of left range?
			blt a2,t0,CORRECT_Y_TOP_TRAIL # If so, reduce width
			# 2 - is the right Y outside of right range?
			blt t4,t1,CORRECT_Y_BOTTOM_TRAIL # If so, reduce width
			j RENDER_ENTITY_TRAIL_CHECK_VERTICAL # Otherwise, the a2 and a4 arguments are already defined correctly, go check vertical		
			
			CORRECT_Y_TOP_TRAIL:
				sub t4,t0,a1    # t4 will have map's current Y - Old Y
				sub a7,a7,t4    # Reduce height
				mv t2,t0        # t2 will recieve map's current Y  
				j RENDER_ENTITY_TRAIL_START  # Render trail
			
			CORRECT_Y_BOTTOM_TRAIL:
				# t2 is inside the range, so it doesn't change
				sub t4,t4,t1    # t4 = map's current Y + 20 - (top left Y related to matrix + rendering area width) 
				sub a7,a7,t4    # Reduce width
				lbu t4,9(tp)    # loads map's Y offset 
				slt t4,zero,t4  # 0 < Y offset ? t4 = 1 : t4 = 0
				add a7,a7,t4    # add 1 to width if offset != 0
				beqz a7, END_RENDER_ENTITY # if width is 0, end procedure
				# j RENDER_ENTITY_TRAIL_START # Render trail
		
		RENDER_ENTITY_TRAIL_START:
		# Storing Registers on Stack
			addi sp,sp,-4
			sw ra,0(sp)
		# End of Stack Operations
			call SCENE_RENDER	# Calls SCENE_RENDER procedure
		# Procedure finished: Loading Registers from Stack
			lw ra,0(sp)
			addi sp,sp,4
		# End of Stack Operations

END_RENDER_ENTITY:	
	ret


###############          RENDER DOOR UPDATE          ###############
#   Will render only the doors after a door needs to be updated    #
#                                                                  #		
#  ----------------        registers used        ----------------  #
#    a0 = Curent map's door address                                #
#    tp = CURRENT_MAP address (located on main.s)		           #
#    t0 = Number of doors on current map                           #
#    t1 = Loop counter                                             #
#    t2 -- t6 = Temporary Registers                                #
#    a0 -- a7 => used as arguments                                 #
#                                                                  #
####################################################################

RENDER_DOOR_UPDATE:
# Storing Registers on Stack
	addi sp,sp,-4
	sw ra,0(sp)
# End of Stack Operations
	la t0, Doors # Loads Doors address
	la tp, CURRENT_MAP # Loads CURRENT_MAP address
	lw a0,0(t0)   # Gets current map's doors address
	lbu t0,0(a0)  # Loads number of doors in this map
	addi a0,a0,1  # Goes to next byte (where doors from current map start)
	li t1,0       # Counter for doors
	
	# Loop that will search for doors in the screen and render them
	RENDER_DOOR_UPDATE_LOOP: 
		# RENDER_DOOR_UPDATE_LOOP_X_CHECK:
		lbu t3, 0(a0)        # Loads door's X on matrix
		lbu a1, 6(tp)        # Loads map's current X on matrix
		sub t4,t3,a1         # t4 = Door's X - Map's current X
		li t5,m_screen_width # Loads 20 (screen's width related to matrix)
		bgtu t5,t4,RENDER_DOOR_UPDATE_LOOP_Y_CHECK # If the result is between 0 and 19 (inclusive), continue on loop
		# Otherwise, check if t4 = 20 and X offset != 0
			bne t5,t4,GO_TO_NEXT_IN_RENDER_DOOR_UPDATE_LOOP   # If t4 != 20, iterate to next door
				lbu t4, 8(tp)                           # Loads map's X offset
				bnez t4,RENDER_DOOR_UPDATE_LOOP_Y_CHECK # If X offset != 0, continue on this loop
				GO_TO_NEXT_IN_RENDER_DOOR_UPDATE_LOOP:  # Otherwise,
				# As label says, iterate to next door
					j NEXT_IN_RENDER_DOOR_UPDATE_LOOP
		RENDER_DOOR_UPDATE_LOOP_Y_CHECK:
			lbu t2, 1(a0)    # Loads door's Y on matrix
			lbu a2, 7(tp)    # Loads map's current Y on matrix
			sub t4,t2,a2     # t4 = Door's top Y - Map's current Y
			li t5,-2               # Loads -2 (lower threshold)
			slt t6,t4,t5           # t6 will be 0 if t4 >= -2
			li t5,m_screen_height  # Loads 15 (screen's height related to matrix)
			slt t5,t5,t4           # t5 will be 0 if t4 <= 15
			add t5,t5,t6           # t5 = 0 only if -2 <= t4 <= 15 
			beqz t5, RENDER_DOOR_UPDATE_LOOP_Y_CHECK_2 # If -2 <= t4 <= 15, continue loop
			# Otherwise, iterate to next door
				j NEXT_IN_RENDER_DOOR_UPDATE_LOOP

			RENDER_DOOR_UPDATE_LOOP_Y_CHECK_2:
				bge t4,zero,RENDER_DOOR_UPDATE_LOOP_MIDDLE_TOP  # If t4 >= 0, go to RENDER_DOOR_UPDATE_LOOP_MIDDLE_TOP
				# Otherwise, t4 is less than 0 (t4 = -1 or -2), so 
					li t2,0        # starting Y will be set to 0
					addi a7,t4,3   # and height will be 1 (if t4 = -2) or 2 (if t4 = -1)
					j START_RENDER_DOOR_UPDATE

				RENDER_DOOR_UPDATE_LOOP_MIDDLE_TOP:
				# If t4 >= 0, check whether it's less than 13
					li t5, 13                                 
					bge t4,t5, RENDER_DOOR_UPDATE_LOOP_TOP_1
					# If t4 < 13, door should be rendered completely
						# t2 is already set (Y from map matrix where rendering will start from)
						li a7, 3    # Height of rendering area will be 3 in order to render it fully
						j START_RENDER_DOOR_UPDATE

					RENDER_DOOR_UPDATE_LOOP_TOP_1:
					# Otherwise, t4 >= 13, so check offset
						lbu a4, 9(tp)   # Loads current Y offset on Map	
						li t5,m_screen_height  # Loads 15 (screen's height related to matrix)
						sub a7,t5,t4    # a7 = Screen's Height (15) - (Door's Y - Map's current Y)    
						slt t5,zero,a4  # a4 > 0 ? t5 = 1 : t5 = 0 (only if a4 == 0)
						add a7,a7,t5    # a7 (height of rendering area) will be increased by 1 if the map's Y offset isn't 0
						bnez a7,START_RENDER_DOOR_UPDATE # If the result isn't equal to 0, continue to rendering this door
						# Otherwise, iterate to next door (can't render something with height = 0 :D )
							j NEXT_IN_RENDER_DOOR_UPDATE_LOOP		                        
					
		START_RENDER_DOOR_UPDATE:
		# Storing Registers on Stack
			addi sp,sp,-16
			sw t1,12(sp)
			sw t0,8(sp)
			sw tp,4(sp)
			sw a0,0(sp)
		# End of Stack Operations
			lw a0,0(tp)
			# a1 is already set (X in map matrix that corresponds to 0x0 on the screen matrix)
			# a2 is already set (Y in map matrix that corresponds to 0x0 on the screen matrix)
			lbu a3, 8(tp)   # Loads current X offset on Map
			lbu a4, 9(tp)   # Loads current Y offset on Map	
			mv a5, s0		# Frame = s0
			li a6, 1        # Width of rendering area will always be 1
			# a7 is already set (height of rendering area)
			# t3 is already set (X from map matrix where rendering will start from)
			# t2 is already set (Y from map matrix where rendering will start from)
			li tp, 0        # Map won't be dislocated		
			call RENDER_MAP
		# Procedure finished: Loading Registers from Stack
			lw t1,12(sp)
			lw t0,8(sp)
			lw tp,4(sp)
			lw a0,0(sp)
			addi sp,sp,16
		# End of Stack Operations
		NEXT_IN_RENDER_DOOR_UPDATE_LOOP:                                  
			addi a0,a0,4 # Going to the next door's address                                  
			addi t1,t1,1 # Iterating counter by 1                                   
			bge t1,t0, END_RENDER_DOOR_UPDATE # If all of the map's doors were checked, end loop                                  
			j RENDER_DOOR_UPDATE_LOOP # otherwise, go back to the loop's beginning                     
    
	END_RENDER_DOOR_UPDATE: 
		# Procedure finished: Loading Registers from Stack
			lw ra,0(sp)
			addi sp,sp,4
		# End of Stack Operations
			ret

###############          RENDER DOOR FRAMES          ###############
#       Will render only the door frames (used for rendering       #
#        on top of player's sprite). It takes no arguments         #	
#                                                                  #		
#  ----------------        registers used        ----------------  #
#    a0 = Curent map's frame address                               #
#    tp = CURRENT_MAP address (located on main.s)		           #
#    t0 = Number of door frames on current map                     #
#    t1 = Loop counter                                             #
#    t2 -- t6 = Temporary Registers                                #
#    a0 -- a7 => used as arguments                                 #
#                                                                  #
####################################################################

RENDER_DOOR_FRAMES:
# Storing Registers on Stack
	addi sp,sp,-4
	sw ra,0(sp)
# End of Stack Operations
	la t0, Frames # Loads Frames address
	la tp, CURRENT_MAP # Loads CURRENT_MAP address
	lw a0,0(t0)   # Gets current map's frames address
	lbu t0,0(a0)  # Loads number of door frames in this map
	addi a0,a0,1  # Goes to next byte (where door frames from current map start)
	li t1,0       # Counter for door frames
	
	# Loop that will search for door frames in the screen and render them
	RENDER_DOOR_FRAMES_LOOP: 
		# RENDER_DOOR_FRAMES_LOOP_X_CHECK:
		lbu t3, 0(a0)        # Loads door frame's X on matrix
		lbu a1, 6(tp)        # Loads map's current X on matrix
		sub t4,t3,a1         # t4 = Door frame's X - Map's current X
		li t5,m_screen_width # Loads 20 (screen's width related to matrix)
		bgtu t5,t4,RENDER_DOOR_FRAMES_LOOP_Y_CHECK # If the result is between 0 and 19 (inclusive), continue on loop
		# Otherwise, check if t4 = 20 and X offset != 0
			bne t5,t4,GO_TO_NEXT_IN_RENDER_DOOR_FRAMES_LOOP   # If t4 != 20, iterate to next door
				lbu t4, 8(tp)                           # Loads map's X offset
				bnez t4,RENDER_DOOR_FRAMES_LOOP_Y_CHECK # If X offset != 0, continue on this loop
				GO_TO_NEXT_IN_RENDER_DOOR_FRAMES_LOOP:  # Otherwise,
				# As label says, iterate to next door frame
					j NEXT_IN_RENDER_DOOR_FRAMES_LOOP
		RENDER_DOOR_FRAMES_LOOP_Y_CHECK:
			lbu t2, 1(a0)    # Loads door frame's Y on matrix
			lbu a2, 7(tp)    # Loads map's current Y on matrix
			sub t4,t2,a2     # t4 = Door frame's top Y - Map's current Y
			li t5,-2               # Loads -2 (lower threshold)
			slt t6,t4,t5           # t6 will be 0 if t4 >= -2
			li t5,m_screen_height  # Loads 15 (screen's height related to matrix)
			slt t5,t5,t4           # t5 will be 0 if t4 <= 15
			add t5,t5,t6           # t5 = 0 only if -2 <= t4 <= 15 
			beqz t5, RENDER_DOOR_FRAMES_LOOP_Y_CHECK_2 # If -2 <= t4 <= 15, continue loop
			# Otherwise, iterate to next door frame
				j NEXT_IN_RENDER_DOOR_FRAMES_LOOP

			RENDER_DOOR_FRAMES_LOOP_Y_CHECK_2:
				bge t4,zero,RENDER_DOOR_FRAMES_LOOP_MIDDLE_TOP  # If t4 >= 0, go to RENDER_DOOR_FRAMES_LOOP_MIDDLE_TOP
				# Otherwise, t4 is less than 0 (t4 = -1 or -2), so 
					li t2,0        # starting Y will be set to 0
					addi a7,t4,3   # and height will be 1 (if t4 = -2) or 2 (if t4 = -1)
					j START_RENDER_DOOR_FRAMES

				RENDER_DOOR_FRAMES_LOOP_MIDDLE_TOP:
				# If t4 >= 0, check whether it's less than 13
					li t5, 13                                 
					bge t4,t5, RENDER_DOOR_FRAMES_LOOP_TOP_1
					# If t4 < 13, door frame should be rendered completely
						# t2 is already set (Y from map matrix where rendering will start from)
						li a7, 3    # Height of rendering area will be 3 in order to render it fully
						j START_RENDER_DOOR_FRAMES

					RENDER_DOOR_FRAMES_LOOP_TOP_1:
					# Otherwise, t4 >= 13, so check offset
						lbu a4, 9(tp)   # Loads current Y offset on Map	
						li t5,m_screen_height  # Loads 15 (screen's height related to matrix)
						sub a7,t5,t4    # a7 = Screen's Height (15) - (Door frame's Y - Map's current Y)    
						slt t5,zero,a4  # a4 > 0 ? t5 = 1 : t5 = 0 (only if a4 == 0)
						add a7,a7,t5    # a7 (height of rendering area) will be increased by 1 if the map's Y offset isn't 0
						bnez a7,START_RENDER_DOOR_FRAMES # If the result isn't equal to 0, continue to rendering this door frame
						# Otherwise, iterate to next door frame (can't render something with height = 0 :D )
							j NEXT_IN_RENDER_DOOR_FRAMES_LOOP		                        
					
		START_RENDER_DOOR_FRAMES:
		# Storing Registers on Stack
			addi sp,sp,-16
			sw t1,12(sp)
			sw t0,8(sp)
			sw tp,4(sp)
			sw a0,0(sp)
		# End of Stack Operations
			lw a0,0(tp)
			# a1 is already set (X in map matrix that corresponds to 0x0 on the screen matrix)
			# a2 is already set (Y in map matrix that corresponds to 0x0 on the screen matrix)
			lbu a3, 8(tp)   # Loads current X offset on Map
			lbu a4, 9(tp)   # Loads current Y offset on Map	
			mv a5, s0		# Frame = s0
			li a6, 1        # Width of rendering area will always be 1
			# a7 is already set (height of rendering area)
			# t3 is already set (X from map matrix where rendering will start from)
			# t2 is already set (Y from map matrix where rendering will start from)
			li tp, 0        # Map won't be dislocated		
			call RENDER_MAP
		# Procedure finished: Loading Registers from Stack
			lw t1,12(sp)
			lw t0,8(sp)
			lw tp,4(sp)
			lw a0,0(sp)
			addi sp,sp,16
		# End of Stack Operations
		NEXT_IN_RENDER_DOOR_FRAMES_LOOP:                                  
			addi a0,a0,6 # Going to the next door frame's address                                  
			addi t1,t1,1 # Iterating counter by 1                                   
			bge t1,t0, END_RENDER_DOOR_FRAMES # If all of the map's doors were checked, end loop                                  
			j RENDER_DOOR_FRAMES_LOOP # otherwise, go back to the loop's beginning                     
    
	END_RENDER_DOOR_FRAMES: 
		# Procedure finished: Loading Registers from Stack
			lw ra,0(sp)
			addi sp,sp,4
		# End of Stack Operations
			ret


###############################          RENDER MAP          ##############################
#    Takes a given map matrix and renders tiles acoording to the value stored on it.      #
#   -- t2 and t3 are recieved as arguments:                                               #
#       > t2: line where rendering will begin (Y related to Matrix)                       #
#       > t3: column where rendering will begin (X related to Matrix)                     #
#   -- the arguments t2 and t3 are related to the full matrix, and not the 20 x 15        # 
#       screen matrix. They'll later be converted to the line and column related to       #
#       the screen sized matrix.                                                          #
#       Obs.: If you aren't rendering a sprite's trail, set t2 and t3 to 0                # 	
#     -------------               argument registers                  -------------       #
#       a0 = Map Matrix Address                                                           #
#       a1 = starting X on Matrix (top left)                                              #
#       a2 = starting Y on Matrix (top left)                                              #	
#       a3 = X offset (0, 4, 8, 12)                                                       #
#       a4 = Y offset (0, 4, 8, 12)                                                       #	 		  
#       a5 = frame (0 or 1)                                                               #
#       a6 = width (Related to Matrix) of rendering area                                  #
#       a7 = height (Related to Matrix) of rendering area                                 #
#       tp = X dislocation factor (how many tiles should rendering be shifted to)         #
#                                                                                         #
#     -------------            saved registers (uses stack)           -------------       #
#       s0 = current X and Y address on Matrix                                            #
#       s1 = Matrix Width                                                                 #
#       s2 = Y where line loop will stop                                                  #
#       s3 = X where column loop will stop                                                #
#                                                                                         #			
#     -------------                temporary registers                -------------    	  #
#       t0 = temporary operations (in the beginning, it has the address of tile to render) #
#       t1 = tile to be rendered                                                          #				
#       t2 = line counter (and also current Y) related to Matrix                          #
#       t3 = column counter (and also current X) related to Matrix                        #
#       t4 = temporary register for moving info                                           #
#       t5 = temporary register for moving info                                           #
#       t6 = temporary register for moving info                                           #
#                                                                                         #
###########################################################################################
RENDER_MAP:
# Storing Registers on Stack
	addi sp,sp,-20
	sw ra,16(sp)
	sw s3,12(sp)
	sw s2,8(sp)
	sw s1,4(sp)
	sw s0,0(sp)
# End of Stack Operations
	addi t0,a0,3 	# skips first 3 bytes of information (goes to the actual matrix)
	add s0, t0, a1 	# s0 = Matrix Address + Starting X on Matrix
	lbu s1,1(a0)	# s1 = matrix width
	mul t0,s1,a2    # t0 = Matrix Width x Starting Y on Matrix
	add s0, s0, t0	# s0 = Address to current X and Y on Matrix
	
	RENDER_MAP_GetCurrentX:
	add s3,t3,a6 	# s3 will be compared with t3 (column counter) to go to next line
	beqz t3,RENDER_MAP_NoTrailX
	
	sub t3,t3,a1	# t3 now is the column counter related to the screen matrix
	add s3,t3,a6
	add s0, s0, t3 	# s0 = Matrix Address + Current X on Matrix
	j RENDER_MAP_GetCurrentY
	
	RENDER_MAP_NoTrailX:
	beqz a3, RENDER_MAP_GetCurrentY # If there's no X offset
	li t0, m_screen_width
	blt a6,t0, RENDER_MAP_GetCurrentY   # If width of rendering area is smaller than the screen's width, ignore
	blt zero,tp, RENDER_MAP_GetCurrentY # If map is dislocated, ignore the next step
	add t1,a1,a6    # t1 = Starting X + Width in tiles
	beq t1,s1, RENDER_MAP_GetCurrentY   # If map is on furthest X to the right, don't increase width
	addi s3,t0,1	# if rendering a full screen (20 wide) with offset, will need to render 21 tiles
		
	RENDER_MAP_GetCurrentY:
	add s2,t2,a7 	# s2 will be compared with t2 (column counter) to go to next line
	beqz t2,RENDER_MAP_NoTrailY
	
	sub t2,t2,a2	# t2 now is the column counter related to the screen matrix
	add s2,t2,a7
	mul t0,s1,t2    # t0 = Matrix Width x Current Y on Matrix
	add s0, s0, t0	# s0 = Address to current X and Y on Matrix
	j RENDER_MAP_LOOP
	
	RENDER_MAP_NoTrailY:
	beqz a4, RENDER_MAP_LOOP # If there's an X offset
	li t0, m_screen_height
	blt a7,t0 RENDER_MAP_LOOP # If height of rendering area is smaller than the screen's height, ignore
	addi s2,t0,1	# if rendering a full screen (15 wide) with offset, will need to render 16 tiles
	
RENDER_MAP_LOOP:
	lbu t1,0(s0)	# loads byte stored on matrix for checking what is the tile
	bnez t1,NotBackground
	j CONTINUE_RENDER_MAP

	NotBackground:
		li t0, 40      # Value where doors start
		bge t1, t0, RENDER_DOOR # If it's a door
		li t0,1
		beq t0,t1, RENDER_BREAK_BLOCK
		la t0, Tileset # Loads Tileset address to t0
		addi t1,t1,-1  # t1 = Tile Number - 1 (so that if t1 = 1, 0 tiles will be skipped)
		slli t1,t1,8   # t1 = (Tile Number - 1) x 256
		add t0,t0,t1   # t0 will skip (Tile Number - 1) x 256 bytes (Tile Number - 1 tiles)
		mv t4,zero     # t4 will hold the tile's sprite status (which will be zero)
		j CONTINUE_RENDER_MAP

	RENDER_BREAK_BLOCK:
		la t4,NEXT_MAP # Loads NEXT_MAP address
		lbu t5,10(t4)  # Gets the Render Next Map byte	
		beqz t5, RENDER_BREAK_BLOCK_CURRENT   # If Render Next Map Door == 0, render current map's door
		# Otherwise, Render Next Map Door == 1, so render next map's door
			la t0,Blocks_Next  # Loads blocks address
			lw t0,0(t0)        # and loads the breakable block address
			j CONTINUE_RENDER_BREAK_BLOCK
		RENDER_BREAK_BLOCK_CURRENT:
		# Renders current map's door
			la t0,Blocks  # Loads blocks address
			lw t0,0(t0)   # and loads the breakable block address
			# j CONTINUE_RENDER_BREAK_BLOCK

		CONTINUE_RENDER_BREAK_BLOCK:
			beqz t0,RENDER_BREAK_BLOCK_BACKGROUND
		
		RENDER_BREAK_BLOCK_CHECK:
			lbu t5,1(t0)  # Gets Y where blocks start
			sub t5,t2,t5  # Sets current Y to be related to Y where blocks start
			add t5,t5,a2  # Corrects Y adding starting Y

			lbu t4,2(t0)  # Loads width
			mul t4,t4,t5  # and multiplies it by current Y	

			lbu t5,0(t0)  # Gets X where blocks start
			sub t5,t3,t5  # Sets current X to be related to X where blocks start
			add t5,t5,a1  # Corrects X adding starting X

			add t4,t5,t4  # adds X to it

			addi t0,t0,4  # Skip first 4 information bytes
			add t0,t4,t0  # and adds t4 to it
			
			lbu t4,0(t0)  # Loads t0 
			bnez t4, RENDER_BREAK_BLOCK_CHECK_EXPLOSION # If block isn't full, see if it's exploding
				la t0, Tileset # Loads Tileset address to t0
				mv t4,zero     # t4 will hold the tile's sprite status (which will be zero)
				j CONTINUE_RENDER_MAP  # Otherwise, render it

			RENDER_BREAK_BLOCK_CHECK_EXPLOSION: li t5,1
			bne t4, t5, RENDER_BREAK_BLOCK_CHECK_EXPLOSION_2 # If block isn't in the first phase of breaking, see if it's in the second phase
				addi t4,t4,1 # Sets block up for next phase
				sb t4,0(t0)  # and stores it
				la t0, BreakBlock_Break1 # Loads BreakBlock_Break1 address to t0
				mv t4,zero               # t4 will hold the tile's sprite status (which will be zero)
				j CONTINUE_RENDER_MAP    # Otherwise, render it
			
			RENDER_BREAK_BLOCK_CHECK_EXPLOSION_2: li t5,1
			bne t4, t5, RENDER_BREAK_BLOCK_BACKGROUND # If block is destroyed, don't render it
				addi t4,t4,1 # Sets block up for next phase
				sb t4,0(t0)  # and stores it
				la t0, BreakBlock_Break2 # Loads BreakBlock_Break2 address to t0
				mv t4,zero               # t4 will hold the tile's sprite status (which will be zero)
				j CONTINUE_RENDER_MAP    # Otherwise, render it

			RENDER_BREAK_BLOCK_BACKGROUND:
				li t1,0   # Won't render
				j CONTINUE_RENDER_MAP

	RENDER_DOOR: 
	# Storing tp on stack cuz we don't really have any registers to use anymore :/
		addi sp,sp,-4
		sw tp,0(sp)
	# End of stack operations, begin:
		# Preparations for loop 
		mv t6,zero     # Resets counter
		la t4,NEXT_MAP # Loads NEXT_MAP address
		lbu t5,10(t4)  # Gets the Render Next Map Door byte	
		beqz t5, RENDER_DOOR_CURRENT   # If Render Next Map Door == 0, render current map's door
		# Otherwise, Render Next Map Door == 1, so render next map's door
			la t4, Doors_Next # Loads Doors_Next address
			lw t4,0(t4)	      # Gets the next map's door address
			lbu t5,0(t4)      # Gets the number of doors in this map
			addi t4,t4,1      # Starting address of the map's first door
			j RENDER_DOOR_LOOP
		RENDER_DOOR_CURRENT:
		# Renders current map's door
			la t4, Doors # Loads Doors address
			lw t4,0(t4)	 # Gets the current map's door address
			lbu t5,0(t4) # Gets the number of doors in this map
			addi t4,t4,1 # Starting address of the map's first door
			# j RENDER_DOOR_LOOP
		RENDER_DOOR_LOOP:
			# Checking if current door will be rendered
			lbu tp, 0(t4) # Loads door's X on matrix
			add t0,a1,t3  # Gets current X on map matrix
			bne tp, t0, NEXT_IN_DOOR_LOOP # If door's X isn't the same as current X, skip this door
			lbu tp, 1(t4) # Loads door's Y on matrix
			add t0,a2,t2  # Gets current Y on map matrix
			sub tp,t0,tp  # tp needs to be equal to 0, 1 or 2 in order to be a tile from this door
			li t0,2 # 2 is the threshold to be compared with tp
			bgtu tp,t0, NEXT_IN_DOOR_LOOP # If current Y is above the door's uppermost Y or bellow it's downmost Y, skip this door
			# If none of the conditions on the branches were met, this current door will be rendered
			lbu tp, 2(t4) # Loads door's state
			bge tp,t0, END_RENDER_DOOR_LOOP # If door is open (state = 2 -- >= 2 for containing errors)
			# Otherwise, check the following
				la t0, Tileset # Loads Tileset address to t0
				addi t1,t1,-1  # t1 = Tile Number - 1 (so that if t1 = 1, 0 tiles will be skipped)
				add t1,t1,tp   # t1 will change if door is opening (tp = 1)
				slli t1,t1,8   # t1 = (Tile Number - 1) x 256
				add t0,t0,t1   # t0 will skip (Tile Number - 1) x 256 bytes (Tile Number - 1 tiles) 
				j END_RENDER_DOOR_LOOP_GLOBAL
			NEXT_IN_DOOR_LOOP:
				addi t4,t4,4 # Going to the next door's address
				addi t6,t6,1 # Iterating counter by 1
				bge t6,t5, END_RENDER_DOOR_LOOP # If all of the map's doors were checked, end loop
				j RENDER_DOOR_LOOP # otherwise, go back to the loop's beginning
	END_RENDER_DOOR_LOOP:
	# This is only reached if no door was found (error) or if door is open, so background color will be rendered
		mv t1,zero
	END_RENDER_DOOR_LOOP_GLOBAL: # After any case of the loop, go here
	# Restoring tp from stack
		mv t4,zero    # t4 will hold the tile's sprite status (which will be zero)
		lw tp,0(sp)
		addi sp,sp,4
	# End of stack operations, begin:
		
	CONTINUE_RENDER_MAP:
	# Storing Registers on Stack
	addi sp,sp,-56
	sw s4,52(sp)
	sw s3,48(sp)
	sw s2,44(sp)
	sw s1,40(sp)
	sw a7,36(sp)
	sw a6,32(sp)
	sw a4,28(sp)
	sw a3,24(sp)
	sw a2,20(sp)
	sw a1,16(sp)
	sw a0,12(sp)
	sw t2,8(sp)
	sw t3,4(sp)
	sw tp,0(sp)
	# End of Stack Operations

	mv a0, t0 # Moves t0 (storing tile address) to a0
	mv a6,t4  # Moves tmv t4 (tile's sprite status) to a6
	          # +--> a6 will be always set to zero when in color mode afterwards 
	# Defining rendering coordinates
	li t0, tile_size 	# Tile size = 16
	add t6,tp,t3        # t6 gets t3 (current X) + tp (X dislocation)
	mul t4,t6,t0		# t4 gets the X value relative to the screen ((t3 + tp) * tile size)
	mul t5,t2,t0		# t5 gets the Y value relative to the screen (t2 (current Y) * tile size)
	# Obs.: don't use t4 and t5 until stack is saved, unless it's related to rendering coordinates
	li t6,0
	bnez a3, X_Offset 	# If there's a X offset
	j Check_Y_Offset
	X_Offset:
		add t0,t3,tp
		bnez t0, TryRightOffset  # If t3 (current colum, i.e., current X) = 0, it's on the left border
		li t6,1			         # t6 = 1: Cropping leftmost tile
		j START_RENDER_MAP  	 # start rendering process
		TryRightOffset:
		li t0, m_screen_width    # screen width related to matrix = 20
		sub t0,t0,t3             # t0 = screen width - t3 (current X) 
		sub t0,t0,tp             # t0 = screen width - t3 (current X) - tp (X dislocation) 
		bne zero, t0, NoX_Offset # If t0 <= 0 (t3 + tp >= 20), it's on the right border
		li t6,2			 # t6 = 2: Cropping rightmost tile
		NoX_Offset:
		j START_RENDER_MAP	 # start rendering process
	
	Check_Y_Offset:
	bnez a4, Y_Offset		 # Or a Y offset, go to offset operations
	j START_RENDER_MAP
	
	Y_Offset:
		bnez t2, TryBottomOffset # If t3 (current colum, i.e., current X) = 0, it's on the top border
		li t6,1			 # t6 = 1: Cropping uppermost tile
		j START_RENDER_MAP	 # start rendering process
		TryBottomOffset:
		li t0, m_screen_height   # screen height related to matrix = 15
		bne t2, t0, NoY_Offset   # If t2 = 15, it's on the lower border
		li t6,2			 # t6 = 2: Cropping lowermost tile
		NoY_Offset:
		j START_RENDER_MAP	 # start rendering process
	
	START_RENDER_MAP:
	bnez t1,NormalRender
	# Color Render
		li a0, 0x00 		# Black
		mv a1, t4		# Top Left X
		mv a2, t5		# Top Left Y	
		mv a6, zero
		# a5 doesn't change
		bnez t6, CropColor 
		j NoCropColor
		CropColor:
		li a6, 1
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
		# a6 was already set (Tiles usually have one image, thus their status is allways 0  -- there are exceptions)
		# If no offset is taken into account, will skip unecessary parameters  
		bnez t6, Continue_Crop 
		j Skip_Offset
		Continue_Crop: 
		li a7,1			# Cropped Render operations
		addi t6,t6,-1		# After this, t6 = 0 or t6 = 1
		bnez t6, RightBottomCrop
		LeftTopCrop:	 # Will crop tile from the left or from the top
			mv s1, a3		# s1 will store the X offset (where rendering will start from)
			mv s2, a4		# s2 will store the Y offset (where rendering will start from)
			li s3, tile_size	# s3 = 16
			li s4, tile_size	# s4 = 16
			sub a3,s3, s1		# a3 will hold rendering widht that is equal to the tile size (16) - X offset
			sub a4,s3, s2		# a4 will hold rendering height that is equal to the tile size (16) - Y offset
			j Start_NormalRender
		RightBottomCrop: # Will crop tile from the right or bottom
			mv s1,zero		# s1 = 0 (rendering will start from the left)
			mv s2,zero		# s2 = 0 (rendering will start from the top)
			li s3, tile_size	# s3 = 16
			li s4, tile_size	# s4 = 16
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
		mv a7,zero		# Normal Render operations
		Start_NormalRender:
		call RENDER_WORD
	
	EndRender:
# Procedure finished: Loading Registers from Stack
	lw s4,52(sp)
	lw s3,48(sp)
	lw s2,44(sp)
	lw s1,40(sp)
	lw a7,36(sp)
	lw a6,32(sp)
	lw a4,28(sp)
	lw a3,24(sp)
	lw a2,20(sp)
	lw a1,16(sp)
	lw a0,12(sp)
	lw t2,8(sp)
	lw t3,4(sp)
	lw tp,0(sp)
	addi sp,sp,56
# End of Stack Operations
			
	addi t3,t3,1	# Increments column counter (current X on Matrix)
	addi s0,s0,1	# Goes to next byte
	bge t3,s3,CONTINUE_LINE	# if column counter >= width, repeat
	j RENDER_MAP_LOOP	# if column counter < width, repeat
	
	CONTINUE_LINE:
		add s0,s0,s1	# s0 = Current Address on Matrix + Matrix Width
		li t0, m_screen_width
		bge a6,t0, MINUS_WIDTH # If width = 20, probably not on remove trail mode
		sub s0,s0,a6	# s0 = New Current Address on Matrix 
		sub t3,t3,a6	# t3 = 0 (resets column counter)
		j CONTINUE_LINE2
		MINUS_WIDTH:
		sub s0,s0,s3
		mv t3,zero	# t3 = 0 (resets column counter)
		
		CONTINUE_LINE2:
		addi t2,t2,1	# Increments line counter (current Y on Matrix)
		bge t2,s2,CONTINUE_COLUMN # If height > line counter, repeat
		j RENDER_MAP_LOOP	  # Return to beggining of loop
		CONTINUE_COLUMN:
	# Procedure finished: Loading Registers from Stack
		lw ra,16(sp)	
		lw s3,12(sp)
		lw s2,8(sp)
		lw s1,4(sp)
		lw s0,0(sp)
		addi sp,sp,20
	# End of Stack Operations: Return to caller		
		ret
