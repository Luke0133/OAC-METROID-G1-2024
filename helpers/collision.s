.text

##########################  COLLISION    ##########################
# Uppon calling COLLISION, it is assumed that the player address  #
# stored on PLYR_MATRIX. This label will	#
#    store the current map's address, so it is a "pointer" to   #
#    another "pointer". Remember that when loading the map's	#
#   address (load address of CURRENT_MAP, then load word from	# 
#      CURRENT_MAP: this will be the current map's address)	    #
#################################################################
#     -----------     DONT USE THESE registers           -----------    #
#	a0 = MOVE_X/MOVE_Y address (located on main.s)		#
#	a1 = CURRENT_MAP address (located on main.s)		#
#	a2 = current map's address (located on matrix.data)	#
#   a3 = PLYR_POS
#   a4 = Move_X/Y in tile format
#   a6 = player offset (t4)
#   a7 = player x on matrix 
#   s11 = what to add to map matrix (-1, 0 or 1)
#   t5,t3 = Temporary Registers


CHECK_HORIZONTAL_COLLISION:
li s8 1
#################################
    lbu t1, 8(a3)  # t1 = Player's X related to matrix
    lbu t2, 6(a3)  # t2 = Player's X offset
    
    lbu t4,1(a2)   # Loads Map Matrix's width
    addi t3,a2,3   # Adds 3 to the Matrix's address so that it goes to the begining of matrix
    lbu t5, 10(a3) # t5 = Player's Y related to matrix
    mul t5,t5,t4   # Player's Y related to matrix * Map Matrix's width
    add t5,t1,t5   # t5 = Player's X related to matrix +  Player's Y related to matrix * Map Matrix's width  

    add t3,t3,t5   # t3 = Map Matrix's address adjusted for Player's X and Y related to matrix
    
    lb t0, 0(a0)   # Loads MOVE_X information to t0
    bnez t0, CHECK_X_DIRECTION # MOVE_X != 0 ? j CHECK_X_DIRECTION : j END_HORIZONTAL_COLLISION 
    j END_HORIZONTAL_COLLISION 
    
    CHECK_X_DIRECTION:
        la t1, MOVE_Y # Loads MOVE_Y address
        lb t1,0(t1)   # Loads MOVE_Y content
        beqz t1, SKIP_THIRD_CHECK # If MOVE_Y = 0, skip
            bge zero,t1, UPWARDS_THIRD_CHECK # If MOVE_Y = 1 (down) continue
                la t1, PLYR_POS # Loads PLYR_POS address
                lb t1, 7(t1)    # Loads Y offset
                beqz t1 SKIP_THIRD_CHECK # If Y offset is zero, there's no need to check 3 tiles
                    li t5, 2    # Checks 3 tiles horizontally (or 2 if on morph ball)
                    j CONTINUE_CHECK_X_DIRECTION
            UPWARDS_THIRD_CHECK: # If MOVE_Y = -1 (up)
                la t1, PLYR_POS # Loads PLYR_POS address
                lb t1, 7(t1)    # Loads Y offset
                li t5, 8        # Represents the desired offset
                bge t5, t1 SKIP_THIRD_CHECK # If Y offset is zero, there's no need to check 3 tiles
                # Otherwise, t5 is already = 2 , so it'll check 3 tiles horizontally (or 2 if on morph ball)
                    li t5, 2        # Represents the desired offset
                    j CONTINUE_CHECK_X_DIRECTION
        SKIP_THIRD_CHECK:
            li t5,1 # Checks 2 tiles horizontally (or 1 if on morph ball)
        CONTINUE_CHECK_X_DIRECTION:
        blt t0, zero, CHECK_X_LEFT # t0 < 0 ? CHECK_X_LEFT : CHECK_X_RIGHT
        j CHECK_X_RIGHT
        
        CHECK_X_LEFT:
            li t0, 12 # t0 = 8 offset pixels 
            beq t2, t0, CONTINUE_CHECK_X_LEFT # offset = 8 ? CONTINUE_CHECK_X_LEFT : END_HORIZONTAL_COLLISION
            j END_HORIZONTAL_COLLISION 
            
            CONTINUE_CHECK_X_LEFT:
                j CHECK_MAP_COLLISION
        
        CHECK_X_RIGHT:
            li t0, 4 # t0 = 4 offset pixels 
            beq t2, t0, CONTINUE_CHECK_X_RIGHT # offset = 0 ? CONTINUE_CHECK_X_LEFT : END_HORIZONTAL_COLLISION
            j END_HORIZONTAL_COLLISION 
            
            CONTINUE_CHECK_X_RIGHT:
                addi t3,t3, 1 # Looks to the tile on the right of player's current tile
                j CHECK_MAP_COLLISION
    

    END_HORIZONTAL_COLLISION:
        li a0,1
        ret 
        
CHECK_VERTICAL_COLLISION:
li s8 0
#################################
    lbu t1, 8(a3) # t1 = PLYR_MATRIX Y
    lbu t2, 7(a3) # t2 = PLYR_Y OFFSET

    lbu t4,1(a2) # Loads matrix width
    addi t3,a2,3 # start of matrix
    lbu t5, 10(a3) # t5 = PLYR_MATRIX Y
    mul t5,t5,t4 # PLYR_MATRIX Y * MATRIX WIDTH
    add t5,t1,t5 # t5 = PLYR_MATRIX X + PLYR_MATRIX Y * MATRIX WIDTH  

    add t3,t3,t5 # t3 = Map address on correct X and Y
    lbu t1, 10(a3) # t1 = PLYR_MATRIX Y   

    lb t0, 0(a0) # Loads MOVE_Y to t0 

    li t5, 3 # t5 = 2 ? Vertical
        
    blt t0,zero, CHECK_Y_UP # t0 < 0 ? CHECK_Y_UP : CHECK_Y_DOWN
    j CHECK_Y_DOWN
    
    CHECK_Y_UP:
        ## TODO: Implement sprite ball colision testing
        beqz t2 CONTINUE_CHECK_Y_UP # offset = 0 ? CONTINUE_CHECK_X_LEFT : END_HORIZONTAL_COLLISION
        j END_VERTICAL_COLLISION
    
        CONTINUE_CHECK_Y_UP: 
            sub t3,t3,t4    # - 1 matrix Y (up)
            lbu t0,13(a3)    # Loads Facing direction (0 = Right, 1 = Left)
            lbu t2, 6(a3)    # t2 = Player's Y offset
            beqz t0, CHECK_Y_UP_RIGHT # t0 = 0 ? CHECK_Y_UP_RIGHT : CHECK_Y_UP_LEFT
            j CHECK_Y_UP_LEFT
            
            CHECK_Y_UP_RIGHT:
                li t0, 8 # Compare X offset with 8
                blt t2,t0, CHECK_1_TILE_RIGHT
                li t0,12 # Compare X offset with 12
                bge t2,t0, CHECK_1_TILE_RIGHT_2
                li t5, 4 # Check two tiles downwards - case 3
                
                CHECK_1_TILE_RIGHT:
                    j CHECK_MAP_COLLISION
                CHECK_1_TILE_RIGHT_2:
                    addi t3,t3,1
                    j CHECK_MAP_COLLISION 
            
            CHECK_Y_UP_LEFT:
                li t0, 4 # Compare X offset with 4
                bge t0,t2, CHECK_1_TILE_LEFT 
                li t0, 12 # Compare X offset with 12
                bge t2,t0, CHECK_RIGHT_TILE_LEFT
                li t5, 4 # Check two tiles upwards - case 3
                
                CHECK_1_TILE_LEFT:
                    j CHECK_MAP_COLLISION
                CHECK_RIGHT_TILE_LEFT:
                    addi t3,t3,1 # Tile to the right
                    j CHECK_MAP_COLLISION
    
    CHECK_Y_DOWN:
        ## TODO: Implement sprite ball colision testing
        beqz t2 CONTINUE_CHECK_Y_DOWN # offset = 0 ? CONTINUE_CHECK_X_LEFT : END_HORIZONTAL_COLLISION
        li t1,2
        beq, t1 t2 CONTINUE_CHECK_Y_DOWN # offset = 0 ? CONTINUE_CHECK_X_LEFT : END_HORIZONTAL_COLLISION
        j END_VERTICAL_COLLISION
    
        CONTINUE_CHECK_Y_DOWN: 
            add t3,t3,t4     # 1 matrix Y (down)
            add t3,t3,t4     # 1 matrix Y (down)
            lbu t0,13(a3)    # Loads Facing direction (0 = Right, 1 = Left)
            lbu t2, 6(a3)    # t2 = Player's Y offset
            beqz t0, CHECK_Y_DOWN_RIGHT # t0 = 0 ? CHECK_Y_UP_RIGHT : CHECK_Y_UP_LEFT
            j CHECK_Y_DOWN_LEFT
            
            CHECK_Y_DOWN_RIGHT:
                li t0, 8 # Compare X offset with 8
                blt t2,t0, CHECK_1_TILE_DOWN_RIGHT 
                li t0,12 # Compare X offset with 12
                bge t2,t0, CHECK_1_TILE_DOWN_RIGHT_2
                li t5, 4 # Check two tiles downwards - case 3
                
                CHECK_1_TILE_DOWN_RIGHT: # Checks the tile to the left
                    j CHECK_MAP_COLLISION
                CHECK_1_TILE_DOWN_RIGHT_2: # Checks the tile to the right
                    addi t3,t3,1
                    j CHECK_MAP_COLLISION 
            
            CHECK_Y_DOWN_LEFT:
                li t0, 4 # Compare X offset with 4
                bge t0,t2, CHECK_1_TILE_DOWN_LEFT 
                li t0, 12 # Compare X offset with 12
                bge t2,t0, CHECK_RIGHT_TILE_DOWN_LEFT # Will check the tile on the right and not the one the player is currently at
                li t5, 4 # Check two tiles downwards - case 3
                
                CHECK_1_TILE_DOWN_LEFT:
                    j CHECK_MAP_COLLISION
                CHECK_RIGHT_TILE_DOWN_LEFT:
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
#       case 3 (2) : check once vertical
#       case 4 (3) : check twice vertical

CHECK_MAP_COLLISION:  
  #  li a4, 1 # Base case: player can move
START_CHECK_MAP_COLLISION:

    bnez a0, CONTINUE_CHECK_MAP_COLLISION_1 # a0 != 0 ? CONTINUE_CHECK_MAP_COLLISION_1 : ret
    ret
    CONTINUE_CHECK_MAP_COLLISION_1:
    lbu t1, 0(t3) # Loads tile from current map

    li t0, 3
    blt t0, t1,COLLISION_NotBackground # If tile isn't passthrough or breakable (t1 > 3)
    # If tile is passthrough or breakable (0 <= t1 <= 3)
        li a0, 1 # Only option when player can move
        beq a0,t1, COLLISION_BREAKABLE  # If tile is breakable, there needs to be a check if it was broken
            j CONTINUE_CHECK_MAP_COLLISION_2 # Otherwise, continue checking collision
    
    COLLISION_BREAKABLE:
# ---> make breakable block work :)
    # li a0, 0 # Player can't move  
    j CONTINUE_CHECK_MAP_COLLISION_2
	
	COLLISION_NotBackground:
        li t0,36
        bge t1,t0, COLLISION_SPECIAL  # If current tile is a door or a damaging tile (t1 >= 36)
            j COLLISION_BLOCKED # If tile isn't special (3 < t1 < 36)

	COLLISION_SPECIAL:
        li t0,40
        bge t1,t0, COLLISION_DOOR   # If tile is a door (t1 >= 40)
            j COLLISION_DAMAGE  # If tile deals damage (36 <= t1 < 40)

    COLLISION_DOOR:
# ---> make doors work :)
        j COLLISION_BLOCKED # For now >:[
    
    COLLISION_DAMAGE:
# ---> make damage work :)
        j COLLISION_BLOCKED # For now >:[
    
    COLLISION_BLOCKED:
        li a0, 0 # Player can't move  
    CONTINUE_CHECK_MAP_COLLISION_2:
    bnez t5, CONTINUE_CHECK_MAP_COLLISION_3 # t5 != 0 ? CONTINUE_CHECK_MAP_COLLISION_4 : RET
###########################
#            beqz s8,NONONOONON
#            mv s3,a0
#            mv s2,a7
#            la a0, DEBUG
#            li a7, 4
#            ecall
#            mv a0,s1
#            mv a7,s2
#            NONONOONON:
######################
    ret
    
    CONTINUE_CHECK_MAP_COLLISION_3:
    li t0, 3
    bge t5, t0, VERTICAL_COLLISION_CHECK # 1 != t5 ? VERTICAL_COLLISION_CHECK : HORIZONTAL_COLLISON_CHECK
    
    HORIZONTAL_COLLISON_CHECK:

        add t3,t3,t4   # t3 = map address + matrix width
        addi t5,t5,-1  # Updates t5
        lbu t0, 16(a3) # Loads morph ball status
        beqz t0, CONTINUE_HORIZONTAL_COLLISON_CHECK # t0 (ball mode) = 0 (not ball mode) ? CONTINUE_HORIZONTAL_COLLISON_CHECK : continue
            addi t5,t5,-1  # Updates t5 again (reduce number of repetitions due to smaller hitbox size)
        CONTINUE_HORIZONTAL_COLLISON_CHECK:
        j START_CHECK_MAP_COLLISION
    
    VERTICAL_COLLISION_CHECK:
        li t0, 3
        bne t0,t5, CONTINUE_VERTICAL_COLLISION_CHECK # 3 != t5 ? CONTINUE_VERTICAL_COLLISION_CHECK : ret
        ret
        
        CONTINUE_VERTICAL_COLLISION_CHECK:
            li t5,0
            addi t3,t3,1
            j START_CHECK_MAP_COLLISION

