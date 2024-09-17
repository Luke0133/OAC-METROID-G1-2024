###################        INPUT CHECK (for FPGA-DE1)        ####################
#     This procedure first checks for cheat inputs through the normal method    #
#   (KDMMIO_Ctrl here, but it's the same as the KDMMIO_ADDRESS), since player   #
#   doesn't need to press more than one key.
#                                                                               #
#  ------------------             registers used            ------------------  #
#    a0 = PLYR_STATUS address                                                   #
#    a1 = PLYR_POS address                                                      #
#    a4, a5, a6, a7 --> used as arguments for COLLISION_CHECK                   #      
#                                                                               #
#  ------------------          temporary registers          ------------------  #
#    t0, t1 --> temporary registers                                             #
#                                                                               #    
#################################################################################  

INPUT_CHECK:
    la a0, PLYR_STATUS   # Loads Player Status
    la a1, PLYR_POS      # Loads Player Pos

    # Uses normal KDMMIO_Ctrl address and the KDMMIO_Data (KDMMIO_Ctrl + 4) to detect cheat inputs
    li t1,KDMMIO_Ctrl  	  # KDMMIO Address
    lw t0, 0(t1)	      # Reads the Keyboard Control bit
    andi t0, t0, 0x0001	  # Masks the least significant bit  

    
    # Checking scene   
    li t2,1                # Menu2 number
    beq t2,s2,MENU2_CHECK  # If on menu2

    li t2,2                # Game scene number
    beq t2,s2,GAME_CHECK   # If on game

    li t2,3                     # Game over scene number
    beq t2,s2,GAME_OVER_CHECK   # If on game over

    GAME_CHECK:
        bnez t0, CONTINUE_GAME_CHECK    # If an input is detected, continue checking
        j NO_CHEAT_INPUT 		        # otherwise no input was detected, but check for other non-cheat inputs 

    GAME_OVER_CHECK:
        bnez t0, CONTINUE_GAME_OVER_CHECK   # If any input is detected, continue
            j END_INPUT_CHECK               # end procedure
        
        CONTINUE_GAME_OVER_CHECK:
        # If there was any input at all, change scene to menu2
            li s3,0
            li s2,1  
            j SETUP          # end procedure by going to setup

    MENU2_CHECK:
        bnez t0, CONTINUE_MENU2_CHECK       # If any input is detected, continue
        MENU2_NO_INPUT:
            j END_INPUT_CHECK               # end procedure

        CONTINUE_MENU2_CHECK:
            lw t0, 4(t1)   # Reads key value

            li t1, 'w'	   # Loads ascii value of 'w' key
            bne t0, t1, CHECK_INPUT.MENU2_S
                li s3,0
                j END_INPUT_CHECK               # end procedure

            CHECK_INPUT.MENU2_S:
            li t1, 's'	# Loads ascii value of 's' key
            bne t0, t1, CHECK_INPUT.MENU2_ENTER
                li s3,1
                j END_INPUT_CHECK               # end procedure

            CHECK_INPUT.MENU2_ENTER:
            li t1, '\n'	# Loads ascii value of ENTER key
            bne t0, t1, MENU2_NO_INPUT
                la t0,PLYR_INFO
                li t1, initial_player_health
                sb t1,0(t0)     # Map 1
                la t0, MAP_INFO # Loads Map Info address
                li t1,1         # Map 1
                sb t1, 0(t0)    # Stores map 1 number
                li t1,4         # 4 - Force switch
                sb t1, 1(t0)    # Stores render byte
                li s2,2  
                j SETUP                         # end procedure by going to setup


    CONTINUE_GAME_CHECK:
    lw t0, 4(t1)   # Reads key value
    # CHEAT INPUTS:
    CHECK_INPUT.1:
    li t1, '1'
    bne t0,t1, CHECK_INPUT.2
    j INPUT.1

    CHECK_INPUT.2:
    li t1, '2'
    bne t0,t1, CHECK_INPUT.3
    j INPUT.2

    CHECK_INPUT.3:
    li t1, '3'
    bne t0,t1, CHECK_INPUT.4
    j INPUT.3

    CHECK_INPUT.4:
    li t1, '4'
    bne t0,t1, CHECK_INPUT.5
    j INPUT.4

    CHECK_INPUT.5:
    li t1, '5'
    bne t0,t1, CHECK_INPUT.6
    j INPUT.5

    CHECK_INPUT.6:
    li t1, '6'
    bne t0,t1, CHECK_INPUT.7
    j INPUT.6

    CHECK_INPUT.7:
    li t1, '7'
    bne t0,t1, CHECK_INPUT.O
    j INPUT.7

    CHECK_INPUT.O:
    li t1, 'o'
    bne t0,t1, CHECK_INPUT.0
    j INPUT.O

    CHECK_INPUT.0:
    li t1, '0'	
    bne t0,t1, GOTO_NO_CHEAT_INPUT
    j INPUT.0 	

    GOTO_NO_CHEAT_INPUT: 
        j NO_CHEAT_INPUT
    
    INPUT.1: # Change to map 1
        la t0 MAP_INFO
        li t1, 1
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,0
        sb t1,1(a0)

        j SETUP

    INPUT.2: # Change to map 2
        la t0 MAP_INFO
        li t1, 2
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,0
        sb t1,1(a0)

        j SETUP

    INPUT.3: # Change to map 3
        la t0 MAP_INFO
        li t1, 3
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,0
        sb t1,1(a0)

        j SETUP

    INPUT.4: # Change to map 4
        la t0 MAP_INFO
        li t1, 4
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,0
        sb t1,1(a0)

        j SETUP

    INPUT.5: # Change to map 5
        la t0 MAP_INFO
        li t1, 5
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,1
        sb t1,1(a0)

        j SETUP

    INPUT.6: # Change to map 6
        la t0 MAP_INFO
        li t1, 6
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,1
        sb t1,1(a0)

        j SETUP

    INPUT.7: # Change to map 7
        la t0 MAP_INFO
        li t1, 7
        sb t1, 0(t0)
        li t1, 4
        sb t1, 1(t0)

        li t1,1
        sb t1,1(a0)

        j SETUP

    INPUT.O:
        li a0, 0    # open doors
        # li a1, 0  # won't be needed, since a0 = 0
        j CHANGE_DOORS_STATE

    INPUT.0: # Deals damage to player
        li a0,2
        li a1,10
        j DAMAGE_PLAYER
        j END_INPUT_CHECK


