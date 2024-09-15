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
    
    la t1, PLYR_INFO_2	   # Loads address of the second part of PLYR_INFO
    lb t1,4(t1)            # Gets the DAMAGE_MOVE_X value

    bnez t0, MOVE_PLAYER_X # If there's X movement, go to MOVE_PLAYER_X
    bnez t1, MOVE_PLAYER_X # Otherwise, if there's damaging X movement, go to MOVE_PLAYER_X
    NO_MOVE_PLAYER_X:
    # Otherwise, don't move player in X axis
    lh t1, 0(a3)  # Loads Player's X related to screen
    sh t1, 2(a3)  # Stores Player's X related to screen on old X
    lbu t1, 8(a3) # Loads Player's X related to screen
    sb t1, 9(a3)  # Stores Player's X related to screen on old X
    j CHECK_MOVE_Y         # Otherwise, go check Y movement
    
    MOVE_PLAYER_X:
        slli a4, t0, 2  # Multiplies the value stored on MOVE_X by 4. a4 will store the movement of the player (+/- 4 pixels)
        
        beqz t1,CONTINUE_MOVE_PLAYER_X  # If there's no damage knockback
        # If damage knockback was set, it'll be the movement
            mv a4,t1    # Adds value from DAMAGE_MOVE_X (if any)

        CONTINUE_MOVE_PLAYER_X:
        lbu t1, 13(a3)  # Loads Player's Facing direction (0 = Right, 1 = Left)
        add t0,t0,t1    # Adds Facing direction with MOVE_X (if the result t0 = -1 or 2, the direction has changed)
        li t2,2         # t1 = 2
        bgeu t0,t2,CHANGE_X_DIRECTION # If t0 = -1 or 2, the direction chas changed
            j KEEP_X_DIRECTION 
        CHANGE_X_DIRECTION:
        # If the direction has changed, no movement will happen, and only the facing direction will be altered
        # Damaging move x does not apply to this
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
        lb t2, 1(a0)   # Loads JUMP information
        blt t0,zero, MOVE_PLAYER_UP
        j ITERATE_JUMP
        
        MOVE_PLAYER_UP:
            la t1, PLYR_INFO_2	       # Loads address of the second part of PLYR_INFO
            lb t1,3(t1)                # Gets the taking damage byte
            bnez t1,SKIP_INPUT_CHECK   # If taking damage, only do a small hop
            li t1, min_jump # minimum height of jump required for the movement 
            blt t2, t1, SKIP_INPUT_CHECK
            lbu t1, 2(a0)   # Loads PLYR_INPUT
            bnez t1, SKIP_INPUT_CHECK # t1 != 0 ? SKIP_INPUT_CHECK : SWITCH_DOWN
            j SWITCH_DOWN
            
            SKIP_INPUT_CHECK:
                fcvt.w.s t1,fs2 
                bge t1,zero, SWITCH_DOWN
                li t1, max_jump # maximum height of jump required for the movement 
                blt t2, t1, ITERATE_JUMP   # 
                        
            SWITCH_DOWN: 
                la t0,PLYR_INPUT      # Loads PLYR_INPUT on t0
                li t1, 1              # Sets t1 to 1 (there's player input, and can move)
                sb t1, 0(t0)          # and stores it in PLYR_INPUT 
                
                sb t1, 1(a0)          # reset jump information
                sb t1,0(a0)           # Switches MOVE_Y to 1 (Down)    

                li t1, 2
                fcvt.s.w fs2,t1     # Sets speed to zero       
                j END_PHYSICS
            
        ITERATE_JUMP:
            fadd.s fs2,fs2,fs0    # fs2 = Player's current Y speed + gravity factor       
            fcvt.w.s a4,fs2       # Sets a4 = floor(fs2)

            li t0,max_speed             # Loads max speed (8, when falling)
            blt a4,t0, SKIP_MAX_SPEED   # If a4 < 8, skip this part
            # Otherwise, set offset modifier to 8
                li a4,max_speed
                # speed doesn't need to be changed (will be 0 when on the ground and 8 while in freefall)
            SKIP_MAX_SPEED: 
            # Iterating JUMP factor with absolute value of a4
                mv t0,a4                # moves a4 to t0
                bge t0,zero, SKIP_ABS   # if t0 >= 0, skip this
                    sub t0,zero,t0      # otherwise, t0 will be its opposite 
                SKIP_ABS:
                    add t2,t2,t0        # t0 to t2 (JUMP factor)
                    sb t2, 1(a0)        # and stores it

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
            mv a3,a4 # Moves offset modifier to a3
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
                fcvt.s.w fs2,zero # Resets player's jump speed
                
                lb t0, 0(a0) # Gets MOVE_Y info
                blt t0,zero, STOP_JUMP # If t0 <= -1 (aka, player would start jumping), reset
                    # If t0 = 0 (not jumping) or t0 = 1 (freefall), reset MOVE_Y and JUMP
                    la t1, PLYR_INFO_2	   # Loads address of the second part of PLYR_INFO
                    sb zero,4(t1)          # If player hit the ground, stop damage knockback

                    lbu t0, 7(a3)  # Loads player's Y offset
                    beqz t0,SKIP_ADJUST_Y_DOWN # If player is on ground and Y offset = 0, don't reajust position
                        sb a7, 10(a3)   # Stores new Y coordinate on matrix
                        lbu t0, 0(a2)   # Loads first byte to check what type of map it is (0 - Fixed, 1 - Horizontal, 2 - Vertical)
                        li t3, 2        # Loads 2 and 
                        bne t3, t0, SKIP_ADJUST_Y_DOWN # compares with the result
                        # If map is vertical, correct its offset and coordinates
                            lbu t0, 9(a1)    # Loads map's Y offset
                            sb zero, 9(a1)   # Sets map's Y offset to 0
                            lbu t4, 2(a2)    # Loads Map matrix height
                            li t3, m_screen_height # Loads Map screen height related to matrix
                            sub t3,t4,t3     # t4 = Map Matrix Height - Screen Matrix Height (t4 = Map's Y when it's on lowermost part of the map)
                            lbu t4, 7(a1)    # Loads Map Y postition on Matrix
                            bge t4,t3,SKIP_ADJUST_Y_DOWN  # If on lowermost Y, don't update map's Y it
                            add t0,t4,t0   # t4 will only be 4 if offset was 0 and Y is zero
                            beqz t0,SKIP_ADJUST_Y_DOWN    # If on topmost Y, don't update map's Y it
                            addi t4,t4,1     # adds 1 to it
                            sb t4, 7(a1)     # and stores it
                            li t3, 2         # t3 = 2 (map will be rendered again)
                            sb t3, 5(a1)     # Stores t3 on CURRENT_MAP's rendering byte
                    SKIP_ADJUST_Y_DOWN:
                    sb zero, 7(a3) # Sets player's Y offset to 0
                    sb zero, 0(a0) # MOVE_Y = 0
                    li t1,-1
                    sb t1, 1(a0) # JUMP = 0
                    j Fixed_Y_Map
                
                STOP_JUMP:
                    # if t0 = -1 (jumping) check if player is already jumping or not
                    la t1, PLYR_INFO_2	   # Loads address of the second part of PLYR_INFO
                    lbu t0,6(t1)          # If player hit the ground, there's no damage knockback anymore
                    addi t0,t0,-10
                    sb t0,6(t1)          # If player hit the ground, there's no damage knockback anymore
                    

                    li t0,8
                    lbu t1,1(a0) # Gets JUMP info
                    slt t0,t0,t1 # t1 > 8 ? t0 = 1 : t0 = 0
                    sb t0, 0(a0) # MOVE_Y = t0 
                    sb zero,1(a0) # reseting jump byte
                    
                    lbu t0, 7(a3)  # Loads player's Y offset
                    beqz t0,SKIP_ADJUST_Y_UP # If player has Y offset = 0, don't reajust position
                        # Otherwise, 
                        sb zero, 7(a3) # Sets player's Y offset to 0
                        lbu t0, 0(a2)   # Loads first byte to check what type of map it is (0 - Fixed, 1 - Horizontal, 2 - Vertical)
                        li t3, 2        # Loads 2 and 
                        bne t3, t0, SKIP_ADJUST_Y_UP # compares with the result
                        # If map is vertical, correct its offset and coordinates
                            sb zero, 9(a1)   # Sets map's Y offset to 0
                            lbu t4, 2(a2)    # Loads Map matrix height
                            li t3, m_screen_height # Loads Map screen height related to matrix
                            sub t3,t4,t3     # t4 = Map Matrix Height - Screen Matrix Height (t4 = Map's Y when it's on lowermost part of the map)
                            lbu t4, 7(a1)    # Loads Map Y postition on Matrix
                            bge t4,t3,SKIP_ADJUST_Y_UP  # If on lowermost Y, don't update map's Y it
                            beqz t4,SKIP_ADJUST_Y_UP    # If on topmost Y, don't update map's Y it
                            sb t4, 7(a1)     # and stores it
                            li t3, 2         # t3 = 2 (map will be rendered again)
                            sb t3, 5(a1)     # Stores t3 on CURRENT_MAP's rendering byte
                    SKIP_ADJUST_Y_UP:
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

                blt t5,t4,NO_Y_OFFSET_CORRECTION    # If t5 != maximum Y on map, skip this next correction
                # Otherwise, if t5 = maximum Y on map
                li a6,0    # set offset to 0               
                
            NO_Y_OFFSET_CORRECTION:
                sb a6, 9(a1)   # Stores Map new Y offset that is equal to player's Y offset
                add t2,t2,t1  # adds to the Y -1, 0 or 1 (moves map horizontally)
                sb t2, 7(a1)   # Stores Map Y postition on Matrix
                
                lbu t0,2(a2)  # Loads map's height
                li t1,m_screen_height # and the screen's height
                sub t0,t0,t1  # Subtracts from map's height the screen height
                blt t2,t0,END_PHYSICS # If the new Y passes the limit of map
                    sb zero, 9(a1)
                    sb t0, 7(a1)   # Stores Map Y postition on Matrix
                

    END_PHYSICS:
      ret
