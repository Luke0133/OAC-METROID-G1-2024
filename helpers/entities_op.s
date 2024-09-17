###################        MARU MARI OPERATIONS        ####################
#              Spawns a loot animation if available,             #
#                    otherwise end procedure.                    #
#                                                                #
#  ----------           argument registers           ----------  #
#    a0 = loot type (0 - none, 1 - energy, 2 - energy or missile)#
#    a1 = X offset                                              #
#    a2 = Y offset                                              #
#    a3 = X (matrix)                                            #
#    a4 = Y (matrix)                                            #
#                                                               #
#  ----------            registers used             ----------  #
#    a0 = LOOT_ARRAY address                                    #
#    a1 = Number of bombs                                       #
#    a2 = Loop counter                                          # 
#                                                               #
#  ----------         temporary registers           ----------  #
#    t0 --> temporary register                                  #
#    t3 = Explosion type (moved from a0)                        #
#    t4 = X offset (moved from a1)                              #
#    t5 = Y offset (moved from a2)                              #
#                                                               #    
#################################################################

MARU_MARI_OPERATIONS:
 # Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
    la t0,MAP_INFO 
    lbu t0,0(t0)
    li t1,1
    beq t0,t1,CONTINUE_MARU_MARI_OPERATIONS
        j END_MARU_MARI_OPERATIONS
        
    CONTINUE_MARU_MARI_OPERATIONS:
        la t0,PLYR_INFO 
        lbu t0,1(t0)                             # Loads player's number of abilities
        beqz t0,CONTINUE_MARU_MARI_OPERATIONS2   # Continue (ability wasn't aquired yet)
            j END_MARU_MARI_OPERATIONS           # otherwise don't render

    CONTINUE_MARU_MARI_OPERATIONS2:
        # Storing Registers on Stack
            addi sp,sp,-16
            sw s1,0(sp)
            sw s2,4(sp)
            sw s3,8(sp)
            sw s4,12(sp)
        # End of Stack Operations           
            la tp,CURRENT_MAP
            # Starting rendering procedure:
            # Calculating maru mari's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            li a1,maru_mari_x    # Loads maru mari's current X
            lbu t0,6(tp) # Loads map's current X
            sub a1,a1,t0 # Gets the X matrix related to the map's X (a1 = maru mari's X - map's X)
            slli a1,a1,tile_size_shift # Multiplies a5 by 16 in order to get X related to screen
            # There's no X offset
            lbu t0,8(tp) # Loads map's X offset
            sub a1,a1,t0 # and takes it from maru mari's position
            
            # Calculating maru mari's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            li a2,maru_mari_y # Loads maru mari's current Y
            lbu t1,7(tp) # Loads map's current Y
            sub a2,a2,t1 # Gets the Y matrix related to the map's Y (a2 = maru mari's Y - map's Y)
            slli a2,a2,tile_size_shift # Multiplies a2 by 16 in order to get Y related to screen
            # There's no Y offset
            lbu t1,9(tp) # Loads map's Y offset
            sub a2,a2,t1 # and takes it from loot's position
            
            li a3,tile_size     # Loads width         
            li a4,tile_size     # Loads height
            mv a5,s0            # gets frame to be rendered on
            li a7,0             # Normal render
    
            # Updating sprite
            la t0,MARU_MARI_INFO # Loads Maru Mari's info address
            lbu a6, 0(t0)        # Loads status sprite
            li t3, 3             # t3 = max_sprite
            beq a6,t3,RESET_MARU_MARI # If status == 3, reset it
                addi a6,a6,1     # Increments status 
                sb a6, 0(t0)     # Stores status sprite
                j MARU_MARI_OPERATIONS_RENDER

            RESET_MARU_MARI:
                sb zero, 0(t0)   # Stores status sprite
                # j MARU_MARI_OPERATIONS_RENDER

            MARU_MARI_OPERATIONS_RENDER:
                la a0,MaruMari
                call RENDER_ENTITY  # Renders it

        # Procedure finished: Loading Registers from Stack
            lw s1,0(sp)
            lw s2,4(sp)
            lw s3,8(sp)
            lw s4,12(sp)
            addi sp,sp,16
        # End of Stack Operations

    END_MARU_MARI_OPERATIONS:
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret     

