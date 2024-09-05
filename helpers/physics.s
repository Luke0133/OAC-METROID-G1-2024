.text
##########################     PHYSICS     #########################
#   Uppon calling PHYSICS, it is assumed that the address of the   #
#     current map is already stored on CURRENT_MAP. This label     # 
#  will check how the player will move and if the map should move  #
#     as well. It'll first check horizontally and, afterwards,     #
#      vertically, only when there's movement from the player      #
#                                                                  #
#  ----------------        registers used        ----------------  #
#	 a0 = MOVE_X/MOVE_Y address (located on main.s)		           #
#	 a1 = CURRENT_MAP address (located on main.s)		           #
#	 a2 = current map's address (located on matrix.data)	       #
#    a3 = PLYR_POS                                                 #
#    a4 = Move_X/Y in tile format                                  #
#    a6 = player offset (t4)                                       #
#    a7 = player x on matrix                                       #
#    t0 -- t5 = Temporary Registers                                #
#                                                                  #
####################################################################

PHYSICS:
    la a0, MOVE_X	       # Loads address of MOVE_X
    lb t0, 0(a0)	       # Loads information from MOVE_X
    la a1, CURRENT_MAP     # Loads CURRENT_MAP's address
    lw a2, 0(a1) 	       # a2 has the current map's address 
    la a3, PLYR_POS        # Loads Player Position
    
    bnez t0, MOVE_PLAYER_X # If there's X movement, go to MOVE_PLAYER_X
    lh t1, 0(a3)  # Loads Player's X related to screen
    sh t1, 2(a3)  # Stores Player's X related to screen on old X
    lbu t1, 8(a3)  # Loads Player's X related to screen
    sb t1, 9(a3)  # Stores Player's X related to screen on old X
    j CHECK_MOVE_Y         # Otherwise, go check Y movement
    
    MOVE_PLAYER_X:
        slli a4, t0, 2  # Multiplies the value stored on MOVE_X by 4. a0 will store the movement of the player (+/- 4 pixels)
        
        lbu t1, 13(a3)  # Loads Player's Facing direction (0 = Right, 1 = Left)
        add t0,t0,t1    # Adds Facing direction with MOVE_X (if the result t0 = -1 or 2, the direction has changed)
        li t2,2         # t1 = 2
        bgeu t0,t2,CHANGE_X_DIRECTION # If t0 = -1 or 2, the direction chas changed
            j KEEP_X_DIRECTION 
        CHANGE_X_DIRECTION:
        # If the direction has changed, no movement will happen, and only the facing direction will be altered
            xori t1,t1,1   # Inverts direction (0 -> 1; 1 -> 0)
            sb t1, 13(a3)  # Loads Player's Facing direction (0 = Right, 1 = Left)
            j CHECK_MOVE_Y
        KEEP_X_DIRECTION:
            lb a6, 6(a3)	# Loads Player's X offset
            add a6,a6,a4	# Adds the X Movement to the Player's Offset
            
            lbu a7, 8(a3)	# Loads Player's X on Matrix
            sb a7, 9(a3)	# Stores Player's X on Matrix on the Old X
            
            bge a6,zero,SKIP_LEFT_X
            
            # If a6 < 0, Player is moving to the left tile
            addi a7, a7, -1		  # Player's X on matrix -= 1 (goes to the left)
            addi a6,a6,tile_size  # Offset gets corrected (relative to new X on matrix coordinate)
        
        SKIP_LEFT_X:
            li t3, tile_size
            blt a6,t3, SKIP_RIGHT_X
            # If a6 >= 16, Player is moving to the right tile
            addi a7,a7, 1	 # Player's X on matrix += 1 (goes to the right)
            sub a6,a6,t3	 # Offset gets corrected (relative to new X on matrix coordinate)
        
        SKIP_RIGHT_X:
        # Storing Registers on Stack
            addi sp,sp,-32
            sw a7,28(sp)
            sw a6,24(sp)
            sw a4,20(sp)
            sw a3,16(sp)
            sw a2,12(sp)
            sw a1,8(sp)
            sw a0,4(sp)
            sw ra,0(sp)
            
            mv a1,a2 # Moves current map's address to a1 
            mv a2,a3 # Moves PLYR_POS to a2
            call CHECK_HORIZONTAL_COLLISION # Checking collision
            ERROR_ON_SWITCH:   # Label used from SWITCH_MAP on map_op.s
            mv t0,a0     # Moves result of collision check to t0 

        # Procedure finished: Loading Registers from Stack
            lw a7,28(sp)
            lw a6,24(sp)
            lw a4,20(sp)
            lw a3,16(sp)
            lw a2,12(sp)
            lw a1,8(sp)
            lw a0,4(sp)
            lw ra,0(sp)
            addi sp,sp,32

            # After checking collision
            lh t2, 0(a3)          # Loads Player's Current X
            bnez t0, CAN_MOVE_X   # If a0 != 0, player can move (go to CAN_MOVE_X)
            # Otherwise, player can't move, so
                mv t5,t2              # store player's current X (t2) in t5
                la t0,PLYR_INPUT      # Loads PLYR_INPUT on t0
                li t1, 2              # Sets t1 to 2 (there's player input, but can't move)
                sb t1, 0(t0)          # and stores it in PLYR_INPUT
                j Fixed_X_Map
        
        CAN_MOVE_X: 
        la t0,PLYR_INPUT      # Loads PLYR_INPUT on t0
        li t1, 1              # Sets t1 to 1 (there's player input, and can move)
        sb t1, 0(t0)          # and stores it in PLYR_INPUT

        sb a6, 6(a3)    # Stores new X offset
        sb a7, 8(a3)    # Stores new X coordinate on matrix

        add t5, a4, t2  # t5 = Player's current X + Movement of Player on X axis
    
        lbu t0, 0(a2)   # loads first byte to check what type of map it is (0 - Fixed, 1 - Horizontal, 2 - Vertical)
        li t3, 1        # Loads 1 and 
        bne t3, t0, Fixed_X_Map # compares with the result
        j Horizontal_Map
        
        Fixed_X_Map:
          # If the map has a fixed X on matrix, that is, the screen won't follow the player, the player will move related to the screen
          sh t2,2(a3) # Stores original X on old X related to screen
          sh t5,0(a3) # Stores new X on current X related to screen
          j CHECK_MOVE_Y
    
        Horizontal_Map:
            lbu t0, 6(a1)    # Loads Map's X postition on Matrix
            lbu t1, 8(a1)    # Loads Map's X offset
                        
            li t3, left_hor_border      # loads left_border = 120 
            blt t3, t5, NOT_LEFT_BORDER_PASS  # if new player position on screen doesn't pass the left border, go to NOT_LEFT_BORDER_PASS
          	
            # Otherwise, if new player position on screen passes left border, check if it is on left corner of the map
            add t4,t0,t1     # Will be 0 if Map's X offset and X position are 0
          	beqz t4, Fixed_X_Map  # If on leftmost part of the map, map won't move
            j MOVE_SCREEN_X     # otherwise, move the map left

        NOT_LEFT_BORDER_PASS:   # Checking if passed the Right Horizontal Border
            li t3, right_hor_border #loads right_border = 180 
            bge t3,t5,Fixed_X_Map   # if new player position on screen doesn't pass the right border, go to Fixed_X_Map
            lbu t1, 1(a2)    # Loads Map matrix width
            li t3, m_screen_width # Loads Map screen width related to matrix
            sub t1,t1,t3    # t1 = Map Matrix Width - Screen Matrix Width (t1 = Map's X when it's on rightmost part of the map)
            beq t0,t1, Fixed_X_Map  # If on rightmost part of the map, map won't move
            # otherwise, move the map right
        
        MOVE_SCREEN_X:
            li t3, 2       # t3 = 2 (map will be rendered again)
            sb t3, 5(a1)   # Stores t3 on CURRENT_MAP's rendering byte
            sh t2,2(a3)    # Stores player's original X on old X related to screen
    
            # Updating map's X offset
            lbu t2, 6(a1)  # Loads Map X postition on Matrix
            lbu a6, 8(a1)  # Loads map's X offset
            add a6,a6,a4  # Adds the X Movement to the map's Offset
            li t1,0  # Right now, the map's X won't be updated 
            bge a6, zero, NO_X_OFFSET_NEGATIVE_CORRECTION 
            # If y offset is currently negative
                beqz t2 LEFTMOST_PART_OF_MAP_RESET
                # If map isn't currently on 0x0
                    li t1, -1
                    addi a6,a6,tile_size # Corrects negative offset by adding 16
                    j NO_X_OFFSET_CORRECTION
                LEFTMOST_PART_OF_MAP_RESET:
                # If on leftmost part of the map (0x0), reset X offset to 0
                    li a6,0
                    j NO_X_OFFSET_CORRECTION

            NO_X_OFFSET_NEGATIVE_CORRECTION:
            # If x offset is currently positive
                li t0, tile_size
                blt a6,t0, NO_X_OFFSET_CORRECTION
                li t1,1
                sub a6,a6,t0 # Corrects values that surpass 16 by subtracting 16 from them

            NO_X_OFFSET_CORRECTION:
                sb a6, 8(a1)   # Stores Map new X offset that is equal to player's X offset
                add t2,t2,t1  # adds to the X -1, 0 or 1 (moves map horizontally)
                sb t2, 6(a1)   # Stores Map X postition on Matrix
                j CHECK_MOVE_Y
      
      
