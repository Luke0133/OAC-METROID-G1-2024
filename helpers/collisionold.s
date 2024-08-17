.text
#######################     CHECK HORIZONTAL COLLISION     ######################
#   This procedure checks the tiles in front of the player depending on which   #
#  direction they're facing. Based on the player's MOVE_Y (movement on Y axis), #
#   it'll be decided whether the CHECK MAP COLLISION will check only two tiles  #
#   (when player's on the ground) or three tiles (when player's on the air) in  #
#    front of the player. Before checking the collision, the X offset of the    #
#     player is checked, in order to call the CHECK MAP COLLISION only when     #    
#  necessary. It's good to note that this procedure is primarily called by the  #
#    PHYSICS procedure, so there are some registers that aren't suposed to be   #
#     messed with, exept for a0, which needs to be stored before calling this,  #
#        and will return 0 if player can't go through and 1 if they can.        #
#                                                                               #
#  ------------------            registers used           --------------------  #
#    a0 = MOVE_X/MOVE_Y address (from PHYSICS, and returns as explained above)  #
#	 a2 = current map's address                                                 #
#    a3 = PLYR_POS                                                              #  
#                                                                               #
#   ----------------         registers used on PHYSICS        ----------------  #      
#    >>> DON'T USE THESE ON ANY COLLISION PROCEDURE                             #         
#    a1, a4, a6, a7, s10, s11 --> used on PHYSICS                               # 
#                                                                               #
#################################################################################                    

CHECK_HORIZONTAL_COLLISION:
    lbu t1, 8(a3)  # t1 = Player's X related to matrix
    lbu t2, 6(a3)  # t2 = Player's X offset
    
    lbu t4,1(a2)   # Loads Map Matrix's width
    addi t3,a2,3   # Adds 3 to the Matrix's address so that it goes to the begining of matrix
    lbu t5, 10(a3) # t5 = Player's Y related to matrix
    mul t5,t5,t4   # Player's Y related to matrix * Map Matrix's width
    add t5,t1,t5   # t5 = Player's X related to matrix +  Player's Y related to matrix * Map Matrix's width  

    add t3,t3,t5   # t3 = Map Matrix's address adjusted for Player's X and Y related to matrix
    
    lb t0, 0(a0)   # Loads MOVE_X information to t0
    bnez t0, CHECK_X_DIRECTION  # If player's not moving, end procedure 
    j END_HORIZONTAL_COLLISION 
    
    CHECK_X_DIRECTION:
    # Checking vertical movement
        la t1, MOVE_Y # Loads MOVE_Y address
        lb t1,0(t1)   # Loads MOVE_Y content
        beqz t1, SKIP_THIRD_CHECK  # If MOVE_Y = 0, skip
            bge zero,t1, UPWARDS_THIRD_CHECK # If MOVE_Y = 1 (down) continue
                la t1, PLYR_POS    # Loads PLYR_POS address
                lb t1, 7(t1)       # Loads Y offset
                beqz t1 SKIP_THIRD_CHECK # If Y offset is zero, there's no need to check 3 tiles
                    li t5, 2    # Checks 3 tiles horizontally (or 2 if on morph ball)
                    j CONTINUE_CHECK_X_DIRECTION
            UPWARDS_THIRD_CHECK: # If MOVE_Y = -1 (up)
                la t1, PLYR_POS # Loads PLYR_POS address
                lb t1, 7(t1)    # Loads Y offset
                li t5, 8        # Represents the desired offset
                bge t5, t1 SKIP_THIRD_CHECK # If Y offset is zero, there's no need to check 3 tiles
                # Otherwise, t5 is already = 2 , so it'll check 3 tiles horizontally (or 2 if on morph ball)
                    li t5, 2    # Checks 3 tiles horizontally (or 2 if on morph ball)
                    j CONTINUE_CHECK_X_DIRECTION
        SKIP_THIRD_CHECK:
            li t5,1 # Checks 2 tiles horizontally (or 1 if on morph ball)

    CONTINUE_CHECK_X_DIRECTION:
        lbu t1,16(a3) # Loads Player's morph ball byte
        beqz t1,CONTINUE_CHECK_X_DIRECTION_2 # If player's not on morph ball
        add t3,t4,t3  # Increments width to player's y on matrix (checks only one tile in front of them)
    
    CONTINUE_CHECK_X_DIRECTION_2:
        blt t0, zero, CHECK_X_LEFT # If player is moving left (t0 < 0), go to CHECK_X_LEFT
        j CHECK_X_RIGHT            # otherwise, go to CHECK_X_RIGHT
        
        CHECK_X_LEFT:
            li t0, 12    # Loads number 12 for comparing with X offset 
            beq t2, t0, CONTINUE_CHECK_X_LEFT # If X offset is 12, continue checking
            addi t0,t0, -8                    # Otherwise, compare with offset 4
            beq t2, t0, CONTINUE_CHECK_X_LEFT_DOOR # If X offset is 4, check for doors
            j END_HORIZONTAL_COLLISION        # Otherwise, stop
            
            CONTINUE_CHECK_X_LEFT:
                j CHECK_MAP_COLLISION

            CONTINUE_CHECK_X_LEFT_DOOR:
                j CHECK_MAP_COLLISION_DOOR
        
        CHECK_X_RIGHT:
            addi t3,t3, 1 # Looks to the tile on the right of player's current tile
            li t0, 4      # Loads number 4 for comparing with X offset 
            beq t2, t0, CONTINUE_CHECK_X_RIGHT # If X offset is 4, continue checking
            addi t0,t0, 8                      # Otherwise, compare with offset 12
            beq t2, t0, CONTINUE_CHECK_X_RIGHT_DOOR # If X offset is 12, check for doors
                j END_HORIZONTAL_COLLISION 
            
            CONTINUE_CHECK_X_RIGHT:
                j CHECK_MAP_COLLISION
            
            CONTINUE_CHECK_X_RIGHT_DOOR:
                j CHECK_MAP_COLLISION_DOOR
    
    END_HORIZONTAL_COLLISION:
    # If no check is to be made, return a0 = 1 (player can move)
        li a0,1  
        ret 

