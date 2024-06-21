.data

####### Informations related to frame rate  ####### 
.eqv frame_rate 65 # T ms por frame 
RUN_TIME: .word 0 # Guarda quanto tempo passou 
####### .eqv related to tiles  ####### 
.eqv tile_size 16	# Tile size (use powers of 2 in order to use tile_size_shift)
.eqv tile_size_shift 4  # Power value that gives tile size (2^tile_size_shift = tile_size)

####### .eqv related to screen  ####### 
.eqv m_screen_width 20
.eqv m_screen_height 15
.eqv left_hor_border 119
.eqv right_hor_border 184
.eqv top_ver_border 64
.eqv bottom_ver_border 176
####### Map informations ####### 
CURRENT_MAP: .word 0
MAP_INFO: .byte 1, 0, # num_map, (0 - don't render, 1 - render once, 2 - render twice, 3 - switch map)
                23, 0 # x of matrix, y of matrix
                8, 0 # X, and Y Tile Offset (0, 4, 8 or 12)

####### Player informations #########
PLYR_INFO: .byte 100, 0 # Stores player's health points, number of habilities (0 - none, 1 - ball, 2 - ball + bomb)
PLYR_POS: .half 152, 0  # Stores Player's current and old top left X respectively, both related to the screen  
		  .byte 160, 0,   # Stores Player's current and old top left Y respectively, both related to the screen 
		        0, 0 # Stores Player's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)

PLYR_MATRIX: .byte 33, 0, 10, 0 # Stores Player's top left new and old X and new and old Y respectively, all related to the map matrix 
PLYR_STATUS: .byte 0,0,0,0 # Sprite's Number, Horizontal Direction (0 = Right, 1 = Left), Vertical Direciton (0 - Normal, 1 - Facing Up), Ground Postition (0 - On Ground, 1 - Freefall)
				   0,0 # Ball Mode (0 - Disabled, 1 - Enabled), Attacking (0 - no, 1 - yes) 

MOVE_X: .byte 0 # -1 left, 1 right, 0 not moving on X axis
MOVE_Y: .byte 0 # -1 up, 1 down, 0 not moving on Y axis
JUMP: .byte 0 # counter of current height
PLYR_INPUT: .byte 0

.eqv max_jump 96
.eqv slow_jump 80
.eqv min_jump 32
.eqv gravity 1


.eqv standing_front_hitbox 8 # offset from the front of Samus' standing sprite 
.eqv standing_back_hitbox 4  # offset from the back of Samus' standing sprite 
.eqv PLYR_HEALTH 100
.eqv SAM_WALK 20
.eqv SAM_SHOOT 28
.eqv SAM_BALL 16 


## ZOOMER ##
ZOOMER_INFO: .byte 0, 0 # Stores Zoomer's health points, Rendering (0 - Disabled, 1 - Enabled)
ZOOMER_POS: .half 240, 0 # Stores Zoomer's current and old top left X respectively, both related to the screen  
		    .byte 96, 0 # Stores Zoomer's current and old top left Y respectively, both related to the screen 
	     		  0, 0 # Stores Zoomer's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
ZOOMER_MATRIX: .byte 0, 0, 0, 0 # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
ZOOMER_STATUS: .byte 0,0 # Sprite's Number, Movement Direction (Clockwise: 0 - Right/Top, 1 - Down/Right, 2 - Left/Bottom, 3 - Up/Left and
			 #                                      Counter-Clockwise: 4 - Left/Top, 5 - Down/Left, 6 - Right/Bottom, 7 - Up/Right)
.eqv ZOOMER_HEALTH 50

## RIPPER ##
RIPPER_INFO: .byte 0, 0 # Stores Ripper's health points, Rendering (0 - Disabled, 1 - Enabled)
RIPPER_POS: .half 80, 0 # Stores Ripper's current and old top left X respectively, both related to the screen  
	  		.byte 180, 0 # Stores Ripper's current and old top left Y respectively, both related to the screen 
	   		  	  0, 0 # Stores Ripper's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
RIPPER_MATRIX: .byte 0, 0, 0, 0 # Stores Ripper's top left new and old X and new and old Y respectively, all related to the map matrix 
RIPPER_STATUS: .byte 0,0 # Sprite's Number, Movement Direction (0 = Right, 1 = Left)
.eqv ZOOMER_HEALTH 50

## RIDLEY ##
RIDLEY_INFO: .byte 0, 0 # Stores Ridley's health points, Rendering (0 - Disabled, 1 - Enabled)
RIDLEY_POS: .half 80, 0 # Stores Ridley's current and old top left X respectively, both related to the screen  
	    .byte 180, 0 # Stores Ridley's current and old top left Y respectively, both related to the screen 
RIDLEY_MATRIX: .byte 0, 0, 0, 0 # Stores Ridley's top left new and old X and new and old Y respectively, all related to the map matrix 
RIDLEY_STATUS: .byte 0,0 # Sprite's Number, Ground Position (0 - On Ground, 1 - Freefall)
.eqv RIDLEY_HEALTH 200