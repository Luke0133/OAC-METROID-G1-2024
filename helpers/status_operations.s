.text

UPDATE_STATUS:
# 1 - UPDATE_PLAYER_SPRITE (Updates Player's sprite)   
# 2 - UPDATE_PLAYER_STATUS (Updates other statuses from player)  
# 3 - UPDATE_MARU_MARI (Updates MaruMari's sprite)  

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
UPDATE_MARU_MARI:
    la t0,CURRENT_MAP # Loads CURRENT_MAP address
    lbu t1, 4(t0)     # Loads Current Map byte
    li t2,1           # Number of map that maru mari appears
    bne t2,t1,END_UPDATE_MARU_MARI # If not on correct map, ignore
    # Otherwise, update sprite status and check if should be rendered
        # Updating sprite
        la t1,MARU_MARI_INFO # Loads Maru Mari's info address
        lbu t2, 1(t1)        # Loads status sprite
        li t3, 3             # t3 = max_sprite
        beq t2,t3,RESET_MARU_MARI # If status == 3, reset it
            addi t2,t2,1     # Increments status 
            sb t2, 1(t1)     # Stores status sprite
            j UPDATE_MARU_MARI_TRY_RENDER
        RESET_MARU_MARI:
            sb zero, 1(t1)   # Stores status sprite
            # j UPDATE_MARU_MARI_TRY_RENDER
        UPDATE_MARU_MARI_TRY_RENDER:
        # Checking if should be rendered
        lbu a1, 6(t0)     # Loads Current Map's X
        li t2,maru_mari_x # Loads Maru_Mari's X
        sub t1,t2,a1      # t1 = Maru_Mari's X - Current Map's X
        bge t1,zero,UPDATE_MARU_MARI_RENDER # If t1 >= 0, render maru mari
        # Otherwise, finish procedure
            j END_UPDATE_MARU_MARI
        UPDATE_MARU_MARI_RENDER:
            lw a0,0(t0)
            # a1 is already set (X in map matrix that corresponds to 0x0 on the screen matrix)
            lbu a2, 7(t0)     # Loads Current Map's Y
            lbu a3, 8(t0)   # Loads current X offset on Map
            lbu a4, 9(t0)   # Loads current Y offset on Map	
            mv a5, s0		# Frame = s0
            li a6, 1        # Width of rendering area will always be 1
            li a7, 1        # Height of rendering area will always be 1
            li t3, maru_mari_x  # X from map matrix where rendering will start from
            li t2, maru_mari_y  # Y from map matrix where rendering will start from
            li tp, 0        # Map won't be dislocated		
            mv s11,ra
            call RENDER_MAP		
            mv ra,s11
    
    END_UPDATE_MARU_MARI:  # Continue to next status update

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
        la t0,PLYR_INFO  # Loads PLYR_INFO
        lbu t1,0(t0)     # and player's health
        sub t1,t1,t5     # takes away hp
        sb t1,0(t0)      # and stores it back

    END_DAMAGE_PLAYER:
    ret















