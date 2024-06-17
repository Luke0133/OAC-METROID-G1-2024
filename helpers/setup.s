.text

########################## SETUP ##########################

#########################################################################

SETUP:
    addi sp,sp,-4
    sw ra, 0(sp)

    la t0, MAP_INFO # Loads Map Info address
    lbu t1, 0 (t0)  # Loads byte related to map number
    
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
        
        la t0, PLYR_POS # Loads Player Position
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

        la t0, PLYR_POS # Loads Player Position
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
            li a3, 8		# X offset (0, 4, 8, 12)
            li a4, 0		# Y offset (0, 4, 8, 12)	
            li a5, 0		# Frame = 0
            li a6, m_screen_width	# Screen Width = 20
            li a7, m_screen_height	# Screen Height = 15
            li t3, 0		# Starting X for rendering (top left, related to Matrix)
            li t2, 0		# Starting Y for rendering (top left, related to Matrix)

            addi sp,sp,-4
            sw ra, 0(sp)

            call RENDER_MAP
            la t0, Map2 		# Map Address
            li a1, 23		# starting X on Matrix (top left)
            li a2, 0		# starting Y on Matrix (top left)		
            li a3, 8		# X offset (0, 4, 8, 12)
            li a4, 0		# Y offset (0, 4, 8, 12)	
            li a5, 1		# Frame = 1
            li a6, m_screen_width	# Screen Width = 20
            li a7, m_screen_height	# Screen Height = 15
            li t3, 0		# Starting X for rendering (top left, related to Matrix)
            li t2, 0		# Starting Y for rendering (top left, related to Matrix)
            call RENDER_MAP
            la t0,Map1
            la t1,CURRENT_MAP
            sw t0,0(t1)
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
    lw ra, 0(sp)
    addi sp,sp,4
    ret
