# ----> Summary: enemies.s stores enemies related procedures
# 1 - ENEMY OPERATIONS (Checks enemies in current map and renders/moves them)
# 2 - ZOOMER OPERATIONS
# 3 - RIPPER OPERATIONS 
# 4 - RIDLEY OPERATIONS 
# 5 - PLASMA BREATH OPERATIONS 

ENEMY_OPERATIONS:
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations   
    la t0,CURRENT_MAP             # Loads map address
    lbu t0,4(t0)                  # and from it, loads map's number
    li t1,7                       # Loads 7 to compare with map's number
    bne t0,t1,SKIP_RIDLEY         # If not on map 7, skip Ridley >:D
        call RIDLEY_OPERATIONS    # Checks Ridley

        call PLASMA_BREATH_OPERATIONS  # Checks Plasma Breaths (ITS.TEDIOUS.TO.KEEP.WRITING.PLASMA.BREATH.EVERY.TIME.I.CANT.TAKE.IT.ANYMOREEEE)
        # Procedure finished: Loading Registers from Stack
            lw ra,0(sp)
            addi sp,sp,4
        # End of Stack Operations  
        ret
    SKIP_RIDLEY:
    call ZOOMER_OPERATIONS        # Checks zoomers
    
    call RIPPER_OPERATIONS        # Checks rippers
# Procedure finished: Loading Registers from Stack
    lw ra,0(sp)
    addi sp,sp,4
# End of Stack Operations  
ret

################         ZOOMER OPERATIONS         #################
#          Checks if Zoomer should be rendered and moved           #
#                       (if on screen range)                       #
#                                                                  #	
#  ----------------        registers used        ----------------  #
#    a0 = Current Map's Zoomer address                             #
#    a1 = Number of zoomers in current map                         #
#    a2 = Loop counter                                             #
#    tp = CURRENT_MAP's address                                    #
#    t0 -- t6 = Temporary Registers                                #
#    a0 -- a7 => used as arguments                                 #
#                                                                  #
####################################################################

ZOOMER_OPERATIONS:
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
    la a0,Zoomers  # Loads Zoomers address
    la tp, CURRENT_MAP # Loads CURRENT_MAP address
    
    lw a0,0(a0)    # Loads the ZoomersA address over the Zoomers address
    bnez a0,CONTINUE_ZOOMER_OPERATIONS  # If there are zoomers in this map
        j END_ZOOMER_OPERATIONS_LOOP    # If a0 = 0, there are no zoomers in this map

    CONTINUE_ZOOMER_OPERATIONS:
    # Otherwise, continue
    lbu a1,0(a0)   # Loads number of Zoomers in current map
    
    li a2,0        # Counter for zoomers
    addi a0,a0,1   # Goes to next byte (where zoomers from current map start)
    ZOOMER_OPERATIONS_LOOP:
        lb t0,0(a0) # Loads zoomer's health
        blt zero,t0,CONTINUE_ZOOMER_OPERATIONS_LOOP # If zoomer is alive
        # Otherwise, skip this zoomer
            j NEXT_IN_ZOOMER_OPERATIONS_LOOP
        CONTINUE_ZOOMER_OPERATIONS_LOOP:
        # Checking X
        lbu t0,6(tp) # Loads map's current X
        lbu a5,4(a0) # Loads zoomer's current X
        li t2,m_render_distance  # Loads 4 (render distance)
        sub t3,t0,t2 # Gets leftmost threshold to manage zoomer
        
        blt a5,t3,NEXT_IN_ZOOMER_OPERATIONS_LOOP # If zoomer's X isn't inside left border, go to next
        # Otherwise,
        add t3,t0,t2 # Calculate rightmost threshold to manage zoomer
        addi t3,t3,m_screen_width # finishing calculating threshold
        bge a5,t3,NEXT_IN_ZOOMER_OPERATIONS_LOOP # If zoomer's X isn't inside right border, go to next

        # Checking Y
        lbu t1,7(tp) # Loads map's current Y
        lbu a4,6(a0) # Loads zoomer's current Y
        # li t2,m_render_distance -- already loaded # Loads 4 (render distance)
        sub t3,t1,t2 # Gets uppermost threshold to manage zoomer
        blt a4,t3,NEXT_IN_ZOOMER_OPERATIONS_LOOP # If zoomer's X isn't inside upper border, go to next
        # Otherwise,
        add t3,t1,t2 # Calculate lowermost threshold to manage zoomer
        addi t3,t3,m_screen_height # finishing calculating threshold
        bge a4,t3,NEXT_IN_ZOOMER_OPERATIONS_LOOP # If zoomer's X isn't inside lower border, go to next

        # If procedure arrived here, move zoomer and render it
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
            
            # a0 is already set
            lw a1,0(tp)
            call MOVE_ZOOMER
            
            # Calculating Ripper's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lw a0,16(sp) # Gets a0 from stack again
            lw tp,32(sp) # Gets tp from stack again
            lbu a1,4(a0) # Loads zoomer's current X
            lbu t0,6(tp) # Loads map's current X
            sub a1,a1,t0 # Gets the X matrix related to the map's X (a1 = zoomer's X - map's X)
            slli a1,a1,tile_size_shift # Multiplies a5 by 16 in order to get X related to screen
            lbu t0,2(a0) # Loads zoomer's X offset
            add a1,a1,t0 # Adds offset to position
            lbu t0,8(tp) # Loads map's X offset
            sub a1,a1,t0 # and takes it from zoomer's position
# dislocation?
        
        # Calculating Ripper's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lbu a2,6(a0) # Loads zoomer's current Y
            lbu t1,7(tp) # Loads map's current Y
            sub a2,a2,t1 # Gets the Y matrix related to the map's Y (a2 = zoomer's Y - map's Y)
            slli a2,a2,tile_size_shift # Multiplies a2 by 16 in order to get Y related to screen
            lbu t0,3(a0) # Loads zoomer's Y offset
            add a2,a2,t0 # Adds offset to position
            lbu t1,9(tp) # Loads map's Y offset
            sub a2,a2,t1 # and takes it from zoomer's position
            
            li a3,tile_size   # 16 = width of rendering area
            li a4,tile_size   # 16 = height of rendering area
            mv a5,s0          # gets frame to be rendered on

            lbu a6,8(a0)      # Loads zoomer's status is its direction
            xori a6,a6,1      # switches it
            sb a6,8(a0)       # and stores it back for using next time

            lbu t0,1(a0)      # gets zoomer's type number
            lbu t1,10(a0)     # gets zoomer's platform

            bnez t1,ZOOMER_OPERATIONS_LOOP_TRY_LEFT
            # If there's a platform bellow, continue
                bnez t0,ZOOMER_OPERATIONS_LOOP_DOWN_NOT_NORMAL
                # If type is normal:
                    la a0,Zoomer_Down
                    j ZOOMER_OPERATIONS_LOOP_RENDER
                ZOOMER_OPERATIONS_LOOP_DOWN_NOT_NORMAL:li t2,1
                bne t0,t2,ZOOMER_OPERATIONS_LOOP_DOWN_DAMAGE
                # If type is variant:
                    la a0,Zoomer_Variant_Down
                    j ZOOMER_OPERATIONS_LOOP_RENDER
                ZOOMER_OPERATIONS_LOOP_DOWN_DAMAGE:
                # If taking damage:
                    addi t0,t0,-2 # Reverts its sprite back to normal
                    sb t0,1(a0)   # and stores it back
                    la a0,Zoomer_Damage_Down
                    j ZOOMER_OPERATIONS_LOOP_RENDER

            ZOOMER_OPERATIONS_LOOP_TRY_LEFT: li t2,1
            bne t1,t2,ZOOMER_OPERATIONS_LOOP_TRY_UP
            # If there's a platform to the left, continue
                bnez t0,ZOOMER_OPERATIONS_LOOP_LEFT_NOT_NORMAL
                # If type is normal:
                    la a0,Zoomer_Left
                    j ZOOMER_OPERATIONS_LOOP_RENDER
                ZOOMER_OPERATIONS_LOOP_LEFT_NOT_NORMAL:li t2,1
                bne t0,t2,ZOOMER_OPERATIONS_LOOP_LEFT_DAMAGE
                # If type is variant:
                    la a0,Zoomer_Variant_Left
                    j ZOOMER_OPERATIONS_LOOP_RENDER
                ZOOMER_OPERATIONS_LOOP_LEFT_DAMAGE:
                # If taking damage:
                    addi t0,t0,-2 # Reverts its sprite back to normal
                    sb t0,1(a0)   # and stores it back
                    la a0,Zoomer_Damage_Left
                    j ZOOMER_OPERATIONS_LOOP_RENDER

            ZOOMER_OPERATIONS_LOOP_TRY_UP: li t2,2
            bne t1,t2,ZOOMER_OPERATIONS_LOOP_RIGHT
            # If there's a platform above, continue
                bnez t0,ZOOMER_OPERATIONS_LOOP_UP_NOT_NORMAL
                # If type is normal:
                    la a0,Zoomer_Up
                    j ZOOMER_OPERATIONS_LOOP_RENDER
                ZOOMER_OPERATIONS_LOOP_UP_NOT_NORMAL:li t2,1
                bne t0,t2,ZOOMER_OPERATIONS_LOOP_UP_DAMAGE
                # If type is variant:
                    la a0,Zoomer_Variant_Up
                    j ZOOMER_OPERATIONS_LOOP_RENDER
                ZOOMER_OPERATIONS_LOOP_UP_DAMAGE:
                # If taking damage:
                    addi t0,t0,-2 # Reverts its sprite back to normal
                    sb t0,1(a0)   # and stores it back
                    la a0,Zoomer_Damage_Up
                    j ZOOMER_OPERATIONS_LOOP_RENDER

            ZOOMER_OPERATIONS_LOOP_RIGHT: # li t2,3
            # If there's a platform to the right, continue
                bnez t0,ZOOMER_OPERATIONS_LOOP_RIGHT_NOT_NORMAL
                # If type is normal:
                    la a0,Zoomer_Right
                    j ZOOMER_OPERATIONS_LOOP_RENDER
                ZOOMER_OPERATIONS_LOOP_RIGHT_NOT_NORMAL:li t2,1
                bne t0,t2,ZOOMER_OPERATIONS_LOOP_RIGHT_DAMAGE
                # If type is variant:
                    la a0,Zoomer_Variant_Right
                    j ZOOMER_OPERATIONS_LOOP_RENDER
                ZOOMER_OPERATIONS_LOOP_RIGHT_DAMAGE:
                # If taking damage:
                    addi t0,t0,-2 # Reverts its sprite back to normal
                    sb t0,1(a0)   # and stores it back
                    la a0,Zoomer_Damage_Right
                    j ZOOMER_OPERATIONS_LOOP_RENDER

            ZOOMER_OPERATIONS_LOOP_RENDER:
                li a7,0             # Normal render
                call RENDER_ENTITY  # Renders it
                j ZOOMER_OPERATIONS_LOOP_AFTER_OPERATIONS
            
            ZOOMER_OPERATIONS_LOOP_RENDER_TRAIL:
                # We aren't using this anymore
                # j ZOOMER_OPERATIONS_LOOP_AFTER_OPERATIONS
            
        ZOOMER_OPERATIONS_LOOP_AFTER_OPERATIONS:
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

        NEXT_IN_ZOOMER_OPERATIONS_LOOP: 
            addi a0,a0,zoomer_size  # Going to the next zoomer's address                                  
            addi a2,a2,1            # Iterating counter by 1                                   
            bge a2,a1, END_ZOOMER_OPERATIONS_LOOP # If all of the zoomers were checked, end loop                                  
            j ZOOMER_OPERATIONS_LOOP # otherwise, go back to the loop's beginning                     
    
    END_ZOOMER_OPERATIONS_LOOP:   
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret



################         RIPPER OPERATIONS         #################
#          Checks if Ripper should be rendered and moved           #
#             (if on screen range) - takes no arguments            #		
#  ----------------        registers used        ----------------  #
#    a0 = Current Map's Ripper address                             #
#    a1 = 0 - Normal Procedure, 1 - Only render trail              #
#    a1 = Number of rippers in current map                         #
#    a2 = Loop counter                                             #
#    tp = CURRENT_MAP's address                                    #
#    t0 -- t6 = Temporary Registers                                #
#    a0 -- a7 => used as arguments                                 #
#                                                                  #
####################################################################

