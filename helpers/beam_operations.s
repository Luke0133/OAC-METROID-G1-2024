.text

###################        BEAM SPAWN        ####################
#      Spawns a beam if available, otherwise end procedure      #
#                    (It takes no arguments)                    #
#                                                               #
#  ----------            registers used             ----------  #
#    a0 = BEAMS_ARRAY address                                   #
#    a1 = PLYR_POS address                                      #
#    a2 = Number of beams                                       #
#    a3 = Loop counter                                          #
#                                                               #
#  ----------         temporary registers           ----------  #
#    t0 --> temporary register                                  #
#                                                               #    
#################################################################

BEAM_SPAWN:
    la a0, BEAMS_ARRAY      # Loads BEAMS array
    lbu t0,0(a0)            # Loads cooldown byte
    beqz t0,CONTINUE_BEAM_SPAWN # If on zero, spawn
        j END_BEAM_SPAWN_LOOP
    CONTINUE_BEAM_SPAWN:
    la a1, PLYR_POS         # Loads Player Pos address
    li a2, beams_number     # Loads total number of beams
    li a3,0                 # Resets counter

    addi a0,a0,1            # Skips cooldown byte
    BEAM_SPAWN_LOOP:
        lbu t0, 0(a0)       # Loads enable byte
        beqz t0, BEAM_SPAWN_LOOP_ACTIVATE # If current beam is disabled, activate it
            j NEXT_IN_BEAM_SPAWN_LOOP     # Otherwise, go to next one in loop

        BEAM_SPAWN_LOOP_ACTIVATE:
            # Setting attack cooldown
            la t0, BEAMS_ARRAY            # Loads BEAMS array
            li t1, beams_attack_cooldown  # gets cooldown value
            sb t1,0(t0)                   # stores it

            # Storing offset (the beam's offset will be the same as the player's)
            lbu t0, 6(a1)    # Loads player's X offset
            sb t0, 3(a0)     # and stores it on beam's X offset

            lbu t0, 7(a1)    # Loads player's Y offset
            sb t0, 4(a0)     # and stores it on beam's Y offset

            li t0,1          # Loads 1 (Enabled) 
            sb t0,0(a0)      # stores in beam's enable byte

            # Checking vertical direction player is facing
            lbu t0, 14(a1)   # Loads vertical direction
            beqz t0, BEAM_SPAWN_LOOP_ACTIVATE_CHECK_X_AXIS # If looking foward
            # Otherwise, player is looking up --> spawn beam above player
                # X is the same as the player
                lbu t0, 8(a1)    # Loads player's X
                sb t0, 5(a0)     # and stores it on beam's X
                sb t0, 6(a0)     # and on beam's old X

                # Y is one tile up from player
                lbu t0, 10(a1)   # Loads player's Y
                addi t0,t0,-1    # goes up 1 tile
                sb t0, 7(a0)     # and stores it on beam's Y
                sb t0, 8(a0)     # and on beam's old Y

                # Getting direction of beam
                li t0,0          # Loads 0 (Up)
                sb t0,1(a0)      # and stores it on the direction byte
                j END_BEAM_SPAWN_LOOP # break loop

            BEAM_SPAWN_LOOP_ACTIVATE_CHECK_X_AXIS:
            # If player is looking foward --> check horizontal direction
            lbu t0, 13(a1)   # Loads horizontal direction
            bnez t0,BEAM_SPAWN_LOOP_ACTIVATE_LEFT_AXIS   # If player is looking left
            # Otherwise, they're facing right
                # X is one tile to the right of player
                lbu t0, 8(a1)    # Loads player's X
                addi t0,t0,1     # goes 1 tile to the right
                sb t0, 5(a0)     # and stores it on beam's X
                sb t0, 6(a0)     # and on beam's old X

                # Y is the same as the player
                lbu t0, 10(a1)   # Loads player's Y
                sb t0, 7(a0)     # and stores it on beam's Y
                sb t0, 8(a0)     # and on beam's old Y

                # Getting direction of beam
                li t0,1          # Loads 1 (Right)
                sb t0,1(a0)      # and stores it on the direction byte
                j END_BEAM_SPAWN_LOOP # break loop

            BEAM_SPAWN_LOOP_ACTIVATE_LEFT_AXIS: 
            # If player is looking left
                # X is one tile to the left of player
                lbu t0, 8(a1)    # Loads player's X
                addi t0,t0,-1    # goes 1 tile to the left
                sb t0, 5(a0)     # and stores it on beam's X
                sb t0, 6(a0)     # and on beam's old X

                # Y is the same as the player
                lbu t0, 10(a1)   # Loads player's Y
                sb t0, 7(a0)     # and stores it on beam's Y
                sb t0, 8(a0)     # and on beam's old Y

                # Getting direction of beam
                li t0,-1         # Loads -1 (Left)
                sb t0,1(a0)      # and stores it on the direction byte
                j END_BEAM_SPAWN_LOOP # break loop

        NEXT_IN_BEAM_SPAWN_LOOP:
            addi a0,a0,beams_size          # Going to the next beams address                                  
            addi a3,a3,1                   # Iterating counter by 1                                   
            bge a3,a2, END_BEAM_SPAWN_LOOP # If all of the beams were checked, end loop (don't attack)                                
            j BEAM_SPAWN_LOOP # otherwise, go back to the loop's beginning 

    END_BEAM_SPAWN_LOOP:
    # Procedure finished, return
        ret


