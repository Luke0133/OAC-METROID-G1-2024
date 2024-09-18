.text

# ----> Summary: setup.s has setup related procedures
# 1 - SETUP (Sets up game by rendering maps and attributing default values)
# 2 - UPDATE DOORS (Updates status of doors when necessary)


#####################          SETUP          ######################
#   Sets up game by rendering maps and attributing default values  #
#                                                                  #		
#  ----------------        registers used        ----------------  #
#    t1 -- t5,tp = Temporary Registers                             #
#    a0 -- a7 => used as arguments                                 #
#                                                                  #
####################################################################

SETUP:
	li t1,1	
	la t0,Brinstar
	sb t1,0(t0)	

    # call MUSIC.SETUP    # If using music.s

    # Checking scente
    li t1,1                # Menu 2 scene number
    beq t1,s2,SETUP_MENU2  # If on game menu 2

    li t1,2                # Game scene number
    beq t1,s2,SETUP_GAME   # If on game

    li t1,3                     # Game over scene number
    beq t1,s2,SETUP_GAME_OVER   # If on game over

    SETUP_MENU2:
        j MENU2_LOOP

    SETUP_GAME_OVER:
        #j GAME_OVER_LOOP
        j GAME_OVER_LOOP_PREP

    SETUP_GAME:

    # Setting Render Next Map Door to zero
    la t0, NEXT_MAP   # Loads NEXT_MAP address
    sb zero,10(t0)    # Stores 0 on Render Next Map Door (in order to render current map's doors properly)

    # Getting informations about Current Map
    la t0, MAP_INFO # Loads Map Info address
    lbu t1, 0 (t0)  # Loads byte related to map number
    lbu t2, 1 (t0)  # Loads rendering byte (0 - don't render, 1 - render once, 2 - render twice, 
                    # 3 - switch map (through door), 4 - switch map (through cheat input)) 
                   
    la t4, Doors    # Doors info address
    la t5, Frames   # Frames info address

    li t0, 1 
    bne t0, t1, SKIP_MAP1_SETUP 
    j MAP1_SETUP
    
    SKIP_MAP1_SETUP:
        li t0, 2 
        bne t0, t1, SKIP_MAP2_SETUP 
        j MAP2_SETUP

    SKIP_MAP2_SETUP:
        li t0, 3 
        bne t0, t1, SKIP_MAP3_SETUP 
        j MAP3_SETUP

    SKIP_MAP3_SETUP:
        li t0, 4
        bne t0, t1, SKIP_MAP4_SETUP 
        j MAP4_SETUP
    
    SKIP_MAP4_SETUP:
        li t0, 5 
        bne t0, t1, SKIP_MAP5_SETUP 
        j MAP5_SETUP
    
    SKIP_MAP5_SETUP:
        li t0, 6
        bne t0, t1, SKIP_MAP6_SETUP 
        j MAP6_SETUP

    SKIP_MAP6_SETUP:
            li t0, 7 
            bne t0, t1, SKIP_MAP7_SETUP 
            j MAP7_SETUP

    SKIP_MAP7_SETUP:    # If no correct color is detected, an error screen is thrown
        li a0, 7
        li a1, 0
        li a2, 0
        li a3, 320
        li a4, 240
        li a5, 0
        li a6, 0	
    
        call RENDER_COLOR

        li a0, 7
        li a1, 0
        li a2, 0
        li a3, 320
        li a4, 240
        li a5, 1
        li a6, 0
        call RENDER_COLOR
	
	    li a0, 3000
	    li a7,32
	    ecall
	    li a7, 10
        ecall	    					
    
    MAP1_SETUP:
        la t0, Doors1   # Doors address
        sw t0,0(t4)     # Stores Doors1 address on Doors address

        la t0, Frames1  # Frames address
        sw t0,0(t5)     # Stores Frames1 address on Doors address

        la t0,Zoomers   # Zoomers address
        la t1,Zoomers1  # Loads Zoomers1 address for Map 1
        sw t1,0(t0)     # and stores it

        la t0,Rippers   # Rippers address
        sw zero,0(t0)   # Stores 0 to it (no rippers)

        la t0,Blocks    # Blocks address
        sw zero,0(t0)   # Stores 0 to it (no breakable blocks)

        la a0, Map1 	# Map Address     
        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        sw a0, 0(t0)    # Stores Map1 address on CURRENT_MAP
        
        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map	

        li t1, 4
        bne t2, t1 CONTINUE_MAP1_SETUP
        # If t2 = 4, player and map's coordinates are changed
            li t2, 2
            sb t2, 5 (t0)  # Stores new rendering byte (2 - render twice) 

            # Reseting map's coordinates
            li a1, resetmap1X
            sb a1, 6(t0)   # Stores new X on Map (starting X on Matrix (top left))
            li a2, resetmap1Y
            sb a2, 7(t0)   # Stores new Y on Map (starting Y on Matrix (top left))	
            li a3, resetmap1Xoff
            sb a3, 8(t0)   # Stores new X offset on Map
            li a4, resetmap1Yoff
            sb a4, 9(t0)   # Stores new Y offset on Map	

            # Reseting player's coordinates
            la t0, PLYR_POS
            li t1, resetmap1plyrXscreen
            sh t1, 0(t0)   # Stores new player's X related to the screen
            li t1, resetmap1plyrYscreen
            sb t1, 4(t0)   # Stores new player's Y related to the screen

            li t1, resetmap1plyrXoff    
            sb t1, 6(t0)   # Stores new player's X offset
            li t1, resetmap1plyrYoff
            sb t1, 7(t0)   # Stores new player's Y offset

            li t1, resetmap1plyrX
            sb t1, 8(t0)   # Stores new player's X related to the matrix
            li t1, resetmap1plyrY
            sb t1, 10(t0)  # Stores new player's Y related to the matrix

        CONTINUE_MAP1_SETUP:
        li a5, 0		# Frame = 0
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated
        
        call RENDER_MAP
  
        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map
        li a5, 1		# Frame = 0
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated

        call RENDER_MAP

        j END_SETUP

    MAP2_SETUP:
        la t0, Doors2   # Doors address
        sw t0,0(t4)     # Stores Doors2 address on Doors address

        la t0, Frames2  # Frames address
        sw t0,0(t5)     # Stores Frames2 address on Doors address

        la t0,Zoomers   # Zoomers address
        la t1,Zoomers2  # Loads Zoomers2 address for Map 2
        sw t1,0(t0)     # and stores it

        la t0,Rippers   # Rippers address
        la t1,Rippers2  # Loads Rippers2 address for Map 2
        sw t1,0(t0)     # and stores it
        
        la t0,Blocks    # Blocks address
        la t1,Blocks2   # Loads Blocks2 address for Map 2
        sw t1,0(t0)     # and stores it

        la a0, Map2 	# Map Address     
        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        sw a0, 0(t0)    # Stores Map2 address on CURRENT_MAP

        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map		
        
        li t1, 4
        bne t2, t1 CONTINUE_MAP2_SETUP
        # If t2 = 4, player and map's coordinates are changed
            li t2, 2
            sb t2, 5 (t0)  # Stores new rendering byte (2 - render twice) 

            # Reseting map's coordinates
            li a1, resetmap2X
            sb a1, 6(t0)   # Stores new X on Map (starting X on Matrix (top left))
            li a2, resetmap2Y
            sb a2, 7(t0)   # Stores new Y on Map (starting Y on Matrix (top left))	
            li a3, resetmap2Xoff
            sb a3, 8(t0)   # Stores new X offset on Map
            li a4, resetmap2Yoff
            sb a4, 9(t0)   # Stores new Y offset on Map	

            # Reseting player's coordinates
            la t0, PLYR_POS
            li t1, resetmap2plyrXscreen
            sh t1, 0(t0)   # Stores new player's X related to the screen
            li t1, resetmap2plyrYscreen
            sb t1, 4(t0)   # Stores new player's Y related to the screen

            li t1, resetmap2plyrXoff    
            sb t1, 6(t0)   # Stores new player's X offset
            li t1, resetmap2plyrYoff
            sb t1, 7(t0)   # Stores new player's Y offset

            li t1, resetmap2plyrX
            sb t1, 8(t0)   # Stores new player's X related to the matrix
            li t1, resetmap2plyrY
            sb t1, 10(t0)  # Stores new player's Y related to the matrix

        CONTINUE_MAP2_SETUP:
        li a5, 0		# Frame = 0
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated

        call RENDER_MAP

        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map	
        li a5, 1		# Frame = 1
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated
        call RENDER_MAP

        j END_SETUP

    MAP3_SETUP:
        la t0, Doors3   # Doors address
        sw t0,0(t4)     # Stores Doors3 address on Doors address

        la t0, Frames3  # Frames address
        sw t0,0(t5)     # Stores Frames3 address on Doors address

        la t0,Zoomers   # Zoomers address
        la t1,Zoomers3  # Loads Zoomers3 address for Map 3
        sw t1,0(t0)     # and stores it

        la t0,Rippers   # Rippers address
        sw zero,0(t0)   # Stores 0 to it (no rippers)

        la t0,Blocks    # Blocks address
        sw zero,0(t0)   # Stores 0 to it (no breakable blocks)

        la a0, Map3 	# Map Address     
        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        sw a0, 0(t0)    # Stores Map3 address on CURRENT_MAP

        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map		
        
        li t1, 4
        bne t2, t1 CONTINUE_MAP3_SETUP
        # If t2 = 4, player and map's coordinates are changed
            li t2, 2
            sb t2, 5 (t0)  # Stores new rendering byte (2 - render twice) 

            # Reseting map's coordinates
            li a1, resetmap3X
            sb a1, 6(t0)   # Stores new X on Map (starting X on Matrix (top left))
            li a2, resetmap3Y
            sb a2, 7(t0)   # Stores new Y on Map (starting Y on Matrix (top left))	
            li a3, resetmap3Xoff
            sb a3, 8(t0)   # Stores new X offset on Map
            li a4, resetmap3Yoff
            sb a4, 9(t0)   # Stores new Y offset on Map	

            # Reseting player's coordinates
            la t0, PLYR_POS
            li t1, resetmap3plyrXscreen
            sh t1, 0(t0)   # Stores new player's X related to the screen
            li t1, resetmap3plyrYscreen
            sb t1, 4(t0)   # Stores new player's Y related to the screen

            li t1, resetmap3plyrXoff    
            sb t1, 6(t0)   # Stores new player's X offset
            li t1, resetmap3plyrYoff
            sb t1, 7(t0)   # Stores new player's Y offset

            li t1, resetmap3plyrX
            sb t1, 8(t0)   # Stores new player's X related to the matrix
            li t1, resetmap3plyrY
            sb t1, 10(t0)  # Stores new player's Y related to the matrix

        CONTINUE_MAP3_SETUP:
        li a5, 0		# Frame = 0
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated

        call RENDER_MAP

        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map	
        li a5, 1		# Frame = 1
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated
        call RENDER_MAP

        j END_SETUP


    MAP4_SETUP:
        la t0, Doors4   # Doors address
        sw t0,0(t4)     # Stores Doors4 address on Doors address

        la t0, Frames4  # Frames address
        sw t0,0(t5)     # Stores Frames4 address on Doors address

        la t0,Zoomers   # Zoomers address
        la t1,Zoomers4  # Loads Zoomers4 address for Map 4
        sw t1,0(t0)     # and stores it

        la t0,Rippers   # Rippers address
        la t1,Rippers4  # Loads Rippers4 address for Map 4
        sw t1,0(t0)     # and stores it

        la t0,Blocks    # Blocks address
        sw zero,0(t0)   # Stores 0 to it (no breakable blocks)
                
        la a0, Map4 	# Map Address     
        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        sw a0, 0(t0)    # Stores Map4 address on CURRENT_MAP

        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map		
        
        li t1, 4
        bne t2, t1 CONTINUE_MAP4_SETUP
        # If t2 = 4, player and map's coordinates are changed
            li t2, 2
            sb t2, 5 (t0)  # Stores new rendering byte (2 - render twice) 

            # Reseting map's coordinates
            li a1, resetmap4X
            sb a1, 6(t0)   # Stores new X on Map (starting X on Matrix (top left))
            li a2, resetmap4Y
            sb a2, 7(t0)   # Stores new Y on Map (starting Y on Matrix (top left))	
            li a3, resetmap4Xoff
            sb a3, 8(t0)   # Stores new X offset on Map
            li a4, resetmap4Yoff
            sb a4, 9(t0)   # Stores new Y offset on Map	

            # Reseting player's coordinates
            la t0, PLYR_POS
            li t1, resetmap4plyrXscreen
            sh t1, 0(t0)   # Stores new player's X related to the screen
            li t1, resetmap4plyrYscreen
            sb t1, 4(t0)   # Stores new player's Y related to the screen

            li t1, resetmap4plyrXoff    
            sb t1, 6(t0)   # Stores new player's X offset
            li t1, resetmap4plyrYoff
            sb t1, 7(t0)   # Stores new player's Y offset

            li t1, resetmap4plyrX
            sb t1, 8(t0)   # Stores new player's X related to the matrix
            li t1, resetmap4plyrY
            sb t1, 10(t0)  # Stores new player's Y related to the matrix

        CONTINUE_MAP4_SETUP:
        li a5, 0		# Frame = 0
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated

        call RENDER_MAP

        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map	
        li a5, 1		# Frame = 1
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated
        call RENDER_MAP

        j END_SETUP

    MAP5_SETUP:
        la t0, Doors5   # Doors address
        sw t0,0(t4)     # Stores Doors5 address on Doors address

        la t0, Frames5  # Frames address
        sw t0,0(t5)     # Stores Frames5 address on Doors address

        la t0,Zoomers   # Zoomers address
        la t1,Zoomers5  # Loads Zoomers5 address for Map 5
        sw t1,0(t0)     # and stores it

        la t0,Rippers   # Rippers address
        sw zero,0(t0)   # Stores 0 to it (no rippers)

        la t0,Blocks    # Blocks address
        sw zero,0(t0)   # Stores 0 to it (no breakable blocks)
        
        la a0, Map5 	# Map Address     
        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        sw a0, 0(t0)    # Stores Map5 address on CURRENT_MAP

        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map		
        
        li t1, 4
        bne t2, t1 CONTINUE_MAP5_SETUP
        # If t2 = 4, player and map's coordinates are changed
            li t2, 2
            sb t2, 5 (t0)  # Stores new rendering byte (2 - render twice) 

            # Reseting map's coordinates
            li a1, resetmap5X
            sb a1, 6(t0)   # Stores new X on Map (starting X on Matrix (top left))
            li a2, resetmap5Y
            sb a2, 7(t0)   # Stores new Y on Map (starting Y on Matrix (top left))	
            li a3, resetmap5Xoff
            sb a3, 8(t0)   # Stores new X offset on Map
            li a4, resetmap5Yoff
            sb a4, 9(t0)   # Stores new Y offset on Map	

            # Reseting player's coordinates
            la t0, PLYR_POS
            li t1, resetmap5plyrXscreen
            sh t1, 0(t0)   # Stores new player's X related to the screen
            li t1, resetmap5plyrYscreen
            sb t1, 4(t0)   # Stores new player's Y related to the screen

            li t1, resetmap5plyrXoff    
            sb t1, 6(t0)   # Stores new player's X offset
            li t1, resetmap5plyrYoff
            sb t1, 7(t0)   # Stores new player's Y offset

            li t1, resetmap5plyrX
            sb t1, 8(t0)   # Stores new player's X related to the matrix
            li t1, resetmap5plyrY
            sb t1, 10(t0)  # Stores new player's Y related to the matrix

        CONTINUE_MAP5_SETUP:
        li a5, 0		# Frame = 0
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated

        call RENDER_MAP

        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map	
        li a5, 1		# Frame = 1
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated
        call RENDER_MAP

        j END_SETUP
        
    MAP6_SETUP:
        la t0, Doors6   # Doors address
        sw t0,0(t4)     # Stores Doors6 address on Doors address

        la t0, Frames6  # Frames address
        sw t0,0(t5)     # Stores Frames6 address on Doors address

        la t0,Zoomers   # Zoomers address
        sw zero,0(t0)   # Stores 0 to it (no zoomers)

        la t0,Rippers   # Rippers address
        sw zero,0(t0)   # Stores 0 to it (no rippers)

        la t0,Blocks    # Blocks address
        sw zero,0(t0)   # Stores 0 to it (no breakable blocks)
        
        la a0, Map6 	# Map Address     
        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        sw a0, 0(t0)    # Stores Map6 address on CURRENT_MAP

        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map		
        
        li t1, 4
        bne t2, t1 CONTINUE_MAP6_SETUP
        # If t2 = 4, player and map's coordinates are changed
            li t2, 2
            sb t2, 5 (t0)  # Stores new rendering byte (2 - render twice) 

            # Reseting map's coordinates
            li a1, resetmap6X
            sb a1, 6(t0)   # Stores new X on Map (starting X on Matrix (top left))
            li a2, resetmap6Y
            sb a2, 7(t0)   # Stores new Y on Map (starting Y on Matrix (top left))	
            li a3, resetmap6Xoff
            sb a3, 8(t0)   # Stores new X offset on Map
            li a4, resetmap6Yoff
            sb a4, 9(t0)   # Stores new Y offset on Map	

            # Reseting player's coordinates
            la t0, PLYR_POS
            li t1, resetmap6plyrXscreen
            sh t1, 0(t0)   # Stores new player's X related to the screen
            li t1, resetmap6plyrYscreen
            sb t1, 4(t0)   # Stores new player's Y related to the screen

            li t1, resetmap6plyrXoff    
            sb t1, 6(t0)   # Stores new player's X offset
            li t1, resetmap6plyrYoff
            sb t1, 7(t0)   # Stores new player's Y offset

            li t1, resetmap6plyrX
            sb t1, 8(t0)   # Stores new player's X related to the matrix
            li t1, resetmap6plyrY
            sb t1, 10(t0)  # Stores new player's Y related to the matrix

        CONTINUE_MAP6_SETUP:
        li a5, 0		# Frame = 0
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated
        call RENDER_MAP

        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map	
        li a5, 1		# Frame = 1
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated 
        call RENDER_MAP

        j END_SETUP
        
    MAP7_SETUP:
        la t0, Doors7   # Doors address
        sw t0,0(t4)     # Stores Doors1 address on Doors address

        la t0, Frames7  # Frames address
        sw t0,0(t5)     # Stores Frames7 address on Doors address

        la t0,Zoomers   # Zoomers address
        sw zero,0(t0)   # Stores 0 to it (no zoomers)

        la t0,Rippers   # Rippers address
        sw zero,0(t0)   # Stores 0 to it (no rippers)

        la t0,Blocks    # Blocks address
        sw zero,0(t0)   # Stores 0 to it (no breakable blocks)
        
        la a0, Map7 	# Map Address     
        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        sw a0, 0(t0)    # Stores Map7 address on CURRENT_MAP

        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map		
        
        li t1, 4
        bne t2, t1 CONTINUE_MAP7_SETUP
        # If t2 = 4, player and map's coordinates are changed
            li t2, 2
            sb t2, 5 (t0)  # Stores new rendering byte (2 - render twice) 

            # Reseting map's coordinates
            li a1, resetmap7X
            sb a1, 6(t0)   # Stores new X on Map (starting X on Matrix (top left))
            li a2, resetmap7Y
            sb a2, 7(t0)   # Stores new Y on Map (starting Y on Matrix (top left))	
            li a3, resetmap7Xoff
            sb a3, 8(t0)   # Stores new X offset on Map
            li a4, resetmap7Yoff
            sb a4, 9(t0)   # Stores new Y offset on Map	

            # Reseting player's coordinates
            la t0, PLYR_POS
            li t1, resetmap7plyrXscreen
            sh t1, 0(t0)   # Stores new player's X related to the screen
            li t1, resetmap7plyrYscreen
            sb t1, 4(t0)   # Stores new player's Y related to the screen

            li t1, resetmap7plyrXoff    
            sb t1, 6(t0)   # Stores new player's X offset
            li t1, resetmap7plyrYoff
            sb t1, 7(t0)   # Stores new player's Y offset

            li t1, resetmap7plyrX
            sb t1, 8(t0)   # Stores new player's X related to the matrix
            li t1, resetmap7plyrY
            sb t1, 10(t0)  # Stores new player's Y related to the matrix

        CONTINUE_MAP7_SETUP:
        li a5, 0		# Frame = 0
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated
        call RENDER_MAP

        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	
        lbu a3, 8(t0)   # Loads current X offset on Map
        lbu a4, 9(t0)   # Loads current Y offset on Map	
        li a5, 1		# Frame = 1
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        li tp, 0        # Map won't be dislocated
        call RENDER_MAP

        j END_SETUP

