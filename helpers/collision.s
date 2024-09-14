.text
# ----> Summary: collisions.s stores collision related procedures, including the movement of enemies and projectiles
# 1 - CHECK HORIZONTAL COLLISION (Checks player's horizontal collision)
# 2 - CHECK VERTICAL COLLISION (Checks player's vertical collision)
# 3 - PLY
# 4 - MOVE BOMB

# 3 - MOVE ZOOMER
# 4 - MOVE RIPPER
# 5 - MOVE RIDLEY
# 6 - MOVE PLASMA BREATH


# N-1 - CHECK MAP COLLISION (The one in charge of checking the map's tiles)
# N - CHECK MAP COLLISION (The one in charge of checking the map's tiles)

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
    li tp, 0  # Player check
    mv t2,a2  # Moves a2 to t2
    li a2, 2  # Base case: check 2 tiles horizontally (or 1 if on morph ball)
    li a3,0   # Sets for horizontal check 
    li a4,0   # Base case: ignore door
    lbu a5,1(a1)   # Loads Map Matrix's width
    lbu a6, 8(t2)  # a6 = Player's X related to matrix
    lbu a7, 10(t2) # a7 = Player's Y related to matrix

    addi a1,a1,3   # Adds 3 to the Matrix's address so that it goes to the beginning of matrix
    mul t0,a7,a5   # Player's Y related to matrix * Map Matrix's width
    add t0,a6,t0   # t0 = Player's X related to matrix +  Player's Y related to matrix * Map Matrix's width  
    add a1,a1,t0   # a1 = Map Matrix's address adjusted for Player's X and Y related to matrix
    
    lbu t3, 6(t2)  # t3 = Player's X offset
    lb t0, 0(a0)   # Loads MOVE_X information to t0
    
    li a0,2        # Sets a0 to 2 (check any type of door)
    bnez t0, CHECK_X_DIRECTION  # If player's not moving, end procedure 
    la t1, PLYR_INFO_2	   # Loads address of the second part of PLYR_INFO
    lb t1,4(t1)            # Gets the DAMAGE_MOVE_X value
    bnez t1, CHECK_X_DIRECTION  # If player's not moving, end procedure 
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
                li t5, 2        # Represents the desired offset
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
        la t0, PLYR_INFO_2	   # Loads address of the second part of PLYR_INFO
        lb t0,4(t0)            # Gets the DAMAGE_MOVE_X value
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
#    a3 = offset modifier (to be added to current offset if able to move)       #
#                                                                               #
#  ------------------             registers used            ------------------  #
#    a3, a4, a5, a6, a7 --> used as arguments for COLLISION_CHECK               #      
#                                                                               #
#  ------------------          temporary registers          ------------------  #
#    t0, t1 --> temporary registers                                             #
#    t2 = PLYR_POS address (stores from a2 to let it be modified)               #
#    t3 = Player's X/Y offset                                                   #
#    tp = offset modifier (stores from a3 to let it be modified)                #
#                                                                               #    
#################################################################################     

CHECK_VERTICAL_COLLISION:
    mv t2,a2  # Moves a2 to t2
    mv tp,a3  # Moves a3 to tp
    li a2,1   # Base case: check 1 tiles vertically
    li a3,1   # Sets for horizontal check 
    li a4,0   # Base case: ignore door
    lbu a5,1(a1)   # Loads Map Matrix's width
    lbu a6, 8(t2)  # a6 = Player's X related to matrix
    lbu a7, 10(t2) # a7 = Player's Y related to matrix

    addi a1,a1,3   # Adds 3 to the Matrix's address so that it goes to the beginning of matrix
    mul t0,a7,a5   # Player's Y related to matrix * Map Matrix's width
    add t0,a6,t0   # t0 = Player's X related to matrix +  Player's Y related to matrix * Map Matrix's width  
    add a1,a1,t0   # a1 = Map Matrix's address adjusted for Player's X and Y related to matrix
    
    lbu t3, 7(t2)  # t3 = Player's Y offset
    lb t0, 0(a0) # Loads MOVE_Y to t0 
    blt t0,zero, CHECK_Y_UP # If t0 < 0, check up, 
    j CHECK_Y_DOWN          # otherwise check down
    
    CHECK_Y_UP:
        # check if current offset + offset modifier (negative) will be less than or equal to 0
        add t3,t3,tp     # current offset + offset modifier
        bge zero,t3 CONTINUE_CHECK_Y_UP # If current offset + offset modifier <= 0, continue checking
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
                li tp, 0  # Player check
                j CHECK_MAP_COLLISION
            CHECK_Y_UP_TO_THE_RIGHT:
            # Checks one tile to the top right of the player
                addi a1,a1, 1 # Looks to the tile on the right of player's current tile
                addi a6,a6,1  # Increments current X on matrix (+1 X)
                li tp, 0  # Player check
                j CHECK_MAP_COLLISION           
    
    CHECK_Y_DOWN:
        li t4,0   # If Y offset = 0
        li t5,0   # If Y offset = 0
        beqz t3 CONTINUE_CHECK_Y_DOWN    # If player's Y offset = 0, continue checking
        # Othewise:
        # 1 - set up t4 and t5, in case branch is correct
        mv t4,a5  
        li t5,1   
        # 2 - check if current offset + offset modifier will be greater than or equal to 16
        li t1,tile_size  # Loads 16
        add t3,t3,tp     # current offset + offset modifier
        bge t3,t1 CONTINUE_CHECK_Y_DOWN  # If current offset + offset modifier >= 16, continue checking (but check one tile bellow)
        
        j END_VERTICAL_COLLISION         # otherwise, end procedure
    
        CONTINUE_CHECK_Y_DOWN: 
            li a4, 1  # Base case: Consider doors
            # In order to check down, moves address down 2 tiles
            slli t0,a5,1     # t0 = 2 x Matrix width
            add a1,a1,t0     # Updates Y 2 tiles down (+2 matrix Y) 
            addi a7,a7,2     # Increments current Y on matrix (+2 Y)

            add a1,a1,t4     # If current offset + offset modifier >= 16, update Y another tile down (+1 matrix Y)
            add a7,a7,t5    # If Y current offset + offset modifier >= 16, increment current Y on matrix once more (+1 Y)
            # Checking player's X for checking collision
            lbu t3, 6(t2)    # t3 = Player's X offset
            beqz t3 CHECK_Y_DOWN_BOTH_DOORS # If X offset = 0, just check one tile bellow, and consider both doors
            li t0, 8   # Loads number 8 for comparing with X offset 
            blt t3,t0, CHECK_Y_DOWN_RIGHT_DOOR # If X offset < 8, just check one tile bellow, and consider right doors
            blt t0,t3, CHECK_Y_DOWN_LEFT_DOOR # If X offset > 8, check one tile bellow to the right , and consider left doors
            # If player's X offset = 8:
                li a2,2  # Check 2 tiles above the player (one bellow, the other bellow to the right)  
                li a4,0  # Ignore doors
                li tp, 0  # Player check
                j CHECK_MAP_COLLISION
            CHECK_Y_DOWN_BOTH_DOORS:
                # If player's X offset = 0, check for ground and for any type of door
                li a0, 2 # Consider both doors on the left and on the right sides of the map
                li tp, 0  # Player check
                j CHECK_MAP_COLLISION
            CHECK_Y_DOWN_RIGHT_DOOR:
                # If 0 < player's X offset < 8, check for ground and for doors on the map's right side
                li a0, 0 # Only consider doors on the right side of the map
                li tp, 0  # Player check
                j CHECK_MAP_COLLISION
            CHECK_Y_DOWN_LEFT_DOOR:
                # If player's X offset > 8, for ground on the tile to the player's bottom right and for doors on the map's left side 
                li a0, 1 # Only consider doors on the left side of the map
                addi a1,a1, 1 # Looks to the tile on the right of player's current tile
                addi a6,a6,1  # Increments current X on matrix (+1 X)
                li tp, 0  # Player check
                j CHECK_MAP_COLLISION 

    END_VERTICAL_COLLISION:
    # If no check is to be made, return a0 = 1 (player can move)
        li a0,1  
        ret 

#######################        MOVE BOMB        ########################
#         Plasma breaths move in a "zig-zag" way, kicking on the ground         #
#   (it follows an oblique motion). It must consider all vertical collisions    #
#              (up and down), ignoring horizontal collision checks              #
#                       (unless it passes an X threshold)                       #
#                                                                               #
#  ------------------           argument registers          ------------------  #
#    a0 = Plasma Breath's address                                               #
#	 a1 = Current map's address                                                 #
#    fa0 = Current Plasma Breath's Y speed (will be returned afterwards)        #
#                                                                               #
#  ------------------             registers used            ------------------  #
#    a2 = Bomb's matrix Y that will be modified and possibly stored             #
#    a3 = Bomb's Y offset that will be modified and possibly stored             #
#    a4, a5, a6, a7 --> used as arguments for COLLISION_CHECK                   #      
#                                                                               #
#  ------------------          temporary registers          ------------------  #
#    t0, t1 --> temporary registers                                             #
#    t2 = PLYR_POS address (stores from a2 to let it be modified)               #
#    t3 = Player's X/Y offset                                                   #
#    tp = offset modifier (stores from a3 to let it be modified)                #
#                                                                               #    
#################################################################################  

