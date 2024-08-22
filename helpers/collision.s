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
#  ------------------           argument registers          ------------------  #
#    a0 = MOVE_X/MOVE_Y address (and returns as explained above)                #
#	 a1 = current map's address                                                 #
#    a2 = PLYR_POS address                                                      # 
#                                                                               #
#  ------------------             registers used            ------------------  #
#    a3, a4, a5, a6, a7 --> used as arguments for COLLISION_CHECK               #      
#                                                                               #
#  ------------------          temporary registers          ------------------  #
#    t0, t1 --> temporary registers                                             #
#    t2 = PLYR_POS address (stores from a2 to let it be modified)               #
#    t3 = Player's X offset                                                     #
#                                                                               #    
#################################################################################                    

CHECK_HORIZONTAL_COLLISION:
    mv t2,a2  # Moves a2 to t2
    li a2, 2  # Base case: check 2 tiles horizontally (or 1 if on morph ball)
    li a3,0   # Sets for horizontal check 
    li a4,0   # Base case: ignore door
    lbu a5,1(a1)   # Loads Map Matrix's width
    lbu a6, 8(t2)  # a6 = Player's X related to matrix
    lbu a7, 10(t2) # a7 = Player's Y related to matrix

    addi a1,a1,3   # Adds 3 to the Matrix's address so that it goes to the begining of matrix
    mul t0,a7,a5   # Player's Y related to matrix * Map Matrix's width
    add t0,a6,t0   # t0 = Player's X related to matrix +  Player's Y related to matrix * Map Matrix's width  
    add a1,a1,t0   # a1 = Map Matrix's address adjusted for Player's X and Y related to matrix
    
    lbu t3, 6(t2)  # t3 = Player's X offset
    lb t0, 0(a0)   # Loads MOVE_X information to t0
    li a0,2        # Sets a0 to 2 (check any type of door)
    bnez t0, CHECK_X_DIRECTION  # If player's not moving, end procedure 
    j END_HORIZONTAL_COLLISION 
    
    CHECK_X_DIRECTION:
        # Checking vertical movement
        la t1, MOVE_Y # Loads MOVE_Y address
        lb t1,0(t1)   # Loads MOVE_Y content
        beqz t1, CONTINUE_CHECK_X_DIRECTION  # If MOVE_Y = 0, skip
            bge zero,t1, UPWARDS_THIRD_CHECK # If MOVE_Y = 1 (down) continue
                la t1, PLYR_POS    # Loads PLYR_POS address
                lb t1, 7(t1)       # Loads Y offset
                beqz t1 CONTINUE_CHECK_X_DIRECTION # If Y offset is zero, there's no need to check 3 tiles
                    addi a2,a2, 1  # Checks 3 tiles horizontally (or 2 if on morph ball)
                    j CONTINUE_CHECK_X_DIRECTION
            UPWARDS_THIRD_CHECK: # If MOVE_Y = -1 (up)
                la t1, PLYR_POS # Loads PLYR_POS address
                lb t1, 7(t1)    # Loads Y offset
                li t5, 8        # Represents the desired offset
                bge t5, t1 CONTINUE_CHECK_X_DIRECTION # If Y offset is zero, there's no need to check 3 tiles
                    addi a2,a2, 1  # Checks 3 tiles horizontally (or 2 if on morph ball)

    CONTINUE_CHECK_X_DIRECTION:
        lbu t1,16(t2) # Loads Player's morph ball byte
        beqz t1,CONTINUE_CHECK_X_DIRECTION_2 # If player's not on morph ball
        addi a2,a2,-1 # Morph ball requires one less iteration on horizontal check
        add a1,a5,a1  # Increments width to player's y on matrix (checks only one tile in front of them)
        addi a7,a7,1  # Increments current Y on matrix(+1 Y)
    
    CONTINUE_CHECK_X_DIRECTION_2:
        blt t0, zero, CHECK_X_LEFT # If player is moving left (t0 < 0), go to CHECK_X_LEFT
        j CHECK_X_RIGHT            # otherwise, go to CHECK_X_RIGHT
        
        CHECK_X_LEFT:
            li t0, 12    # Loads number 12 for comparing with X offset 
            beq t3, t0, CONTINUE_CHECK_X_LEFT # If X offset is 12, continue checking
            addi t0,t0, -8                    # Otherwise, compare with offset 4
            li a4,2      # Sets to check for only doors (if the next condition isn't met, it doesn' matter the value of a4)
            beq t3, t0, CONTINUE_CHECK_X_LEFT_DOOR # If X offset is 4, check for doors
            j END_HORIZONTAL_COLLISION             # Otherwise, stop
            
            CONTINUE_CHECK_X_LEFT: 
                li a4,0 # Sets to ignore doors
            CONTINUE_CHECK_X_LEFT_DOOR:
                j CHECK_MAP_COLLISION
        
        CHECK_X_RIGHT:
            addi a1,a1, 1 # Looks to the tile on the right of player's current tile
            addi a6,a6,1  # Increments current X on matrix(+1 X)
            li t0, 4      # Loads number 4 for comparing with X offset 
            beq t3, t0, CONTINUE_CHECK_X_RIGHT # If X offset is 4, continue checking
            addi t0,t0, 8                      # Otherwise, compare with offset 12
            li a4,2       # Sets to check for only doors (if the next condition isn't met, it doesn' matter the value of a4)
            beq t3, t0, CONTINUE_CHECK_X_RIGHT_DOOR # If X offset is 12, check for doors
                j END_HORIZONTAL_COLLISION 
        
            CONTINUE_CHECK_X_RIGHT: 
                li a4,0 # Sets to ignore doors
            CONTINUE_CHECK_X_RIGHT_DOOR:
                j CHECK_MAP_COLLISION
    
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
#  ------------------           argument registers          ------------------  #
#    a0 = MOVE_X/MOVE_Y address (and returns as explained above)                #
#	 a1 = current map's address                                                 #
#    a2 = PLYR_POS address                                                      # 
#                                                                               #
#  ------------------             registers used            ------------------  #
#    a3, a4, a5, a6, a7 --> used as arguments for COLLISION_CHECK               #      
#                                                                               #
#  ------------------          temporary registers          ------------------  #
#    t0, t1 --> temporary registers                                             #
#    t2 = PLYR_POS address (stores from a2 to let it be modified)               #
#    t3 = Player's X/Y offset                                                     #
#                                                                               #    
#################################################################################     