##############        BEAMS OPERATIONS        ##############
#           Renders enabled beams and moves them           #
#                                                          #		
#  ------------        registers used        ------------  #
#    a0 = BEAMS ARRAY address                              #
#    a1 = Number of beams in current map                   #
#    a2 = Loop counter                                     #
#    tp = CURRENT_MAP's address                            #
#    t0 -- t6 = Temporary Registers                        #
#    a0 -- a7 => used as arguments                         #
#                                                          #
############################################################


BEAMS_OPERATIONS:
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
    la tp, CURRENT_MAP  # Loads CURRENT_MAP address

    la a0,BEAMS_ARRAY   # Loads Beams array
    addi a0,a0,1        # skips cooldown byte

    li a2,0             # resets counter
    li a1,beams_number  # gets number of beams in game
    BEAMS_OPERATIONS_LOOP:
        lbu t2,0(a0) # Loads enable byte
        bnez t2,BEAMS_OPERATIONS_LOOP_CONTINUE    # If enabled,
            j NEXT_IN_BEAMS_OPERATIONS_LOOP       # Otherwise, check other beams
        BEAMS_OPERATIONS_LOOP_CONTINUE:  
            li t0,2  # Loads "To be Disabled" 
            bne t0,t2, BEAMS_OPERATIONS_LOOP_CONTINUE_2   # If beam is trully enabled,
            # Otherwise
                sb zero,0(a0) # Disables beam
                j NEXT_IN_BEAMS_OPERATIONS_LOOP  # Check other beams
            
        BEAMS_OPERATIONS_LOOP_CONTINUE_2:
        # If procedure arrived here, move current beam and render it
        # Storing Registers on Stack
            addi sp,sp,-36
            sw s1,0(sp)
            sw s2,4(sp)
            sw s3,8(sp)
            sw s4,12(sp)
            sw a0,16(sp)
            sw a1,20(sp)
            sw a2,24(sp)
            sw a3,28(sp)
            sw tp,32(sp)
        # End of Stack Operations           
            
            
            # Calculating Beams's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lbu a1,5(a0) # Loads beam's current X
            lbu t0,6(tp) # Loads map's current X
            sub a1,a1,t0 # Gets the X matrix related to the map's X (a1 = beam's X - map's X)
            slli a1,a1,tile_size_shift # Multiplies a5 by 16 in order to get X related to screen
            lbu t0,3(a0) # Loads beam's X offset
            add a1,a1,t0 # Adds offset to position
            lbu t0,8(tp) # Loads map's X offset
            sub a1,a1,t0 # and takes it from beam's position
# dislocation?
        
            # Calculating Beams's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lbu a2,7(a0) # Loads beam's current Y
            lbu t1,7(tp) # Loads map's current Y
            sub a2,a2,t1 # Gets the Y matrix related to the map's Y (a2 = beam's Y - map's Y)
            slli a2,a2,tile_size_shift # Multiplies a2 by 16 in order to get Y related to screen
            lbu t0,4(a0) # Loads beam's Y offset
            add a2,a2,t0 # Adds offset to position
            lbu t1,9(tp) # Loads map's Y offset
            sub a2,a2,t1 # and takes it from beam's position
            
            li a3,tile_size   # 16 = width of rendering area
            li a4,tile_size   # 16 = height of rendering area
            mv a5,s0          # gets frame to be rendered on

            li a6,0           # There's only one sprite per direction

            lb t0,1(a0)       # Loads direction byte
            beqz t0,BEAMS_OPERATIONS_LOOP_RENDER_UP   # If beam is going up
                la a0,Beam_Horizontal   # If beam is moving horizontally
                j BEAMS_OPERATIONS_LOOP_RENDER_START  # Render

            BEAMS_OPERATIONS_LOOP_RENDER_UP:
                la a0,Beam_Vertical     # If beam is moving vertically
                # j BEAMS_OPERATIONS_LOOP_RENDER_START  # Render

            BEAMS_OPERATIONS_LOOP_RENDER_START:
                li a7,0             # Normal render
                call RENDER_ENTITY  # Renders it

            lw a0,16(sp)    # Restores a0


