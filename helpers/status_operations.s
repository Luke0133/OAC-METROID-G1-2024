.text

UPDATE_STATUS:
# 1 - CHECK_LIFE (Sees if player is still alive)   
# 2 - UPDATE_PLAYER_SPRITE (Updates Player's sprite)   
# 3 - UPDATE_PLAYER_STATUS (Updates other statuses from player)  
# 4 - UPDATE_MARU_MARI (Updates MaruMari's sprite)  

# Sees if player is still alive
CHECK_LIFE:
    la t0,PLYR_INFO
    lb t0,0(t0)
    blt zero,t0,END_CHECK_LIFE   # If player is alive
    # Otherwise, player is dead, go to game over
    j DEATH_LOOP_PREP
        li s2,3
        csrr s1,3073
        j SETUP

    END_CHECK_LIFE:

# Updating Player's sprite
UPDATE_PLAYER_SPRITE:
    # Updating player's sprite status
    la t0,PLYR_STATUS  # Loads Player Status
    lb t1, 4(t0)       # Loads Ball Byte 
    bnez t1, UPDATE_PLAYER_SPRITE_BALL # If player is on morph ball (t1 != 0), go to UPDATE_BALL_SPRITE
    j UPDATE_PLAYER_SPRITE_STANDING    # Otherwise, go to CHECK_VERTICAL_MOV

    UPDATE_PLAYER_SPRITE_BALL:
        # Checking direction in order to determine the direction ball should spin
        lbu t1, 1(t0)                    # Loads player's facing direction into t1
        bnez t1, UPDATE_PLAYER_SPRITE_BALL_LEFT # If player is looking left, go to UPDATE_PLAYER_SPRITE_BALL_LEFT
        j UPDATE_PLAYER_SPRITE_BALL_RIGHT       # otherwise, go to UPDATE_PLAYER_SPRITE_BALL_RIGHT

        UPDATE_PLAYER_SPRITE_BALL_LEFT:
        # Turns ball anti-clockwise (3 -> 2 -> 1 -> 0 -> 3 ...)
            lbu t1, 0(t0)  # Loads sprite number
            beqz t1, UPDATE_PLAYER_SPRITE_BALL_LEFT_RESET   # If sprite arrived at 0
            # Otherwise decrement it
                addi t1,t1,-1  # Decrements sprite number
                sb t1, 0(t0)   # and stores it
                j END_UPDATE_PLAYER_SPRITE

            UPDATE_PLAYER_SPRITE_BALL_LEFT_RESET:
                li t1,3        # Loads new sprite status
                sb t1, 0(t0)  # and stores it
                j END_UPDATE_PLAYER_SPRITE

        UPDATE_PLAYER_SPRITE_BALL_RIGHT:
        # Turns ball clockwise (0 -> 1 -> 2 -> 3 -> 0 ...)
            lbu t1, 0(t0)  # Loads sprite number
            li t2,3        # loads upper threshold
            beq t1,t2, UPDATE_PLAYER_SPRITE_BALL_RIGHT_RESET   # If sprite arrived at 3
            # Otherwise increment it
                addi t1,t1,1   # Increments sprite number
                sb t1, 0(t0)   # and stores it
                j END_UPDATE_PLAYER_SPRITE

            UPDATE_PLAYER_SPRITE_BALL_RIGHT_RESET:
                sb zero, 0(t0)  # Stores 0 on sprite status
                j END_UPDATE_PLAYER_SPRITE

    UPDATE_PLAYER_SPRITE_STANDING:
        lbu t1, 7(t0) # Loads MOVE_Y to t1
        beqz t1, UPDATE_PLAYER_SPRITE_STANDING_CHECK_HORIZONTAL_MOV 
        # If player's moving on Y axis, reset sprite status
            sb zero, 0(t0)  # Stores 0 on sprite status
            j END_UPDATE_PLAYER_SPRITE

        UPDATE_PLAYER_SPRITE_STANDING_CHECK_HORIZONTAL_MOV:
            lbu t1,6(t0)  # Loads Move X to t1
            bnez t1, UPDATE_PLAYER_SPRITE_STANDING_HORIZONTAL_MOV
            # If player isn't moving on X axis, reset sprite status
                sb zero, 0(t0)  # Stores 0 on sprite status
                j END_UPDATE_PLAYER_SPRITE

        UPDATE_PLAYER_SPRITE_STANDING_HORIZONTAL_MOV:
        # If player is moving on X axis, update sprite status (0 -> 1 -> 2 -> 0 ...)
            lbu t1, 0(t0)  # Loads sprite number
            li t2,2        # loads upper threshold
            beq t1,t2, UPDATE_PLAYER_SPRITE_STANDING_HORIZONTAL_MOV_RESET   # If sprite arrived at 2
            # Otherwise increment it
                addi t1,t1,1   # Increments sprite number
                sb t1, 0(t0)   # and stores it
                j END_UPDATE_PLAYER_SPRITE

            UPDATE_PLAYER_SPRITE_STANDING_HORIZONTAL_MOV_RESET:
                sb zero, 0(t0)  # Stores 0 on sprite status
                j END_UPDATE_PLAYER_SPRITE

    END_UPDATE_PLAYER_SPRITE:  # Continue to next status update