#######################     CHECK VERTICAL COLLISION     ########################
#   This procedure checks the tiles in bellow or above the player depending on  #
#     which direction they're going. Based on the player's X offset it'll be    #
#    decided whether the CHECK MAP COLLISION will check only one or two tiles   #
#    depending on the player's position (when player's on one tile or between   #
#  two tiles). After getting the player's MOVE_Y and determining the direction, #
#   the player's Y offset is checked in order to call the CHECK MAP COLLISION   #   
#    only when necessary. It's good to note that this procedure is primarily    #
#    called by the PHYSICS procedure, so there are some registers that aren't   #
#    suposed to be messed with, exept for a0, which needs to be stored before   #
# calling this, and will return 0 if player can't go through and 1 if they can. #
#                                                                               #
#  ------------------            registers used           --------------------  #
#    a0 = MOVE_X/MOVE_Y address (from PHYSICS, and returns as explained above)  #
#	 a2 = current map's address                                                 #
#    a3 = PLYR_POS                                                              #  
#                                                                               #
#   ----------------         registers used on PHYSICS        ----------------  #      
#    >>> DON'T USE THESE ON ANY COLLISION PROCEDURE                             #         
#    a1, a4, a6, a7, s10, s11 --> used on PHYSICS                               # 
#                                                                               #
#################################################################################    
CHECK_VERTICAL_COLLISION:
    lbu t1, 8(a3) # t1 = PLYR_MATRIX Y
    lbu t2, 7(a3) # t2 = PLYR_Y OFFSET

    lbu t4,1(a2)   # Loads matrix width
    addi t3,a2,3   # start of matrix
    lbu t5, 10(a3) # t5 = PLYR_MATRIX Y
    mul t5,t5,t4   # PLYR_MATRIX Y * MATRIX WIDTH
    add t5,t1,t5   # t5 = PLYR_MATRIX X + PLYR_MATRIX Y * MATRIX WIDTH  

    add t3,t3,t5   # t3 = Map address on correct X and Y
    lbu t1, 10(a3) # t1 = PLYR_MATRIX Y   

    lb t0, 0(a0) # Loads MOVE_Y to t0 

    li t5,3      # t5 = 3 --> check once vertical
        
    blt t0,zero, CHECK_Y_UP # If t0 < 0, check up, 
    j CHECK_Y_DOWN          # otherwise check down
    
    CHECK_Y_UP:
        beqz t2 CONTINUE_CHECK_Y_UP # If player's offset is 0, continue checking
        j END_VERTICAL_COLLISION    # otherwise, end procedure
    
        CONTINUE_CHECK_Y_UP:
        # Doesn't need to check for doors 
            lbu t1,16(a3)      # Loads Player's morph ball byte
            bnez t1, CONTINUE_CHECK_Y_UP2 # If player is on morph ball, don't update Y to be checked
            sub t3,t3,t4       # If player isn't on morph ball, update Y one tile up (-1 matrix Y) 
            
            CONTINUE_CHECK_Y_UP2: 
            lbu t0,13(a3)  # Loads Facing direction (0 = Right, 1 = Left)
            lbu t2, 6(a3)  # t2 = Player's Y offset
            beqz t0, CHECK_Y_UP_RIGHT # If t0 = 0, check tile to the right
            j CHECK_Y_UP_LEFT         # otherwise, check tile to the left
            
            CHECK_Y_UP_RIGHT:
                li t0, 8   # Loads number 8 for comparing with X offset 
                blt t2,t0, CHECK_1_TILE_RIGHT
                li t0,12   # Loads number 12 for comparing with X offset 
                bge t2,t0, CHECK_1_TILE_RIGHT_2
                li t5, 4   # Check two tiles downwards - case 4
                
                CHECK_1_TILE_RIGHT:
                # Checks one or two tiles above the player
                    j CHECK_MAP_COLLISION
                CHECK_1_TILE_RIGHT_2:
                # Checks one tile to the top right of the player
                    addi t3,t3,1
                    j CHECK_MAP_COLLISION 
            
            CHECK_Y_UP_LEFT:
                li t0, 4   # Loads number 4 for comparing with X offset
                bge t0,t2, CHECK_1_TILE_LEFT 
                li t0, 12  # Loads number 12 for comparing with X offset
                bge t2,t0, CHECK_RIGHT_TILE_LEFT
                li t5, 4   # Check two tiles upwards - case 4
                
                CHECK_1_TILE_LEFT:
                # Checks one or two tiles above the player
                    j CHECK_MAP_COLLISION
                CHECK_RIGHT_TILE_LEFT:
                # Checks one tile to the top right of the player
                    addi t3,t3,1
                    j CHECK_MAP_COLLISION
    
    CHECK_Y_DOWN:
        beqz t2 CONTINUE_CHECK_Y_DOWN # If player's offset is 0, continue checking
        li t1,2                       # comparing with offset 2 
        beq, t1 t2 CONTINUE_CHECK_Y_DOWN # If player's offset is 2, continue checking
        j END_VERTICAL_COLLISION         # otherwise, end procedure
    
        CONTINUE_CHECK_Y_DOWN: 
            add t3,t3,t4     # Updates Y one tile down (+1 matrix Y) 
            add t3,t3,t4     # Updates Y another tile down (+1 matrix Y) 
            lbu t0,13(a3)    # Loads Facing direction (0 = Right, 1 = Left)
            lbu t2, 6(a3)    # t2 = Player's Y offset
            beqz t0, CHECK_Y_DOWN_RIGHT # If t0 = 0, check tile to the right
            j CHECK_Y_DOWN_LEFT         # otherwise, check tile to the left
            
            CHECK_Y_DOWN_RIGHT:
                bnez t2, SKIP_DOOR_CHECK_RIGHT
                    mv s9, ra
                    call CHECK_MAP_COLLISION_DOOR
                    mv ra, s9
                    bnez a0, SKIP_DOOR_CHECK_RIGHT
                    j END_VERTICAL_COLLISION
                SKIP_DOOR_CHECK_RIGHT:
                li t5,3
                li t0, 8   # Loads number 8 for comparing with X offset
                blt t2,t0, CHECK_1_TILE_DOWN_RIGHT 
                li t0,12   # Loads number 8 for comparing with X offset
                bge t2,t0, CHECK_1_TILE_DOWN_RIGHT_2
                li t5, 4   # Check two tiles downwards - case 4
                
                CHECK_1_TILE_DOWN_RIGHT:
                # Checks one or two tiles above the player
                    j CHECK_MAP_COLLISION
                CHECK_1_TILE_DOWN_RIGHT_2:
                # Checks one tile to the top right of the player
                    addi t3,t3,1 # Tile to the right
                    j CHECK_MAP_COLLISION 
            
            CHECK_Y_DOWN_LEFT:
                li t0, 4   # Loads number 4 for comparing with X offset
                bge t0,t2, CHECK_1_TILE_DOWN_LEFT 
                li t0, 12  # Loads number 12 for comparing with X offset
                bge t2,t0, CHECK_RIGHT_TILE_DOWN_LEFT # Will check the tile on the right and not the one the player is currently at
                li t5, 4   # Check two tiles downwards - case 4
                
                CHECK_1_TILE_DOWN_LEFT:
                # Checks one or two tiles above the player
                    j CHECK_MAP_COLLISION
                CHECK_RIGHT_TILE_DOWN_LEFT:
                # Checks one tile to the top right of the player
                    addi t3,t3,1 # Tile to the right
                    j CHECK_MAP_COLLISION

    END_VERTICAL_COLLISION:
        li a0,1
        ret 