RIPPER_OPERATIONS:
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
    
    la a0,Rippers  # Loads Rippers address
    la tp, CURRENT_MAP # Loads CURRENT_MAP address
    
    lw a0,0(a0)    # Loads the RippersA address over the Rippers address
    bnez a0,CONTINUE_RIPPER_OPERATIONS    # If there are rippers in this map
        j END_RIPPER_OPERATIONS_LOOP      # If a0 = 0, there are no rippers in this map

    CONTINUE_RIPPER_OPERATIONS:
    # Otherwise, continue
    lbu a1,0(a0)   # Loads number of Rippers in current map
    
    li a2,0        # Counter for rippers
    addi a0,a0,1   # Goes to next byte (where rippers from current map start)
    RIPPER_OPERATIONS_LOOP:
        # Checking X
        lbu t0,6(tp) # Loads map's current X
        lbu a5,3(a0) # Loads ripper's current X
        li t2,m_render_distance  # Loads 4 (render distance)
        sub t3,t0,t2 # Gets leftmost threshold to manage ripper
        blt a5,t3,NEXT_IN_RIPPER_OPERATIONS_LOOP # If ripper's X isn't inside left border, go to next
        # Otherwise,
        add t3,t0,t2 # Calculate rightmost threshold to manage ripper
        addi t3,t3,m_screen_width # finishing calculating threshold
        bge a5,t3,NEXT_IN_RIPPER_OPERATIONS_LOOP # If ripper's X isn't inside right border, go to next

        # Checking Y
        lbu t1,7(tp) # Loads map's current Y
        lbu a4,5(a0) # Loads ripper's current Y
        # li t2,m_render_distance -- already loaded # Loads 4 (render distance)
        sub t3,t1,t2 # Gets uppermost threshold to manage ripper
        blt a4,t3,NEXT_IN_RIPPER_OPERATIONS_LOOP # If ripper's X isn't inside upper border, go to next
        # Otherwise,
        add t3,t1,t2 # Calculate lowermost threshold to manage ripper
        addi t3,t3,m_screen_height # finishing calculating threshold
        bge a4,t3,NEXT_IN_RIPPER_OPERATIONS_LOOP # If ripper's X isn't inside lower border, go to next

        # If procedure arrived here, move ripper and render it
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
            
            # a0 is already set
            lw a1,0(tp)
            call MOVE_RIPPER
            
            # Calculating Ripper's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lw a0,16(sp) # Gets a0 from stack again
            lw tp,32(sp) # Gets tp from stack again
            lbu a1,3(a0) # Loads ripper's current X
            lbu t0,6(tp) # Loads map's current X
            sub a1,a1,t0 # Gets the X matrix related to the map's X (a1 = ripper's X - map's X)
            slli a1,a1,tile_size_shift # Multiplies a5 by 16 in order to get X related to screen
            lbu t0,2(a0) # Loads ripper's X offset
            add a1,a1,t0 # Adds offset to position
            lbu t0,8(tp) # Loads map's X offset
            sub a1,a1,t0 # and takes it from ripper's position
# dislocation?
        
        # Calculating Ripper's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lbu a2,5(a0) # Loads ripper's current Y
            lbu t1,7(tp) # Loads map's current Y
            sub a2,a2,t1 # Gets the Y matrix related to the map's Y (a2 = ripper's Y - map's Y)
            slli a2,a2,tile_size_shift # Multiplies a2 by 16 in order to get Y related to screen
            # Ripper's Y offset is always the same as the map's Y offset
            lbu t1,9(tp) # Loads map's Y offset
            sub a2,a2,t1 # and takes it from ripper's position
            li a3,tile_size   # 16 = width of rendering area
            li a4,tile_size   # 16 = height of rendering area
            mv a5,s0          # gets frame to be rendered on
            lbu a6,1(a0)      # ripper's status is its direction

            lbu a0,0(a0)      # gets ripper's type number
            beqz a0,RIPPER_OPERATIONS_LOOP_RENDER_NORMAL
                la a0,Ripper_Variant  # loads image address of red ripper
                j RIPPER_OPERATIONS_LOOP_RENDER
            RIPPER_OPERATIONS_LOOP_RENDER_NORMAL:
                la a0,Ripper  # loads image address of normal ripper
            RIPPER_OPERATIONS_LOOP_RENDER:
                li a7,0             # Normal render
                call RENDER_ENTITY  # Renders it
                # j RIPPER_OPERATIONS_LOOP_AFTER_OPERATIONS
            
        RIPPER_OPERATIONS_LOOP_AFTER_OPERATIONS:
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

        NEXT_IN_RIPPER_OPERATIONS_LOOP:                    
            addi a0,a0,ripper_size  # Going to the next ripper's address                                  
            addi a2,a2,1            # Iterating counter by 1                                   
            bge a2,a1, END_RIPPER_OPERATIONS_LOOP # If all of the rippers were checked, end loop                                  
            j RIPPER_OPERATIONS_LOOP # otherwise, go back to the loop's beginning                     
    
    END_RIPPER_OPERATIONS_LOOP:   
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret


################         RIDLEY OPERATIONS         #################
#          Renders Ridley, makes him jump and attack >:]           #
#                                                                  #		
#  ----------------        registers used        ----------------  #
#    a0 = Ridley address                                           #
#    a1 = Number of rippers in current map                         #
#    a2 = Loop counter                                             #
#    tp = CURRENT_MAP's address                                    #
#    t0 -- t6 = Temporary Registers                                #
#    a0 -- a7 => used as arguments                                 #
#                                                                  #
####################################################################

RIDLEY_OPERATIONS:
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
    
    la a0,RIDLEY_INFO  # Loads Ridley's address
    la tp, CURRENT_MAP # Loads CURRENT_MAP address

    lb t0,0(a0) # Loads Ridley's health
    blt zero,t0,CONTINUE_RIDLEY_OPERATIONS # If Ridley is alive
    # Otherwise, skip procedure
        sb zero,0(a0) # Stores zero on Ridley's health
        j END_RIDLEY_OPERATIONS

    CONTINUE_RIDLEY_OPERATIONS:
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
        
    # a0 is already set
    lw a1,0(tp)
    call MOVE_RIDLEY
    
    # Calculating Ridley's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
    lw a0,16(sp)     # Gets a0 from stack again
    lw tp,32(sp)     # Gets tp from stack again
    li a1,ridley_X   # Loads ridley's current X
    addi a1,a1,-1    # subtracts 1 from it (a sort of offset for rendering sprite in proper place)
    lbu t0,6(tp)     # Loads map's current X  
    sub a1,a1,t0     # Gets the X matrix related to the map's X (a1 = ridley's X - map's X)
    slli a1,a1,tile_size_shift # Multiplies a5 by 16 in order to get X related to screen
    li t0,ridley_X_Offset # Loads ridley's X offset
    add a1,a1,t0          # Adds offset to position
    lbu t0,8(tp)          # Loads map's X offset
    sub a1,a1,t0          # and takes it from ridley's position
