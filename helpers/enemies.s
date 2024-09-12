# ----> Summary: enemies.s stores enemies related procedures
# 1 - ENEMY OPERATIONS (Checks enemies in current map and renders/moves them)
# 2 - ZOOMER OPERATIONS
# 3 - RIPPER OPERATIONS 

ENEMY_OPERATIONS:
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
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
#  ----------------      argument registers      ----------------  #
#    a0 = 0 - Normal Procedure      #
#                                                                  #
#  ----------------        registers used        ----------------  #
#    a0 = Current Map's Zoomer address                             #
#    a1 = 0 - Normal Procedure             #
#    a2 = Number of zoomers in current map                         #
#    a3 = Loop counter                                             #
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
    mv a1,a0       # Moves argument to a0

    la a0,Zoomers  # Loads Zoomers address
    la tp, CURRENT_MAP # Loads CURRENT_MAP address
    
    lw a0,0(a0)    # Loads the ZoomersA address over the Zoomers address
    beqz a0,END_ZOOMER_OPERATIONS_LOOP # If a0 = 0, there are no zoomers in this map
    # Otherwise, continue

    lbu a2,0(a0)   # Loads number of Zoomers in current map
    
    li a3,0        # Counter for zoomers
    addi a0,a0,1   # Goes to next byte (where zoomers from current map start)
    ZOOMER_OPERATIONS_LOOP:
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
            
            bnez a1,ZOOMER_OPERATIONS_LOOP_RENDER_TRAIL
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
            addi a3,a3,1            # Iterating counter by 1                                   
            bge a3,a2, END_ZOOMER_OPERATIONS_LOOP # If all of the zoomer's were checked, end loop                                  
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
#    a2 = Number of rippers in current map                         #
#    a3 = Loop counter                                             #
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
    beqz a0,END_RIPPER_OPERATIONS_LOOP # If a0 = 0, there are no rippers in this map
    # Otherwise, continue

    lbu a2,0(a0)   # Loads number of Rippers in current map
    
    li a3,0        # Counter for rippers
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
            addi a3,a3,1            # Iterating counter by 1                                   
            bge a3,a2, END_RIPPER_OPERATIONS_LOOP # If all of the ripper's were checked, end loop                                  
            j RIPPER_OPERATIONS_LOOP # otherwise, go back to the loop's beginning                     
    
    END_RIPPER_OPERATIONS_LOOP:   
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret




		
   