# Updating other statuses from player
UPDATE_PLAYER_STATUS:  
    # Updating damage status (invincibility frames)
    UPDATE_PLAYER_STATUS_DAMAGE_COOLDOWN:
        la t1, PLYR_INFO_2	 # Loads address of the second part of PLYR_INFO
        lbu t0,5(t1)         # and damage cooldown
        beqz t0,UPDATE_PLAYER_STATUS_DAMAGE_MOVE_X  # If it's on 0, don't update it
        # Otherwise, 
            addi t0,t0,-1    # decrements it
            sb t0,5(t1)      # and stores it back
            bnez t0,UPDATE_PLAYER_STATUS_DAMAGE_MOVE_X # If it didn't reach 0, 
            # If it's on 0, player isn't invincible/taking damage anymore
                sb zero,3(t1)
    
    # Updating damage MOVE_X cooldown (for how long should knockback be applied)
    UPDATE_PLAYER_STATUS_DAMAGE_MOVE_X:
        lbu t0,6(t1)   # Loads knockback cooldown
        beqz t0,UPDATE_PLAYER_STATUS_ATTACK_COOLDOWN  # If it's on 0, don't update it
        # Otherwise, 
            addi t0,t0,-1    # decrements it
            sb t0,6(t1)      # and stores it back
            bgt t0,zero,UPDATE_PLAYER_STATUS_ATTACK_COOLDOWN # If it didn't reach 0, 
            # If it's on 0, reset DAMAGE_MOVE_X (knockback)
                sb zero,4(t1)   

    UPDATE_PLAYER_STATUS_ATTACK_COOLDOWN:
        la t1, BEAMS_ARRAY     # Loads BEAMS array
        lbu t0,0(t1)           # And the attack cooldown byte
        beqz t0,UPDATE_PLAYER_STATUS_BOMB_COOLDOWN  # If it's on 0, don't update it
        # Otherwise, 
            addi t0,t0,-1    # decrements it
            sb t0,0(t1)      # and stores it back

    UPDATE_PLAYER_STATUS_BOMB_COOLDOWN:
        la t1, BOMBS_ARRAY     # Loads BOMBS array
        lbu t0,0(t1)           # And the attack cooldown byte
        beqz t0,END_UPDATE_PLAYER_STATUS  # If it's on 0, don't update it
        # Otherwise, 
            addi t0,t0,-1    # decrements it
            sb t0,0(t1)      # and stores it back

    END_UPDATE_PLAYER_STATUS:  # Continue to next status update

# Updating MaruMari's sprite


# Finished all status related procedures
END_UPDATE_STATUS:
    ret    


#######################        INTO/OUT OF MORPH BALL        ########################

INTO_MORPH_BALL:
        li t1, 1      # Loads morph ball mode (1 = enabled)
        sb t1, 4(a0)  # Stores new direction on PLYR_STATUS
        ret