NO_CHEAT_INPUT:
# If no cheat input was detected, use the KeyMap0, KeyMap1, KeyMap2 e KeyMap3 addresses to find what key is being pressed
    li a2,KeyMap0	# Loads KEY0 address   (1<<(code))
    lw a2,0(a2)     # and loads its contents to a2
    
	li a3,KeyMap1	# Loads KEY1 address   (1<<(code - 32))
    lw a3,0(a3)     # and loads its contents to a3

	li a4,KeyMap2	# Loads KEY2 address   (1<<(code - 64))
    lw a4,0(a4)     # and loads its contents to a4

	li a5,KeyMap3	# Loads KEY3 address   (1<<(code - 96))
    lw a5,0(a5)     # and loads its contents to a5
	
    or t4,a2,a3     # t4 == 0 only if there's no input in a2 and a3
    or t4,t4,a4     # t4 == 0 only if there's no input in a2, a3 and a4
    or t4,t4,a5     # t4 == 0 only if there's no input in a2, a3, a4 and a5
    
    li a6,0         # Sets a6 to 0 (no key was pressed) as a default
    bnez t4,CONTINUE_NO_CHEAT_INPUT_CHECK  # If there's any input at all
    # If t4 == 0 only if there's no input in a2, a3, a4 and a5, so end procedure
    NO_INPUT:
        la t0, PLYR_INPUT # Loads PLYR_INPUT address
        beqz a6,CONTINUE_NO_INPUT   # If no key was pressed
        # Otherwise, a6 == 1 and a key was pressed
            lbu t2,0(t0)      # Loads PLYR_INPUT's value
            bnez t2, DONT_UPDATE_PLYR_INPUT  # If it isn't 0, don't update it
                li t2, 1      # Otherwise, there's input
                sb t2, 0(t0)  # store it
            DONT_UPDATE_PLYR_INPUT:
                j END_INPUT_CHECK   # End input check

        CONTINUE_NO_INPUT:
        li t2, 0   # There isn't input
        sb t2, 0(t0) 

        la a0, PLYR_STATUS      # Loads Player Status
        li t1, 0        # Loads vertical direction (0 = normal)
        sb t1, 2(a0)    # Stores new direction on PLYR_STATUS

        sb t1, 5(a0)                  
	    sb zero, 6(a0)      # Stores new direction on MOVE_X
        j END_INPUT_CHECK 

    CONTINUE_NO_CHEAT_INPUT_CHECK:
    # Otherwise, continue

    li tp,1         # Number that will be shifted for comparisions
    
    # Checking W
    li t4,0x1D      # W sanscode        
    sll t4,tp,t4    # (1<<(29))
    and t4,t4,a2    # will be !=0 if W is being pressed
    bnez t4,INPUT.W # if pressing W
        j CHECK_INPUT.A # Otherwise, check if A was pressed

    INPUT.W:  # Looking Up
        li a6,1         # Sets a6 to 1 (a key was pressed)
        lbu t4, 4(a0) # Loads player's abilities
        beqz t4, W.NOT_MORPH_BALL # t4 != 0 ? BALL = OFF : BALL = ON (If on ball mode, deactivate it)
        # Storing Registers on Stack
            addi sp,sp,-4
            sw ra,0(sp)
        # End of Stack Operations
            call OUT_OF_MORPH_BALL      # Only changes temporary 
        # Procedure finished: Loading Registers from Stack
            lw ra,0(sp)
            addi sp,sp,4
        # End of Stack Operations   
            j CHECK_INPUT.A
        W.NOT_MORPH_BALL:
        li t4, 1      # Loads vertical direction (1 = up)
        sb t4, 2(a0)  # Stores new direction on PLYR_STATUS
	    # j CHECK_INPUT.A
    
    CHECK_INPUT.A:
    # Checking A
    li t4,0x1C      # A sanscode        
    sll t4,tp,t4    # (1<<(28))
    and t4,t4,a2    # will be !=0 if A is being pressed
    bnez t4,INPUT.A # if pressing A
        j CHECK_INPUT.D # Otherwise, check if D was pressed
	
    INPUT.A: # Moves player left
        li a6,1         # Sets a6 to 1 (a key was pressed)
        li t4, -1     # Loads direction for MOVE_X (-1 = left)
        sb t4, 6(a0)  # Stores new direction on MOVE_X
        j CHECK_INPUT.S # If A was pressed, ignore D   (muahhahahahahah)   

    CHECK_INPUT.D:
    # Checking D
    li t4,0x23      # D sanscode  
    addi t4,t4,-32  # adjusts it for comparision      
    sll t4,tp,t4    # (1<<(0x23 - 32))
    and t4,t4,a3    # will be !=0 if D is being pressed
    bnez t4,INPUT.D # if pressing D
        j CHECK_INPUT.S # Otherwise, check if S was pressed

    INPUT.D:          # Moves player right
        li a6,1         # Sets a6 to 1 (a key was pressed)
        li t4, 1      # Loads direction for MOVE_X (1 = right)
        sb t4, 6(a0)  # Stores new direction on MOVE_X
        # j CHECK_INPUT.S 
	
    CHECK_INPUT.S:
    # Checking S
    li t4,0x1B      # S sanscode        
    sll t4,tp,t4    # (1<<(27))
    and t4,t4,a2    # will be !=0 if S is being pressed
    bnez t4,INPUT.S # if pressing S
        j CHECK_INPUT.SPACE # Otherwise, check if Space was pressed

    INPUT.S:
        li a6,1         # Sets a6 to 1 (a key was pressed)
        lbu t4, -1(a1) # Loads player's abilities
        lb t5, 7(a0)  # Loads direction on MOVE_Y
        slt t4, zero, t4 # t4 > 0 ? t4=1 : t4=0 --> if t4 = 1 or 2 (morph ball ability aquired) then go into morph ball
        
        bnez t5, SkipMorphBallTransformation
        beqz t4, SkipMorphBallTransformation 
        lb t4, 4(a0) # loads ball mode 
        bnez t4, SkipMorphBallTransformation
        # Storing Registers on Stack
            addi sp,sp,-4
            sw ra,0(sp)
        # End of Stack Operations
            call INTO_MORPH_BALL      # Only changes temporary 
        # Procedure finished: Loading Registers from Stack
            lw ra,0(sp)
            addi sp,sp,4
        # End of Stack Operations
        SkipMorphBallTransformation:
        # j CHECK_INPUT.SPACE
    
    CHECK_INPUT.SPACE:
    # Checking SPACE
    li t4,0x29      # SPACE sanscode  
    addi t4,t4,-32  # adjusts it for comparision      
    sll t4,tp,t4    # (1<<(0x23 - 32))
    and t4,t4,a3    # will be !=0 if SPACE is being pressed
    bnez t4,INPUT.SPACE # if pressing SPACE
        j CHECK_INPUT.K # Otherwise, check if K was pressed
	
    INPUT.SPACE:
        li a6,1         # Sets a6 to 1 (a key was pressed)
        lb t4, 4(a0) # loads ball mode 
        beqz t4, SPACE.NOT_MORPH_BALL
        # Storing Registers on Stack
            addi sp,sp,-4
            sw ra,0(sp)
        # End of Stack Operations
            call OUT_OF_MORPH_BALL      # Only changes temporary 
        # Procedure finished: Loading Registers from Stack
            lw ra,0(sp)
            addi sp,sp,4
        # End of Stack Operations   
            j CHECK_INPUT.K
        SPACE.NOT_MORPH_BALL:
            lb t1, 7(a0)  # Loads current direction on MOVE_Y
            beqz t1, CAN_JUMP
            j CHECK_INPUT.K
            CAN_JUMP:
                li t1, 1     # Loads ground position (1 = freefall)
                sb t1, 3(a0) # Stores new direction on PLYR_STATUS
        
                li t1, -1      # Loads direction for MOVE_Y (-1 = up)
                sb t1, 7(a0)   # Stores new direction on MOVE_Y
                
                # USES FLOATING POINT OPERATIONS
                fmv.s fs2,fs1  # Sets fs2 (player's Y speed) to -9 
	            # j CHECK_INPUT.K
	
    CHECK_INPUT.K:
    # Checking K
    li t4,0x42      # K sanscode  
    addi t4,t4,-64  # adjusts it for comparision      
    sll t4,tp,t4    # (1<<(0x23 - 64))
    and t4,t4,a4    # will be !=0 if K is being pressed
    bnez t4,INPUT.K # if pressing K
        j CHECK_INPUT.J # Otherwise, check if J was pressed

    INPUT.K: # Shoots
        li a6,1            # Sets a6 to 1 (a key was pressed)
        lb t4, 4(a0)       # loads ball mode 
        beqz t4, K.SHOOT   # If standing
            lbu t3,-1(a1)  # Loads number of abilities
            li t1,3        # Number where bomb ability is aquired
            bge t3,t1,K.PLACE_BOMB   # If player can place bombs
                j CHECK_INPUT.J      # otherwise, skip it
        
        K.PLACE_BOMB: # If in ball mode and has bomb hability
            # Storing Registers on Stack
                addi sp,sp,-32
                sw a6,28(sp)
                sw a5,24(sp)
                sw a4,20(sp)
                sw a3,16(sp)
                sw a2,12(sp)
                sw a1,8(sp)
                sw a0,4(sp)
                sw ra,0(sp)
            # End of Stack Operations
                call BOMB_SPAWN
            # Procedure finished: Loading Registers from Stack
                lw a6,28(sp)
                lw a5,24(sp)
                lw a4,20(sp)
                lw a3,16(sp)
                lw a2,12(sp)
                lw a1,8(sp)
                lw a0,4(sp)
                lw ra,0(sp)
                addi sp,sp,32
            # End of Stack Operations  
                j CHECK_INPUT.J    
   
        K.SHOOT:    
            li t4, 1     # Loads attacking status (1 = attacking)
            sb t4, 5(a0) # Stores new attack status on PLYR_STATUS
            # Storing Registers on Stack
                addi sp,sp,-32
                sw a6,28(sp)
                sw a5,24(sp)
                sw a4,20(sp)
                sw a3,16(sp)
                sw a2,12(sp)
                sw a1,8(sp)
                sw a0,4(sp)
                sw ra,0(sp)
            # End of Stack Operations
                call BEAM_SPAWN
            # Procedure finished: Loading Registers from Stack
                lw a6,28(sp)
                lw a5,24(sp)
                lw a4,20(sp)
                lw a3,16(sp)
                lw a2,12(sp)
                lw a1,8(sp)
                lw a0,4(sp)
                lw ra,0(sp)
                addi sp,sp,32
            # End of Stack Operations  
            #    j CHECK_INPUT.J     

    CHECK_INPUT.J:
    # Checking J
    li t4,0x3B      # J sanscode  
    addi t4,t4,-32  # adjusts it for comparision      
    sll t4,tp,t4    # (1<<(0x23 - 64))
    and t4,t4,a3    # will be !=0 if J is being pressed
    bnez t4,INPUT.J # if pressing J
        j NO_INPUT  # There's no input


    INPUT.J:   # Switches to missile mode (if available)
        li a6,1         # Sets a6 to 1 (a key was pressed)
        la t5, PLYR_INFO_2    # Loads address to PLYR_INFO_2
        lbu t4,1(t5)          # Loads missile cooldown
        bnez t4,SKIP_ENABLE_MISSILE  # If cooldown != 0, don't enable byte
            lbu t6,0(t5)          # Loads missile enable byte
            xori t6,t6,1          # Switches its value
            sb t6,0(t5)           # and stores it back
        SKIP_ENABLE_MISSILE:
            xori t4,t4,1      # Switches cooldown value
            sb t4,1(t5)       # and stores it back
        j NO_INPUT   # needs to go there for last check :/

 
	END_INPUT_CHECK:
		ret	