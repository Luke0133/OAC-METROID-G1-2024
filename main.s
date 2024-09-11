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
#    fs1 = initial jump speed (const)                               #
#    fs2 = player's Y speed (positive when down, negative when up)  #
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
 
	call INPUT_CHECK	    # Checks player's input
	call PHYSICS            # Physics operations

	call UPDATE_DOORS       # Updates doors
	call MAP_MOVE_RENDER    # Renders map when necessary
	
	li a0,0
	call ENEMY_OPERATIONS

	call UPDATE_MARU_MARI   # Updates Maru Mari's sprite (in sprite op)
	
	call UPDATE_STATUS      # Updates player's sprite status

	li a0, 0     # Rendering player operation
	li a1, 0     # Rendering full player
	call RENDER_PLAYER	

	li a0, 0     # Rendering UI operation
	call RENDER_UI	

#	call RENDER_DOOR_UPDATE         - probably not using :D
	call RENDER_DOOR_FRAMES

	# Switching Frame on Bitmap Display											
	li t0,0xFF200604	# Loads Bitmap Display address
	sw s0,0(t0)         # Stores new frame value (from s0) on Bitmap Display

	# li a0,1
	# call ENEMY_OPERATIONS
	
	# li a0, 1     # Rendering player's trail operation
	# li a1, 0     # Rendering full player (a1 doesn't really matter when a0 = 1)
	# call RENDER_PLAYER


	#call RENDER_LIFE

	#la a0, Beam
	call BEAM_OPERATIONS_RENDER
	
	#call ENEMY_OPERATIONS

	csrr s1,3073    # new time is stored in s1, in order to be compared later		

	#call MUSIC.PLAY
	
	j GAME_LOOP	# Volta para ENGINE_LOOP





.include "helpers/helpers.s"