OUT_OF_MORPH_BALL:
    li t1, -1     # Loads direction for MOVE_Y (-1 = up)
    sb t1, 7(a0)  # Stores new direction on MOVE_Y

    # Setting arguments for COLLISION CHECK
    la a0, MOVE_Y
    la a1, CURRENT_MAP
    lw a1, 0(a1)
    la a2, PLYR_POS
    li a3, 0

    # MOVE_Y will return to 0 afterwards
    mv s11, ra # storing return address in s11
    call CHECK_VERTICAL_COLLISION
    mv ra, s11 # loading return address from s11

    la t0, PLYR_STATUS      # Loads Player Status
    beqz a0, END_OUT_OF_MORPH_BALL
        sb zero, 4(t0) # key = up ? ball = 0 
    END_OUT_OF_MORPH_BALL: 
        li t1,1       # Sets MOVE_Y to 1 (falling) so that player is placed on the ground correctly
        sb t0, 7(t0)  # Stores new direction on MOVE_Y
        ret



########################          DAMAGE PLAYER          ########################
#                                                                               #
#  ------------------           argument registers          ------------------  #
#    a0 = origin of damage (0 - natural causes, 1 - lava                        #
#                           2 - through cheat command)                          #
#	 a1 = damage ammount                                                        #
#	 a2 = damage direction (if a0 == 2 or a2 == 3, it'll be randomized)         #
#       (otherwise, 0 from the right, 1 from the left, 2 if from same X axis)   #
#                                                                               #
#  ------------------          temporary registers          ------------------  #
#    t0, t1 --> temporary registers                                             #
#    tp = origin of damage (0 - natural causes, 1 - lava   -->> stores from a0  #
#                           2 - through cheat command)                          #
#    t5 = damage ammount  -->> stores from a1                                   #
#                                                                               #    
################################################################################# 

DAMAGE_PLAYER:
    mv tp, a0 # Moves whether it was damage from input (1 - Cheat) or from enemy (0)
    mv t5, a1

    la a0, PLYR_INFO_2	 # Loads address of the second part of PLYR_INFO
    lbu t0,3(a0)         # Loads taking damage byte
    beqz t0,DAMAGE_PLAYER_START   # If not taking damage, do it
        j END_DAMAGE_PLAYER       # Otherwise, player is invincible, end procedure
    
    DAMAGE_PLAYER_START:
        li t0,1        # Taking damage == True
        sb t0,3(a0)    # stores taking damage byte

        li t0,damage_iframes  # Loads number of invincibility frames
        sb t0,5(a0)           # and stores it

        li t0,damage_iframes  # Loads number of invincibility frames
        sb t0,6(a0)           # and stores it

        la t1, MOVE_Y	# Loads address of the second part of PLYR_INFO
        li t0, -1       # Loads direction for MOVE_Y (-1 = up)
        sb t0, 0(t1)    # Stores new direction on MOVE_Y
        sb zero,1(t1)   # Resets jump counter
        
        # USES FLOATING POINT OPERATIONS
        li t0,damage_jump # Jumping value for damage
        fcvt.s.w fs2,t0   # Sets fs2 (player's Y speed) to -3

        li t0,3
        beq a2,t0,DAMAGE_PLAYER_RANDOMIZE
        li t0,2
        bne t0,tp,DAMAGE_PLAYER_CHECK_DIRECTION
        DAMAGE_PLAYER_RANDOMIZE:
        # Randomizing damage direction
            li a1,2                  # Range
            li a7,RandIntRangeEcall  # random integer within range ecall
            ecall
            mv a2,a0   # Moves result to a2 and starts checking direction
        DAMAGE_PLAYER_CHECK_DIRECTION:
            bnez a2,DAMAGE_PLAYER_CHECK_LEFT
            # If damage was taken from the right, move left
                li t0,-4
                j DAMAGE_PLAYER_DIRECTION

            DAMAGE_PLAYER_CHECK_LEFT: li t0,1
            bne t0,a2,DAMAGE_PLAYER_SAME_X
            # If damage was taken from the left, move right
                li t0,4
                j DAMAGE_PLAYER_DIRECTION

            DAMAGE_PLAYER_SAME_X:
            # If damage was taken from the same X axis, don't move horizontally
                li t0,0
                j DAMAGE_PLAYER_DIRECTION

            DAMAGE_PLAYER_DIRECTION:
                la a0, PLYR_INFO_2	 # Loads address of the second part of PLYR_INFO 
                sb t0, 4(a0)    # Stores new direction on DAMAGE_MOVE_X

                

        # Taking away damage:
        la t0,PLYR_INFO_2
        lbu t0,0(t0)
        bnez t0,END_DAMAGE_PLAYER
            la t0,PLYR_INFO  # Loads PLYR_INFO
            lbu t1,0(t0)     # and player's health
            sub t1,t1,t5     # takes away hp
            sb t1,0(t0)      # and stores it back

    END_DAMAGE_PLAYER:
    ret