###################    CHECK MAP COLLISION    ###################    
#   Effectivelly checks the collision by checking which is the      #
#   tile from the normalized address given as an argument (t3)      #
#   arguments: t3, t4, t5 , a3
#   t0 works as an 'assistent register'
#   returns a0 = 0 ? Can't move : Can move                          
#   switch (t5):
#       case 0 : pls stop
#       case 1 : horizontal (check twice)
#       case 2 : horizontal (check thrice)
#       case 3 : check once vertical
#       case 4 : check twice vertical

CHECK_MAP_COLLISION:
    bnez a0, CONTINUE_CHECK_MAP_COLLISION_1 # a0 != 0 ? CONTINUE_CHECK_MAP_COLLISION_1 : ret
    ret

    CONTINUE_CHECK_MAP_COLLISION_1:
    bge t5, zero, CONTINUE_CHECK_MAP_COLLISION_2 # t5 != 0 ? CONTINUE_CHECK_MAP_COLLISION_4 : RET
    ret

    CONTINUE_CHECK_MAP_COLLISION_2:
    lbu t1, 0(t3) # Loads tile from current map

    li t0, 3
    blt t0, t1,COLLISION_NotBackground # If tile isn't passthrough or breakable (t1 > 3)
    # If tile is passthrough or breakable (0 <= t1 <= 3)
        li a0, 1 # Only option when player can move
        beq a0,t1, COLLISION_BREAKABLE  # If tile is breakable, there needs to be a check if it was broken
            j CONTINUE_CHECK_MAP_COLLISION_3 # Otherwise, continue checking collision
    
    COLLISION_BREAKABLE:
