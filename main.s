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
	li s1, 0  # Reseting time
	li s2, 0  # Game loop state 

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
    csrr a0,3073
    sub a0, a0, s1 #  # a0 = current time - last frame's time
    li t0, frame_rate	# Loads frame rate (time (in ms) per frame)
    bltu a0,t0, GAME_LOOP  # While a0 < minimum time for a frame, keep looping 

### Game operations
    xori s0,s0,1		    # Switches frame value (register)

	call MUSIC.PLAY

	call INPUT_CHECK	    # Checks player's input

	call PHYSICS            # Physics operations

	call UPDATE_DOORS       # Updates doors
	call MAP_MOVE_RENDER    # Renders map when necessary
	
	li a0,0
	call ENEMY_OPERATIONS

	call BEAMS_OPERATIONS
	
	call UPDATE_STATUS      # Updates player's sprite status

	li a0, 0     # Rendering player operation
	li a1, 0     # Rendering full player
	call RENDER_PLAYER	

	call BOMBS_OPERATIONS
	call EXPLOSIONS_OPERATIONS

	li a0, 0     # Rendering UI operation
	call RENDER_UI	

	call RENDER_DOOR_FRAMES

	call PLAYER_COLLISION  # Will see if player was hit by an enemy

	call BEAM_COLLISION  # Will see if beam hit an enemy

	# Switching Frame on Bitmap Display and getting current time to finish loop											
	li t0,0xFF200604	# Loads Bitmap Display address
	sw s0,0(t0)         # Stores new frame value (from s0) on Bitmap Display

	csrr s1,3073        # New time is stored in s1, in order to be compared later		
	
	j GAME_LOOP	        # Returns to loop's beginning





.include "helpers/helpers.s"