DEATH_LOOP_PREP:

#    ft0 = PLASMA_0's Y speed (same logic as the others)            #
#    ft1 = PLASMA_1's Y speed (same logic as the others)            #
#    ft2 = PLASMA_2's Y speed (same logic as the others)            #
#    ft3 = PLASMA_3's Y speed (same logic as the others)            #
#    ft4 = PLASMA_4's Y speed (same logic as the others)            #
#    ft5 = BOMB_0's Y speed (same logic as the others)             #

	la t0, PLYR_POS
	lhu t2,0(t0)           # Loads Player's X
	lbu t3,4(t0)           # Loads Player's Y

	la t1, DEATH_1E_POS    # Loads 
	sh t2,0(t1)
	sh t3,2(t1)
	li t4,-8
	fcvt.s.w ft0 ,t4

	la t1, DEATH_2E_POS    # Loads 
	sh t2,0(t1)
	addi t4,t3,8
	sh t4,2(t1)
	li t4,-5
	fcvt.s.w ft0 ,t4

	la t1, DEATH_3E_POS    # Loads 
	sh t2,0(t1)
	addi t4,t3,16
	sh t4,2(t1)
	li t4,-3
	fcvt.s.w ft0 ,t4

	la t1, DEATH_1D_POS    # Loads 
	addi t4,t2,8
	sh t4,0(t1)
	sh t3,2(t1)
	li t4,-8
	fcvt.s.w ft0 ,t4

	la t1, DEATH_2D_POS    # Loads 
	addi t4,t2,8
	sh t4,0(t1)
	addi t4,t3,8
	sh t4,2(t1)
	li t4,-5
	fcvt.s.w ft0 ,t4

	la t1, DEATH_3D_POS    # Loads 
	addi t4,t2,8
	sh t4,0(t1)
	addi t4,t3,16
	sh t4,2(t1)
	li t4,-3
	fcvt.s.w ft0 ,t4

	li s4,0         #   Counter
	li s5,0

DEATH_LOOP:
	### Frame rate check
    csrr a0,3073
    sub a0, a0, s1          # a0 = current time - last frame's time
    li t0, frame_rate	    # Loads frame rate (time (in ms) per frame)
    bltu a0,t0, DEATH_LOOP  # While a0 < minimum time for a frame, keep looping 