# ---> make breakable block work :)
    # li a0, 0 # Player can't move  
    j CONTINUE_CHECK_MAP_COLLISION_3
	
	COLLISION_NotBackground:
        li t0,36
        bge t1,t0, COLLISION_SPECIAL  # If current tile is a door or a damaging tile (t1 >= 36)
            j COLLISION_BLOCKED # If tile isn't special (3 < t1 < 36)

	COLLISION_SPECIAL:
        li t0,40
        blt t1,t0, COLLISION_DAMAGE   # If tile is a door (t1 >= 40)
        li a0, 1 # Only option when player can move
        j CONTINUE_CHECK_MAP_COLLISION_3 # Otherwise, continue checking collision
    
    COLLISION_DAMAGE:
# ---> make damage work :)
        j COLLISION_BLOCKED # For now >:[
    
    COLLISION_BLOCKED:
        li a0, 0 # Player can't move  
    CONTINUE_CHECK_MAP_COLLISION_3:
    blt zero, t5, CONTINUE_CHECK_MAP_COLLISION_4 # t5 != 0 ? CONTINUE_CHECK_MAP_COLLISION_4 : RET

    ret
    
    CONTINUE_CHECK_MAP_COLLISION_4:
    li t0, 3
    bge t5, t0, VERTICAL_COLLISION_CHECK # 1 != t5 ? VERTICAL_COLLISION_CHECK : HORIZONTAL_COLLISON_CHECK
    
    HORIZONTAL_COLLISON_CHECK:

        add t3,t3,t4   # t3 = map address + matrix width
        addi t5,t5,-1  # Updates t5
        lbu t0, 16(a3) # Loads morph ball status
        beqz t0, CONTINUE_HORIZONTAL_COLLISON_CHECK # t0 (ball mode) = 0 (not ball mode) ? CONTINUE_HORIZONTAL_COLLISON_CHECK : continue
            addi t5,t5,-1  # Updates t5 again (reduce number of repetitions due to smaller hitbox size)
        CONTINUE_HORIZONTAL_COLLISON_CHECK:
        j CHECK_MAP_COLLISION
    
    VERTICAL_COLLISION_CHECK:
        li t0, 3
        bne t0,t5, CONTINUE_VERTICAL_COLLISION_CHECK # 3 != t5 ? CONTINUE_VERTICAL_COLLISION_CHECK : ret
        ret
        
        CONTINUE_VERTICAL_COLLISION_CHECK:
            li t5,0
            addi t3,t3,1
            j CHECK_MAP_COLLISION