END_SETUP:
    la t0, CURRENT_MAP   # Loads CURRENT_MAP address
    lbu t1,5(t0)         # Loads rendering byte     
    li t2, 3             # Loads 3 (switch map through door) to be compared with
    bne t1,t2, END_SETUP_NORMAL # If rendering byte != 3, return to game loop
        j LEAVE_DOOR_ANIMATION_PREP # Otherwise, finish map switch
    
    END_SETUP_NORMAL:
        # Resetting information  --  player coordinates have already been reset
        bnez s3,SKIP_ABILITY_RESET   # If clicking on continue, habilities will be kept
            la t0,PLYR_INFO
            sb zero,1(t0)     # Resets ability information

            la t0, ITEM_CAPSULE_INFO
            sb zero,0(t0)              # Restores capsule
        SKIP_ABILITY_RESET:
            li s3, 1       # If player's info was already reset
            la t0,MOVE_X
            sw zero,0(t0)  # Resets MOVE_X, MOVE_Y,JUMP byte and Player input byte

            la t0,PLYR_INFO_2
            sw zero,0(t0)
            sw zero,4(t0)
                
            call RESET_ENEMIES

            call RESET_BLOCKS

    j GAME_LOOP



###############          UPDATE DOORS          ###############
#           Updates status of doors when necessary           #
#                  (when their counter != 0)                 #		
#   ------------        registers used        ------------   #
#    a0 = Curent map's door address                          #
#    a1 = 0 - no major updates, 1 - change of state: render  #
#    tp = CURRENT_MAP address (located on main.s)		     #
#    t0 = Number of doors on current map                     #
#    t1 = Loop counter                                       #
#    t2 -- t6 = Temporary Registers                          #
#    a0 -- a7 => used as arguments                           #
#                                                            #
##############################################################