CHECK_MOVE_Y:
    la a0, MOVE_Y	       # Loads address of MOVE_Y
    lb t0, 0(a0)	       # Loads information from MOVE_Y
    la a1, CURRENT_MAP     # Loads CURRENT_MAP's address
    lw a2, 0(a1) 	       # a2 has the current map's address 
    la a3, PLYR_POS        # Loads Player Position address
    
    bnez t0, MOVE_PLAYER_Y # If there's Y movement, go to MOVE_PLAYER_Y
        lbu t1, 4(a3)  # Loads Player's Y related to screen
        sb t1, 5(a3)  # Stores Player's Y related to screen on old Y
        lbu t1, 10(a3)  # Loads Player's Y related to screen
        sb t1, 11(a3)  # Stores Player's Y related to screen on old Y
        
        addi sp,sp,-20
        sw a3,16(sp)
        sw a2,12(sp)
        sw a1,8(sp)
        sw a0,4(sp)
        sw ra,0(sp)

        mv a1,a2 # Moves current map's address to a1 
        mv a2,a3 # Moves PLYR_POS to a2
        call CHECK_VERTICAL_COLLISION # Checking collision
        mv t0,a0     # Moves result of collision check to t0 

        # Procedure finished: Loading Registers from Stack
        lw a3,16(sp)
        lw a2,12(sp)
        lw a1,8(sp)
        lw a0,4(sp)
        lw ra,0(sp)
        addi sp,sp,20

        beqz t0, HAS_GROUND    # If t0 (holds result of collision check) != 0 go to HAS_GROUND
        # Otherwise, continue (down)
        la a0, MOVE_Y	   # Loads address of MOVE_Y
        li t0, 1           # Gets number correspondent to DOWN (1)
        sb t0, 0(a0)	   # and stores it
        # li t0, 1           # Loads ground position (1 = freefall)
        # sb t0,15(a3)     # and stores it
        j MOVE_PLAYER_Y
    
    HAS_GROUND:  
      j END_PHYSICS

    MOVE_PLAYER_Y:
        lbu t2, 1(a0)   # Loads JUMP information
        blt t0,zero, MOVE_PLAYER_UP
        j MOVE_PLAYER_DOWN
        
        MOVE_PLAYER_UP:
            li t1, min_jump # minimum height of jump required for the movement 
            blt t2, t1, SKIP_INPUT_CHECK
            lbu t1, 2(a0)   # Loads PLYR_INPUT
            bnez t1, SKIP_INPUT_CHECK # t1 != 0 ? SKIP_INPUT_CHECK : SWITCH_DOWN
            j SWITCH_DOWN
            
            SKIP_INPUT_CHECK:
                li t1, max_jump # minimum height of jump required for the movement 
                blt t2, t1, ITERATE_JUMP   # 
                j SWITCH_DOWN
                
                ITERATE_JUMP:
                li t1, slow_jump # threshold of max height to slow down
                blt t2, t1, JUMP_4_PIXELS
                li t1, 1 # Will increment only 2 pixels up
                addi t2,t2,2
                j CONTINUE_MOVE_PLAYER_Y
                JUMP_4_PIXELS:
                    li t1 medium_jump
                    blt t2,t1, JUMP_8_PIXELS
                        li t1, 2 # Will increment 4 pixels up
                        addi t2,t2,4
                        j CONTINUE_MOVE_PLAYER_Y
                    JUMP_8_PIXELS:
                        li t1, 3 # Will increment 4 pixels up
                        addi t2,t2,8
                        j CONTINUE_MOVE_PLAYER_Y
                    
            SWITCH_DOWN:
                la t0,PLYR_INPUT      # Loads PLYR_INPUT on t0
                li t1, 1              # Sets t1 to 1 (there's player input, and can move)
                sb t1, 0(t0)          # and stores it in PLYR_INPUT 
                
                sb zero, 1(a0) # reset jump information
                li t1, 1
                sb t1,0(a0) # Switches MOVE_Y to 1 (Down)            
                j END_PHYSICS
        MOVE_PLAYER_DOWN:
            li t1, min_jump
            lbu t2, 1(a0)   # Loads JUMP information
            blt t2, t1, FALL_2_PIXELS
            li t1, 2 # Will increment 4 pixels down
            addi t2,t2,4
            j CONTINUE_MOVE_PLAYER_Y
            
            FALL_2_PIXELS:
                li t1, 1 # Will increment only 2 pixels down
                addi t2,t2,2
                j CONTINUE_MOVE_PLAYER_Y
        
        CONTINUE_MOVE_PLAYER_Y:
        # t1 will hold the value to multiply with t0 (MOVE_Y)
        sb t2, 1(a0)
        sll a4, t0, t1  # Multiplies the value stored on MOVE_Y by 4. a0 will store the movement of the player (+/- 4 pixels)

        lbu t2, 1(a0)   # Loads JUMP information
        lbu a6, 7(a3)	# Loads Player's Y offset

        add a6,a6,a4	# Adds the X Movement to the Player's Offset
        
        lbu a7, 10(a3)	# Loads Player's Y on Matrix
        sb a7, 11(a3)	# Stores Plater's Y on Matrix on the Old Y
        
        bge a6,zero,SKIP_UP_Y
        # If a6 < 0, Player is moving to the upper tile
        addi a7, a7, -1		  # Player's Y on matrix -= 1 (goes to the left)
        addi a6,a6,tile_size  # Offset gets corrected (relative to new X on matrix coordinate)
        
        SKIP_UP_Y:
            li t3, tile_size
            blt a6,t3, SKIP_DOWN_Y
            # If a6 >= 16, Player is moving to the lower tile
            addi a7,a7, 1	 # Player's Y on matrix += 1 (goes to the right)
            sub a6,a6,t3	 # Offset gets corrected (relative to new Y on matrix coordinate)
        
        SKIP_DOWN_Y:  
        # Storing Registers on Stack
            addi sp,sp,-32
            sw a7,28(sp)
            sw a6,24(sp)
            sw a4,20(sp)
            sw a3,16(sp)
            sw a2,12(sp)
            sw a1,8(sp)
            sw a0,4(sp)
            sw ra,0(sp)

            mv a1,a2 # Moves current map's address to a1 
            mv a2,a3 # Moves PLYR_POS to a2
            call CHECK_VERTICAL_COLLISION # Checking collision
            mv t0,a0     # Moves result of collision check to t0 

        # Procedure finished: Loading Registers from Stack
            lw a7,28(sp)
            lw a6,24(sp)
            lw a4,20(sp)
            lw a3,16(sp)
            lw a2,12(sp)
            lw a1,8(sp)
            lw a0,4(sp)
            lw ra,0(sp)
            addi sp,sp,32
            
            # After checking collision
            lbu t2, 4(a3)    # Loads Player's Current Y
            bnez t0, CAN_MOVE_Y # t0 != 0 ? CAN_MOVE_Y : Fixed_Y_Map
                mv t5,t2 # storing PLYRS_current Y in t5
                #  la a0, MOVE_Y
                #  sb zero,15(a3)  # Sets player status to be on ground
                lb t0, 0(a0) # Gets MOVE_Y info
                blt t0,zero, STOP_JUMP # If t1 <= -1 (aka, player would start jumping), reset
                    # If t0 = 0 (not jumping) or t1 = 1 (freefall), reset MOVE_Y and JUMP
                    lbu t0, 7(a3)  # Loads player's Y offset
                    li t1, 14
                    bne t1,t0,SKIP_ADJUST_Y # If player is on ground and Y offset = 0, don't reajust position
                    # Otherwise, 
                       # addi a7,a7,1 # Player's Y on matrix += 1 (goes another tile down)
                        sb a7, 10(a3)   # Stores new Y coordinate on matrix
                        addi t2,t2,2    # add player's Y with the Y offset
                        mv t5,t2        # and stores PLYRS_current Y in t5
                        lbu t0, 0(a2)   # Loads first byte to check what type of map it is (0 - Fixed, 1 - Horizontal, 2 - Vertical)
                        li t3, 2        # Loads 2 and 
                        bne t3, t0, SKIP_ADJUST_Y # compares with the result
                        # If map is vertical, correct its offset and coordinates
                            sb zero, 9(a1)   # Sets map's Y offset to 0
                            lbu t4, 2(a2)    # Loads Map matrix height
                            li t3, m_screen_height # Loads Map screen height related to matrix
                            sub t3,t4,t3     # t4 = Map Matrix Height - Screen Matrix Height (t4 = Map's Y when it's on lowermost part of the map)
                            lbu t4, 7(a1)    # Loads Map Y postition on Matrix
                            bge t4,t3,SKIP_ADJUST_Y  # If on lowermost Y, don't update map's Y it
                            beqz t4,SKIP_ADJUST_Y    # If on topmost Y, don't update map's Y it
                            addi t4,t4,1     # adds 1 to it
                            sb t4, 7(a1)     # and stores it
                            li t3, 2         # t3 = 2 (map will be rendered again)
                            sb t3, 5(a1)     # Stores t3 on CURRENT_MAP's rendering byte
                    SKIP_ADJUST_Y:
                    sb zero, 7(a3) # Sets player's Y offset to 0
                    sb zero, 0(a0) # MOVE_Y = 0
                    li t1,-1
                    sb t1, 1(a0) # JUMP = 0
                    j Fixed_Y_Map
                STOP_JUMP:
                    # if t0 = -1 (jumping) check if player is already jumping or not
                    li t0,8
                    lbu t1,1(a0) # Gets JUMP info
                    slt t0,t0,t1 # t1 > 8 ? t0 = 1 : t0 = 0
                    sb t0, 0(a0) # MOVE_Y = t0 
                    sb zero,1(a0) # reseting jump byte
                    j Fixed_Y_Map
        
        CAN_MOVE_Y:  
            la t0,PLYR_INPUT      # Loads PLYR_INPUT on t0
            li t1, 1              # Sets t1 to 1 (there's player input, and can move)
            sb t1, 0(t0)          # and stores it in PLYR_INPUT 
            
            sb a6, 7(a3)    # Stores new Y offset
            sb a7, 10(a3)   # Stores new Y coordinate on matrix

            add t5, a4, t2  # t5 = Player's current X + Movement of Player on X axis
            
            lbu t0, 0(a2)   # loads first byte to check what type of map it is (0 - Fixed, 1 - Horizontal, 2 - Vertical)
            li t3, 2        # Loads 2 and 
            bne t3, t0, Fixed_Y_Map # compares with the result
            j Vertical_Map
        
        Fixed_Y_Map:
            # If the map has a fixed Y on matrix, that is, the screen won't follow the player, the player will move related to the screen
            lbu t2 7(a1)    # Gets map's Y related to matrix
            lbu t5, 10(a3)	# Loads Player's Y related to matrix
            sub t5,t5,t2    # Gets the Y matrix related to the map's Y
            slli t5,t5,tile_size_shift # Multiplies t5 by 16 in order to get Y related to screen
            lbu t2, 7(a3)	# Loads Player's Y offset
            add t5,t5,t2    # Adds offset to position
            lbu t2 9(a1)    # Gets map's offset
            sub t5,t5,t2    # and takes it from player's position

            sb t5,5(a3) # Stores original Y on old Y  related to screen
            sb t5,4(a3) # Stores new Y on current Y related to screen
            j END_PHYSICS

        Vertical_Map:
            lbu t0, 7(a1)    # Loads Map's Y postition on Matrix
            lbu t1, 9(a1)    # Loads Map's Y offset
                        
            li t3, top_ver_border      # loads top vertical border = 94 
            blt t3, t5, NOT_TOP_BORDER_PASS  # if new player position on screen doesn't pass the upper border, go to NOT_LEFT_BORDER_PASS
            # Otherwise, if new player position on screen passes left border, check if it is on uppermost part of the map
            add t4,t0,t1     # Will be 0 if Map's X offset and X position are 0
            beqz t4, Fixed_Y_Map  # If on uppermost part of the map, map won't move
            j MOVE_SCREEN_Y     # otherwise, move the map left

        NOT_TOP_BORDER_PASS:   # Checking if passed the Right Horizontal Border
            li t3, bottom_ver_border #loads bottom vertical border = 96 
            bge t3,t5,Fixed_Y_Map   # if new player position on screen doesn't pass the lower border, go to Fixed_X_Map
            lbu t1, 2(a2)    # Loads Map matrix height
            li t3, m_screen_height # Loads Map screen height related to matrix
            sub t1,t1,t3    # t1 = Map Matrix Height - Screen Matrix Height (t1 = Map's Y when it's on lowermost part of the map)
            beq t0,t1, Fixed_Y_Map  # If on lowermost part of the map, map won't move
            # otherwise, move the map downs
        MOVE_SCREEN_Y:
            li t3, 2       # t3 = 2 (map will be rendered again)
            sb t3, 5(a1)   # Stores t3 on CURRENT_MAP's rendering byte

            sb t2,5(a3)    # Stores player's original Y on old Y related to screen

            # Updating map's Y offset
            lbu t2, 7(a1)  # Loads Map Y postition on Matrix
            lbu a6, 9(a1)  # Loads map's Y offset
            add a6,a6,a4  # Adds the Y Movement to the map's Offset
            li t1,0  # Right now, the map's Y won't be updated 
            bge a6, zero, NO_Y_OFFSET_NEGATIVE_CORRECTION 
            # If y offset is currently negative
                beqz t2 TOP_OF_MAP_RESET
                # If map isn't currently on 0x0
                    li t1, -1
                    addi a6,a6,tile_size # Corrects negative offset by adding 16
                    j NO_Y_OFFSET_CORRECTION
                TOP_OF_MAP_RESET:
                # If on top of the map (0x0), reset Y offset to 0
                    li a6,0
                    j NO_Y_OFFSET_CORRECTION

            NO_Y_OFFSET_NEGATIVE_CORRECTION:
            # If y offset is currently positive
                li t0, tile_size
                blt a6,t0, NO_Y_OFFSET_CORRECTION
                li t1,1
                sub a6,a6,t0 # Corrects values that surpass 16 by subtracting 16 from them

                lbu t4, 2(a2)    # Loads Map matrix height
                li t3, m_screen_height # Loads Map screen height related to matrix
                sub t4,t4,t3     # t4 = Map Matrix Height - Screen Matrix Height (t1 = Map's Y when it's on lowermost part of the map)
                addi t5,t2,1     # Maximum Y on map

                bne t5,t4,NO_Y_OFFSET_CORRECTION    # If t5 != maximum Y on map, skip this next correction
                # Otherwise, if t5 = maximum Y on map
                li a6,0    # set offset to 0               
                
            NO_Y_OFFSET_CORRECTION:
                sb a6, 9(a1)   # Stores Map new Y offset that is equal to player's Y offset
                add t2,t2,t1  # adds to the Y -1, 0 or 1 (moves map horizontally)
                sb t2, 7(a1)   # Stores Map Y postition on Matrix

    END_PHYSICS:
      ret