MOVE_BOMB:
    # X doesn't change
    
    # Altering Y and doing a collision check afterwards
    lbu a2,7(a0)    # Loads bomb's current Y
    sb a2,8(a0)     # And stores it on old Y
    lbu a3,4(a0)    # Loads bomb's current Y offset

    # Proper movement calculations 
    # Bomb will always be trying to move dow     
    fadd.s fa0,fa0,fs0    # fa0 = Bomb's current Y speed + gravity factor       
    fcvt.w.s t3,fa0       # Sets t3 = floor(fa0)

    li t0,max_speed                    # Loads max speed (8, when falling)
    blt t3,t0, SKIP_BOMB_MAX_SPEED   # If t3 < 8, skip this part
    # Otherwise, set offset modifier to 8
        li t3,max_speed
        fcvt.s.w fa0,t0

    SKIP_BOMB_MAX_SPEED: 
        add a3,a3,t3	# Adds the Y Movement to the Bomb's Offset      
        # a3 will never be negative, since bomb will always try to move down
        li t0, tile_size
        blt a3,t0, SKIP_DOWN_Y_BOMB
        # If a3 >= 16, Bomb is moving to the lower tile
        addi a2,a2, 1	 # Bomb's Y on matrix += 1 (goes to the right)
        sub a3,a3,t0	 # Offset gets corrected (relative to new Y on matrix coordinate)
        
    SKIP_DOWN_Y_BOMB:  
        # Preparations for check        
        lbu a5,1(a1)     # Loads map's matrix width
        lbu a6,5(a0)     # Loads Bomb's current X
        lbu a7,7(a0)     # Loads Bomb's current Y

        addi a1,a1,3     # Adds 3 to the Matrix's address so that it goes to the beginning of matrix
        mul t0,a7,a5     # (Bomb's matrix Y + 3)  * Map Matrix's width
        add t0,a6,t0     # t0 = Bomb's X related to matrix + (Bomb's matrix Y + 3)  * Map Matrix's width
        add a1,a1,t0     # a1 = Map Matrix's address adjusted for Bomb's X and Y (+3) related to matrix       

        # Will always check down 
        lbu t0,4(a0)     # Loads Bomb's Y offset    
        add a1,a1,a5  # Moves matrix one tile down
        addi a7,a7,1  # Moves Y one tile down
        beqz t0 CONTINUE_CHECK_Y_DOWN_BOMB   # If Bomb's Y offset == 0, continue checking
        # Othewise:
        # 1 - Go another tile down, in case branch condition is met
        add a1,a1,a5  # If Y offset != 0
        addi a7,a7,1  # If Y offset != 0
        # 2 - check if current offset + offset modifier will be greater than or equal to 16
        li t1,tile_size  # Loads 16
        add t0,t0,t3     # Current Y offset + Y offset modifier
        bge t0,t1 CONTINUE_CHECK_Y_DOWN_BOMB  # If current offset + offset modifier >= 16, continue checking (but check one tile bellow)
            j MOVE_BOMB_PROPERLY              # Othewise, just move the bomb

        CONTINUE_CHECK_Y_DOWN_BOMB:
        # If it arrived here, but Y offset != 0, it'll check 2 two tiles down
        # Otherwise, it'll check only one tile down
            li a4, 1  # Base case: Consider doors      
            li t2, 1  # Base case: Check only one tile  
            # Checking Bomb's X for checking collision
            lbu t3,3(a0)     # Loads Bomb's X offset
            beqz t3 CHECK_BOMB_Y_DOWN_BOTH_DOORS # If X offset = 0, just check one tile bellow, and consider both doors
            li t0, 8   # Loads number 8 for comparing with X offset 
            blt t3,t0, CHECK_BOMB_Y_DOWN_RIGHT_DOOR # If X offset < 8, just check one tile bellow, and consider right doors
            blt t0,t3, CHECK_BOMB_Y_DOWN_LEFT_DOOR # If X offset > 8, check one tile bellow to the right , and consider left doors
            # If Bomb's X offset = 8:
                li t2,2   # Check 2 tiles bellow bomb (one bellow, the other bellow to the right)  
                li a4,0   # Ignore doors
                j START_BOMB_COLLISION

            CHECK_BOMB_Y_DOWN_BOTH_DOORS:
                # If Bomb's X offset = 0, check for ground and for any type of door
                li t1, 2 # Consider both doors on the left and on the right sides of the map
                j START_BOMB_COLLISION

            CHECK_BOMB_Y_DOWN_RIGHT_DOOR:
                # If 0 < Bomb's X offset < 8, check for ground and for doors on the map's right side
                li t1, 0 # Only consider doors on the right side of the map
                j START_BOMB_COLLISION

            CHECK_BOMB_Y_DOWN_LEFT_DOOR:
                # If Bomb's X offset > 8, for ground on the tile to the Bomb's bottom right and for doors on the map's left side 
                li t1, 1 # Only consider doors on the left side of the map
                addi a1,a1, 1 # Looks to the tile on the right of Bomb's current tile
                addi a6,a6,1  # Increments current X on matrix (+1 X)
                # j START_BOMB_COLLISION 

            START_BOMB_COLLISION:
            # Storing Registers on Stack
                addi sp,sp,-20
                sw a3,16(sp)
                sw a2,12(sp)
                sw a1,8(sp)
                sw a0,4(sp)
                sw ra,0(sp)
            # End of Stack Operations

                mv a0,t1  # Doesn't matter, since no doors will be checked
                # a1 is already defined
                mv a2,t2  # Only check one tile
                li a3,1   # Vertical check
                # a5 is already defined
                # a6 is already defined
                # a7 is already defined
                li tp, 1  # Entity collision
                call CHECK_MAP_COLLISION
                mv t0,a0

            # Procedure finished: Loading Registers from Stack
                lw a3,16(sp)
                lw a2,12(sp)
                lw a1,8(sp)
                lw a0,4(sp)
                lw ra,0(sp)
                addi sp,sp,20
            # End of Stack Operations
            
            # After checking collision
            bnez t0, MOVE_BOMB_PROPERLY   # If returning anything but 0, Plasma Breath can move
            # Otherwise (in theory) the only time Ridley should face a collision is when moving down           
                fcvt.s.w fa0,zero # Resets Bomb's jump speed

                lbu t0,4(a0)   # Loads Bomb's current Y offset  
                beqz t0,MOVE_BOMB_SKIP_ADJUST_Y  
                    sb zero, 4(a0) # Sets Bomb's Y offset to 0 
                    sb a2,7(a0)    # Stores new Y 
                MOVE_BOMB_SKIP_ADJUST_Y: 
                # If Y offset was 0, everything was already set
                    j END_MOVE_BOMB   # Finish procedure               
        
        MOVE_BOMB_PROPERLY:         
            sb a2,7(a0)     # Stores Bomb's new Y 
            sb a3,4(a0)     # Stores new Y offset
            #j END_MOVE_BOMB   
    
    END_MOVE_BOMB:
        ret

###########################        MOVE ZOOMER        ###########################
#      This procedure checks the tiles in front and at the base of a Zoomer     #
#  when X/Y offset is 0. When there's no tile on the base of a zoomer, it will  #
#       turn following its clock direction (clockwise or anti-clockwise).       # 
#   If there is a tile on the base of the zoomer, it'll try to move foward by   #
#     checking the tile in front of it (determined by the clock direction).     #
#   In the case where there's something blocking it, it'll turn arround in the  #
#    opposite clock direction (in the case of going arround the map borders,    # 
#   this will result in the zoomer moving in the opposite direction that one    # 
#    would think, for instance, going anti-clockwise even though zoomer was     #
#     set to go clockwise). This will also work for closed doors, since the     #
#       movement is checked for an X offset of 8 (with special treatments).     # 
#                                                                               #
#                                 **im tired**                                  #
#                                                                               #
#  ------------------           argument registers          ------------------  #
#    a0 = Ripper's address                                                      #
#	 a1 = Current map's address                                                 #
#                                                                               #
#  ------------------             registers used            ------------------  #
#    a2,a3, a4, a5, a6, a7 --> used as arguments for COLLISION_CHECK            #      
#                                                                               #
#  ------------------          temporary registers          ------------------  #
#    t0, t1 --> temporary registers                                             #
#    t2 = PLYR_POS address (stores from a2 to let it be modified)               #
#    t3 = Player's X/Y offset                                                   #
#    tp = offset modifier (stores from a3 to let it be modified)                #
#                                                                               #    
#################################################################################  

MOVE_ZOOMER:
    # Storing current X and Y to old X and Y
    lbu t1,4(a0)  # Loads Zoomer's X
    sb t1,5(a0)   # And stores it in Zoomer's old 
    lbu t1,6(a0)  # Loads Zoomer's Y
    sb t1,7(a0)   # And stores it in Zoomer's old Y

    li a2, 0      # First stage of check (platform) 
    # Storing Registers on Stack
        addi sp,sp,-4
        sw a1,0(sp)
    # End of Stack Operations
    MOVE_ZOOMER_CHECK_LOOP:
        # Preparations for check
        li t0,1       # In case no collision check is made

        lw a1,0(sp)   # Loads map's matrix original address
        lbu a5,1(a1)  # Loads map's matrix width
        lbu a6,4(a0)  # Loads Zoomer's current X
        lbu a7,6(a0)  # Loads Zoomer's current Y

        addi a1,a1,3   # Adds 3 to the Matrix's address so that it goes to the beginning of matrix
        mul t1,a7,a5   # Zoomer's Y related to matrix * Map Matrix's width
        add t1,a6,t1   # t1 = Zoomer's X related to matrix +  Zoomer's Y related to matrix * Map Matrix's width  
        add a1,a1,t1   # a1 = Map Matrix's address adjusted for Zoomer's X and Y related to matrix

        li a4,0  # Base case: Don't consider doors (if X offset stays 0)
        li tp,1  # Base case (will be passed to a2): only check 1 tile (if X offset stays 0)

        lbu t1,10(a0)  # Loads Zoomer's Platform
        lbu t2,2(a0)   # Loads Zoomer's X offset
        lbu t3,3(a0)   # Loads Zoomer's Y offset
        lbu t4,9(a0)   # Loads Zoomer's Clock movement
        bnez t1,TRY_MOVE_ZOOMER_COLLISION_LEFT
        # If t1 == 0, platform is bellow zoomer
            li a4,1  # Base case: Consider doors
            li t1,8
            bne t1,t2,MOVE_ZOOMER_CHECK_DOWN_0_OFF  # If offset != 8, check if it's 0
                li a4,1  # Base case: Consider doors
                add a4,a4,a2 # If on second check, consider ONLY doors
                li tp,2  # Check 2 tiles
                sub tp,tp,a2 # If on second check, check ONLY 1 tile
                j MOVE_ZOOMER_CHECK_DOWN_SETUP # start collision check
            MOVE_ZOOMER_CHECK_DOWN_0_OFF:
            # Otherwise, if offset != 0, skip this collision check
            beqz t2, MOVE_ZOOMER_CHECK_DOWN_SETUP
                j MOVE_ZOOMER_PROPERLY

            MOVE_ZOOMER_CHECK_DOWN_SETUP:  # Start checking
            bnez a2, MOVE_ZOOMER_CHECK_DOWN_FOWARD
            # If a2 = 0, it's on first check, so check platform bellow
                addi a7,a7,1 # Checking one tile down
                add a1,a1,a5 # Updates starting address on map matrix
                li a3,1  # Vertical check
                j START_ZOOMER_COLLISION
            
            MOVE_ZOOMER_CHECK_DOWN_FOWARD:
            # If a2 = 1, it's on second check, so check foward
                beqz t4, MOVE_ZOOMER_CHECK_DOWN_FOWARD_CLOCKWISE
                # If t4 = 1, check anti-clockwise (tile to the left)
                li t1,8
                beq t1,t2,MOVE_ZOOMER_CHECK_DOWN_FOWARD_OFF_8 # If offset == 8, don't alter X
                    addi a6,a6,-1   # Checking left tile
                    addi a1,a1,-1   # Updates starting address on map matrix
                MOVE_ZOOMER_CHECK_DOWN_FOWARD_OFF_8:
                    li a3,0  # Horizontal check
                    j START_ZOOMER_COLLISION

                MOVE_ZOOMER_CHECK_DOWN_FOWARD_CLOCKWISE:
                # If t4 = 0, check clockwise (tile to the right)
                    addi a6,a6,1  # Checking right tile
                    addi a1,a1,1   # Updates starting address on map matrix
                    li a3,0  # Horizontal check
                    j START_ZOOMER_COLLISION


        TRY_MOVE_ZOOMER_COLLISION_LEFT:  li t5,1
            bne t1,t5,TRY_MOVE_ZOOMER_COLLISION_UP
            # If platform is to the left of zoomer:
            li t1,8
            bne t1,t2,MOVE_ZOOMER_CHECK_LEFT_0_OFF  # If X offset != 8, skip it
                li a4,1  # Base case: Consider doors
                sub a4,a4,a2 # If on second check, don't consider doors           
            MOVE_ZOOMER_CHECK_LEFT_0_OFF:
            # Otherwise, if Y offset != 0, skip this collision check
            beqz t3, MOVE_ZOOMER_CHECK_LEFT_SETUP
                j MOVE_ZOOMER_PROPERLY

            MOVE_ZOOMER_CHECK_LEFT_SETUP:  # Start checking
            bnez a2, MOVE_ZOOMER_CHECK_LEFT_FOWARD
            # If a2 = 0, it's on first check, so check platform bellow
                li t1,8
                beq t1,t2,MOVE_ZOOMER_CHECK_LEFT_8_OFF  # If X offset is 8, don't update X 
                    addi a6,a6,-1  # Checking left tile (or current tile if X offset == 8)
                    addi a1,a1,-1   # Updates starting address on map matrix 
                MOVE_ZOOMER_CHECK_LEFT_8_OFF:
                li a3,0  # Horizontal check
                j START_ZOOMER_COLLISION
            
            MOVE_ZOOMER_CHECK_LEFT_FOWARD:
            # If a2 = 1, it's on second check, so check foward
                li t1,8
                beq t1,t2,MOVE_ZOOMER_CHECK_LEFT_FOWARD_8_OFF  # If X offset is 8, don't consider doors
                    li a4,1  # Base case: Consider doors
                MOVE_ZOOMER_CHECK_LEFT_FOWARD_8_OFF:
                beqz t4, MOVE_ZOOMER_CHECK_LEFT_FOWARD_CLOCKWISE
                # If t4 = 1, check anti-clockwise (tile above)
                    addi a7,a7,-1 # Checking one tile up
                    sub a1,a1,a5  # Updates starting address on map matrix
                    li a3,1  # Vertical check
                    j START_ZOOMER_COLLISION

                MOVE_ZOOMER_CHECK_LEFT_FOWARD_CLOCKWISE:
                # If t4 = 0, check clockwise (tile bellow)
                    addi a7,a7,1 # Checking one tile down
                    add a1,a1,a5 # Updates starting address on map matrix
                    li a3,1  # Vertical check
                    j START_ZOOMER_COLLISION


        TRY_MOVE_ZOOMER_COLLISION_UP:  li t5,2
            bne t1,t5,MOVE_ZOOMER_COLLISION_RIGHT
            # If platform is above zoomer:
            li t5,8
            bne t5,t2,MOVE_ZOOMER_CHECK_UP_0_OFF  # If offset != 8, check if it's 0
                li a4,1  # Base case: Consider doors
                add a4,a4,a2 # If on second check, consider ONLY doors
                
                li tp,2  # Check 2 tiles
                sub tp,tp,a2 # If on second check, check ONLY 1 tile
                
                j MOVE_ZOOMER_CHECK_UP_SETUP # start collision check
            MOVE_ZOOMER_CHECK_UP_0_OFF:
            # Otherwise, if offset != 0, skip this collision check
            beqz t2, MOVE_ZOOMER_CHECK_UP_SETUP
                j MOVE_ZOOMER_PROPERLY

            MOVE_ZOOMER_CHECK_UP_SETUP:  # Start checking
            bnez a2, MOVE_ZOOMER_CHECK_UP_FOWARD
            # If a2 = 0, it's on first check, so check platform bellow
                addi a7,a7,-1 # Checking one tile above
                sub a1,a1,a5  # Updates starting address on map matrix
                li a3,1  # Vertical check
                j START_ZOOMER_COLLISION
            
            MOVE_ZOOMER_CHECK_UP_FOWARD:
            # If a2 = 1, it's on second check, so check foward
                beqz t4, MOVE_ZOOMER_CHECK_UP_FOWARD_CLOCKWISE
                # If t4 = 1, check anti-clockwise (tile to the left)
                    addi a6,a6,1  # Checking right tile
                    addi a1,a1,1   # Updates starting address on map matrix
                    li a3,0  # Horizontal check
                    j START_ZOOMER_COLLISION

                MOVE_ZOOMER_CHECK_UP_FOWARD_CLOCKWISE:
                # If t4 = 0, check clockwise (tile to the right)
                    li t5,8
                    beq t5,t2,MOVE_ZOOMER_CHECK_UP_FOWARD_CLOCKWISE_0_OFF  # If offset is 8, don't update this
                        addi a6,a6,-1  # Checking left tile
                        addi a1,a1,-1   # Updates starting address on map matrix
                    MOVE_ZOOMER_CHECK_UP_FOWARD_CLOCKWISE_0_OFF:
                    li a3,0  # Horizontal check
                    j START_ZOOMER_COLLISION


        MOVE_ZOOMER_COLLISION_RIGHT:  # li t5,3
            # If platform is to the right of zoomer:
            li t1,8
            bne t1,t2,MOVE_ZOOMER_CHECK_RIGHT_0_OFF  # If X offset != 8, skip this
                li a4,1  # Base case: Consider doors
                
                add a6,a6,a2   # Checking right tile
                add a1,a1,a2   # Updates starting address on map matrix
            
            MOVE_ZOOMER_CHECK_RIGHT_0_OFF:
            # Otherwise, if Y offset != 0, skip this collision check
            beqz t3, MOVE_ZOOMER_CHECK_RIGHT_SETUP
                j MOVE_ZOOMER_PROPERLY

            MOVE_ZOOMER_CHECK_RIGHT_SETUP:  # Start checking
            bnez a2, MOVE_ZOOMER_CHECK_RIGHT_FOWARD
            # If a2 = 0, it's on first check, so check platform on the right
                addi a6,a6,1   # Checking right tile
                addi a1,a1,1   # Updates starting address on map matrix
                li a3,0  # Horizontal check
                j START_ZOOMER_COLLISION
            
            MOVE_ZOOMER_CHECK_RIGHT_FOWARD:
            # If a2 = 1, it's on second check, so check foward
                li a4,1  # Base case: Consider doors
                beqz t4, MOVE_ZOOMER_CHECK_RIGHT_FOWARD_CLOCKWISE
                # If t4 = 1, check anti-clockwise (tile above)
                    addi a7,a7,1 # Checking one tile down
                    add a1,a1,a5 # Updates starting address on map matrix
                    li a3,1  # Vertical check
                    j START_ZOOMER_COLLISION

                MOVE_ZOOMER_CHECK_RIGHT_FOWARD_CLOCKWISE:
                # If t4 = 0, check clockwise (tile bellow)
                    addi a7,a7,-1 # Checking one tile up
                    sub a1,a1,a5  # Updates starting address on map matrix
                    li a3,1  # Vertical check
                    j START_ZOOMER_COLLISION

        START_ZOOMER_COLLISION:
        # Storing Registers on Stack
            addi sp,sp,-16
            sw ra,0(sp)
            sw a0,4(sp)
            sw a1,8(sp)
            sw a2,12(sp)
        # End of Stack Operations

            li a0,2  # All doors should be checked
            # a1 is already defined
            mv a2,tp #li a2,1  # Only check one tile
            # a3 is already defined
            # a4 is already defined
            # a5 is already defined
            # a6 is already defined
            # a7 is already defined
            li tp, 1  # Entity collision

            call CHECK_MAP_COLLISION
            mv t0,a0   # Stores result from a0 to t0
            mv tp,a1   # Stores result from a1 to tp
            
        # Procedure finished: Loading Registers from Stack
            lw ra,0(sp)
            lw a0,4(sp)
            lw a1,8(sp)
            lw a2,12(sp)
            addi sp,sp,16
        # End of Stack Operations
        
        beqz a2, MOVE_ZOOMER_FIRST_CHECK 
            j MOVE_ZOOMER_SECOND_CHECK
            
        MOVE_ZOOMER_FIRST_CHECK:
        # If a2 = 0, it's on first check
            bnez t0, MOVE_ZOOMER_CHANGE_PLATFORM # If returning anything but 0, change zoomer's platform
            li t5,8
            lbu t2,2(a0)   # Loads Zoomer's X offset
            bne t5,t2,MOVE_ZOOMER_REPEAT_LOOP # If zoomer's X isn't 8, treat it as solid
            beqz tp,MOVE_ZOOMER_REPEAT_LOOP # If zoomer isn't on top of a door, treat as solid
            # Otherwise, change direction of movement if it checked platform bellow
                lbu t1,10(a0)  # Loads Zoomer's Platform
                lbu t3,3(a0)   # Loads Zoomer's Y offset
                lbu t4,9(a0)   # Loads Zoomer's Clock movement
                bnez t1,MOVE_ZOOMER_REPEAT_LOOP
                # If platform is bellow zoomer:
                    beqz t4, MOVE_ZOOMER_CHANGE_PLATFORM_DOWN_CLOCKWISE_OFF_8
                    # Otherwise, zoomer is moving anti-clockwise:
                        li t1, 3       # Sets platform to 3 (on the right)
                        li t3, 2       # Sets Y offset to 4

                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        sb t3,3(a0)   # Stores Zoomer's new Y offset
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                    MOVE_ZOOMER_CHANGE_PLATFORM_DOWN_CLOCKWISE_OFF_8:
                    # If zoomer is moving clockwise:
                        li t1, 1       # Sets platform to 1 (on the left)
                        # t2 is the same -- Keeps X offset
                        li t3, 2       # Sets Y offset to 4

                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        sb t3,3(a0)   # Stores Zoomer's new Y offset
                        j END_MOVE_ZOOMER # Ends Move Zoomer

            MOVE_ZOOMER_REPEAT_LOOP:
            # Otherwise, there's "ground", so a foward check needs to be made
                li a2,1 # Loads second check state
                j MOVE_ZOOMER_CHECK_LOOP # and return to the beginning
            
            MOVE_ZOOMER_CHANGE_PLATFORM:
                lbu t1,10(a0)  # Loads Zoomer's Platform
                lbu t2,2(a0)   # Loads Zoomer's X offset
                lbu t3,3(a0)   # Loads Zoomer's Y offset
                lbu t4,9(a0)   # Loads Zoomer's Clock movement
                bnez t1,TRY_MOVE_ZOOMER_CHANGE_PLATFORM_LEFT
                # If platform is bellow zoomer:
                    beqz t4, MOVE_ZOOMER_CHANGE_PLATFORM_DOWN_CLOCKWISE
                    # Otherwise, zoomer is moving anti-clockwise:
                        li t1, 3       # Sets platform to 3 (on the right)
                        # t2 is the same -- Keeps X offset
                        li t3, 2       # Sets Y offset to 4

                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        sb t3,3(a0)   # Stores Zoomer's new Y offset
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                    MOVE_ZOOMER_CHANGE_PLATFORM_DOWN_CLOCKWISE:
                    # If zoomer is moving clockwise:
                        li t1, 1       # Sets platform to 1 (on the left)
                        # t2 is the same -- Keeps X offset
                        li t3, 2       # Sets Y offset to 4

                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        sb t3,3(a0)   # Stores Zoomer's new Y offset
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                TRY_MOVE_ZOOMER_CHANGE_PLATFORM_LEFT:  li t5,1
                bne t1,t5,TRY_MOVE_ZOOMER_CHANGE_PLATFORM_UP
                # If platform is to the left of zoomer:
                    beqz t4, MOVE_ZOOMER_CHANGE_PLATFORM_LEFT_CLOCKWISE
                    # Otherwise, zoomer is moving anti-clockwise:
                        li t1, 0       # Sets platform to 0 (bellow)
                        li t5,8
                        beq t5,t2,MOVE_ZOOMER_CHANGE_PLATFORM_LEFT_OFF_8 # If offset == 8, don't alter X
                            li t2, 14      # Sets X offset to 12
                            lbu t4,4(a0)   # Loads Zoomer's X
                            addi t4,t4,-1  # Subtracts 1 from it (offset was reduced)
                            # t3 is the same -- Keeps Y offset

                            sb t1,10(a0)  # Stores Zoomer's new Platform
                            sb t2,2(a0)   # Stores Zoomer's new X offset
                            sb t4,4(a0)   # Stores Zoomer's new X
                            j END_MOVE_ZOOMER # Ends Move Zoomer

                        MOVE_ZOOMER_CHANGE_PLATFORM_LEFT_OFF_8:
                            li t2, 6       # Sets X offset to 6
                            # t3 is the same -- Keeps Y offset

                            sb t1,10(a0)  # Stores Zoomer's new Platform
                            sb t2,2(a0)   # Stores Zoomer's new X offset
                            j END_MOVE_ZOOMER # Ends Move Zoomer


                    MOVE_ZOOMER_CHANGE_PLATFORM_LEFT_CLOCKWISE:
                    # If zoomer is moving clockwise:
                        li t1, 2       # Sets platform to 2 (above)
                        li t2, 14      # Sets X offset to 12
                        lbu t4,4(a0)   # Loads Zoomer's X
                        addi t4,t4,-1  # Subtracts 1 from it (offset was reduced)
                        # t3 is the same -- Keeps Y offset

                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        sb t2,2(a0)   # Stores Zoomer's new X offset
                        sb t4,4(a0)   # Stores Zoomer's new X
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                TRY_MOVE_ZOOMER_CHANGE_PLATFORM_UP:  li t5,2
                bne t1,t5,MOVE_ZOOMER_CHANGE_PLATFORM_RIGHT
                # If platform is above zoomer:
                    beqz t4, MOVE_ZOOMER_CHANGE_PLATFORM_UP_CLOCKWISE
                    # Otherwise, zoomer is moving anti-clockwise:
                        li t1, 1       # Sets platform to 1 (on the left)
                        # t2 is the same -- Keeps X offset
                        li t3, 14      # Sets Y offset to 12
                        lbu t4,6(a0)   # Loads Zoomer's Y
                        addi t4,t4,-1  # Subtracts 1 from it (offset was reduced)

                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        sb t3,3(a0)   # Stores Zoomer's new Y offset
                        sb t4,6(a0)   # Stores Zoomer's new Y
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                    MOVE_ZOOMER_CHANGE_PLATFORM_UP_CLOCKWISE:
                    # If zoomer is moving clockwise:
                        li t1, 3       # Sets platform to 3 (on the right)
                        # t2 is the same -- Keeps X offset
                        li t3, 14      # Sets Y offset to 12
                        lbu t4,6(a0)   # Loads Zoomer's Y
                        addi t4,t4,-1  # Subtracts 1 from it (offset was reduced)

                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        sb t3,3(a0)   # Stores Zoomer's new Y offset
                        sb t4,6(a0)   # Stores Zoomer's new Y
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                MOVE_ZOOMER_CHANGE_PLATFORM_RIGHT:  # li t5,3
                # If platform is to the right of zoomer:
                    beqz t4, MOVE_ZOOMER_CHANGE_PLATFORM_RIGHT_CLOCKWISE
                    # Otherwise, zoomer is moving anti-clockwise:
                        li t1, 2       # Sets platform to 2 (above)
                        li t2, 2       # Sets X offset to 4
                        # t3 is the same -- Keeps Y offset

                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        sb t2,2(a0)   # Stores Zoomer's new X offset
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                    MOVE_ZOOMER_CHANGE_PLATFORM_RIGHT_CLOCKWISE:
                    # If zoomer is moving clockwise:
                        li t1, 0       # Sets platform to 0 (bellow)
                        beqz t2,MOVE_ZOOMER_CHANGE_PLATFORM_RIGHT_CLOCKWISE_0
                            li t2, 10      # Sets X offset to 10
                            # t3 is the same -- Keeps Y offset

                            sb t1,10(a0)  # Stores Zoomer's new Platform
                            sb t2,2(a0)   # Stores Zoomer's new X offset
                            j END_MOVE_ZOOMER # Ends Move Zoomer
                        MOVE_ZOOMER_CHANGE_PLATFORM_RIGHT_CLOCKWISE_0:
                            li t2, 2      # Sets X offset to 4
                            # t3 is the same -- Keeps Y offset

                            sb t1,10(a0)  # Stores Zoomer's new Platform
                            sb t2,2(a0)   # Stores Zoomer's new X offset
                            j END_MOVE_ZOOMER # Ends Move Zoomer
                
        MOVE_ZOOMER_SECOND_CHECK:
        # If a2 = 1, it's on second check
            bnez t0, MOVE_ZOOMER_PROPERLY  # If returning anything but 0, properly move zoomer
            # Otherwise, there's a tile blocking its path, so change platform (opposite of its clock movement)
                lbu t1,10(a0)  # Loads Zoomer's Platform
                # This will only change platform, and not position/offset
                lbu t4,9(a0)   # Loads Zoomer's Clock movement
                bnez t1,TRY_MOVE_ZOOMER_CHANGE_PLATFORM_LEFT_V2
                # If platform is bellow zoomer:
                    lbu t2,2(a0)   # Loads Zoomer's new X offset
                    li t5,8
                    beq t5,t2,CONTINUE_MOVE_ZOOMER_CHANGE_PLATFORM_DOWN # If offset == 8, continue
                    # Otherwise, if door was detected, ignore it
                        bnez tp,MOVE_ZOOMER_PROPERLY # If there was a door, don't change direction
                    CONTINUE_MOVE_ZOOMER_CHANGE_PLATFORM_DOWN:
                    beqz t4, MOVE_ZOOMER_CHANGE_PLATFORM_DOWN_CLOCKWISE_V2
                    # Otherwise, zoomer is moving anti-clockwise:
                        li t1, 1       # Sets platform to 1 (on the left)
                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                    MOVE_ZOOMER_CHANGE_PLATFORM_DOWN_CLOCKWISE_V2:
                    # If zoomer is moving clockwise:
                        li t1, 3       # Sets platform to 3 (on the right)
                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                TRY_MOVE_ZOOMER_CHANGE_PLATFORM_LEFT_V2:  li t5,1
                bne t1,t5,TRY_MOVE_ZOOMER_CHANGE_PLATFORM_UP_V2
                # If platform is to the left of zoomer:
                    beqz t4, MOVE_ZOOMER_CHANGE_PLATFORM_LEFT_CLOCKWISE_V2
                    # Otherwise, zoomer is moving anti-clockwise:
                        li t1, 2       # Sets platform to 2 (above)
                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                    MOVE_ZOOMER_CHANGE_PLATFORM_LEFT_CLOCKWISE_V2:
                    # If zoomer is moving clockwise:
                        li t1, 0       # Sets platform to 0 (bellow)
                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                TRY_MOVE_ZOOMER_CHANGE_PLATFORM_UP_V2:  li t5,2
                bne t1,t5,MOVE_ZOOMER_CHANGE_PLATFORM_RIGHT_V2
                # If platform is above zoomer:
                    beqz t4, MOVE_ZOOMER_CHANGE_PLATFORM_UP_CLOCKWISE_V2
                    # Otherwise, zoomer is moving anti-clockwise:
                        li t1, 3       # Sets platform to 3 (on the right)
                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                    MOVE_ZOOMER_CHANGE_PLATFORM_UP_CLOCKWISE_V2:
                    # If zoomer is moving clockwise:
                        li t1, 1       # Sets platform to 1 (on the left)
                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                MOVE_ZOOMER_CHANGE_PLATFORM_RIGHT_V2:  # li t5,3
                # If platform is to the right of zoomer:
                    bnez tp,MOVE_ZOOMER_PROPERLY
                    beqz t4, MOVE_ZOOMER_CHANGE_PLATFORM_RIGHT_CLOCKWISE_V2
                    # Otherwise, zoomer is moving anti-clockwise:
                        li t1, 0       # Sets platform to 0 (bellow)
                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        j END_MOVE_ZOOMER # Ends Move Zoomer

                    MOVE_ZOOMER_CHANGE_PLATFORM_RIGHT_CLOCKWISE_V2:
                    # If zoomer is moving clockwise:
                        li t1, 2       # Sets platform to 2 (above)
                        sb t1,10(a0)  # Stores Zoomer's new Platform
                        j END_MOVE_ZOOMER # Ends Move Zoomer
                
        MOVE_ZOOMER_PROPERLY:
        # In order to move zoomer, it needs to check clock direction and platform (again...)
            lbu t1,10(a0)  # Loads Zoomer's Platform
            lbu t2,2(a0)   # Loads Zoomer's X offset
            lbu t3,3(a0)   # Loads Zoomer's Y offset
            lbu t4,9(a0)   # Loads Zoomer's Clock movement
            bnez t1,TRY_MOVE_ZOOMER_PROPERLY_LEFT
            # If platform is bellow zoomer:
                beqz t4, MOVE_ZOOMER_PROPERLY_DOWN_CLOCKWISE
                # Otherwise, zoomer is moving anti-clockwise:
                    addi t2,t2,-2     # Updates X offset
                    # t3 stays the same -- don't change Y offset
                    j MOVE_ZOOMER_PROPERLY_OFFSET_CHECK # Checking if offset is ok

                MOVE_ZOOMER_PROPERLY_DOWN_CLOCKWISE:
                # If zoomer is moving clockwise:
                    addi t2,t2,2     # Updates X offset
                    # t3 stays the same -- don't change Y offset
                    j MOVE_ZOOMER_PROPERLY_OFFSET_CHECK # Checking if offset is ok

            TRY_MOVE_ZOOMER_PROPERLY_LEFT:  li t5,1
            bne t1,t5,TRY_MOVE_ZOOMER_PROPERLY_UP
            # If platform is to the left of zoomer:
                beqz t4, MOVE_ZOOMER_PROPERLY_LEFT_CLOCKWISE
                # Otherwise, zoomer is moving anti-clockwise:
                    # t2 stays the same -- don't change X offset
                    addi t3,t3,-2     # Updates Y offset
                    j MOVE_ZOOMER_PROPERLY_OFFSET_CHECK # Checking if offset is ok

                MOVE_ZOOMER_PROPERLY_LEFT_CLOCKWISE:
                # If zoomer is moving clockwise:
                    # t2 stays the same -- don't change X offset
                    addi t3,t3,2     # Updates Y offset
                    j MOVE_ZOOMER_PROPERLY_OFFSET_CHECK # Checking if offset is ok

            TRY_MOVE_ZOOMER_PROPERLY_UP:  li t5,2
            bne t1,t5,MOVE_ZOOMER_PROPERLY_RIGHT
            # If platform is above zoomer:
                beqz t4, MOVE_ZOOMER_PROPERLY_UP_CLOCKWISE
                # Otherwise, zoomer is moving anti-clockwise:
                    addi t2,t2,2     # Updates X offset
                    # t3 stays the same -- don't change Y offset
                    j MOVE_ZOOMER_PROPERLY_OFFSET_CHECK # Checking if offset is ok

                MOVE_ZOOMER_PROPERLY_UP_CLOCKWISE:
                # If zoomer is moving clockwise:
                    addi t2,t2,-2     # Updates X offset
                    # t3 stays the same -- don't change Y offset
                    j MOVE_ZOOMER_PROPERLY_OFFSET_CHECK # Checking if offset is ok

            MOVE_ZOOMER_PROPERLY_RIGHT:  # li t5,3
            # If platform is to the right of zoomer:
                beqz t4, MOVE_ZOOMER_PROPERLY_RIGHT_CLOCKWISE
                # Otherwise, zoomer is moving anti-clockwise:
                    # t2 stays the same -- don't change X offset
                    addi t3,t3,2     # Updates Y offset
                    j MOVE_ZOOMER_PROPERLY_OFFSET_CHECK # Checking if offset is ok

                MOVE_ZOOMER_PROPERLY_RIGHT_CLOCKWISE:
                # If zoomer is moving clockwise:
                    # t2 stays the same -- don't change X offset
                    addi t3,t3,-2     # Updates Y offset
                    #j MOVE_ZOOMER_PROPERLY_OFFSET_CHECK # Checking if offset is ok
            
            MOVE_ZOOMER_PROPERLY_OFFSET_CHECK:
                sb t2,2(a0)   # Stores Zoomer's new X offset (may change depending on next checks)
                bge t2,zero, SKIP_MOVE_ZOOMER_PROPERLY_X_OFFSET_NEGATIVE
                # X offset is < 0
                    addi t2,t2,tile_size # adds 16 to offset
                    lbu t4,4(a0)         # Loads Zoomer's X
                    addi t4,t4,-1        # subtracts 1 from it

                    sb t2,2(a0)          # Stores Zoomer's new X offset
                    sb t4,4(a0)          # Stores Zoomer's new X
                    j MOVE_ZOOMER_PROPERLY_OFFSET_CHECK_Y    # check Y offset
                
                SKIP_MOVE_ZOOMER_PROPERLY_X_OFFSET_NEGATIVE:
                # X offset is >= 0 
                li t0,tile_size
                blt t2,t0,MOVE_ZOOMER_PROPERLY_OFFSET_CHECK_Y # X offset is ok
                # X offset is >= 16
                    sub t2,t2,t0         # subtracts 16 to offset
                    lbu t4,4(a0)         # Loads Zoomer's X
                    addi t4,t4,1         # adds 1 from it

                    sb t2,2(a0)          # Stores Zoomer's new X offset
                    sb t4,4(a0)          # Stores Zoomer's new X
                    # j MOVE_ZOOMER_PROPERLY_OFFSET_CHECK_Y    # check Y offset

                MOVE_ZOOMER_PROPERLY_OFFSET_CHECK_Y:
                sb t3,3(a0)   # Stores Zoomer's new X offset (may change depending on next checks)
                bge t3,zero, SKIP_MOVE_ZOOMER_PROPERLY_Y_OFFSET_NEGATIVE
                # Y offset is < 0
                    addi t3,t3,tile_size # adds 16 to offset
                    lbu t4,6(a0)         # Loads Zoomer's Y
                    addi t4,t4,-1        # subtracts 1 from it

                    sb t3,3(a0)          # Stores Zoomer's new Y offset
                    sb t4,6(a0)          # Stores Zoomer's new Y
                    j END_MOVE_ZOOMER    # Finishes procedure
                
                SKIP_MOVE_ZOOMER_PROPERLY_Y_OFFSET_NEGATIVE:
                # Y offset is >= 0 
                li t0,tile_size
                blt t3,t0,END_MOVE_ZOOMER # Y offset is ok
                # Y offset is >= 16
                    sub t3,t3,t0         # subtracts 16 to offset
                    lbu t4,6(a0)         # Loads Zoomer's Y
                    addi t4,t4,1         # adds 1 from it

                    sb t3,3(a0)          # Stores Zoomer's new Y offset
                    sb t4,6(a0)          # Stores Zoomer's new Y
                    j END_MOVE_ZOOMER    # Finishes procedure

    END_MOVE_ZOOMER:
    # Procedure finished: Loading Registers from Stack
        # lw a1,0(sp) not needed
        addi sp,sp,4
    # End of Stack Operations
        ret


###########################        MOVE RIPPER        ###########################
#          This procedure checks the tiles in front of Ripper when its          #
#            X offset is 0. If there's something blocking its path,             #
#                              it'll turn arround.                              #
#                                                                               #
#  ------------------           argument registers          ------------------  #
#    a0 = Ripper's address                                                      #
#	 a1 = Current map's address                                                 #
#                                                                               #
#  ------------------             registers used            ------------------  #
#    a2,a3, a4, a5, a6, a7 --> used as arguments for COLLISION_CHECK            #      
#                                                                               #
#  ------------------          temporary registers          ------------------  #
#    t0, t1 --> temporary registers                                             #
#    t2 = PLYR_POS address (stores from a2 to let it be modified)               #
#    t3 = Player's X/Y offset                                                   #
#    tp = offset modifier (stores from a3 to let it be modified)                #
#                                                                               #    
#################################################################################  

MOVE_RIPPER:
    # Storing current X and Y to old X and Y
    lbu t1,3(a0)  # Loads Ripper's X
    sb t1,4(a0)   # And stores it in Ripper's old 
    lbu t1,5(a0)  # Loads Ripper's Y
    sb t1,6(a0)   # And stores it in Ripper's old Y

    # Preparations for check
    li t0,1       # In case no collision check is made
    lbu t1,2(a0)  # Loads Ripper's X offset

    bnez t1,SKIP_RIPPER_COLLISION   # If offset isn't 0, just move ripper
    # Otherwise, check collision
        lbu a5,1(a1)  # Loads map's matrix width
        lbu a6,3(a0)  # Loads Ripper's current X
        lbu a7,5(a0)  # Loads Ripper's current Y

        addi a1,a1,3   # Adds 3 to the Matrix's address so that it goes to the beginning of matrix
        mul t0,a7,a5   # Ripper's Y related to matrix * Map Matrix's width
        add t0,a6,t0   # t0 = Ripper's X related to matrix +  Ripper's Y related to matrix * Map Matrix's width  
        add a1,a1,t0   # a1 = Map Matrix's address adjusted for Ripper's X and Y related to matrix
    
        lbu t0,1(a0)  # Loads Ripper's direction
        beqz t0,RIPPER_COLLISION_RIGHT   # If moving right
        # Otherwise, check on the left
            addi a6,a6,-1 # Checking tile to the left
            addi a1,a1,-1 # Updates starting address on map matrix
            j START_RIPPER_COLLISION
        
        RIPPER_COLLISION_RIGHT: 
            addi a6,a6,1 # Checking tile to the right
            addi a1,a1,1 # Updates starting address on map matrix
            #j START_RIPPER_COLLISION

    START_RIPPER_COLLISION:
    # Storing Registers on Stack
        addi sp,sp,-12
        sw a0,0(sp)
        sw a1,4(sp)
        sw ra,8(sp)
    # End of Stack Operations

        li a0,2  # Doesn't matter, since no doors will be checked
        # a1 is already defined
        li a2,1  # Only check one tile
        li a3,0  # Horizontal check
        li a4,0  # Don't consider doors (since it never spawns there)
        # a5 is already defined
        # a6 is already defined
        # a7 is already defined
        li tp, 1  # Entity collision

        call CHECK_MAP_COLLISION
        mv t0,a0

    # Procedure finished: Loading Registers from Stack
        lw a0,0(sp)
        lw a1,4(sp)
        lw ra,8(sp)
        addi sp,sp,12
    # End of Stack Operations
    
    SKIP_RIPPER_COLLISION:
    # In case no collision check was made, t0 = 1
        lbu t1,1(a0)  # Loads Ripper's direction
        bnez t0, CONTINUE_MOVE_RIPPER  # If returning anything but 0, continue moving ripper
        # Otherwise, turn it arround
            xori t1,t1,1  # Inverts direction
            sb t1,1(a0)   # and stores it back
            ret # and finish procedure

        CONTINUE_MOVE_RIPPER:
            # Y never updates
            lbu t0,3(a0)  # Loads Ripper's X
            lbu t2,2(a0)  # Loads Ripper's X offset
            beqz t1,MOVE_RIPPER_RIGHT  # If direction is to the right
            # Otherwise, update to the left
                addi t2,t2,-2   # Movement for ripper to the left
                bge t2,zero,MOVE_RIPPER_LEFT_SKIP_CORRECTION
                    addi t2,t2,tile_size # adds 16 to offset
                    addi t0,t0,-1        # subtracts 1 from X
                MOVE_RIPPER_LEFT_SKIP_CORRECTION:
                    sb t0,3(a0)    # Stores Ripper's new X
                    sb t2,2(a0)    # Stores Ripper's new X offset
                    ret # and finish procedure

            MOVE_RIPPER_RIGHT:
                addi t2,t2,2      # Movement for ripper to the right
                li t1,tile_size   # loads 16
                blt t2,t1,MOVE_RIPPER_RIGHT_SKIP_CORRECTION
                    sub t2,t2,t1  # subtracts 16 from offset
                    addi t0,t0,1  # subtracts 1 from X
                MOVE_RIPPER_RIGHT_SKIP_CORRECTION:
                    sb t0,3(a0)   # Stores Ripper's new X
                    sb t2,2(a0)   # Stores Ripper's new X offset
                    ret # and finish procedure


###########################        MOVE RIDLEY        ###########################
#         Ridley does not move through the X axis. Rather, he only jumps        #
#   from time to time. This procedure will make sure that he jumps and lands    #
#           in the right spot. It does not check collision above and            #
#                   considers a cooldown for ridley to jump.                    #
#                                                                               #
#  ------------------           argument registers          ------------------  #
#    a0 = Ridley's address                                                      #
#	 a1 = Current map's address                                                 #
#                                                                               #
#  ------------------             registers used            ------------------  #
#    a2 = Ridley's matrix Y that will be modified and possibly stored           #
#    a3 = Ridley's Y offset that will be modified and possibly stored           #
#    a4, a5, a6, a7 --> used as arguments for COLLISION_CHECK                   #      
#                                                                               #
#  ------------------          temporary registers          ------------------  #
#    t0, t1 --> temporary registers                                             #
#    t2 = PLYR_POS address (stores from a2 to let it be modified)               #
#    t3 = Player's X/Y offset                                                   #
#    tp = offset modifier (stores from a3 to let it be modified)                #
#                                                                               #    
#################################################################################  

MOVE_RIDLEY:
#ebreak
    lbu a3,2(a0)    # Loads Ridley's Y offset
    # Storing current X and Y to old X and Y
    lbu a2,3(a0)  # Loads Ridley's Y
    sb a2,4(a0)   # And stores it in Ridley's old Y

    # Proper movement calculations 
    lb t0,7(a0)   # Loads Ridley's MOVE_Y
    lb t2,8(a0)   # Loads JUMP information
    blt t0,zero, MOVE_RIDLEY_UP   # In case MOVE_Y = -1
    bnez t0, ITERATE_RIDLEY_JUMP  # In case of MOVE_Y = 1, just iterate jump downards
    # Otherwise, 
        j MOVE_RIDLEY_PROPERLY
        
    MOVE_RIDLEY_UP:   
        fcvt.w.s t1,fs4                    # gets Ridley's current Y speed (truncated)
        bge t1,zero, SWITCH_RIDLEY_DOWN    # if less then zero, switch down
        li t1, ridley_max_jump             # maximum height of jump 
        blt t2, t1, ITERATE_RIDLEY_JUMP    # if still not there, iterate jump
        # Otherwise, switch to falling                
            SWITCH_RIDLEY_DOWN:     
                li t1, 1         # Loads 1 (Down)       
                sb t1, 7(a0)     # Switches MOVE_Y to 1 (Down)  
                sb zero, 8(a0)   # reset jump information

                fcvt.s.w fs4,zero       # Sets speed to zero       
                j END_MOVE_RIDLEY  
            
        ITERATE_RIDLEY_JUMP:
            fadd.s fs4,fs4,fs0    # fs4 = Ridley's current Y speed + gravity factor       
            fcvt.w.s t3,fs4       # Sets t3 = floor(fs4)

