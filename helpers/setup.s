.text

########################## SETUP ##########################

#########################################################################

SETUP:
    call MUSIC.SETUP

    la t0, MAP_INFO # Loads Map Info address
    lbu t1, 0 (t0)  # Loads byte related to map number
    lbu t2, 1 (t0)  # Loads rendering byte (0 - don't render, 1 - render once, 2 - render twice, 
                    # 3 - switch map (through door), 4 - switch map (through cheat input)) 

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

        call RENDER_MAP

        j END_SETUP

    MAP2_SETUP:
        la a0, Map2 	# Map Address
        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        sw a0, 0(t0)    # Stores Map1 address on CURRENT_MAP

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
        call RENDER_MAP

        j END_SETUP

    MAP3_SETUP:
        la a0, Map3 	# Map Address
        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        sw a0, 0(t0)    # Stores Map1 address on CURRENT_MAP
        
        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	

        la t0, PLYR_POS # Loads Player Position
        lbu a3, 5(t0)	# Loads player's X offset
        li a4, 0		# Y offset (0, 4, 8, 12)	
        li a5, 0		# Frame = 0
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)
        
        call RENDER_MAP

        la t0, CURRENT_MAP # Loads CURRENT_MAP address
        lbu a1, 6(t0)   # Loads current X on Map (starting X on Matrix (top left))
        lbu a2, 7(t0)   # Loads current Y on Map (starting Y on Matrix (top left))	

        la t0, PLYR_POS # Loads Player Position
        lbu a3, 5(t0)	# Loads player's X offset
        li a4, 0		# Y offset (0, 4, 8, 12)	
        li a5, 1		# Frame = 0
        li a6, m_screen_width	# Screen Width = 20
        li a7, m_screen_height	# Screen Height = 15
        li t3, 0		# Starting X for rendering (top left, related to Matrix)
        li t2, 0		# Starting Y for rendering (top left, related to Matrix)

        call RENDER_MAP

        j END_SETUP


    MAP4_SETUP:
        j END_SETUP

    MAP5_SETUP:
        j END_SETUP
        
    MAP6_SETUP:
        j END_SETUP
        
    MAP7_SETUP:
        j END_SETUP

END_SETUP:

    j GAME_LOOP
