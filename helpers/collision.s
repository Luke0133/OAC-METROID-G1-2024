.text

##########################  COLLISION    ##########################
# Uppon calling COLLISION, it is assumed that the player address  #
# stored on PLYR_MATRIX. This label will	#
#    store the current map's address, so it is a "pointer" to   #
#    another "pointer". Remember that when loading the map's	#
#   address (load address of CURRENT_MAP, then load word from	# 
#      CURRENT_MAP: this will be the current map's address)	    #
#################################################################
#     -----------           argument registers           -----------    #
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
    li a4, 1
    lbu t1, 8(a3) # t1 = PLYR_MATRIX X
    lbu t2, 6(a3) # t2 = PLYR_X OFFSET
    
    lbu t4,1(a2) # Loads matrix width
    addi t3,a2,3 # start of matrix
    lbu t5, 10(a3) # t5 = PLYR_MATRIX Y
    mul t5,t5,t4 # PLYR_MATRIX Y * MATRIX WIDTH

    add t3,t3,t5 # t3 = start of mtrix +  PLYR_MATRIX Y * MATRIX WIDTH
    add t3,t3,t1 # t3 = Map address on correct X and Y
    
    bnez a0, CHECK_X_DIRECTION # MOVE_X != 0 ? CHECK_X_DIRECTION : END
    j END_HORIZONTAL_COLLISION 
    
    li t5,0 # t5 = 0 means it's a horizontal check 
    CHECK_X_DIRECTION:
        lb t0, 0(a0) # Loads MOVE_X to a0   
        blt t0, zero, CHECK_X_LEFT # t0 < 0 ? CHECK_X_LEFT : CHECK_X_RIGHT
        j CHECK_X_RIGHT
        
        CHECK_X_LEFT:
            li t0, 8 # t0 = 8 offset pixels 
            beq t2, t0, CONTINUE_CHECK_X_LEFT # offset = 8 ? CONTINUE_CHECK_X_LEFT : END_HORIZONTAL_COLLISION
            j END_HORIZONTAL_COLLISION 
            
            CONTINUE_CHECK_X_LEFT:
                j CHECK_MAP_COLLISION
        
        CHECK_X_RIGHT:
            beqz t2, CONTINUE_CHECK_X_RIGHT # offset = 8 ? CONTINUE_CHECK_X_LEFT : END_HORIZONTAL_COLLISION
            j END_HORIZONTAL_COLLISION 
            
            CONTINUE_CHECK_X_RIGHT:
                addi t3,t3, 1 # Looks to the tile on the right of player's current tile
                j CHECK_MAP_COLLISION
    

    END_HORIZONTAL_COLLISION:
        ret 
        
CHECK_VERTICAL_COLLISION:
    lbu t1, 10(a3) # t1 = PLYR_MATRIX Y
    lbu t2, 7(a3) # t2 = PLYR_Y OFFSET


###################    CHECK MAP COLLISION    ###################    
#   Effectivelly checks the collision by checking which is the      #
#   tile from the normalized address given as an argument (t3)      #
#   arguments: t3, t4, t5 , a3
#   returns a4 = 0 ? Can't move : Can move                          
#   switch (t5):
#       case 0 : pls stop
#       case 1 : horizontal 
#       case 2 : check once vertical
#       case 3 : check twice vertical

CHECK_MAP_COLLISION:  
  #  li a4, 1 # Base case: player can move

START_CHECK_MAP_COLLISION:
    bnez a4, CONTINUE_CHECK_MAP_COLLISION_1
    ret
    CONTINUE_CHECK_MAP_COLLISION_1:

    lbu t1, 0(t3) # Loads normalized map address

    bnez t1,COLLISION_NotBackground
	li a4, 1 # Only option when player can move
    j CONTINUE_CHECK_MAP_COLLISION_2
	
	COLLISION_NotBackground:
    li t0,14
	bne t1,t0, COLLISION_NotDoorLeftTop
    # j SMTH DOOR

	COLLISION_NotDoorLeftTop:
	li t0,12
	bne t1,t0, COLLISION_NotDoorLeftMiddle
    # j SMTH DOOR

    COLLISION_NotDoorLeftMiddle:
	li t0,10
	bne t1,t0, COLLISION_NotDoorLeftBottom
    # j SMTH DOOR
    
    COLLISION_NotDoorLeftBottom:
	li t0,6
	bne t1,t0, COLLISION_NotDoorRightTop
    # j SMTH DOOR

    COLLISION_NotDoorRightTop:
	li t0, 4 
	bne t1,t0, COLLISION_NotDoorRightMiddle
    # j SMTH DOOR
    
	COLLISION_NotDoorRightMiddle:
	li t0, 2 
	bne t1,t0, COLLISION_NotDoorRightBottom
    # j SMTH DOOR

	COLLISION_NotDoorRightBottom:
    li t0, 102
	bne t1,t0, COLLISION_NotLavaT
	# j SMTH KILL PLAYER
    
	COLLISION_NotLavaT:
    li a4, 0 # Player can't move

    CONTINUE_CHECK_MAP_COLLISION_2:
    lbu t0, 16(a3) # Loads morph ball status
    beqz t0, CONTINUE_CHECK_MAP_COLLISION_3
    ret
    
    CONTINUE_CHECK_MAP_COLLISION_3:
    bnez t5, CONTINUE_CHECK_MAP_COLLISION_4
    ret
    
    CONTINUE_CHECK_MAP_COLLISION_4:
    li t0, 1
    bne t0, t5, VERTICAL_COLLISION_CHECK
    
    HORIZONTAL_COLLISON_CHECK:
        add t3,t3,t4 # t3 = map address + matrix width
        li t5,0
        j START_CHECK_MAP_COLLISION
    
    VERTICAL_COLLISION_CHECK:
        li t0, 2
        bne t0,t5, CONTINUE_VERTICAL_COLLISION_CHECK
        ret
        CONTINUE_VERTICAL_COLLISION_CHECK:
            li t5,0
            lbu t0, 13(a3) # Loads horizontal facing direction
            beqz t0, VERTICAL_COLLISION_CHECK_RIGHT
            VERTICAL_COLLISION_CHECK_LEFT:
                addi t3,t3,-1
                j START_CHECK_MAP_COLLISION
            VERTICAL_COLLISION_CHECK_RIGHT:
                addi t3,t3,1
                j START_CHECK_MAP_COLLISION