# dislocation?
    
    # Calculating Ridley's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
    lbu a2,3(a0) # Loads ridley's current Y
    lbu t1,7(tp) # Loads map's current Y
    sub a2,a2,t1 # Gets the Y matrix related to the map's Y (a2 = ridley's Y - map's Y)
    slli a2,a2,tile_size_shift # Multiplies a2 by 16 in order to get Y related to screen
    lbu t0,2(a0) # Loads ridley's Y offset
    add a2,a2,t0 # Adds offset to position
    lbu t1,9(tp) # Loads map's Y offset
    sub a2,a2,t1 # and takes it from ridley's position
    
    li a3,32   # 16 = width of rendering area
    mv a5,s0          # gets frame to be rendered on

    lbu a6,5(a0)      # Loads ridley's status is its direction
    xori a6,a6,1      # switches it
    sb a6,5(a0)       # and stores it back for using next time

    li t0, ridley_jump_animation              # Loads screen's Y threshold where jumping animation appears
    lbu t1,1(a0)                              # Gets ridley's type number
    bge t0,a2,RIDLEY_OPERATIONS_RENDER_JUMP   # If Y (a2) <= 80, render jumping animation
    # If ridley isn't jumping:
        li a4,40   # 40 = height of rendering area
        bnez t1,RIDLEY_OPERATIONS_RENDER_DAMAGE
        # If ridley is normal
            la a0,Ridley
            j RIDLEY_OPERATIONS_RENDER

        RIDLEY_OPERATIONS_RENDER_DAMAGE:
        # If ridley is taking damage
            sb zero,1(a0)             # Reverts to normal state
            la a0,Ridley_Damage
            j RIDLEY_OPERATIONS_RENDER

    RIDLEY_OPERATIONS_RENDER_JUMP:
    # If ridley is jumping:
        li a4,48   # 48 = height of rendering area
        bnez t1,RIDLEY_OPERATIONS_RENDER_JUMP_DAMAGE
        # If ridley is normal
            la a0,Ridley_Jump
            j RIDLEY_OPERATIONS_RENDER

        RIDLEY_OPERATIONS_RENDER_JUMP_DAMAGE:
        # If ridley is taking damage  
            sb zero,1(a0)             # Reverts to normal state
            la a0,Ridley_Damage_Jump
            # j RIDLEY_OPERATIONS_RENDER  

    RIDLEY_OPERATIONS_RENDER:
        li a7,0             # Normal render
        call RENDER_ENTITY  # Renders it
        
    # Trying to attack
    li a1,9                  # Range
    li a7,RandIntRangeEcall  # random integer within range ecall
    ecall
    li t0,5                  # to compare with result (in a0)
    blt a0,t0,RIDLEY_OPERATIONS_ATTACK  # 50% chance to attack
        j END_RIDLEY_OPERATIONS_PART_1  # 50% chance to not attack
    RIDLEY_OPERATIONS_ATTACK: 
        lw a0,16(sp)      # Gets Ridley's address again
        lbu t0,10(a0)     # Loads attack cooldown byte
        beqz t0,RIDLEY_OPERATIONS_ATTACK_CONTINUE 
        # If still on cooldown, don't attack
            addi t0,t0,-1   # Subtracs 1 from cooldown
            sb t0,10(a0)    # and stores it back
            j END_RIDLEY_OPERATIONS_PART_1
        RIDLEY_OPERATIONS_ATTACK_CONTINUE:
        # If not on cooldown anymore, attack:
            li t0,ridley_attack_cooldown   # Resets ridley's cooldown
            sb t0,10(a0)                   # and stores it back
            
            la a2,PLASMA_BREATH_ARRAY  # Loads Plasma breath array
            li t0,0 # resets counter
            li t1,plasma_number # gets number of plasma breaths in game

            # Begin Loop
            PLASMA_SPAWN_LOOP:
                lw a0,16(sp)      # Gets Ridley's address again
                lbu t2,0(a2) # Loads enable byte
                beqz t2,PLASMA_SPAWN_LOOP_CONTINUE # If not enabled, enable current plasma breath
                    j NEXT_IN_PLASMA_SPAWN__LOOP   # Otherwise, check other plasma breaths
                PLASMA_SPAWN_LOOP_CONTINUE:   
                # Spawning Plasma Breath
                    # Enabling
                    li t2,1     # Enabled
                    sb t2,0(a2) # stores enable byte

                    # Determining X and X offset
                    li t2,ridley_X_Offset  # Loads 6
                    sb zero,3(a2) # Stores 6 on X offset (since ridley's X offset is always 6)

                    li t2,ridley_X  # Loads 10
                    addi t2,t2,1    # adds 1 to it
                    sb t2,6(a2)     # Stores 11 on X (since ridley's X is always 10)
                    sb t2,7(a2)     # Stores 11 on old X (since ridley's X is always 10)

                    # Determining Y and Y offset
                    lbu t2,2(a0)    # Loads ridley's Y offset
                    sb t2,4(a2)     # Stores it on Y offset

                    lbu t2,3(a0)    # Loads ridley's current Y
                    sb t2,8(a2)     # Stores it on Y
                    sb t2,9(a2)     # Stores it on dol Y

                    # Getting random X movement
                    li a1,2                  # Range
                    li a7,RandIntRangeEcall  # random integer within range ecall
                    ecall

                    addi t2,a0,1   # X movement will be between 1 and 3 (inclusive)
                    sb t2,1(a2)    # Stores it on X movement

                    # Setting MOVE_Y
                    li t2,-1       # Loads -1 (Up)
                    sb t2,2(a2)    # Stores it on MOVE_Y (Up)

                    # Setting Random Y speed
                    li a1,3                  # Range
                    li a7,RandIntRangeEcall  # random integer within range ecall
                    ecall

                    li t2,-6                 # Loads -8 (base speed)
                    add t2,t2,a0             # Speed will be between -8 and -4

                    # Checking which Plasma Breath we are activating in order to set Y speed
                    bnez t0,PLASMA_SPAWN_LOOP_NOT_PLASMA_0
                    #    fs5 = PLASMA_0's Y speed  
                        fcvt.s.w fs5,t2    # Sets PLASMA_0's Y speed 
                        j END_RIDLEY_OPERATIONS_PART_1  # Break loop

                    PLASMA_SPAWN_LOOP_NOT_PLASMA_0: li t1,1
                    bne t0,t1,PLASMA_SPAWN_LOOP_NOT_PLASMA_1
                    #    fs6 = PLASMA_1's Y speed 
                        fcvt.s.w fs6,t2    # Sets PLASMA_1's Y speed
                        j END_RIDLEY_OPERATIONS_PART_1  # Break loop

                    PLASMA_SPAWN_LOOP_NOT_PLASMA_1: li t1,2
                    bne t0,t1,PLASMA_SPAWN_LOOP_NOT_PLASMA_2
                    #    fs7 = PLASMA_2's Y speed 
                        fcvt.s.w fs7,t2    # Sets PLASMA_2's Y speed
                        j END_RIDLEY_OPERATIONS_PART_1  # Break loop

                    PLASMA_SPAWN_LOOP_NOT_PLASMA_2: li t1,3
                    bne t0,t1,PLASMA_SPAWN_LOOP_NOT_PLASMA_3
                    #    fs8 = PLASMA_3's Y speed 
                        fcvt.s.w fs8,t2    # Sets PLASMA_3's Y speed
                        j END_RIDLEY_OPERATIONS_PART_1  # Break loop

                    PLASMA_SPAWN_LOOP_NOT_PLASMA_3: # li t1,4
                    #    fs9 = PLASMA_4's Y speed 
                        fcvt.s.w fs9,t2    # Sets PLASMA_4's Y speed
                        j END_RIDLEY_OPERATIONS_PART_1  # Break loop

                NEXT_IN_PLASMA_SPAWN__LOOP:                    
                    addi a2,a2,plasma_size  # Going to the next plasma breath address                                  
                    addi t0,t0,1            # Iterating counter by 1                                   
                    bge t0,t1, END_RIDLEY_OPERATIONS_PART_1 # If all of the plasma breaths were checked, end loop (don't attack)                                
                    j PLASMA_SPAWN_LOOP # otherwise, go back to the loop's beginning 

    END_RIDLEY_OPERATIONS_PART_1:
    # Procedure finished: Loading Registers from Stack
        lw s1,0(sp)
        lw s2,4(sp)
        lw s3,8(sp)
        lw s4,12(sp)
    #    lw a0,16(sp)
    #    lw a1,20(sp)
    #    lw a2,24(sp)
    #    lw a3,28(sp)
    #    lw tp,32(sp)
        addi sp,sp,36
    # End of Stack Operations 

    END_RIDLEY_OPERATIONS:
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret


##############        PLASMA BREATH OPERATIONS        ##############
#         Renders enabled plasma breaths and moves them :D         #
#                                                                  #		
#  ----------------        registers used        ----------------  #
#    a0 = PLASMA BREATH ARRAY address                              #
#    a1 = Number of plasma breaths in current map                  #
#    a2 = Loop counter                                             #
#    tp = CURRENT_MAP's address                                    #
#    t0 -- t6 = Temporary Registers                                #
#    a0 -- a7 => used as arguments                                 #
#                                                                  #
####################################################################


PLASMA_BREATH_OPERATIONS:
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
    la tp, CURRENT_MAP         # Loads CURRENT_MAP address

    la a0,PLASMA_BREATH_ARRAY  # Loads Plasma breath array

    li a2,0 # resets counter
    li a1,plasma_number # gets number of plasma breaths in game
    PLASMA_BREATH_OPERATIONS_LOOP:
        lbu t2,0(a0) # Loads enable byte
        bnez t2,PLASMA_BREATH_OPERATIONS_LOOP_CONTINUE    # If enabled,
            j NEXT_IN_PLASMA_BREATH_OPERATIONS_LOOP       # Otherwise, check other plasma breaths
        PLASMA_BREATH_OPERATIONS_LOOP_CONTINUE:  
            li t0,2  # Loads "To be Disabled" 
            bne t0,t2, PLASMA_BREATH_OPERATIONS_LOOP_CONTINUE_2   # If plasma breath is trully enabled,
            # Otherwise
                sb zero,0(a0) # Disables plasma breath
                j NEXT_IN_PLASMA_BREATH_OPERATIONS_LOOP  # Check other plasma breaths
            
        PLASMA_BREATH_OPERATIONS_LOOP_CONTINUE_2:
        # If procedure arrived here, move current plasma breath and render it
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
            
            # Checking which Plasma Breath we are moving
            bnez a2,PLASMA_BREATH_OPERATIONS_LOOP_NOT_PLASMA_0
            #    fs5 = PLASMA_0's Y speed  
                fmv.s fa0,fs5   # Moves PLASMA_0's current Y speed to fa0 
                j PLASMA_BREATH_OPERATIONS_LOOP_MOVE  # Move

            PLASMA_BREATH_OPERATIONS_LOOP_NOT_PLASMA_0: li t0,1
            bne a2,t0,PLASMA_BREATH_OPERATIONS_LOOP_NOT_PLASMA_1
            #    fs6 = PLASMA_1's Y speed 
                fmv.s fa0,fs6   # Moves PLASMA_1's current Y speed to fa0
                j PLASMA_BREATH_OPERATIONS_LOOP_MOVE  # Move

            PLASMA_BREATH_OPERATIONS_LOOP_NOT_PLASMA_1: li t0,2
            bne a2,t0,PLASMA_BREATH_OPERATIONS_LOOP_NOT_PLASMA_2
            #    fs7 = PLASMA_2's Y speed 
                fmv.s fa0,fs7   # Moves PLASMA_2's current Y speed to fa0
                j PLASMA_BREATH_OPERATIONS_LOOP_MOVE  # Move

            PLASMA_BREATH_OPERATIONS_LOOP_NOT_PLASMA_2: li t0,3
            bne a2,t0,PLASMA_BREATH_OPERATIONS_LOOP_NOT_PLASMA_3
            #    fs8 = PLASMA_3's Y speed 
                fmv.s fa0,fs8   # Moves PLASMA_3's current Y speed to fa0
                j PLASMA_BREATH_OPERATIONS_LOOP_MOVE  # Move

            PLASMA_BREATH_OPERATIONS_LOOP_NOT_PLASMA_3: # li t0,4
            #    fs9 = PLASMA_4's Y speed 
                fmv.s fa0,fs9   # Moves PLASMA_4's current Y speed to fa0
                # j PLASMA_BREATH_OPERATIONS_LOOP_MOVE  # Move
            
            PLASMA_BREATH_OPERATIONS_LOOP_MOVE:
            # Proper movement check
            # a0 is already set
            lw a1,0(tp)
            call MOVE_PLASMA_BREATH
            
            lw a2,24(sp) # Getting Plasma Breath's number back (counter)
            
            # Checking which Plasma Breath we have moved (returning fa0 to its speed)
            bnez a2,PLASMA_BREATH_OPERATIONS_LOOP_AFTER_CHECK_NOT_PLASMA_0
            #    fs5 = PLASMA_0's Y speed  
                fmv.s fs5,fa0   # Saves PLASMA_0's new Y speed from fa0 
                j PLASMA_BREATH_OPERATIONS_AFTER_CHECK  # Finish move

            PLASMA_BREATH_OPERATIONS_LOOP_AFTER_CHECK_NOT_PLASMA_0: li t0,1
            bne a2,t0,PLASMA_BREATH_OPERATIONS_LOOP_AFTER_CHECK_NOT_PLASMA_1
            #    fs6 = PLASMA_1's Y speed 
                fmv.s fs6,fa0   # Saves PLASMA_1's new Y speed from fa0 
                j PLASMA_BREATH_OPERATIONS_AFTER_CHECK  # Finish move

            PLASMA_BREATH_OPERATIONS_LOOP_AFTER_CHECK_NOT_PLASMA_1: li t0,2
            bne a2,t0,PLASMA_BREATH_OPERATIONS_LOOP_AFTER_CHECK_NOT_PLASMA_2
            #    fs7 = PLASMA_2's Y speed 
                fmv.s fs7,fa0   # Saves PLASMA_2's new Y speed from fa0 
                j PLASMA_BREATH_OPERATIONS_AFTER_CHECK  # Finish move

            PLASMA_BREATH_OPERATIONS_LOOP_AFTER_CHECK_NOT_PLASMA_2: li t0,3
            bne a2,t0,PLASMA_BREATH_OPERATIONS_LOOP_AFTER_CHECK_NOT_PLASMA_3
            #    fs8 = PLASMA_3's Y speed 
                fmv.s fs8,fa0   # Saves PLASMA_3's new Y speed from fa0 
                j PLASMA_BREATH_OPERATIONS_AFTER_CHECK  # Finish move

            PLASMA_BREATH_OPERATIONS_LOOP_AFTER_CHECK_NOT_PLASMA_3: # li t0,4
            #    fs9 = PLASMA_4's Y speed 
                fmv.s fs9,fa0   # Saves PLASMA_0's new Y speed from fa0 
                # j PLASMA_BREATH_OPERATIONS_AFTER_CHECK  # Finish move

            PLASMA_BREATH_OPERATIONS_AFTER_CHECK:


            # Calculating Plasma Breath's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lw a0,16(sp) # Gets a0 from stack again
            lw tp,32(sp) # Gets tp from stack again
            lbu a1,6(a0) # Loads plasma breath's current X
            lbu t0,6(tp) # Loads map's current X
            sub a1,a1,t0 # Gets the X matrix related to the map's X (a1 = plasma breath's X - map's X)
            slli a1,a1,tile_size_shift # Multiplies a5 by 16 in order to get X related to screen
            lbu t0,3(a0) # Loads plasma breath's X offset
            add a1,a1,t0 # Adds offset to position
            lbu t0,8(tp) # Loads map's X offset
            sub a1,a1,t0 # and takes it from plasma breath's position

