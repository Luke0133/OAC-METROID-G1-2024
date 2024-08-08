.include "helpers/MACROSv24.s" # Macros para bitmap display
.include "helpers/data.s"
#.include "helpers/dataold.s"

.data
DEBUG: .string "\n"
DEBUG2: .string " x "
DEBUG1: .string "rarara\n"
		
.text
li s1, 0  # Reseting time
main:
	j SETUP

##########################    GAME LOOP    ##########################
#                Main operations for the game to run                #
#     ------------         saved registers         ------------     #
#       s0 = current frame                                          #
#       s1 = last frame time                                        #
#####################################################################

GAME_LOOP:
### Frame rate check
    li a7,30	# Ecall 30: Gets current time
    ecall 		# Syscall
    sub a0, a0, s1 #  # a0 = current time - last frame's time
    li t0, frame_rate	# Loads frame rate (time (in ms) per frame)
    bltu a0,t0, GAME_LOOP  # While a0 < minimum time for a frame, keep looping 

### Game operations  
    xori s0,s0,1			# inverte o valor frame atual (somente o registrador)

	call INPUT_CHECK	# Checa input do jogador

	call PHYSICS

#la t0 PLYR_POS
#lh a0,6(t0)
#li a7 1
#ecall
#la a0 DEBUG2
#li a7 4
#ecall
#lbu a0,7(t0)
#li a7 1
#ecall
#la a0 DEBUG
#li a7 4
#ecall

	call MAP_MOVE_RENDER
	
	call UPDATE_STATUS

	li a0, 0
	call RENDER_PLAYER				
									
	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)

	li a0, 1
	call RENDER_PLAYER
	call RENDER_LIFE

	li a7,30    # gets current time
	ecall       # syscall
	mv s1,a0    # new time is stored in s1, in order to be compared later		

	call MUSIC.PLAY
	
	j GAME_LOOP	# Volta para ENGINE_LOOP


.include "helpers/helpers.s"