#    li t0,max_speed             # Loads max speed (8, when falling)
#    blt t3,t0, SKIP_MAX_SPEED   # If t3 < 8, skip this part
#    # Otherwise, set offset modifier to 8
#        li a4,max_speed
#        # speed doesn't need to be changed (will be 0 when on the ground and 8 while in freefall)
#    SKIP_MAX_SPEED: 
         
            # Iterating JUMP factor with absolute value of t3
            mv t0,t3                # moves t3 to t0
            bge t0,zero, SKIP_ABS_RIDLEY   # if t0 >= 0, skip this
                sub t0,zero,t0             # otherwise, t0 will be its opposite 
            SKIP_ABS_RIDLEY:
                add t2,t2,t0               # t0 to t2 (JUMP factor)
                sb t2, 8(a0)               # and stores it

        add a3,a3,t3	# Adds the Y Movement to the Ridley's Offset
        
        bge a3,zero,SKIP_UP_Y_RIDLEY
        # If a3 < 0, Ridley is moving to the upper tile
        addi a2, a2, -1		    # Ridley's Y on matrix -= 1 (goes to the left)
        addi a3, a3, tile_size  # Offset gets corrected (relative to new Y on matrix coordinate)
        
        SKIP_UP_Y_RIDLEY:
            li t0, tile_size
            blt a3,t0, SKIP_DOWN_Y_RIDLEY
            # If a3 >= 16, Ridley is moving to the lower tile
            addi a2,a2, 1	 # Ridley's Y on matrix += 1 (goes to the right)
            sub a3,a3,t0	 # Offset gets corrected (relative to new Y on matrix coordinate)
        
        SKIP_DOWN_Y_RIDLEY:  
        # Preparations for check
        li t0,1       # In case no collision check is made
        lb t1,7(a0)   # Loads Ridley's MOVE_Y
        blt t1,zero,MOVE_RIDLEY_PROPERLY # If moving up, doesn't need collision (he doesn't jump to high)
        # Otherwise, begin collision check
            lbu t0,2(a0)   # Loads Ridley's Y offset
            li t1, 10      # For comparing
            add t0,t0,t3   # Current Y offset + Y offset modifier

            bge t0,t1 CONTINUE_RIDLEY_COLLISION    # If the result >= 10, continue checking
                j MOVE_RIDLEY_PROPERLY             # Othewise, just move the reptile dragon thing ¯\_(ツ)_/¯

        CONTINUE_RIDLEY_COLLISION:
            lb t0,7(a0)   # Loads Ridley's MOVE_Y
            bgt t0,zero CONTINUE_RIDLEY_COLLISION_2   # In case MOVE_Y = 1
                j MOVE_RIDLEY_PROPERLY # If MOVE_Y = 0 or -1
        CONTINUE_RIDLEY_COLLISION_2:
        # In order to check down, moves address down 3 tiles
            lbu a5,1(a1)     # Loads map's matrix width
            li a6,ridley_X   # Loads Ridley's current X
            lbu a7,3(a0)     # Loads Ridley's current Y
            addi a7,a7,3     # adds 3 to Y, so that address will be 3 tiles down

            addi a1,a1,3          # Adds 3 to the Matrix's address so that it goes to the beginning of matrix
            mul t0,a7,a5          # (Ridley's matrix Y + 3)  * Map Matrix's width
            add t0,a6,t0          # t0 = Ridley's X related to matrix + (Ridley's matrix Y + 3)  * Map Matrix's width
            add a1,a1,t0          # a1 = Map Matrix's address adjusted for Ridley's X and Y (+3) related to matrix       

            START_RIDLEY_COLLISION:
            # Storing Registers on Stack
                addi sp,sp,-20
                sw a3,16(sp)
                sw a2,12(sp)
                sw a1,8(sp)
                sw a0,4(sp)
                sw ra,0(sp)
            # End of Stack Operations

                li a0,2  # Doesn't matter, since no doors will be checked
                # a1 is already defined
                li a2,1  # Only check one tile
                li a3,1  # Vertical check
                li a4,0  # Don't consider doors (since it never spawns there)
                # a5 is already defined
                # a6 is already defined
                # a7 is already defined
                li tp, 1  # Entity collision
                call CHECK_MAP_COLLISION
                mv t0,a0

            # Procedure finished: Loading Registers from Stack
                lw a3,16(sp)
                lw a2,12(sp)
                lw a1,8(sp)
                lw a0,4(sp)
                lw ra,0(sp)
                addi sp,sp,20
            # End of Stack Operations
            
            # After checking collision
            bnez t0, MOVE_RIDLEY_PROPERLY   # If returning anything but 0, Ridley can move
            # Otherwise (in theory) the only time Ridley should face a collision is when moving down
                fcvt.s.w fs4,zero # Resets Ridley's jump speed
                sb zero, 7(a0) # RIDLEY_MOVE_Y = 0
                sb zero, 8(a0) # RIDLEY_JUMP = 0
                # Don't adjust Ridley's Y
                li t0,10        # setting new Y offset    
                sb t0,2(a0)     # Sets Ridley's Y offset to 10

                lbu t0, 9(a0)   # Loads jump cooldown
                bnez t0,MOVE_RIDLEY_SKIP_COOLDOWN_RESET  # If cooldown isn't 0, don't reset it
                # Otherwise, reset cooldown
                    li t0,ridley_jump_cooldown  
                    sb t0, 9(a0)
                MOVE_RIDLEY_SKIP_COOLDOWN_RESET:
                #j END_MOVE_RIDLEY    
        
        MOVE_RIDLEY_PROPERLY:         
            lbu t0, 9(a0)   # Loads jump cooldown 
            bnez t0,MOVE_RIDLEY_PROPERLY_ITERATE_COOLDOWN
            # If able to jump, change ridley's coordinates
                sb a2,3(a0)     # Stores Ridley's new Y 
                sb a3,2(a0)     # Stores new Y offset
                j END_MOVE_RIDLEY

            MOVE_RIDLEY_PROPERLY_ITERATE_COOLDOWN:
            # If not able to jump, iterate over jump cooldown
                addi t0,t0,-1   # Takes 1 from cooldown
                bnez t0,MOVE_RIDLEY_PROPERLY_FINISH_ITERATE_COOLDOWN
                # If cooldown is 0, set up ridley to jump
                    fmv.s fs4,fs3  # moves ridley's initial speed to fs4
                    li t1,-1       # Loads -1 (Up)
                    sb t1,7(a0)    # and stores it on Ridley's MOVE_Y
                MOVE_RIDLEY_PROPERLY_FINISH_ITERATE_COOLDOWN:
                # If cooldown is still not 0 (or is and jump speed was already set), store it back 
                # and end it all (the procedure o_o)
                    sb t0, 9(a0)   # Loads jump cooldown
                    #j END_MOVE_RIDLEY      
    
    END_MOVE_RIDLEY:
        ret