# dislocation?
        
            # Calculating Plasma Breath's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lbu a2,8(a0) # Loads plasma breath's current Y
            lbu t1,7(tp) # Loads map's current Y
            sub a2,a2,t1 # Gets the Y matrix related to the map's Y (a2 = plasma breath's Y - map's Y)
            slli a2,a2,tile_size_shift # Multiplies a2 by 16 in order to get Y related to screen
            lbu t0,4(a0) # Loads plasma breath's Y offset
            add a2,a2,t0 # Adds offset to position
            lbu t1,9(tp) # Loads map's Y offset
            sub a2,a2,t1 # and takes it from plasma breath's position
            
            li a3,tile_size   # 16 = width of rendering area
            li a4,tile_size   # 16 = height of rendering area
            mv a5,s0          # gets frame to be rendered on

            lbu a6,5(a0)      # Loads plasma breath's status
            addi a6,a6,1      # adds 1 to it
            li t0,3
            bge t0,a6,PLASMA_BREATH_OPERATIONS_LOOP_SKIP_STATUS_CORRECTION  # If a6 <= 3, continue
                li a6,0       # resets a6 to 0
            PLASMA_BREATH_OPERATIONS_LOOP_SKIP_STATUS_CORRECTION:
            sb a6,5(a0)       # and stores it back for using next time

            la a0,Plasma_Breath
            li a7,0             # Normal render
            call RENDER_ENTITY  # Renders it
            # j PLASMA_BREATH_OPERATIONS_LOOP_AFTER_OPERATIONS
            
        PLASMA_BREATH_OPERATIONS_LOOP_AFTER_OPERATIONS:
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

                NEXT_IN_PLASMA_BREATH_OPERATIONS_LOOP:                    
                    addi a0,a0,plasma_size  # Going to the next plasma breath's address                                  
                    addi a2,a2,1            # Iterating counter by 1                                   
                    bge a2,a1, END_PLASMA_BREATH_OPERATIONS_LOOP # If all of the plasma breaths were checked, end loop (don't attack)                                
                    j PLASMA_BREATH_OPERATIONS_LOOP # otherwise, go back to the loop's beginning 

    END_PLASMA_BREATH_OPERATIONS_LOOP:
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret

 
##############              RESET ENEMIES             ##############
#         Renders enabled plasma breaths and moves them :D         #
#                                                                  #		
#  ----------------        registers used        ----------------  #
#    a0 = PLASMA BREATH ARRAY address                              #
#    a1 = Number of plasma breaths in current map                  #
#    a2 = Loop counter                                             #
#    tp = CURRENT_MAP's address                                    #
#    t0 -- t6 = Temporary Registers                                #
#    a0 -- a7 => used as arguments                                 #
#                                                                  #
####################################################################    
RESET_ENEMIES:
    la tp,CURRENT_MAP
    lbu a7,4(tp)       # Loads current map's number
    la a0 Zoomers

    la t1,NEXT_MAP
	lbu t2,10(t1)      # Loads render Next Map's
    beqz t2,NOT_NEXT_MAP
        la tp,NEXT_MAP
        lbu a7,4(tp)       # Loads current map's number
        la a0,Zoomers_Next
    NOT_NEXT_MAP:
    
    li t0,7        # Loads 7 for comparision
    bne t0,a7, START_ZOOMERS_RESET
        j RESET_RIDLEY
    START_ZOOMERS_RESET:

    lw a0,0(a0)    # Loads the ZoomersA address over the Zoomers address
    bnez a0,CONTINUE_ZOOMER_RESET  # If there are zoomers in this map
        j END_RESET_ZOOMER_LOOP    # If a0 = 0, there are no zoomers in this map

    CONTINUE_ZOOMER_RESET:
    # Otherwise, continue
    lbu a1,0(a0)   # Loads number of Zoomers in current map
    
    li a2,0        # Counter for zoomers
    addi a0,a0,1   # Goes to next byte (where zoomers from current map start)
    RESET_ZOOMER_LOOP:
        li t0, 1 
        bne t0, a7, SKIP_MAP1_RESET_ZOOMER_LOOP 
        j RESET_ZOOMER_LOOP_MAP1
    
        SKIP_MAP1_RESET_ZOOMER_LOOP:
            li t0, 2 
            bne t0, a7, SKIP_MAP2_RESET_ZOOMER_LOOP 
            j RESET_ZOOMER_LOOP_MAP2

        SKIP_MAP2_RESET_ZOOMER_LOOP:
            li t0, 3 
            bne t0, a7, SKIP_MAP3_RESET_ZOOMER_LOOP 
            j RESET_ZOOMER_LOOP_MAP3

        SKIP_MAP3_RESET_ZOOMER_LOOP:
            li t0, 4
            bne t0, a7, SKIP_MAP4_RESET_ZOOMER_LOOP 
            j RESET_ZOOMER_LOOP_MAP4
        
        SKIP_MAP4_RESET_ZOOMER_LOOP:
            j RESET_ZOOMER_LOOP_MAP5
  					
    
        RESET_ZOOMER_LOOP_MAP1:
            bnez a2,RESET_ZOOMER_LOOP_MAP1_NOT_0
            # If it's Zoomer1_0
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,34
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,7
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                li t0,3
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP1_NOT_0: li t0,1
            bne t0,a2,RESET_ZOOMER_LOOP_MAP1_NOT_1
            # If it's Zoomer1_1
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,32
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,5
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                li t0,1
                sb t0,10(a0)
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP
            
            RESET_ZOOMER_LOOP_MAP1_NOT_1: li t0,2
            bne t0,a2,RESET_ZOOMER_LOOP_MAP1_NOT_2
            # If it's Zoomer1_2
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,9
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,7
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb t0,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP1_NOT_2: li t0,3
            bne t0,a2,RESET_ZOOMER_LOOP_MAP1_NOT_3
            # If it's Zoomer1_3
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,55
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,2
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                li t0,2
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP
            
            RESET_ZOOMER_LOOP_MAP1_NOT_3: li t0,4
            bne t0,a2,RESET_ZOOMER_LOOP_MAP1_NOT_4
            # If it's Zoomer1_4
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,55
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,9
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                li t0,2
                sb t0,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP1_NOT_4: # li t0,5
            # If it's Zoomer1_5
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,48
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,12
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb zero,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

        RESET_ZOOMER_LOOP_MAP2:
        bnez a2,RESET_ZOOMER_LOOP_MAP2_NOT_0
            # If it's Zoomer4_0
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,15
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,5
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP2_NOT_0: li t0,1
            bne t0,a2,RESET_ZOOMER_LOOP_MAP2_NOT_1
            # If it's Zoomer2_1
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,9
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,7
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb zero,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP
            
            RESET_ZOOMER_LOOP_MAP2_NOT_1: li t0,2
            bne t0,a2,RESET_ZOOMER_LOOP_MAP2_NOT_2
            # If it's Zoomer2_2
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,4
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,9
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                li t0,1
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP2_NOT_2: li t0,3
            bne t0,a2,RESET_ZOOMER_LOOP_MAP2_NOT_3
            # If it's Zoomer2_3
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,12
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,11
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP
            
            RESET_ZOOMER_LOOP_MAP2_NOT_3: li t0,4
            bne t0,a2,RESET_ZOOMER_LOOP_MAP2_NOT_4
            # If it's Zoomer2_4
                li t0,zoomer_variant_health
                sb t0,0(a0)
                li t0,1
                sb t0,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,6
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,18
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                li t0,3
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP2_NOT_4: li t0,5
            bne t0,a2,RESET_ZOOMER_LOOP_MAP2_NOT_5
            # If it's Zoomer2_5
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,12
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,22
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP   

            RESET_ZOOMER_LOOP_MAP2_NOT_5: li t0,6
            bne t0,a2,RESET_ZOOMER_LOOP_MAP2_NOT_6
            # If it's Zoomer2_6
                li t0,zoomer_variant_health
                sb t0,0(a0)
                li t0,1
                sb t0,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,4
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,28
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                sb zero,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP     
            
            RESET_ZOOMER_LOOP_MAP2_NOT_6: li t0,7
            bne t0,a2,RESET_ZOOMER_LOOP_MAP2_NOT_7
            # If it's Zoomer2_7
                li t0,zoomer_variant_health
                sb t0,0(a0)
                li t0,1
                sb t0,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,7
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,33
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP  

            RESET_ZOOMER_LOOP_MAP2_NOT_7: # li t0,8
            # If it's Zoomer2_8
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,17
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,34
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                li t0,3
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP        

        RESET_ZOOMER_LOOP_MAP3:
        bnez a2,RESET_ZOOMER_LOOP_MAP3_NOT_0
            # If it's Zoomer3_0
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,2
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,10
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                li t0,1
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP3_NOT_0: li t0,1
            bne t0,a2,RESET_ZOOMER_LOOP_MAP3_NOT_1
            # If it's Zoomer3_1
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,18
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,12
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP
            
            RESET_ZOOMER_LOOP_MAP3_NOT_1: li t0,2
            bne t0,a2,RESET_ZOOMER_LOOP_MAP3_NOT_2
            # If it's Zoomer3_2
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,31
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,2
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                li t0,3
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP3_NOT_2: li t0,3
            bne t0,a2,RESET_ZOOMER_LOOP_MAP3_NOT_3
            # If it's Zoomer3_3
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,40
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,3
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                li t0,2
                sb t0,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP
            
            RESET_ZOOMER_LOOP_MAP3_NOT_3: li t0,4
            bne t0,a2,RESET_ZOOMER_LOOP_MAP3_NOT_4
            # If it's Zoomer3_4
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,43
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,12
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP3_NOT_4: # li t0,5
            # If it's Zoomer3_5
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,48
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,1
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP    


        RESET_ZOOMER_LOOP_MAP4:
        bnez a2,RESET_ZOOMER_LOOP_MAP4_NOT_0
            # If it's Zoomer4_0
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,5
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,41
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                li t0,3
                sb t0,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP4_NOT_0: li t0,1
            bne t0,a2,RESET_ZOOMER_LOOP_MAP4_NOT_1
            # If it's Zoomer4_1
                li t0,zoomer_variant_health
                sb t0,0(a0)
                li t0,1
                sb t0,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,15
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,38
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                sb zero,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP
            
            RESET_ZOOMER_LOOP_MAP4_NOT_1: li t0,2
            bne t0,a2,RESET_ZOOMER_LOOP_MAP4_NOT_2
            # If it's Zoomer4_2
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,8
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,33
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                li t0,1
                sb zero,10(a0)
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP4_NOT_2: li t0,3
            bne t0,a2,RESET_ZOOMER_LOOP_MAP4_NOT_3
            # If it's Zoomer4_3
                li t0,zoomer_variant_health
                sb t0,0(a0)
                li t0,1
                sb t0,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,10
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,26
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                li t0,1
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP
            
            RESET_ZOOMER_LOOP_MAP4_NOT_3: li t0,4
            bne t0,a2,RESET_ZOOMER_LOOP_MAP4_NOT_4
            # If it's Zoomer4_4
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,10
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,22
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP4_NOT_4: li t0,5
            bne t0,a2,RESET_ZOOMER_LOOP_MAP4_NOT_5
            # If it's Zoomer4_5
                li t0,zoomer_variant_health
                sb t0,0(a0)
                li t0,1
                sb t0,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,4
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,21
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP   

            RESET_ZOOMER_LOOP_MAP4_NOT_5: li t0,6
            bne t0,a2,RESET_ZOOMER_LOOP_MAP4_NOT_6
            # If it's Zoomer4_6
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,17
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,21
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                li t0,3
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP     
            
            RESET_ZOOMER_LOOP_MAP4_NOT_6: li t0,7
            bne t0,a2,RESET_ZOOMER_LOOP_MAP4_NOT_7
            # If it's Zoomer4_7
                li t0,zoomer_variant_health
                sb t0,0(a0)
                li t0,1
                sb t0,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,12
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,15
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                li t0,2
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP  

            RESET_ZOOMER_LOOP_MAP4_NOT_7: li t0,8
            bne t0,a2,RESET_ZOOMER_LOOP_MAP4_NOT_8
            # If it's Zoomer4_8
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,7
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,11
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP    
            
            RESET_ZOOMER_LOOP_MAP4_NOT_8: li t0,9
            bne t0,a2,RESET_ZOOMER_LOOP_MAP4_NOT_9
            # If it's Zoomer4_9
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,5
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,8
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                li t0,1
                sb t0,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP 

            RESET_ZOOMER_LOOP_MAP4_NOT_9: #li t0,10
            # If it's Zoomer4_10
                li t0,zoomer_variant_health
                sb t0,0(a0)
                li t0,1
                sb t0,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,8
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,3
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP     

        RESET_ZOOMER_LOOP_MAP5:
        bnez a2,RESET_ZOOMER_LOOP_MAP5_NOT_0
            # If it's Zoomer5_0
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,30
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,12
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP5_NOT_0: li t0,1
            bne t0,a2,RESET_ZOOMER_LOOP_MAP5_NOT_1
            # If it's Zoomer5_1
                li t0,zoomer_variant_health
                sb t0,0(a0)
                li t0,1
                sb t0,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,21
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,12
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                sb zero,9(a0)
                sb zero,10(a0)
                li t0,1
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP
            
            RESET_ZOOMER_LOOP_MAP5_NOT_1: li t0,2
            bne t0,a2,RESET_ZOOMER_LOOP_MAP5_NOT_2
            # If it's Zoomer5_2
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,19
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,12
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb zero,10(a0)
                sb zero,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP

            RESET_ZOOMER_LOOP_MAP5_NOT_2: # li t0,3
            # If it's Zoomer5_3
                li t0,zoomer_normal_health
                sb t0,0(a0)
                sb zero,1(a0)
                sb zero,2(a0)
                sb zero,3(a0)
                li t0,9
                sb t0,4(a0)
                sb zero,5(a0)
                li t0,8
                sb t0,6(a0)
                sb zero,7(a0)
                sb zero,8(a0)
                li t0,1
                sb t0,9(a0)
                sb t0,10(a0)
                sb t0,11(a0)
                j NEXT_IN_RESET_ZOOMER_LOOP
            
            

        NEXT_IN_RESET_ZOOMER_LOOP: 
            addi a0,a0,zoomer_size  # Going to the next zoomer's address                                  
            addi a2,a2,1            # Iterating counter by 1                                   
            bge a2,a1, END_RESET_ZOOMER_LOOP # If all of the zoomers were checked, end loop                                  
            j RESET_ZOOMER_LOOP # otherwise, go back to the loop's beginning                     
    
    END_RESET_ZOOMER_LOOP:



    # Rippers won't be reset (they basically just go back and forth, so who cares :P)

    li t0,7
    bne a7,t0,RESET_RIDLEY
        j END_RESET_PLASMA_BREATH_LOOP

    RESET_RIDLEY:
        la t0, RIDLEY_INFO
        li t1, ridley_health
        sb t1, 0(t0)            # Restores Ridley's health points
        li t1,10
        sb t1,2(t0)             # Restores Ridley's Y offset
        li t1,5
        sb t1,3(t0)             # Restores Ridley's Y
        sb t1,4(t0)             # Restores Ridley's old Y
        sb zero,6(t0)           # Restores Ridley's ground position
        sb zero,7(t0)           # Restores Ridley's MOVE_Y
        sb zero,8(t0)           # Restores Ridley's JUMP
        li t1, ridley_jump_cooldown
        sb t1,9(t0)             # Restores Ridley's jump cooldown
        li t1,ridley_attack_cooldown
        sb t1,10(t0)            # Restores Ridley's attack cooldown

    la a0,PLASMA_BREATH_ARRAY  # Loads Plasma breath array
    li a2,0 # resets counter
    li a1,plasma_number # gets number of plasma breaths in game
    RESET_PLASMA_BREATH_LOOP:
        sb zero,0(a0)   # Disables it

        NEXT_IN_RESET_PLASMA_BREATH_LOOP:                    
            addi a0,a0,plasma_size  # Going to the next plasma breath's address                                  
            addi a2,a2,1            # Iterating counter by 1                                   
            bge a2,a1, END_RESET_PLASMA_BREATH_LOOP # If all of the plasma breaths were checked, end loop (don't attack)                                
            j RESET_PLASMA_BREATH_LOOP # otherwise, go back to the loop's beginning 
        
    END_RESET_PLASMA_BREATH_LOOP:
    ret