### Game operations
    xori s0,s0,1		    # Switches frame value (register)

	call UPDATE_DOORS       # Updates doors
	call MAP_MOVE_RENDER    # Renders map when necessary

	call MARU_MARI_OPERATIONS

	call BOMB_POWER_OPERATIONS

	call ITEM_CAPSULE_OPERATIONS
	
	li a0,0
	call ENEMY_OPERATIONS

	call BEAMS_OPERATIONS


	la t1, DEATH_1E_POS    # Loads 
	la a0, Death_E1
	lhu a1,0(t1)
	lhu a2,2(t1)

	addi t2,a1,-10
	fadd.s ft0,ft0,fs0    # ft0 = Death Sprite's current Y speed + gravity factor       
    fcvt.w.s t3,ft0       # Sets t3 = floor(ft0)
	add t3,a2,t3 
	sh t2,0(t1)
	sh t3,2(t1)

	li a3,8
	li a4,8
	mv a5,s0
	mv a6,s5
	addi s5,s5,1
	li t0,3
	blt s5,t0,SKIP_STATUS_CORRECTION_1E
		li s5,0
	SKIP_STATUS_CORRECTION_1E:
	li a7,0

	call RENDER

	la t1, DEATH_2E_POS    # Loads 
	la a0, Death_E2
	lhu a1,0(t1)
	lhu a2,2(t1)

	addi t2,a1,-10
	fadd.s ft1,ft1,fs0    # ft1 = Death Sprite's current Y speed + gravity factor       
    fcvt.w.s t3,ft1       # Sets t3 = floor(ft0)
	add t3,a2,t3 
	sh t2,0(t1)
	sh t3,2(t1)

	li a3,8
	li a4,8
	mv a5,s0
	li t0,4
	mv a6,s4
	blt s4,t0,SKIP_STATUS_CORRECTION_2E
		addi a6,a6,-4
	SKIP_STATUS_CORRECTION_2E:
	li a7,0

	call RENDER

	la t1, DEATH_3E_POS    # Loads
	la a0, Death_E3 
	lhu a1,0(t1)
	lhu a2,2(t1)

	addi t2,a1,-10
	fadd.s ft2,ft2,fs0    # ft0 = Death Sprite's current Y speed + gravity factor       
    fcvt.w.s t3,ft2       # Sets t3 = floor(ft0)
	add t3,a2,t3 
	sh t2,0(t1)
	sh t3,2(t1)

	li a3,8
	li a4,8
	mv a5,s0
	li t0,4
	mv a6,s4
	blt s4,t0,SKIP_STATUS_CORRECTION_3E
		addi a6,a6,-4
	SKIP_STATUS_CORRECTION_3E:
	li a7,0

	call RENDER

	la t1, DEATH_1D_POS    # Loads 
	la a0, Death_D1
	lhu a1,0(t1)
	lhu a2,2(t1)

	addi t2,a1,10
	fadd.s ft3,ft3,fs0    # ft3 = Death Sprite's current Y speed + gravity factor       
    fcvt.w.s t3,ft3       # Sets t3 = floor(ft3)
	add t3,a2,t3 
	sh t2,0(t1)
	sh t3,2(t1)

	li a3,8
	li a4,8
	mv a5,s0
	li t0,4
	mv a6,s4
	blt s4,t0,SKIP_STATUS_CORRECTION_1D
		addi a6,a6,-4
	SKIP_STATUS_CORRECTION_1D:
	li a7,0

	call RENDER

	la t1, DEATH_2D_POS    # Loads 
	la a0, Death_D2
	lhu a1,0(t1)
	lhu a2,2(t1)

	addi t2,a1,10
	fadd.s ft4,ft4,fs0    # ft4 = Death Sprite's current Y speed + gravity factor       
    fcvt.w.s t3,ft4       # Sets t3 = floor(ft4)
	add t3,a2,t3 
	sh t2,0(t1)
	sh t3,2(t1)

	li a3,8
	li a4,8
	mv a5,s0
	li t0,4
	mv a6,s4
	blt s4,t0,SKIP_STATUS_CORRECTION_2D
		addi a6,a6,-4
	SKIP_STATUS_CORRECTION_2D:
	li a7,0

	call RENDER

	la t1, DEATH_3D_POS    # Loads 
	la a0, Death_D3
	lhu a1,0(t1)
	lhu a2,2(t1)

	addi t2,a1,10
	fadd.s ft5,ft5,fs0    # ft5 = Death Sprite's current Y speed + gravity factor       
    fcvt.w.s t3,ft5       # Sets t3 = floor(ft5)
	add t3,a2,t3 
	sh t2,0(t1)
	sh t3,2(t1)

	li a3,8
	li a4,8
	mv a5,s0
	li t0,4
	mv a6,s4
	blt s4,t0,SKIP_STATUS_CORRECTION_3D
		addi a6,a6,-4
	SKIP_STATUS_CORRECTION_3D:
	li a7,0

	call RENDER

	call LOOT_OPERATIONS

	call BOMBS_OPERATIONS
	call EXPLOSIONS_OPERATIONS

	call BEAM_COLLISION  # Will see if beam hit an enemy

	li a0, 0     # Rendering UI operation
	call RENDER_UI	

	# Switching Frame on Bitmap Display and getting current time to finish loop											
	li t0,0xFF200604	# Loads Bitmap Display address
	sw s0,0(t0)         # Stores new frame value (from s0) on Bitmap Display

	csrr s1,3073        # New time is stored in s1, in order to be compared later		
	
	addi s4,s4,1
	li t0,6
	blt s4,t0,DEATH_LOOP
        li s2,3
        csrr s1,3073
        j SETUP