UPDATE_DOORS:
    la t0, Doors # Loads Doors address
	la tp, CURRENT_MAP # Loads CURRENT_MAP address
	lw a0,0(t0)   # Gets current map's doors address
	lbu t0,0(a0)  # Loads number of doors in this map
	addi a0,a0,1  # Goes to next byte (where doors from current map start)
	li t1,0       # Counter for doors
    li a1,0       # Default: won't render doors unless there's a change of state
    # Loop that will do from door to door and update them
    UPDATE_DOORS_LOOP:
        lb t2,3(a0)  # Loads C (counter) parameter
        blt t2,zero,UPDATE_DOORS_LOOP_COUNT_UP    # If counter is negative, iterate up
        bgt t2,zero,UPDATE_DOORS_LOOP_COUNT_DOWN  # If counter is positive, iterate down
            j NEXT_IN_UPDATE_DOORS_LOOP # Otherwise, counter is 0 and should stay this way
        UPDATE_DOORS_LOOP_COUNT_UP:  
        # Only case: door is on "opening" state (initial C = -2) and should go to "open" state when C = 0 
            addi t2,t2,1  # C++
            sb t2,3(a0)   # and stores updated C on door's counter byte
            bnez t2,NEXT_IN_UPDATE_DOORS_LOOP # If C != 0, go update next door
            # Otherwise, before updating next door, this door should go to "open" state
                li t2,2         # Loads 2 (open)
                sb t2,2(a0)     # and stores it on door's state byte
                li t2,open_door # Gets new counter (related to open door)
                sb t2,3(a0)     # and stores it on door's counter byte
                li a1,1         # Since status was updated, should render doors  
                j NEXT_IN_UPDATE_DOORS_LOOP  
        UPDATE_DOORS_LOOP_COUNT_DOWN:   
        # Two case: door is on "opening" state (initial C = 2) and should go to "closed" state when C = 0 
        #           door is on "open" state (initial C = 20) and should go to "closed" state when C = 0  
            addi t2,t2,-1  # C--
            sb t2,3(a0)    # and stores updated C on door's counter byte
            bnez t2,NEXT_IN_UPDATE_DOORS_LOOP # If C != 0, go update next door
            # Otherwise, before updating next door, check state of current door
                lbu t2,2(a0)  # Loads door's state byte
                addi t2,t2,-1 # If state is 2 -> 1; if state is 1 -> 0
                beqz t2, UPDATE_DOORS_LOOP_CHANGE_OPENING  # If t2 = 0, state was 1 (opening)
                # UPDATE_DOORS_LOOP_CHANGE_OPEN:
                # If state was open, it should go to opening state in order to close afterwards
                    li t2,1             # Loads 1 (opening)
                    sb t2,2(a0)         # and stores it on door's state byte
                    li t2,closing_door  # Gets new counter (related to opening door -- positive, in order to close)
                    sb t2,3(a0)         # and stores it on door's counter byte
                    li a1,1             # Since status was updated, should render doors  
                    j NEXT_IN_UPDATE_DOORS_LOOP 
                UPDATE_DOORS_LOOP_CHANGE_OPENING:
                # If state was opening, it should go to closed state
                    li t2,0         # Loads 0 (closed)
                    sb t2,2(a0)     # and stores it on door's state byte
                    # In order to be here, C parameter was set to 0 and is already stored, don't change that
                    li a1,1         # Since status was updated, should render doors  
                    # j NEXT_IN_UPDATE_DOORS_LOOP 
        
        NEXT_IN_UPDATE_DOORS_LOOP:                    
            addi a0,a0,4 # Going to the next door's address                                  
            addi t1,t1,1 # Iterating counter by 1                                   
            bge t1,t0, END_UPDATE_DOORS_LOOP # If all of the map's doors were checked, end loop                                  
            j UPDATE_DOORS_LOOP # otherwise, go back to the loop's beginning                     
    
    END_UPDATE_DOORS_LOOP:    
    # End of loop
        beqz a1,END_UPDATE_DOORS # If a1 is 0, doors shouldn't be rendered again
        li t0, 3        # To be compared with rendering byte (3 - switch map through doors)
        lbu t1, 5(tp)   # Loads CURRENT_MAP's rendering byte on t1
        beq t0,t1,END_UPDATE_DOORS # If rendering byte is 3, don't change it
        # Otherwise, set it to 2
        li t2, 2       # t2 = 2 (map will be rendered again)
        sb t2, 5(tp)   # Stores t3 on CURRENT_MAP's rendering byte
            
    END_UPDATE_DOORS: 
    # End of procedure, return        
        ret 


