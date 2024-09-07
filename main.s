.include "helpers/MACROSv24.s" # Macros para bitmap display
.include "helpers/data.s"
#.include "helpers/dataold.s"

.data
DEBUG: .string "\n"
DEBUG2: .string " x "
DEBUG1: .string "rarara\n"
DEBUG11: .string "pasou\n"
		
.text
li s1, 0  # Reseting time
li s2, 0  # Game loop state 
main:
	j SETUP

##########################    GAME LOOP    ##########################
#                Main operations for the game to run                #
#     ------------         saved registers         ------------     #
#       s0 = current frame                                          #
#       s1 = last frame time                                        #
#       s2 = game loop state: 0 - Normal Game Loop,                 #
#                             1 - Entering Door Loop, -- on map_op.s              #
#                             2 - Switching Map Loop, -- on map_op.s            #
#                             3 - Exiting Door Loop,  -- on map_op.s              #
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
	
	call UPDATE_STATUS      # Updates player's sprite status

	li a0, 0     # Rendering player operation
	li a1, 0     # Rendering full player
	call RENDER_PLAYER	

#	call RENDER_DOOR_UPDATE         - probably not using :D
	call RENDER_DOOR_FRAMES

	# Switching Frame on Bitmap Display											
	li t0,0xFF200604	# Loads Bitmap Display address
	sw s0,0(t0)         # Stores new frame value (from s0) on Bitmap Display

	li a0, 1     # Rendering player's trail operation
	li a1, 0     # Rendering full player (a1 doesn't really matter when a0 = 1)
	call RENDER_PLAYER


	call RENDER_LIFE

	#la a0, Beam
	#call BEAM_OPERATIONS
	
	#call ENEMY_OPERATIONS

	csrr s1,3073    # new time is stored in s1, in order to be compared later		

	#call MUSIC.PLAY
	
	j GAME_LOOP	# Volta para ENGINE_LOOP





.include "helpers/helpers.s"