CHECK_VERTICAL_COLLISION:
    mv t2,a2  # Moves a2 to t2
    li a2,1   # Base case: check 1 tiles vertically
    li a3,1   # Sets for horizontal check 
    li a4,0   # Base case: ignore door
    lbu a5,1(a1)   # Loads Map Matrix's width
    lbu a6, 8(t2)  # a6 = Player's X related to matrix
    lbu a7, 10(t2) # a7 = Player's Y related to matrix

    addi a1,a1,3   # Adds 3 to the Matrix's address so that it goes to the begining of matrix
    mul t0,a7,a5   # Player's Y related to matrix * Map Matrix's width
    add t0,a6,t0   # t0 = Player's X related to matrix +  Player's Y related to matrix * Map Matrix's width  
    add a1,a1,t0   # a1 = Map Matrix's address adjusted for Player's X and Y related to matrix
    
    lbu t3, 7(t2)  # t3 = Player's Y offset
    lb t0, 0(a0) # Loads MOVE_Y to t0 
    blt t0,zero, CHECK_Y_UP # If t0 < 0, check up, 
    j CHECK_Y_DOWN          # otherwise check down
    
    CHECK_Y_UP:
        li t1,2
        bge t1,t3 CONTINUE_CHECK_Y_UP # If player's Y offset is 0, continue checking
        j END_VERTICAL_COLLISION    # otherwise, end procedure
    
        CONTINUE_CHECK_Y_UP:
        # Doesn't need to check for doors (a4 stays as 0)
            lbu t1,16(t2)  # Loads Player's morph ball byte
            bnez t1, CONTINUE_CHECK_Y_UP2 # If player is on morph ball, don't update Y to be checked
            sub a1,a1,a5   # If player isn't on morph ball, update Y one tile up (-1 matrix Y) 
            addi a7,a7,-1  # Increments current Y on matrix(-1 Y)
            
            CONTINUE_CHECK_Y_UP2: 
            # Checking player's X for checking collision
            lbu t3, 6(t2)  # t3 = Player's X offset
            li t0, 8   # Loads number 8 for comparing with X offset 
            blt t3,t0, CHECK_Y_UP_ABOVE # If X offset < 8, just check one tile above
            li t0,12   # Loads number 12 for comparing with X offset 
            bge t3,t0, CHECK_Y_UP_TO_THE_RIGHT # If X offset >= 12, check one tile above to the right 
            li a2,2    # If player's X offset = 8, check 2 tiles above the player (one above, the other above to the right)
            CHECK_Y_UP_ABOVE:
            # Checks one (X offset < 8) or two (X offset = 8) tiles above the player
                j CHECK_MAP_COLLISION
            CHECK_Y_UP_TO_THE_RIGHT:
            # Checks one tile to the top right of the player
                addi a1,a1, 1 # Looks to the tile on the right of player's current tile
                addi a6,a6,1  # Increments current X on matrix (+1 X)
                j CHECK_MAP_COLLISION           
    
    CHECK_Y_DOWN:
        li t1,2    # Loads number 2 for comparing with Y offset 
        bge t1, t3 CONTINUE_CHECK_Y_DOWN # If player's Y offset <= 2, continue checking
        j END_VERTICAL_COLLISION         # otherwise, end procedure
    
        CONTINUE_CHECK_Y_DOWN: 
            li a4, 1  # Base case: Consider doors
            # In order to check down, moves address down 2 tiles
            slli t0,a5,1     # t0 = 2 x Matrix width
            add a1,a1,t0     # Updates Y 2 tiles down (+2 matrix Y) 
            addi a7,a7,2     # Increments current Y on matrix (+2 Y)
            # Checking player's X for checking collision
            lbu t3, 6(t2)    # t3 = Player's X offset
            beqz t3 CHECK_Y_DOWN_BOTH_DOORS # If X offset = 0, just check one tile bellow, and consider both doors
            li t0, 8   # Loads number 8 for comparing with X offset 
            blt t3,t0, CHECK_Y_DOWN_RIGHT_DOOR # If X offset < 8, just check one tile bellow, and consider right doors
            blt t0,t3, CHECK_Y_DOWN_LEFT_DOOR # If X offset > 8, check one tile bellow to the right , and consider left doors
            # If player's X offset = 8:
                li a2,2  # Check 2 tiles above the player (one bellow, the other bellow to the right)  
                li a4,0  # Ignore doors
                j CHECK_MAP_COLLISION
            CHECK_Y_DOWN_BOTH_DOORS:
                # If player's X offset = 0, check for ground and for any type of door
                li a0, 2 # Consider both doors on the left and on the right sides of the map
                j CHECK_MAP_COLLISION
            CHECK_Y_DOWN_RIGHT_DOOR:
                # If 0 < player's X offset < 8, check for ground and for doors on the map's right side
                li a0, 0 # Only consider doors on the right side of the map
                j CHECK_MAP_COLLISION
            CHECK_Y_DOWN_LEFT_DOOR:
                # If player's X offset > 8, for ground on the tile to the player's bottom right and for doors on the map's left side 
                li a0, 1 # Only consider doors on the left side of the map
                addi a1,a1, 1 # Looks to the tile on the right of player's current tile
                addi a6,a6,1  # Increments current X on matrix (+1 X)
                j CHECK_MAP_COLLISION 

    END_VERTICAL_COLLISION:
    # If no check is to be made, return a0 = 1 (player can move)
        li a0,1  
        ret 

######################      CHECK MAP COLLISION      ######################    
#   Checks the tile on the address given by a1, and returns whether the   #
#                player can move (a0 = 1) or not (a0 = 0).                #
#                                                                         #
#  -----------------        argument registers        -----------------   #
#    a0 = check right (0), left(1) or both (2) doors                      # 
#    a1 = starting address on map matrix                                  #
#    a2 = number of iterations to be made                                 #  
#	 a3 = horizontal check (0) or vertical check (1)                      #
#    (horizontal - iterate vertically; vertical - iterate horizontally)   #
#    a4 = don't consider door (0), consider door (1) or                   #
#    consider ONLY door (2)                                               #
#    a5 = map matrix width                                                #
#    a6 = current X on matrix                                             #   
#    a7 = current Y on matrix                                             #
#                                                                         #
#  -----------------          registers used           -----------------  #
#    a0 = returns 0 (player can't move) or 1 (player can move)            # 
#                                                                         #
#  -----------------        temporary registers       -----------------   #
#    tp = check right (0) or left(1) door                                 #
#    t0 = temporary register for comparison                               #
#    t1 = tile loaded                                                     #
###########################################################################

CHECK_MAP_COLLISION:
mv tp,a0 # Moves door check to tp
li a0,1  # Sets a0 to 1 (can move)
# Begins loop
    MAP_COLLISION_LOOP:
    # If a0 = 0, player can't move and the checking should stop
        bnez a0, CONTINUE_CHECK_MAP_COLLISION_1 # Otherwise, continue check
        ret

        CONTINUE_CHECK_MAP_COLLISION_1:
        # If a2 > 0, stop checking 
            blt zero, a2, CONTINUE_CHECK_MAP_COLLISION_2
            ret

        CONTINUE_CHECK_MAP_COLLISION_2:
            lbu t1, 0(a1) # Loads tile from current map
            beqz a4, SKIP_DOOR_CHECK_MAP_COLLISION  # If a4 = 0 (don't consider door), skip door check 
                li t0,40   # Tile where doors start
                blt t1,t0, NOT_DOOR_CHECK_MAP_COLLISION # If current tile isn't a door   
                j COLLISION_DOOR  # If tile is a door (t1 >= 40)
                NOT_DOOR_CHECK_MAP_COLLISION:
                    li t0,1   # Consider all tiles
                    beq a4,t0, SKIP_DOOR_CHECK_MAP_COLLISION # If no door was detected and other tiles should be checked, continue
                    j CONTINUE_CHECK_MAP_COLLISION_3  # If no door was detected and only doors should be checked, skip to the end
            SKIP_DOOR_CHECK_MAP_COLLISION:
                li t0, 4      # Loads t0 = 4 for comparison
                bge t1,t0,COLLISION_NOT_BACKGROUND # If tile isn't part of background or isn't breakable (t1 >= 4)
                # If tile is breakable or part of background (0 <= t1 <= 3), a0 should still be 1, otherwise procedure would've ended before
                    beq a0,t1, COLLISION_BREAKABLE   # If tile is breakable, there needs to be a check if it was broken
                    j CONTINUE_CHECK_MAP_COLLISION_3 # Otherwise, continue checking collision
        
            COLLISION_BREAKABLE:
            # ---> make breakable block work :)
                # li a0, 0 # Player can't move  
                j CONTINUE_CHECK_MAP_COLLISION_3
            
            COLLISION_NOT_BACKGROUND:
                beq t0,t1,COLLISION_DOOR_FRAME  # If t1 = 4, it's a door frame
                li t0,36   # Tile from which collision behaves differently
                bge t1,t0, COLLISION_SPECIAL  # If current tile is a door or a damaging tile (t1 >= 36)
                    j COLLISION_BLOCKED # If tile isn't special (3 < t1 < 36)
            
            COLLISION_DOOR_FRAME:
                mv t0,zero   # Resets counter
                la t1, Frames # Loads Frames address
                lw t1,0(t1)	 # Gets the current map's door frame address
                lbu t2,0(t1) # Gets the number of door frames in this map
                addi t1,t1,1 # Starting address of the map's first door frame
                COLLISION_DOOR_FRAME_LOOP:
                    # Checking if current door frame is the one player is colliding with
                    lbu t3, 0(t1) # Loads door frame's X on matrix
                    bne t3, a6, NEXT_IN_COLLISION_DOOR_FRAME_LOOP # If door frame's X isn't the same as current X, skip it       
                    lbu t3, 1(t1) # Loads door frame's Y on matrix
                    sub t3,a7,t3  # t3 needs to be equal to 0, 1 or 2 in order to be a tile from this door frame
                    li t4,2       # 2 is the threshold to be compared with t3
                    bgtu t3,t4, NEXT_IN_COLLISION_DOOR_FRAME_LOOP # If current Y is above the door frame's uppermost Y or bellow it's downmost Y, skip it                       
                    # If the correct door tile is the one being checked, continue as follows   
                        mv a0,t1       # Moves current door frame's address to a0
                        addi sp,sp,32  # Freeing stack since it won't return to Physics
                        j CONTINUE_CHECK_MAP_COLLISION_3                            
                    NEXT_IN_COLLISION_DOOR_FRAME_LOOP:                                  
                        addi t1,t1,6 # Going to the next door's address                                  
                        addi t0,t0,1 # Iterating counter by 1                                   
                        bge t0,t2, END_COLLISION_DOOR_FRAME_LOOP # If all of the map's doors were checked, end loop                                  
                        j COLLISION_DOOR_FRAME_LOOP # otherwise, go back to the loop's begining                     
                END_COLLISION_DOOR_FRAME_LOOP:                     
                # This is only reached if no door frame was found (error) 
                    j CONTINUE_CHECK_MAP_COLLISION_3     


            COLLISION_SPECIAL:
                li t0,40   # Tile from which door tiles begin
                blt t1,t0, CONTINUE_COLLISION_SCPECIAL   # If tile is a door (t1 >= 40)
                    j CONTINUE_CHECK_MAP_COLLISION_3     # Otherwise, finish this iteration's checks
            
                CONTINUE_COLLISION_SCPECIAL:
            # ---> make damage work :)
                    j COLLISION_BLOCKED # For now >:[
            
            COLLISION_DOOR:
                mv t0,zero   # Resets counter
                la t1, Doors # Loads Doors address
                lw t1,0(t1)	 # Gets the current map's door address
                lbu t2,0(t1) # Gets the number of doors in this map
                addi t1,t1,1 # Starting address of the map's first door
                COLLISION_DOOR_LOOP:
                    # Checking if current door is the one player is colliding with
                    lbu t3, 0(t1) # Loads door's X on matrix
                    bne t3, a6, NEXT_IN_COLLISION_DOOR_LOOP # If door's X isn't the same as current X, skip this door
                    lbu t3, 1(t1) # Loads door's Y on matrix
                    sub t3,a7,t3  # t3 needs to be equal to 0, 1 or 2 in order to be a tile from this door
                    li t4,2       # 2 is the threshold to be compared with t3
                    bgtu t3,t4, NEXT_IN_COLLISION_DOOR_LOOP # If current Y is above the door's uppermost Y or bellow it's downmost Y, skip this door                        
                    # If the correct door tile is the one being checked, continue as follows   
                        beq t4,tp,AFTER_COLLISION_DOOR_LOOP_DIRECTION_CHECK # If tp = 2, check any type of door
                        lbu t3, 0(t1) # Loads door's X on matrix 
                        beqz tp,COLLISION_DOOR_LOOP_CHECK_RIGHT # If tp = 0, check if door is on right wall
                        COLLISION_DOOR_LOOP_CHECK_LEFT:         # otherwise, check if door is on left wall
                            beq tp,t3,AFTER_COLLISION_DOOR_LOOP_DIRECTION_CHECK # If t3 = 1, door is on left wall; continue checking collision
                            j END_COLLISION_DOOR_LOOP # Otherwise, door is on right wall and not on left wall (stop checking)
                        COLLISION_DOOR_LOOP_CHECK_RIGHT:
                            li t4, 1 # 1 is the threshold of when a door can be on right wall
                            bgt t3,t4, AFTER_COLLISION_DOOR_LOOP_DIRECTION_CHECK # If t3 > 1, door is on right wall; continue checking collision
                            j END_COLLISION_DOOR_LOOP # Otherwise, door is on left wall and not on right wall (stop checking)
                        AFTER_COLLISION_DOOR_LOOP_DIRECTION_CHECK:
                            lbu t3, 2(t1) # Loads door's state
                            bnez t3, END_COLLISION_DOOR_LOOP # If door is open or opening, player can move through 
                            li a0, 0 # Otherwise, door is closed and player can't move                     
                            j CONTINUE_CHECK_MAP_COLLISION_3                            
                    NEXT_IN_COLLISION_DOOR_LOOP:                                  
                        addi t1,t1,3 # Going to the next door's address                                  
                        addi t0,t0,1 # Iterating counter by 1                                   
                        bge t0,t2, END_COLLISION_DOOR_LOOP # If all of the map's doors were checked, end loop                                  
                        j COLLISION_DOOR_LOOP # otherwise, go back to the loop's begining                     
                END_COLLISION_DOOR_LOOP:                     
                # This is only reached if no door was found (error) or if door is open/opening, so player will be able to go through 
                    j CONTINUE_CHECK_MAP_COLLISION_3                                                                 
            
            COLLISION_BLOCKED:
                li a0,0 # Player can't move  

        CONTINUE_CHECK_MAP_COLLISION_3:
        # If a3 = 0, go to horizontal check, otherwise, go to vertical check
            bnez a3, CHECK_MAP_COLLISION_VERTICAL
            CHECK_MAP_COLLISION_HORIZONTAL:
                add a1,a1,a5   # a1 = current tile address + matrix width (+1 Y)
                addi a7,a7,1   # a7++ (+1 Y)
                addi a2,a2,-1  # Iterates a2 (a2--)
                j MAP_COLLISION_LOOP
            
            CHECK_MAP_COLLISION_VERTICAL:
                addi a1,a1,1   # a1 = current tile address + 1 (+1 X)
                addi a6,a6,1   # a6++ (+1 X)
                addi a2,a2,-1  # Iterates a2 (a2--)
                j MAP_COLLISION_LOOP