###################        BOMB POWER OPERATIONS        ####################
#              Spawns a loot animation if available,             #
#                    otherwise end procedure.                    #
#                                                                #
#  ----------           argument registers           ----------  #
#    a0 = loot type (0 - none, 1 - energy, 2 - energy or missile)#
#    a1 = X offset                                              #
#    a2 = Y offset                                              #
#    a3 = X (matrix)                                            #
#    a4 = Y (matrix)                                            #
#                                                               #
#  ----------            registers used             ----------  #
#    a0 = LOOT_ARRAY address                                    #
#    a1 = Number of bombs                                       #
#    a2 = Loop counter                                          # 
#                                                               #
#  ----------         temporary registers           ----------  #
#    t0 --> temporary register                                  #
#    t3 = Explosion type (moved from a0)                        #
#    t4 = X offset (moved from a1)                              #
#    t5 = Y offset (moved from a2)                              #
#                                                               #    
#################################################################

BOMB_POWER_OPERATIONS:
 # Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
    la t0,MAP_INFO 
    lbu t0,0(t0)
    li t1,6
    beq t0,t1,CONTINUE_BOMB_POWER_OPERATIONS
        j END_BOMB_POWER_OPERATIONS
        
    CONTINUE_BOMB_POWER_OPERATIONS:
        la t0,PLYR_INFO 
        lbu t0,1(t0)                                # Loads player's number of abilities
        li t1,3
        bne t0,t1,CONTINUE_BOMB_POWER_OPERATIONS2   # Continue (ability wasn't aquired yet)
            j END_BOMB_POWER_OPERATIONS             # otherwise don't render

    CONTINUE_BOMB_POWER_OPERATIONS2:
        la t0,BOMB_POWER_INFO 
        lbu t0,0(t0)                                # Loads whether capsule has been broken or not
        bnez t0,CONTINUE_BOMB_POWER_OPERATIONS3  # Continue (capsule was broken)
            j END_BOMB_POWER_OPERATIONS             # otherwise don't render
    
    CONTINUE_BOMB_POWER_OPERATIONS3:
        # Storing Registers on Stack
            addi sp,sp,-16
            sw s1,0(sp)
            sw s2,4(sp)
            sw s3,8(sp)
            sw s4,12(sp)
        # End of Stack Operations           
            la tp,CURRENT_MAP
            # Starting rendering procedure:
            # Calculating maru mari's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            li a1,bomb_power_x    # Loads maru mari's current X
            lbu t0,6(tp) # Loads map's current X
            sub a1,a1,t0 # Gets the X matrix related to the map's X (a1 = maru mari's X - map's X)
            slli a1,a1,tile_size_shift # Multiplies a5 by 16 in order to get X related to screen
            # There's no X offset
            lbu t0,8(tp) # Loads map's X offset
            sub a1,a1,t0 # and takes it from maru mari's position
            
            # Calculating maru mari's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            li a2,bomb_power_y    # Loads maru mari's current Y
            lbu t1,7(tp) # Loads map's current Y
            sub a2,a2,t1 # Gets the Y matrix related to the map's Y (a2 = maru mari's Y - map's Y)
            slli a2,a2,tile_size_shift # Multiplies a2 by 16 in order to get Y related to screen
            # There's no Y offset
            lbu t1,9(tp) # Loads map's Y offset
            sub a2,a2,t1 # and takes it from loot's position
            
            li a3,tile_size     # Loads width         
            li a4,tile_size     # Loads height
            mv a5,s0            # Gets frame to be rendered on
            li a6,0             # No status
            li a7,0             # Normal render

            la a0,Bomb_Power
            call RENDER_ENTITY  # Renders it

        # Procedure finished: Loading Registers from Stack
            lw s1,0(sp)
            lw s2,4(sp)
            lw s3,8(sp)
            lw s4,12(sp)
            addi sp,sp,16
        # End of Stack Operations

    END_BOMB_POWER_OPERATIONS:
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret    

###################        BOMB POWER OPERATIONS        ####################
#              Spawns a loot animation if available,             #
#                    otherwise end procedure.                    #
#                                                                #
#  ----------           argument registers           ----------  #
#    a0 = loot type (0 - none, 1 - energy, 2 - energy or missile)#
#    a1 = X offset                                              #
#    a2 = Y offset                                              #
#    a3 = X (matrix)                                            #
#    a4 = Y (matrix)                                            #
#                                                               #
#  ----------            registers used             ----------  #
#    a0 = LOOT_ARRAY address                                    #
#    a1 = Number of bombs                                       #
#    a2 = Loop counter                                          # 
#                                                               #
#  ----------         temporary registers           ----------  #
#    t0 --> temporary register                                  #
#    t3 = Explosion type (moved from a0)                        #
#    t4 = X offset (moved from a1)                              #
#    t5 = Y offset (moved from a2)                              #
#                                                               #    
#################################################################

ITEM_CAPSULE_OPERATIONS:
 # Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
    la t0,MAP_INFO 
    lbu t0,0(t0)
    li t1,6
    beq t0,t1,CONTINUE_ITEM_CAPSULE_OPERATIONS1
        j END_ITEM_CAPSULE_OPERATIONS
        
    CONTINUE_ITEM_CAPSULE_OPERATIONS1:
        la t0,ITEM_CAPSULE_INFO 
        lbu a6,0(t0)                                # Loads whether capsule has been broken or not
        li t1,3
        bne a6,t1,CONTINUE_ITEM_CAPSULE_OPERATIONS2   # Continue (capsule was broken)
            j END_ITEM_CAPSULE_OPERATIONS             # otherwise don't render
    
    CONTINUE_ITEM_CAPSULE_OPERATIONS2:
        # Storing Registers on Stack
            addi sp,sp,-16
            sw s1,0(sp)
            sw s2,4(sp)
            sw s3,8(sp)
            sw s4,12(sp)
        # End of Stack Operations           
            la tp,CURRENT_MAP
            # Starting rendering procedure:
            # Calculating maru mari's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            li a1,bomb_power_x    # Loads maru mari's current X
            lbu t0,6(tp) # Loads map's current X
            sub a1,a1,t0 # Gets the X matrix related to the map's X (a1 = maru mari's X - map's X)
            slli a1,a1,tile_size_shift # Multiplies a5 by 16 in order to get X related to screen
            # There's no X offset
            lbu t0,8(tp) # Loads map's X offset
            sub a1,a1,t0 # and takes it from maru mari's position
            
            # Calculating maru mari's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            li a2,bomb_power_y    # Loads maru mari's current Y
            lbu t1,7(tp) # Loads map's current Y
            sub a2,a2,t1 # Gets the Y matrix related to the map's Y (a2 = maru mari's Y - map's Y)
            slli a2,a2,tile_size_shift # Multiplies a2 by 16 in order to get Y related to screen
            # There's no Y offset
            lbu t1,9(tp) # Loads map's Y offset
            sub a2,a2,t1 # and takes it from loot's position
            
            li a3,tile_size     # Loads width         
            li a4,tile_size     # Loads height
            mv a5,s0            # Gets frame to be rendered on
            li a7,0             # Normal render

            la t0,ITEM_CAPSULE_INFO 
            beqz a6, SKIP_CAPSULE_STATUS_UPDATE
                addi a6,a6,1
                sb a6,0(t0)    # Stores resulting status
                li t0,3
                beq t0,a6,AFTER_CAPSULE_RENDER
            SKIP_CAPSULE_STATUS_UPDATE:
            la a0,Item_Capsule
            call RENDER_ENTITY  # Renders it

            AFTER_CAPSULE_RENDER:

        # Procedure finished: Loading Registers from Stack
            lw s1,0(sp)
            lw s2,4(sp)
            lw s3,8(sp)
            lw s4,12(sp)
            addi sp,sp,16
        # End of Stack Operations

    END_ITEM_CAPSULE_OPERATIONS:
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret    

###################        LOOT SPAWN        ####################
#              Spawns a loot animation if available,             #
#                    otherwise end procedure.                    #
#                                                                #
#  ----------           argument registers           ----------  #
#    a0 = loot type (0 - none, 1 - energy, 2 - energy or missile)#
#    a1 = X offset                                              #
#    a2 = Y offset                                              #
#    a3 = X (matrix)                                            #
#    a4 = Y (matrix)                                            #
#                                                               #
#  ----------            registers used             ----------  #
#    a0 = LOOT_ARRAY address                                    #
#    a1 = Number of bombs                                       #
#    a2 = Loop counter                                          # 
#                                                               #
#  ----------         temporary registers           ----------  #
#    t0 --> temporary register                                  #
#    t3 = Explosion type (moved from a0)                        #
#    t4 = X offset (moved from a1)                              #
#    t5 = Y offset (moved from a2)                              #
#                                                               #    
#################################################################

LOOT_SPAWN:
    bnez a0,CONTINUE_LOOT_SPAWN   # If we actually want to spawn loot
        j END_LOOT_SPAWN_LOOP     # Otherwise, finish procedure

    CONTINUE_LOOT_SPAWN:
        mv t3, a0  # Moves explosion type to t3
        mv t4, a1  # Moves X offset to t4
        mv t5, a2  # Moves Y offset to t5

        la a0, LOOT_ARRAY      # Loads LOOT array
        
        li a1, loot_number      # Loads total number of loot
        li a2,0                 # Resets counter
        LOOT_SPAWN_LOOP:
            lbu t0, 2(a0)       # Loads enable byte
            beqz t0, LOOT_SPAWN_LOOP_ACTIVATE # If current loot is disabled, activate it
                j NEXT_IN_LOOT_SPAWN_LOOP     # Otherwise, go to next one in loop

            LOOT_SPAWN_LOOP_ACTIVATE:
                li t0,1          # Loads 1 (Enabled) 
                sb t0,2(a0)      # stores in explosion's enable byte

                addi t3,t3,-1    # If t3 = 1 -> t3 = 0. If t3 = 2 -> t3 = 1
                beqz t3,SKIP_RANDOM_LOOT  # If the result is 0, spawn energy
                # Storing Registers on Stack
                    addi sp,sp,-8
                    sw a0,0(sp)
                    sw a1,4(sp)
                # End of Stack Operations 

                    # Getting random loot value
                    li a1,10                  # Range
                    li a7,RandIntRangeEcall  # random integer within range ecall
                    ecall
                    mv t3,a0

                # Syscall finished: Loading Registers from Stack
                    lw a0,0(sp)
                    lw a1,4(sp)
                    addi sp,sp,8
                # End of Stack Operations    
                    
                    beqz t3,SKIP_RANDOM_LOOT   # If result is 0 (10%), spawn energy
                        li t3,1                # otherwise (90%), spawn missile

                SKIP_RANDOM_LOOT:

                sb t3,3(a0)      # Stores explosion's type (0 - Small, 1 - Big)

                sb t4, 4(a0)     # Stores explosion's X offset
                sb t5, 5(a0)     # Stores explosion's Y offset

                sb a3, 6(a0)     # Stores explosion's X 
                sb a3, 7(a0)     # Stores explosion's old X 

                sb a4, 8(a0)     # Stores explosion's Y 
                sb a4, 9(a0)     # Stores explosion's old Y   

                j END_LOOT_SPAWN_LOOP # Break Loop       

            NEXT_IN_LOOT_SPAWN_LOOP:
                addi a0,a0,loot_size           # Going to the next loot address                                  
                addi a2,a2,1                   # Iterating counter by 1                                   
                bge a2,a1, END_LOOT_SPAWN_LOOP # If all of the loot were checked, end loop (don't spawn loot)                                
                j LOOT_SPAWN_LOOP # otherwise, go back to the loop's beginning 

    END_LOOT_SPAWN_LOOP:
    # Procedure finished, return
        ret        


##############        LOOT OPERATIONS        ##############
#           Renders enabled bombs and moves them          #
#                                                         #		
#  ------------        registers used       ------------  #
#    a0 = LOOT ARRAY address                              #
#    a1 = Total number of loot                            #
#    a2 = Loop counter                                    #
#    tp = CURRENT_MAP's address                           #
#    t0 -- t6 = Temporary Registers                       #
#    a0 -- a7 => used as arguments                        #
#                                                         #
###########################################################


LOOT_OPERATIONS:
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
    la tp, CURRENT_MAP      # Loads CURRENT_MAP address

    la a0,LOOT_ARRAY   # Loads loot array

    li a2,0                 # resets counter
    li a1,loot_number       # gets number of loot in game
    LOOT_OPERATIONS_LOOP:
        lbu t2,2(a0) # Loads enable byte
        bnez t2,LOOT_OPERATIONS_LOOP_CONTINUE    # If enabled,
            j NEXT_IN_LOOT_OPERATIONS_LOOP       # Otherwise, check other loot

        LOOT_OPERATIONS_LOOP_CONTINUE:
        # If procedure arrived here, render current loot
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

            # Starting rendering procedure:
            # Calculating loot's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lbu a1,6(a0) # Loads loot's current X
            lbu t0,6(tp) # Loads map's current X
            sub a1,a1,t0 # Gets the X matrix related to the map's X (a1 = loot's X - map's X)
            slli a1,a1,tile_size_shift # Multiplies a5 by 16 in order to get X related to screen
            lbu t0,4(a0) # Loads loot's X offset
            add a1,a1,t0 # Adds offset to position
            lbu t0,8(tp) # Loads map's X offset
            sub a1,a1,t0 # and takes it from loot's position
            
            # Calculating loot's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lbu a2,8(a0) # Loads loot's current Y
            lbu t1,7(tp) # Loads map's current Y
            sub a2,a2,t1 # Gets the Y matrix related to the map's Y (a2 = loot's Y - map's Y)
            slli a2,a2,tile_size_shift # Multiplies a2 by 16 in order to get Y related to screen
            lbu t0,5(a0) # Loads loot's Y offset
            add a2,a2,t0 # Adds offset to position
            lbu t1,9(tp) # Loads map's Y offset
            sub a2,a2,t1 # and takes it from loot's position
            
            li a3,tile_size            
            li a4,tile_size
            mv a5,s0     # gets frame to be rendered on
            li a7,0      # Normal render

            lhu t0,0(a0)      # Gets number of times that it was rendered (counter)
            andi a6,t0,1      # Will be 1 if on an odd number of times, 0, if even
            
            lbu t0,3(a0)      # Loads loot type
            bnez t0,LOOT_OPERATIONS_LOOP_RENDER_MISSILE # If it's a missile collectible
                la a0,Energy
                j START_LOOT_OPERATIONS_LOOP_RENDER
            
            LOOT_OPERATIONS_LOOP_RENDER_MISSILE:
                la a0,Missile_Collectable
                # j START_LOOT_OPERATIONS_LOOP_RENDER            
            
            START_LOOT_OPERATIONS_LOOP_RENDER:
                call RENDER_ENTITY  # Renders it
 
                lw a0,16(sp)     # Restores a0
                lhu t0,0(a0)     # Gets number of times that it was rendered (counter)
                addi t0,t0,1     # iterates it
                sh t0,0(a0)      # and stores it back

                li t1,loot_time  # Loads number of times small explosion should render before being disabled
                blt t0,t1,LOOT_OPERATIONS_LOOP_AFTER_OPERATIONS  # If it didn't surpass the threshold, finish this part of loop
                # Otherwise, set it to be disabled
                    sh zero,0(a0)  # Resets render counter
                    sh zero,2(a0)  # Disables loot
                    # j LOOT_OPERATIONS_LOOP_AFTER_OPERATIONS
         
        LOOT_OPERATIONS_LOOP_AFTER_OPERATIONS:
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

        NEXT_IN_LOOT_OPERATIONS_LOOP:                    
            addi a0,a0,loot_size  # Going to the next bomb's address                                  
            addi a2,a2,1               # Iterating counter by 1                                   
            bge a2,a1, END_LOOT_OPERATIONS_LOOP # If all of the bombs were checked, end loop (don't attack)                                
            j LOOT_OPERATIONS_LOOP # otherwise, go back to the loop's beginning 

    END_LOOT_OPERATIONS_LOOP:
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret



#################        EXPLOSION SPAWN        #################
#          Spawns an explosion animation if available,          #
#                    otherwise end procedure.                   #
#                                                               #
#  ----------          argument registers           ----------  #
#    a0 = Explosion type (0 - Small, 1 - Big)                   #
#    a1 = X offset                                              #
#    a2 = Y offset                                              #
#    a3 = X (matrix)                                            #
#    a4 = Y (matrix)                                            #
#    a5 = delay (0 - none, any other positive number for delay) #
#                                                               #
#  ----------            registers used             ----------  #
#    a0 = EXPLOSION_ARRAY address                               #
#    a1 = Number of bombs                                       #
#    a2 = Loop counter                                          # 
#                                                               #
#  ----------         temporary registers           ----------  #
#    t0 --> temporary register                                  #
#    t3 = Explosion type (moved from a0)                        #
#    t4 = X offset (moved from a1)                              #
#    t5 = Y offset (moved from a2)                              #
#                                                               #    
#################################################################

EXPLOSION_SPAWN:
    mv t3, a0  # Moves explosion type to t3
    mv t4, a1  # Moves X offset to t4
    mv t5, a2  # Moves Y offset to t5

    la a0, EXPLOSION_ARRAY      # Loads EXPLOSION array
    
    li a1, explosion_number     # Loads total number of explosions
    li a2,0                     # Resets counter
    EXPLOSION_SPAWN_LOOP:
        lbu t0, 0(a0)       # Loads enable byte
        beqz t0, EXPLOSION_SPAWN_LOOP_ACTIVATE # If current explosion is disabled, activate it
            j NEXT_IN_EXPLOSION_SPAWN_LOOP     # Otherwise, go to next one in loop

        EXPLOSION_SPAWN_LOOP_ACTIVATE:
            li t0,1          # Loads 1 (Enabled) 
            sb t0,0(a0)      # stores in explosion's enable byte

            sb t3,1(a0)      # Stores explosion's type (0 - Small, 1 - Big)

            sb t4, 3(a0)     # Stores explosion's X offset
            sb t5, 4(a0)     # Stores explosion's Y offset

            sb a3, 5(a0)     # Stores explosion's X 
            sb a3, 6(a0)     # Stores explosion's old X 

            sb a4, 7(a0)     # Stores explosion's Y 
            sb a4, 8(a0)     # Stores explosion's old Y   

            neg a5,a5        # If a5 > 0, a5 < 0
            sb a5,2(a0)      # Sets counter (0 - normal / negative for delay)
            j END_EXPLOSION_SPAWN_LOOP # Break Loop       

        NEXT_IN_EXPLOSION_SPAWN_LOOP:
            addi a0,a0,explosion_size      # Going to the next explosion address                                  
            addi a2,a2,1                   # Iterating counter by 1                                   
            bge a2,a1, END_EXPLOSION_SPAWN_LOOP # If all of the explosions were checked, end loop (don't spawn explosion)                                
            j EXPLOSION_SPAWN_LOOP # otherwise, go back to the loop's beginning 

    END_EXPLOSION_SPAWN_LOOP:
    # Procedure finished, return
        ret        

##############        EXPLOSIONS OPERATIONS        ##############
#           Renders enabled bombs and moves them           #
#                                                          #		
#  ------------        registers used        ------------  #
#    a0 = EXPLOSIONS ARRAY address                              #
#    a1 = Number of bombs in current map                   #
#    a2 = Loop counter                                     #
#    tp = CURRENT_MAP's address                            #
#    t0 -- t6 = Temporary Registers                        #
#    a0 -- a7 => used as arguments                         #
#                                                          #
############################################################


EXPLOSIONS_OPERATIONS:
# Storing Registers on Stack
    addi sp,sp,-4
    sw ra,0(sp)
# End of Stack Operations
    la tp, CURRENT_MAP  # Loads CURRENT_MAP address

    la a0,EXPLOSION_ARRAY   # Loads explosions array

    li a2,0                 # resets counter
    li a1,explosion_number  # gets number of explosions in game
    EXPLOSIONS_OPERATIONS_LOOP:
        lbu t2,0(a0) # Loads enable byte
        bnez t2,EXPLOSIONS_OPERATIONS_LOOP_CONTINUE    # If enabled,
            j NEXT_IN_EXPLOSIONS_OPERATIONS_LOOP       # Otherwise, check other explosions

        EXPLOSIONS_OPERATIONS_LOOP_CONTINUE:
        # If procedure arrived here, render current explosion
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

            # Starting rendering procedure:
            # Calculating explosion's X related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lbu a1,5(a0) # Loads explosion's current X
            lbu t0,6(tp) # Loads map's current X
            sub a1,a1,t0 # Gets the X matrix related to the map's X (a1 = explosion's X - map's X)
            slli a1,a1,tile_size_shift # Multiplies a5 by 16 in order to get X related to screen
            lbu t0,3(a0) # Loads explosion's X offset
            add a1,a1,t0 # Adds offset to position
            lbu t0,8(tp) # Loads map's X offset
            sub a1,a1,t0 # and takes it from explosion's position
