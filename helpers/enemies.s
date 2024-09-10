# ----> Summary: enemies.s stores enemies related procedures
# 1 - ENEMY OPERATIONS (Checks enemies in current map and renders/moves them)
# 2 - ZOOMER OPERATIONS
# 3 - RIPPER OPERATIONS 

ENEMY_OPERATIONS:
mv s11,ra # stores ra
    la t0,CURRENT_MAP  # Loads CURRENT_MAP address
    lbu t0,4(t0)       # Loads current map byte
    li t1,2            # loads 2 to compare with
    beq t0,t1,ENEMY_OPERATIONS_CHECK_RIPPER  # If on map 2, go to check ripper
    # Otherwise, check if it's on map 4
    li t1,4            # loads 4 to compare with
    bne t0,t1,ENEMY_OPERATIONS_SKIP_RIPPER  # If not on map 4, don't check ripper
    # Otherwise, check rippers
    ENEMY_OPERATIONS_CHECK_RIPPER:
        call RIPPER_OPERATIONS        # Checks rippers
    ENEMY_OPERATIONS_SKIP_RIPPER:
mv ra,s11 # gets ra
ret



################         RIPPER OPERATIONS         #################
#          Checks if Ripper should be rendered and moved           #
#           (if on screen range). It takes no arguments            #	
#  ----------------        registers used        ----------------  #
#    a0 = Current Map's Ripper address                             #
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
    lbu a1,0(a0)   # Loads number of Rippers in current map
    
    li a2,0        # Counter for rippers
    addi a0,a0,1   # Goes to next byte (where rippers from current map start)
    RIPPER_OPERATIONS_LOOP:
        # Checking X
        lbu t0,6(tp) # Loads map's current X
        lbu a3,3(a0) # Loads ripper's current X
        li t2,m_render_distance  # Loads 4 (render distance)
        sub t3,t0,t2 # Gets leftmost threshold to manage ripper
        blt a3,t3,NEXT_IN_RIPPER_OPERATIONS_LOOP # If ripper's X isn't inside left border, go to next
        # Otherwise,
        add t3,t0,t2 # Calculate rightmost threshold to manage ripper
        addi t3,t3,m_screen_width # finishing calculating threshold
        bge a3,t3,NEXT_IN_RIPPER_OPERATIONS_LOOP # If ripper's X isn't inside right border, go to next

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
            addi sp,sp,-28
            sw s1,0(sp)
            sw s2,4(sp)
            sw s3,8(sp)
            sw s4,12(sp)
            sw a0,16(sp)
            sw a1,20(sp)
            sw a2,24(sp)
        # End of Stack Operations
            
            # Calculating Ripper's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            sub a1,a3,t0 # Gets the X matrix related to the map's X (a1 = ripper's X - map's X)
            slli a1,a1,tile_size_shift # Multiplies a3 by 16 in order to get X related to screen
            lbu t0,2(a0) # Loads ripper's X offset
            add a1,a1,t0 # Adds offset to position
            lbu t0,8(tp) # Loads map's X offset
            sub a1,a1,t0 # and takes it from ripper's position
# dislocation?
        
        # Calculating Ripper's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            sub a2,a4,t1 # Gets the Y matrix related to the map's Y (a2 = ripper's Y - map's Y)
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
                call RENDER_ENTITY  # Renders it


        # Procedure finished: Loading Registers from Stack
            lw s1,0(sp)
            lw s2,4(sp)
            lw s3,8(sp)
            lw s4,12(sp)
            lw a0,16(sp)
            lw a1,20(sp)
            lw a2,24(sp)
            addi sp,sp,28
        # End of Stack Operations
            la tp, CURRENT_MAP # Loads CURRENT_MAP address and iterate

        NEXT_IN_RIPPER_OPERATIONS_LOOP:                    
            addi a0,a0,ripper_size  # Going to the next ripper's address                                  
            addi a2,a2,1            # Iterating counter by 1                                   
            bge a2,a1, END_RIPPER_OPERATIONS_LOOP # If all of the ripper's were checked, end loop                                  
            j RIPPER_OPERATIONS_LOOP # otherwise, go back to the loop's beginning                     
    
    END_RIPPER_OPERATIONS_LOOP:   
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret




		
   