#######################        MOVE PLASMA BREATH        ########################
#         Plasma breaths move in a "zig-zag" way, kicking on the ground         #
#   (it follows an oblique motion). It must consider all vertical collisions    #
#              (up and down), ignoring horizontal collision checks              #
#                       (unless it passes an X threshold)                       #
#                                                                               #
#  ------------------           argument registers          ------------------  #
#    a0 = Plasma Breath's address                                               #
#	 a1 = Current map's address                                                 #
#    fa0 = Current Plasma Breath's Y speed (will be returned afterwards)        #
#                                                                               #
#  ------------------             registers used            ------------------  #
#    a2 = Plasma Breath's matrix Y that will be modified and possibly stored    #
#    a3 = Plasma Breath's Y offset that will be modified and possibly stored    #
#    a4, a5, a6, a7 --> used as arguments for COLLISION_CHECK                   #      
#                                                                               #
#  ------------------          temporary registers          ------------------  #
#    t0, t1 --> temporary registers                                             #
#    t2 = PLYR_POS address (stores from a2 to let it be modified)               #
#    t3 = Player's X/Y offset                                                   #
#    tp = offset modifier (stores from a3 to let it be modified)                #
#                                                                               #    
#################################################################################  

MOVE_PLASMA_BREATH:
            #lbu a1,6(a0) # Loads plasma breath's current X
            #lbu t0,3(a0) # Loads plasma breath's X offset
    
    # X doesn't need a collision check
    lbu t3,6(a0) # Loads plasma breath's current X
    sb t3,7(a0)  # And stores it on old X

    lbu t0,3(a0) # Loads plasma breath's X offset
    lbu t1,1(a0) # Loads plasma breath's X movement (always positive)

    add t0,t0,t1 # Adds X movement to X offset
 
    li t2,tile_size # Loads 16
    blt t0,t2,MOVE_PLASMA_BREATH_SKIP_CORRECTION # If less than 16, skip correction
        addi t3,t3,1   # Adds 1 to X
        sub t0,t0,t2   # Corrects X offset 
    MOVE_PLASMA_BREATH_SKIP_CORRECTION:
        sb t3,6(a0)    # Stores new X (or the same, if unaltered)
        sb t0,3(a0)    # Stores new X offset

    li t1,disable_threshold  # Loads X where plasma breath should be disabled
    blt t3,t1,MOVE_PLASMA_BREATH_KEEP  # If it didn't surpass the threshold, continue
    # Otherwise, set it to be disabled
        li t1,2     # Loads "To be Disabled" 
        sb t1,0(a0) # and stores it on enable byte
        # This loop will continue normally and even the collision will work. Only
        # when arriving on the next loop's PLASMA_BREATH_OPERATIONS will it be disabled

    MOVE_PLASMA_BREATH_KEEP:
    # Altering Y and doing a collision check afterwards
    lbu a2,8(a0)    # Loads plasma breath's current Y
    sb a2,9(a0)     # And stores it on old Y
    lbu a3,4(a0)    # Loads plasma breath's current Y offset

    # Proper movement calculations 
    lb t0,2(a0)   # Loads Plasma Breath's MOVE_Y
 #   lb t2,8(a0)   # Loads JUMP information
    blt t0,zero, MOVE_PLASMA_BREATH_UP   # In case MOVE_Y = -1 
        j ITERATE_PLASMA_BREATH_JUMP     # Otherwise, just iterate
        
    MOVE_PLASMA_BREATH_UP:   
        fcvt.w.s t1,fa0                           # Gets Plasma Breath's current Y speed (truncated)
        bge t1,zero, SWITCH_PLASMA_BREATH_DOWN    # If less then zero, switch down
        j ITERATE_PLASMA_BREATH_JUMP                     # If still not there, iterate jump
        # Otherwise, switch to falling                
            SWITCH_PLASMA_BREATH_DOWN:     
                li t1, 1         # Loads 1 (Down)       
                sb t1, 2(a0)     # Switches MOVE_Y to 1 (Down) 
                # keep the same speed
                #fcvt.s.w fa0,zero       # Sets speed to zero       
                j END_MOVE_PLASMA_BREATH
            
        ITERATE_PLASMA_BREATH_JUMP:
            fadd.s fa0,fa0,fs0    # fa0 = Plasma Breath's current Y speed + gravity factor       
            fcvt.w.s t3,fa0       # Sets t3 = floor(fa0)

            li t0,plasma_max_speed             # Loads max speed (8, when falling)
            blt t3,t0, SKIP_PLASMA_MAX_SPEED   # If t3 < 8, skip this part
            # Otherwise, set offset modifier to 8
                li t3,plasma_max_speed
                fcvt.s.w fa0,t0

            SKIP_PLASMA_MAX_SPEED: 
            # Iterating JUMP factor with absolute value of t3
        #    mv t0,t3                # moves t3 to t0
        #    bge t0,zero, SKIP_ABS_RIDLEY   # if t0 >= 0, skip this
        #        sub t0,zero,t0             # otherwise, t0 will be its opposite 
        #    SKIP_ABS_RIDLEY:
        #        add t2,t2,t0               # t0 to t2 (JUMP factor)
        #        sb t2, 8(a0)               # and stores it

        add a3,a3,t3	# Adds the Y Movement to the Plasma Breath's Offset      
        bge a3,zero,SKIP_UP_Y_PLASMA_BREATH
        # If a3 < 0, Plasma Breath is moving to the upper tile 
        addi a2, a2, -1		    # Plasma Breath's Y on matrix -= 1 (goes to the left)
        addi a3, a3, tile_size  # Offset gets corrected (relative to new Y on matrix coordinate)
        
        SKIP_UP_Y_PLASMA_BREATH:
            li t0, tile_size
            blt a3,t0, SKIP_DOWN_Y_PLASMA_BREATH
            # If a3 >= 16, Plasma Breath is moving to the lower tile
            addi a2,a2, 1	 # Plasma Breath's Y on matrix += 1 (goes to the right)
            sub a3,a3,t0	 # Offset gets corrected (relative to new Y on matrix coordinate)
        
        SKIP_DOWN_Y_PLASMA_BREATH:  
        # Preparations for check