#############         CHANGE DOORS STATE           ###########
#           Opens or closes all door on current map          #
#   Takes two arguments, which will determine whether doors  #
#      should open or close (a0) and, should they close,     #
#  whether doors should have a fast or normal closing cycle  #   
#                                                            #	
#   ------------      argument registers      ------------   #
#    a0 = 0 to open all doors, 1 to close all doors          #
#    a1 = 0 - normal closing time, 1 - fast closing time     #	
#                                                            #	
#   ------------        registers used        ------------   #
#    a2 = Curent map's door address                          #
#    tp = CURRENT_MAP address (located on main.s)		     #
#    t0 = Number of doors on current map                     #
#    t1 = Loop counter                                       #
#    t2 = Temporary Registers                                #
#                                                            #
##############################################################

CHANGE_DOORS_STATE:
    la t0, Doors # Loads Doors address
	la tp, CURRENT_MAP # Loads CURRENT_MAP address
	lw a2,0(t0)   # Gets current map's doors address
	lbu t0,0(a2)  # Loads number of doors in this map
	addi a2,a2,1  # Goes to next byte (where doors from current map start)
    slli a1,a1,1  # Multiplies a1 by 2 

    li t1,0       # Counter for doors     
    # Loop that will open every door on map
    CHANGE_DOORS_STATE_LOOP:
        li t2,1       # Loads 1 (opening/closing)
        sb t2,2(a2)   # and stores it on door's state byte    
        beqz a0, CHANGE_DOORS_STATE_LOOP_OPEN_DOORS # If a0 = 0, open doors
        # Otherwise, close doors
            li t2,closing_door  # Gets new counter (related to closing door -- positive, in order to close)
            sub t2,t2,a1        # t2 = 4 if a1 is 0, otherwise, t2 = 2
            sb t2,3(a2)         # Stores C on door's counter byte
            j NEXT_IN_CHANGE_DOORS_STATE_LOOP 

        CHANGE_DOORS_STATE_LOOP_OPEN_DOORS:
            li t2,opening_door  # Gets new counter (related to opening door -- negative, in order to open)
            sb t2,3(a2)         # and stores it on door's counter byte
            # j NEXT_IN_CHANGE_DOORS_STATE_LOOP    
        NEXT_IN_CHANGE_DOORS_STATE_LOOP:                                  
        addi a2,a2,4 # Going to the next door's address                                  
        addi t1,t1,1 # Iterating counter by 1                                   
        bge t1,t0, END_CHANGE_DOORS_STATE_LOOP # If all of the map's doors were checked, end loop                                  
        j CHANGE_DOORS_STATE_LOOP # otherwise, go back to the loop's beginning                     
    
    END_CHANGE_DOORS_STATE_LOOP: 
        li t2, 2       # t2 = 2 (map will be rendered again)
        sb t2, 5(tp)   # Stores t3 on CURRENT_MAP's rendering byte
        ret  # End of procedure, return    


RESET_BLOCKS:
    la a0, Blocks2
    lbu t0,2(a0)
    lbu t1,3(a0)
    addi a0,a0,4
    mul a1,t0,t1   # Total number of iterations
    li t0,0
    RESET_BLOCKS_LOOP:
        lb t1,0(a0)
        li t2,-1
        beq t1,t2,NEXT_IN_RESET_BLOCKS_LOOP
            sb zero,0(a0)
        NEXT_IN_RESET_BLOCKS_LOOP:
            addi a0,a0,1
            addi t0,t0,1
            blt t0,a1,RESET_BLOCKS_LOOP
                ret        