# dislocation?
            
            # Calculating Bomb's Y related to screen (may be negative, but this will be fixed in RENDER_ENTITY)
            lbu a2,7(a0) # Loads explosion's current Y
            lbu t1,7(tp) # Loads map's current Y
            sub a2,a2,t1 # Gets the Y matrix related to the map's Y (a2 = explosion's Y - map's Y)
            slli a2,a2,tile_size_shift # Multiplies a2 by 16 in order to get Y related to screen
            lbu t0,4(a0) # Loads explosion's Y offset
            add a2,a2,t0 # Adds offset to position
            lbu t1,9(tp) # Loads map's Y offset
            sub a2,a2,t1 # and takes it from explosion's position
            addi a2,a2,4 # Offsets sprite a little bit
            
            mv a5,s0          # gets frame to be rendered on
            li a7,0             # Normal render
            
            lbu t0,1(a0)      # Loads explosion type
            bnez t0,EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG  # If it's a big explosion
            # Otherwise it's a small explosion
                lb t0,2(a0)      # Gets number of times that it was rendered (counter)
                blt t0,zero,AFTER_EXPLOSIONS_OPERATIONS_LOOP_RENDER_SMALL  # If it has a delay
                bnez t0,EXPLOSIONS_OPERATIONS_LOOP_RENDER_SMALL_NOT_0  # If not on state 0
                # If it's the first time rendering, get small explosion sprite
                    la a0, Explosions_1   # Small explosion sprite
                    li a3,tile_size      # 16 = width of rendering area
                    li a4,tile_size      # 16 = height of rendering area
                    li a6, 1             # Small explosion section
                    j START_EXPLOSIONS_OPERATIONS_LOOP_RENDER_SMALL # Render

                EXPLOSIONS_OPERATIONS_LOOP_RENDER_SMALL_NOT_0:  li t1,1
                bne t0,t1,EXPLOSIONS_OPERATIONS_LOOP_RENDER_SMALL_NOT_1  # If not on state 1
                # If it's in the second state, don't render it 
                    j AFTER_EXPLOSIONS_OPERATIONS_LOOP_RENDER_SMALL # Skip render

                EXPLOSIONS_OPERATIONS_LOOP_RENDER_SMALL_NOT_1: # li t1,2
                # If it's in the last state, get big explosion sprite
                    la a0, Explosions_2   # Big explosion sprite
                    addi a1,a1,-8        # Offsetting sprite
                    addi a2,a2,-8        # Offsetting sprite
                    li a3,32             # 32 = width of rendering area
                    li a4,32             # 32 = height of rendering area
                    li a6, 0             # There's only one sprite for it
                    #j START_EXPLOSIONS_OPERATIONS_LOOP_RENDER_SMALL # Render

                START_EXPLOSIONS_OPERATIONS_LOOP_RENDER_SMALL:
                    call RENDER_ENTITY  # Renders it

                AFTER_EXPLOSIONS_OPERATIONS_LOOP_RENDER_SMALL:    
                    lw a0,16(sp)    # Restores a0
                    lb t0,2(a0)     # Gets number of times that it was rendered (counter)
                    addi t0,t0,1    # iterates it
                    sb t0,2(a0)     # and stores it back
                    li t1,small_explosion  # Loads number of times small explosion should render before being disabled
                    blt t0,t1,EXPLOSIONS_OPERATIONS_LOOP_AFTER_OPERATIONS  # If it didn't surpass the threshold, finish this part of loop
                    # Otherwise, set it to be disabled
                        sb zero,0(a0)  # Disables explosion
                        sb zero,2(a0)  # Resets render counter
                        j EXPLOSIONS_OPERATIONS_LOOP_AFTER_OPERATIONS

            EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG:
            # If it's a big explosion
                lb t0,2(a0)      # Gets number of times that it was rendered (counter)
                blt t0,zero,AFTER_EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG  # If it has a delay
                bnez t0,EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_0  # If not on state 0
                # If it's the first time rendering, get bomb exploding sprite
                    la a0, Explosions_1   # Small explosion sprite
                    li a3, tile_size     # 16 = width of rendering area
                    li a4, tile_size     # 16 = height of rendering area
                    li a6, 0             # Bomb exploding section
                    j START_EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG # Render

                EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_0:  li t1,1
                bne t0,t1,EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_1  # If not on state 1
                # If it's in the second state, don't render it 
                    j AFTER_EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG # Skips render

                EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_1: li t1,2
                bne t0,t1,EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_2  # If not on state 2
                # If it's in the third state, get small explosion sprite
                    la a0, Explosions_1   # Small explosion sprite
                    li a3, tile_size     # 16 = width of rendering area
                    li a4, tile_size     # 16 = height of rendering area
                    li a6, 1             # Small explosion section
                    j START_EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG # Render

                EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_2:  li t1,3
                bne t0,t1,EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_3  # If not on state 3
                # If it's in the fourth state, don't render it 
                    j AFTER_EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG # Skips render

                EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_3: li t1,4
                bne t0,t1,EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_4  # If not on state 4
                # If it's in the fith state, get big explosion sprite
                    la a0, Explosions_2   # Big explosion sprite
                    addi a1,a1,-8        # Offsetting sprite
                    addi a2,a2,-8        # Offsetting sprite
                    li a3,32             # 32 = width of rendering area
                    li a4,32             # 32 = height of rendering area
                    li a6, 0             # There's only one sprite for it
                    j START_EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG # Render

                EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_4:  li t1,5
                bne t0,t1,EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_5  # If not on state 5
                # If it's in the sixth state, don't render it 
                    j AFTER_EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG # Skips render

                EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG_NOT_5: # li t1,6
                # If it's in the last state, get big explosion sprite
                    la a0, Explosions_2   # Big explosion sprite
                    addi a1,a1,-8        # Offsetting sprite
                    addi a2,a2,-8        # Offsetting sprite
                    li a3,32             # 32 = width of rendering area
                    li a4,32             # 32 = height of rendering area
                    li a6, 0             # There's only one sprite for it
                    #j START_EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG # Render

                START_EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG:
                    call RENDER_ENTITY  # Renders it

                AFTER_EXPLOSIONS_OPERATIONS_LOOP_RENDER_BIG:    
                    lw a0,16(sp)    # Restores a0
                    lb t0,2(a0)    # Gets number of times that it was rendered (counter)
                    addi t0,t0,1    # iterates it
                    sb t0,2(a0)     # and stores it back
                    li t1,big_explosion  # Loads number of times big explosion should render before being disabled
                    blt t0,t1,EXPLOSIONS_OPERATIONS_LOOP_AFTER_OPERATIONS  # If it didn't surpass the threshold, finish this part of loop
                    # Otherwise, set it to be disabled
                        sb zero,0(a0)  # Disables explosion
                        sb zero,2(a0)  # Resets render counter
                        # j EXPLOSIONS_OPERATIONS_LOOP_AFTER_OPERATIONS
         
        EXPLOSIONS_OPERATIONS_LOOP_AFTER_OPERATIONS:
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

        NEXT_IN_EXPLOSIONS_OPERATIONS_LOOP:                    
            addi a0,a0,explosion_size  # Going to the next bomb's address                                  
            addi a2,a2,1               # Iterating counter by 1                                   
            bge a2,a1, END_EXPLOSIONS_OPERATIONS_LOOP # If all of the bombs were checked, end loop (don't attack)                                
            j EXPLOSIONS_OPERATIONS_LOOP # otherwise, go back to the loop's beginning 

    END_EXPLOSIONS_OPERATIONS_LOOP:
    # Procedure finished: Loading Registers from Stack
        lw ra,0(sp)
        addi sp,sp,4
    # End of Stack Operations   
        ret