#        li t0,1       # In case no collision check is made
        
        lbu a5,1(a1)     # Loads map's matrix width
        lbu a6,6(a0)     # Loads plasma breath's current X
        lbu a7,8(a0)     # Loads plasma breath's current Y

        addi a1,a1,3     # Adds 3 to the Matrix's address so that it goes to the beginning of matrix
        mul t0,a7,a5     # (Plasma Breath's matrix Y + 3)  * Map Matrix's width
        add t0,a6,t0     # t0 = Plasma Breath's X related to matrix + (Plasma Breath's matrix Y + 3)  * Map Matrix's width
        add a1,a1,t0     # a1 = Map Matrix's address adjusted for Plasma Breath's X and Y (+3) related to matrix       

        lbu t0,4(a0)     # Loads Plasma Breath's Y offset
        lb t1,2(a0)      # Loads Plasma Breath's MOVE_Y
        blt t1,zero, CHECK_Y_UP_PLASMA_BREATH # If t1 < 0, check up, 
        j CHECK_Y_DOWN_PLASMA_BREATH          # otherwise check down

        CHECK_Y_UP_PLASMA_BREATH:
            li t1, 8       # For comparing
            add t0,t0,t3   # Current Y offset + Y offset modifier
            bge t1,t0 CONTINUE_PLASMA_BREATH_COLLISION_UP    # If the result <= 8, continue checking
                j MOVE_PLASMA_BREATH_PROPERLY  # Othewise, just move the fourth state of matter breath 

            CONTINUE_PLASMA_BREATH_COLLISION_UP:
            # If it arrived here, it'll check the current tile to see if
            # plasma breath can move up, and since it's already been calculated
                j START_PLASMA_BREATH_COLLISION
        
        CHECK_Y_DOWN_PLASMA_BREATH:
            add a1,a1,a5  # Moves matrix one tile down
            addi a7,a7,1  # Moves Y one tile down
            beqz t3 CONTINUE_CHECK_Y_DOWN_PLASMA_BREATH   # If plasma breath's Y offset == 0, continue checking
            # Othewise:
            # 1 - Go another tile down, in case branch condition is met
            add a1,a1,a5  # If Y offset != 0
            addi a7,a7,1  # If Y offset != 0
            # 2 - check if current offset + offset modifier will be greater than or equal to 16
            li t1,tile_size  # Loads 16
            add t0,t0,t3     # Current Y offset + Y offset modifier
            bge t0,t1 CONTINUE_CHECK_Y_DOWN_PLASMA_BREATH  # If current offset + offset modifier >= 16, continue checking (but check one tile bellow)
                j MOVE_PLASMA_BREATH_PROPERLY              # Othewise, just move the the fourth state of matter breath (Ha, you've only read one "the")

            CONTINUE_CHECK_Y_DOWN_PLASMA_BREATH:
            # If it arrived here, but Y offset != 0, it'll check 2 two tiles down
            # Otherwise, it'll check only one tile down
                j START_PLASMA_BREATH_COLLISION

            START_PLASMA_BREATH_COLLISION:
            # Storing Registers on Stack
                addi sp,sp,-20
                sw a3,16(sp)
                sw a2,12(sp)
                sw a1,8(sp)
                sw a0,4(sp)
                sw ra,0(sp)
            # End of Stack Operations

                li a0,2  # Doesn't matter, since no doors will be checked
                # a1 is already defined
                li a2,1  # Only check one tile
                li a3,1  # Vertical check
                li a4,0  # Don't consider doors (since it never spawns there)
                # a5 is already defined
                # a6 is already defined
                # a7 is already defined
                li tp, 1  # Entity collision
                call CHECK_MAP_COLLISION
                mv t0,a0

            # Procedure finished: Loading Registers from Stack
                lw a3,16(sp)
                lw a2,12(sp)
                lw a1,8(sp)
                lw a0,4(sp)
                lw ra,0(sp)
                addi sp,sp,20
            # End of Stack Operations
            
            # After checking collision
            bnez t0, MOVE_PLASMA_BREATH_PROPERLY   # If returning anything but 0, Plasma Breath can move
            # Otherwise (in theory) the only time Ridley should face a collision is when moving down
                #fcvt.s.w fa0,zero # Resets Ridley's jump speed              
                fneg.s fa0,fa0  # Invert speed
                
                lb t0,2(a0)   # Loads Plasma Breath's MOVE_Y,
                neg t1,t0     # inverts it,
                lb t1,2(a0)   # and stores it back
                
                blt t0,zero,SWITCH_PLASMA_BREATH_DOWN_2 # If t0 (old MOVE_Y) <= -1 adjust coordinates
                # Otherwise, adjust coordinates for the falling plasma breath
                    lbu t0,4(a0)   # Loads plasma breath's current Y offset  
                    beqz t0,MOVE_PLASMA_BREATH_SKIP_ADJUST_Y  
                        sb zero, 4(a0) # Sets plasma breath's Y offset to 0     
                        sb a2,8(a0)    # Stores new Y 
                    MOVE_PLASMA_BREATH_SKIP_ADJUST_Y: 
                    # If Y offset was 0, everything was already set
                        j END_MOVE_PLASMA_BREATH   # Finish procedure
                
                SWITCH_PLASMA_BREATH_DOWN_2:
                # If moving up, all we need to do is set Y offset to 8, since it's already in the correct Y
                    li t0,8      # Loads new Y offset
                    sb t0,4(a0)  # and stores it back
                    j END_MOVE_PLASMA_BREATH   # Finish procedure
        
        MOVE_PLASMA_BREATH_PROPERLY:         
            sb a2,8(a0)     # Stores Plasma Breath's new Y 
            sb a3,4(a0)     # Stores new Y offset
            #j END_MOVE_PLASMA_BREATH   
    
    END_MOVE_PLASMA_BREATH:
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
#    t5 = holds value of tp (player or entity)                            #
###########################################################################

CHECK_MAP_COLLISION:
mv t5,tp
mv tp,a0 # Moves door check to tp
li a0,1  # Sets a0 to 1 (can move)
li t6,0  # Sets t6 to 0 (no doors detected)
# Begins loop
    MAP_COLLISION_LOOP:
    # If a0 = 0, player can't move and the checking should stop
        bnez a0, CONTINUE_CHECK_MAP_COLLISION_1 # Otherwise, continue check
        j END_COLLISON_MAP

        CONTINUE_CHECK_MAP_COLLISION_1:
        # If a2 > 0, stop checking 
            blt zero, a2, CONTINUE_CHECK_MAP_COLLISION_2
            j END_COLLISON_MAP

        CONTINUE_CHECK_MAP_COLLISION_2:
            lbu t1, 0(a1) # Loads tile from current map
########### CHECK THIS OUT #######################################
		    li t0, 251     # Value where special tiles start 
		    bge t1, t0, COLLISION_SPECIAL_1 # If it's a special tile
#####################################################################
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

            COLLISION_SPECIAL_1:
                bnez a3,CONTINUE_COLLISION_SPECIAL_1 # If on vertical check, continue
                # Otherwise, only if on last iteration of horizontal check should you continue
                addi t2,a2,-1
                beqz t2,CONTINUE_COLLISION_SPECIAL_1
                    j CONTINUE_CHECK_MAP_COLLISION_3
                CONTINUE_COLLISION_SPECIAL_1:    
                    bnez t5,COLLISION_SPECIAL_1_NOT_MARU_MARI
                    li t0,255
                    bne t0,t1,COLLISION_SPECIAL_1_NOT_MARU_MARI
                        la t1,MARU_MARI_INFO # Loads Maru Mari's info address
                        lbu t0, 0(t1)        # Loads enable byte
                        beqz t0,COLLISION_SPECIAL_1_BACKGROUND # If disabled, skip
                        # Otherwise, pick up MaruMari
                            sb zero, 0(t1)   # disables Maru Mari
                            li t0,1          # Loads 1 (1- ball)
                            la t1,PLYR_INFO  # Loads Maru Mari's info address
                            sb t0,1(t1)      # New ability
                            j COLLISION_SPECIAL_1_GET
                    
                    COLLISION_SPECIAL_1_GET:  # Will go to a loop and play a tune
                        csrr t1,3073                       # Gets current time for loop
                        COLLISION_SPECIAL_1_GET_LOOP:
                            csrr t0,3073                              # Gets current time
                            sub t0, t0, t1                            # t0 = current time - last frame's time
                            li t2, power_up_delay                     # Loads power_up_delay
                            bltu t0,t2, COLLISION_SPECIAL_1_GET_LOOP  # While t0 < minimum time for a frame, keep looping
                            j CONTINUE_CHECK_MAP_COLLISION_3
                    COLLISION_SPECIAL_1_NOT_MARU_MARI:
                    COLLISION_SPECIAL_1_BACKGROUND:
                        # This is only reached if there was an error or tile is disabled
                        # a0 should still be 1, otherwise procedure would've ended before
                        j CONTINUE_CHECK_MAP_COLLISION_3

            COLLISION_BREAKABLE:
            # ---> make breakable block work :)
                # li a0, 0 # Player can't move  
                j CONTINUE_CHECK_MAP_COLLISION_3
            
            COLLISION_NOT_BACKGROUND:
                beq t0,t1,COLLISION_DOOR_FRAME  # If t1 = 4, it's a door frame
                li t0,36   # Tile from which collision behaves differently
                bge t1,t0, COLLISION_SPECIAL_2  # If current tile is a door or a damaging tile (t1 >= 36)
                    j COLLISION_BLOCKED # If tile isn't special (3 < t1 < 36)
            
            COLLISION_DOOR_FRAME:
                bnez t5,COLLISION_BLOCKED  # If not player, consider this a solid object
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
                        j CHANGE_MAP                            
                    NEXT_IN_COLLISION_DOOR_FRAME_LOOP:                                  
                        addi t1,t1,6 # Going to the next door frame's address                                  
                        addi t0,t0,1 # Iterating counter by 1                                   
                        bge t0,t2, END_COLLISION_DOOR_FRAME_LOOP # If all of the map's door frames were checked, end loop                                  
                        j COLLISION_DOOR_FRAME_LOOP # otherwise, go back to the loop's beginning                     
                END_COLLISION_DOOR_FRAME_LOOP:                     
                # This is only reached if no door frame was found (error) 
                    j CONTINUE_CHECK_MAP_COLLISION_3     


            COLLISION_SPECIAL_2:
                li t0,40   # Tile from which door tiles begin
                blt t1,t0, CONTINUE_COLLISION_SCPECIAL_2   # If tile is a door (t1 >= 40)
                    j CONTINUE_CHECK_MAP_COLLISION_3     # Otherwise, finish this iteration's checks
            
                CONTINUE_COLLISION_SCPECIAL_2:
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
                            lbu t4, 2(t1) # Loads door's state
                            bnez t4, END_COLLISION_DOOR_LOOP # If door is open or opening, player can move through 
                                li t4,2 # 1 is the threshold of when a door can be on right wall
                                bnez t6,COLLISION_BLOCKED  # if t6 != 0 , don't update it
                                    lbu t3, 0(t1) # Loads door's X on matrix 
                                    slt t6,t3,t4   # door's x < 2 ? t6 = 1 : t6 = 0
                                    addi t6,t6,1   # If right door, t6 = 1; left door, t6 = 2
                                    j COLLISION_BLOCKED # Otherwise, door is closed and player can't move                   
                    NEXT_IN_COLLISION_DOOR_LOOP:                                  
                        addi t1,t1,4 # Going to the next door's address                                  
                        addi t0,t0,1 # Iterating counter by 1                                   
                        bge t0,t2, END_COLLISION_DOOR_LOOP # If all of the map's doors were checked, end loop                                  
                        j COLLISION_DOOR_LOOP # otherwise, go back to the loop's beginning                     
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

END_COLLISON_MAP:
    mv a1,t6  # moves t6 (0 - no door, 1 - right door, 2 - left door)
    ret