# Moving beam
            lb t0, 1(a0) # loads direction
            beqz t0,BEAMS_OPERATIONS_LOOP_MOVE_Y  # If direction is 0 (Up) 
                    j BEAMS_OPERATIONS_LOOP_MOVE_X
                    
            BEAMS_OPERATIONS_LOOP_MOVE_Y:
                lbu t1, 7(a0)    # Loads beam's current Y
                sb t1, 8(a0)     # and stores it on beam's old Y

                lbu t0,4(a0)   # Loads beam's current Y offset
                addi t0,t0,-8  # moves it up

                bge t0,zero,BEAMS_OPERATIONS_LOOP_MOVE_Y_STORE_BEAM # If no correction is needed
                # Correcting offset
                    addi t1,t1,-1          # Moves Y up one tile
                    addi t0,t0,tile_size   # adds 16 to offset
                    sb t1, 7(a0)     # Stores beam's new Y

                BEAMS_OPERATIONS_LOOP_MOVE_Y_STORE_BEAM:
                    sb t0, 4(a0)     # Stores new Y offset
                    j BEAMS_OPERATIONS_LOOP_RENDER # Goes to render
                    
            BEAMS_OPERATIONS_LOOP_MOVE_X:
                lbu t1, 5(a0)    # Loads beam's current X
                sb t1, 6(a0)     # and stores it on beam's old X

                la t3,MOVE_X     # Loads MOVE_X
                lb t3,0(t3)      # and gets player's movement speed
                li t4,0          # X momentum
                beqz t3,BEAMS_OPERATIONS_LOOP_MOVE_X_SKIP_ADD
                    slli t4,t0,2     # Multiplies t0 by 4 (so that beam moves +-4)
                BEAMS_OPERATIONS_LOOP_MOVE_X_SKIP_ADD:
                    slli t2,t0,3     # Multiplies t0 by 8 (so that beam moves +-8)
                    
                    lbu t0,3(a0)     # Loads beam's current X offset
                    add t0,t0,t2     # moves it
                    add t0,t0,t4     # and adds player's momentum

                bge t0,zero,BEAMS_OPERATIONS_LOOP_MOVE_X_SKIP_NEGATIVE_CORRECTION
                # If resulting offset < 0, correct it
                    addi t1,t1,-1          # Moves X one tile to the left
                    addi t0,t0,tile_size   # adds 16 to offset
                    sb t1, 5(a0)           # Stores beam's new X
                    j BEAMS_OPERATIONS_LOOP_MOVE_X_STORE_BEAM

                BEAMS_OPERATIONS_LOOP_MOVE_X_SKIP_NEGATIVE_CORRECTION:
                # If resulting offset >= 0
                    li t2,tile_size
                    blt t0,t2,BEAMS_OPERATIONS_LOOP_MOVE_X_STORE_BEAM  # If  0 <= resulting offset < 16, don't change X
                    # If resulting offset >= 16
                        addi t1,t1,1           # Moves X one tile to the right
                        sub t0,t0,t2           # subtracts 16 from offset
                        sb t1, 5(a0)           # Stores beam's new X
                        j BEAMS_OPERATIONS_LOOP_MOVE_X_STORE_BEAM
                
                BEAMS_OPERATIONS_LOOP_MOVE_X_STORE_BEAM:
                    sb t0, 3(a0)     # Stores new X offset
                    #j BEAMS_OPERATIONS_LOOP_RENDER # Goes to render                    
            
            BEAMS_OPERATIONS_LOOP_RENDER:






            lbu t0,2(a0)    # Gets number of times that it was rendered
            addi t0,t0,1    # iterates it
            sb t0,2(a0)     # and stores it back
            li t1,beams_disable_threshold  # Loads number of times beam should render/move before being disabled
            blt t0,t1,BEAMS_OPERATIONS_LOOP_AFTER_OPERATIONS  # If it didn't surpass the threshold, finish this part of loop
            # Otherwise, set it to be disabled
                li t1,2        # Loads "To be Disabled" 
                sb t1,0(a0)    # and stores it on enable byte
                sb zero,2(a0)  # Resets render counter
                # This loop will continue normally and even the collision will work. Only
                # when arriving on the next loop's PLASMA_BREATH_OPERATIONS will it be disabled
                # j BEAMS_OPERATIONS_LOOP_AFTER_OPERATIONS
            
        BEAMS_OPERATIONS_LOOP_AFTER_OPERATIONS:
        # Procedure finished: Loading Registers from Stack
            lw s1,0(sp)
            lw s2,4(sp)
            lw s3,8(sp)
            lw s4,12(sp)
            lw a0,16(sp)
            lw a1,20(sp)
            lw a2,24(sp)
            lw a3,28(sp)
            lw tp,32(sp)
            addi sp,sp,36
        # End of Stack Operations

        NEXT_IN_BEAMS_OPERATIONS_LOOP:                    
            addi a0,a0,beams_size  # Going to the next beam's address                                  
            addi a2,a2,1            # Iterating counter by 1                                   
            bge a2,a1, END_BEAMS_OPERATIONS_LOOP # If all of the beams were checked, end loop (don't attack)                                
            j BEAMS_OPERATIONS_LOOP # otherwise, go back to the loop's beginning 

    END_BEAMS_OPERATIONS_LOOP:
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret