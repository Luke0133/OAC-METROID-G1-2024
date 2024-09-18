.include "helpers/MACROSv24.s" # Macros para bitmap display
.include "helpers/data.s"
#.include "helpers/dataold.s"

# 34 --> 240 
.data
DEBUG: .string "\n"
DEBUG2: .string " x "
DEBUG1: .string "rarara\n"
DEBUG12: .string "rarara -> "
DEBUG11: .string "pasou\n"
		
.text
main:
	li s0, 0  # Initial frame
	li s1, 0  # Reseting time
	li s2, 1  # Game loop state 
	li s3, 0  # Select state

	la t0, GRAVITY_FACTOR
	flw fs0,0(t0)
	la t0, JUMP_SPEED
	flw fs1,0(t0)
	
	la t0, RIDLEY_JUMP_SPEED
	flw fs3,0(t0)

	j SETUP

##########################    GAME LOOP    ##########################
#                Main operations for the game to run                #
#  --------------          saved registers          --------------  #
#       s0 = current frame                                          #
#       s1 = last frame time                                        #
#       s2 = scene player's at (0 - menu1, 1 - menu2, 2 - game,     #
#            3 - game over)                                         #
#       s3 = menu select (for menu2)                                #
#       s11 = stores return address in some procedures              #
#                                                                   #
#  --------------          float registers          --------------  #
#    fs0 = gravity factor (const)                                   #
#    fs1 = player's initial jump speed (const)                      #
#    fs2 = player's Y speed (positive when down, negative when up)  #
#    fs3 = ridley's initial jump speed                              #
#    fs4 = ridley's Y speed (positive when down, negative when up)  #
#                                                                   #
#    fs5 = PLASMA_0's Y speed (same logic as the others)            #
#    fs6 = PLASMA_1's Y speed (same logic as the others)            #
#    fs7 = PLASMA_2's Y speed (same logic as the others)            #
#    fs8 = PLASMA_3's Y speed (same logic as the others)            #
#    fs9 = PLASMA_4's Y speed (same logic as the others)            #
#                                                                   #
#    fs10 = BOMB_0's Y speed (same logic as the others)             #
#    fs11 = BOMB_1's Y speed (same logic as the others)             #
#    fa7  = BOMB_2's Y speed (same logic as the others)             #
#                                                                   #
#####################################################################

GAME_LOOP:
### Frame rate check
	call PLAY_SOUND
    csrr a0,3073
    sub a0, a0, s1 #  # a0 = current time - last frame's time
    li t0, frame_rate	# Loads frame rate (time (in ms) per frame)
    bltu a0,t0, GAME_LOOP  # While a0 < minimum time for a frame, keep looping 

### Game operations
    xori s0,s0,1		    # Switches frame value (register)

	

	call INPUT_CHECK	    # Checks player's input

	call PHYSICS            # Physics operations

	call UPDATE_DOORS       # Updates doors
	call MAP_MOVE_RENDER    # Renders map when necessary

	call MARU_MARI_OPERATIONS

	call BOMB_POWER_OPERATIONS

	call ITEM_CAPSULE_OPERATIONS
	
	li a0,0
	call ENEMY_OPERATIONS

	call BEAMS_OPERATIONS
	
	call UPDATE_STATUS      # Updates player's sprite status

	li a0, 0     # Rendering player operation
	li a1, 0     # Rendering full player
	call RENDER_PLAYER	

	call LOOT_OPERATIONS

	call BOMBS_OPERATIONS
	call EXPLOSIONS_OPERATIONS

	call RENDER_DOOR_FRAMES

	call PLAYER_COLLISION  # Will see if player was hit by an enemy

	call BEAM_COLLISION  # Will see if beam hit an enemy

	li a0, 0     # Rendering UI operation
	call RENDER_UI	

	# Switching Frame on Bitmap Display and getting current time to finish loop											
	li t0,0xFF200604	# Loads Bitmap Display address
	sw s0,0(t0)         # Stores new frame value (from s0) on Bitmap Display

	csrr s1,3073        # New time is stored in s1, in order to be compared later		
	
	j GAME_LOOP	        # Returns to loop's beginning


## Start menu  ##
MENU2_LOOP:
	call RESET_MUSIC
### Frame rate check
    csrr a0,3073
    sub a0, a0, s1 				# a0 = current time - last frame's time
    li t0, frame_rate			# Loads frame rate (time (in ms) per frame)
    bltu a0,t0, MENU2_LOOP  # While a0 < minimum time for a frame, keep looping 