CHECK_MAP_COLLISION_DOOR:
    # Checking if player's already blocked
    bnez a0, CONTINUE_CHECK_MAP_COLLISION_DOOR_1 # If a0 is 0 (can't move) stop procedure
    ret
    # Checking if enough checks have been made
    CONTINUE_CHECK_MAP_COLLISION_DOOR_1:
        bge t5, zero, CONTINUE_CHECK_MAP_COLLISION_DOOR_2 # If t5 < 0, stop procedure
        ret
    # Checking tile, to see if there's a door
    CONTINUE_CHECK_MAP_COLLISION_DOOR_2:
        lbu t1,0(t3)  # Loads tile from current map
        li t0,40      # Tile number of door
        bge t1,t0, COLLISION_DOOR   # If tile is a door (t1 >= 40), check if it's open or not
        li a0, 1
        j CONTINUE_CHECK_MAP_COLLISION_DOOR_3  # Otherwise, skip the door check

    COLLISION_DOOR:
        mv a0, zero # Player can't move
    
    CONTINUE_CHECK_MAP_COLLISION_DOOR_3:
        blt zero, t5, CONTINUE_CHECK_MAP_COLLISION_DOOR_4 # If t5 > 0, continue checking
        ret # Otherwise, return
    
    CONTINUE_CHECK_MAP_COLLISION_DOOR_4:
        li t0, 3
        bge t5, t0, VERTICAL_COLLISION_DOOR_CHECK  # If t5 >= 3, it's a vertical collision check
    
    HORIZONTAL_COLLISION_DOOR_CHECK:
        add t3,t3,t4   # t3 = map address + matrix width
        addi t5,t5,-1  # Updates t5
        lbu t0, 16(a3) # Loads morph ball status
        beqz t0, CONTINUE_HORIZONTAL_COLLISION_DOOR_CHECK # If player isn't on morph ball (t0 = 0) skip the next step
            addi t5,t5,-1  # Updates t5 again (reduce number of repetitions due to smaller hitbox size)
        CONTINUE_HORIZONTAL_COLLISION_DOOR_CHECK:
        j CHECK_MAP_COLLISION_DOOR # go to next iteration
    
    VERTICAL_COLLISION_DOOR_CHECK:
        li t0, 3  # t0 = 3 -> check collision only once
        bne t0,t5, CONTINUE_VERTICAL_COLLISION_DOOR_CHECK # If t5 != 3, it should do another vertical collision check
            ret
        CONTINUE_VERTICAL_COLLISION_DOOR_CHECK:
            mv t5,zero    # sets t5 to 0 (will stop on next iteration)
            addi t3,t3,1  # adds 1 to t3 (check next tile)
            j CHECK_MAP_COLLISION_DOOR # go to next iteration