### Game operations
    xori s0,s0,1		    # Switches frame value (register)

	call INPUT_CHECK	    # Checks player's input

	li a0,0               # Black
	li a1,0               # Starting X (0)
	li a2,0               # Starting Y (0)
	li a3,screen_width    # Gets width
	li a4,screen_height   # Gets height
	mv a5,s0              # Gets frame
	li a6,0               # Render per word
	call RENDER_COLOR

	la a0,Select_UI
	li a1,112             # Starting X (0)
	li a2,97              # Starting Y (0)
	beqz s3,SKIP_SELECT_CONTINUE
		addi a2,a2,24     # If selecting continue, render further down
	SKIP_SELECT_CONTINUE:
	li a3,8               # Gets width
	li a4,8               # Gets height
	mv a5,s0              # Gets frame
	li a6,0               # Only one sprite, so status is 0
	li a7,0               # Normal render
	call RENDER_WORD

	la a0,START_TXT
	li a1,128             # a1 = column
	li a2,96              # a2 = row 
	li a3,0x00EA          # a3 = colors 
	mv a4,s0              # a4 = frame
	li a5,1               # Font
	li a7,104 # syscal for 'print integer'
	ecall

	la a0,CONTINUE_TXT
	li a1,128             # a1 = column
	li a2,120             # a2 = row 
	li a3,0x00EA          # a3 = colors 
	mv a4,s0              # a4 = frame
	li a5,1               # Font
	li a7,104 # syscal for 'print integer'
	ecall

	# Switching Frame on Bitmap Display and getting current time to finish loop											
	li t0,0xFF200604	# Loads Bitmap Display address
	sw s0,0(t0)         # Stores new frame value (from s0) on Bitmap Display

	csrr s1,3073        # New time is stored in s1, in order to be compared later		
	
	j MENU2_LOOP	# Returns to loop's beginning



GAME_OVER_LOOP_PREP:
	li a0,0               # Black
	li a1,0               # Starting X (0)
	li a2,0               # Starting Y (0)
	li a3,screen_width    # Gets width
	li a4,screen_height   # Gets height
	li a5,0               # Gets frame
	li a6,0               # Render per word
	call RENDER_COLOR

	la a0,GAME_OVER_TXT
	li a1,120             # a1 = column
	li a2,116             # a2 = row 
	li a3,0x00ff          # a3 = colors 
	li a4,0               # a4 = frame
	li a5,1               # Font
	li a7,104 # syscal for 'print integer'
	ecall

	li a0,0               # Black
	li a1,0               # Starting X (0)
	li a2,0               # Starting Y (0)
	li a3,screen_width    # Gets width
	li a4,screen_height   # Gets height
	li a5,1               # Gets frame
	li a6,0               # Render per word
	call RENDER_COLOR

	la a0,GAME_OVER_TXT
	li a1,120             # a1 = column
	li a2,116             # a2 = row 
	li a3,0x00ff          # a3 = colors 
	li a4,1               # a4 = frame
	li a5,1               # Font
	li a7,104 # syscal for 'print integer'
	ecall

	csrr s1,3073        # New time is stored in s1, in order to be compared later

GAME_OVER_LOOP_PREP2:
### Frame rate check
    csrr a0,3073
    sub a0, a0, s1 				# a0 = current time - last frame's time
    li t0, 1000			# Loads frame rate (time (in ms) per frame)
    bltu a0,t0, GAME_OVER_LOOP_PREP2  # While a0 < minimum time for a frame, keep looping 

GAME_OVER_LOOP:
### Frame rate check
    csrr a0,3073
    sub a0, a0, s1 				# a0 = current time - last frame's time
    li t0, frame_rate			# Loads frame rate (time (in ms) per frame)
    bltu a0,t0, GAME_OVER_LOOP  # While a0 < minimum time for a frame, keep looping 

### Game operations
    xori s0,s0,1		    # Switches frame value (register)

	call INPUT_CHECK	    # Checks player's input

	# Switching Frame on Bitmap Display and getting current time to finish loop											
	li t0,0xFF200604	# Loads Bitmap Display address
	sw s0,0(t0)         # Stores new frame value (from s0) on Bitmap Display

	csrr s1,3073        # New time is stored in s1, in order to be compared later		
	
	j GAME_OVER_LOOP	# Returns to loop's beginning

.include "helpers/helpers.s"



