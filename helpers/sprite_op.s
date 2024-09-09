#.data
#last_key: .byte 0 #0=0,1=w,2=a,3=s,4=d

# 0 1 2  -> 0 1 2

# ground position -> la t0 PLYR_STATUS -> lb t0, 3(t0)

.text

UPDATE_STATUS:
    la t0,PLYR_STATUS  # Loads Player Status
    lb t1, 4(t0)       # Loads Ball Byte 
    bnez t1, UPDATE_BALL_SPRITE # If player is on morph ball (t1 != 0), go to UPDATE_BALL_SPRITE
    j CHECK_VERTICAL_MOV        # Otherwise, go to CHECK_VERTICAL_MOV

    UPDATE_BALL_SPRITE:
        # CHECAR DIREÇÃO 0 (dir 0 -> 1 -> 2 -> 3 -> 0) 1 (esq 0 -> 3 -> 2 -> 1 -> 0)
        lbu t1, 1(t0) # Loads player's facing direction into t1
        bnez t1, UPDATE_BALL_SPRITE_LEFT # If player is looking left, go to UPDATE_BALL_SPRITE_LEFT
        j UPDATE_BALL_SPRITE_RIGHT       # otherwise, go to UPDATE_BALL_SPRITE_RIGHT

        UPDATE_BALL_SPRITE_LEFT:
            lbu t1, 0(t0) # Loads sprite number
            li t2, 3 # t2 = max_sprite
            beq t1,t2,RESET_SPRITE_BALL # t1 == t2 ? RESET_SPRITE : INC_SPRITE
            addi t1,t1,1 # INC_SPRITE
            sb t1, 0(t0) # Store sprite number in status
            j END_UPDATE_STATUS

        UPDATE_BALL_SPRITE_RIGHT:
            lbu t1, 0(t0) # Loads sprite number
            li t2, 3 # t2 = max_sprite
            beq t1,t2,RESET_SPRITE_BALL # t1 == t2 ? RESET_SPRITE : INC_SPRITE
            addi t1,t1,1 # INC_SPRITE
            sb t1, 0(t0) # Store sprite number in status
            j END_UPDATE_STATUS

        RESET_SPRITE_BALL:
            sb zero, 0(t0) # Reset sprite number
            j END_UPDATE_STATUS

CHECK_VERTICAL_MOV:
    lbu t1, 7(t0) # Loads MOVE_Y to t1
    beqz t1, CHECK_HORIZONTAL_MOV # t1 == 0 ? CHECK_HORIZONTAL_MOV : END_UPDATE_STATUS
    j RESET_SPRITE

CHECK_HORIZONTAL_MOV:
    lbu t1,6(t0) # Loads Move X to t1
    bnez t1, CHECK_HORIZONTAL_MOV_2 # t1 = 0 ? DONT UPDATE SPRITE : CHECK_SPRITES
    j RESET_SPRITE

CHECK_HORIZONTAL_MOV_2:
    blt zero, t1, SPRITE_LEFT # zero < moveX ? SPRITE_LEFT : SPRITE_RIGHT 
    j SPRITE_RIGHT

SPRITE_LEFT:
    lbu t1, 0(t0)   # Loads sprite number
    li t2,2    # t2 = max sprite-number
    blt t1,t2, ASC_LEFT_SPRITE # t1 < t2 ? ASC_ESQ_SPRITE  : DESC_LEFT_SPRITE
    j RESET_SPRITE

ASC_LEFT_SPRITE:
    addi t1,t1,1 # Increments sprite number
    sb t1, 0(t0) # Stores sprite_number in PLYR_STATUS
    j END_UPDATE_STATUS

    
SPRITE_RIGHT:
    lbu t1, 0(t0)   # Loads sprite number
    li t2,2        # t2 = end of sprites
    blt t1,t2, ASC_RIGHT_SPRITE # t1 < t2 ? ASC_RIGHT_SPRITE  
    j RESET_SPRITE

ASC_RIGHT_SPRITE:
    addi t1,t1,1 # increments sprite number
    sb t1, 0(t0) # stores in PLYR_POS
    j END_UPDATE_STATUS
        
RESET_SPRITE:
    sb zero, 0(t0) # returns to sprite 0

END_UPDATE_STATUS:
    ret
    

UPDATE_MARU_MARI:
    la t0,CURRENT_MAP # Loads CURRENT_MAP address
    lbu t1, 4(t0)     # Loads Current Map byte
    li t2,1           # Number of map that maru mari appears
    bne t2,t1,END_UPDATE_MARU_MARI # If not on correct map, ignore
    # Otherwise, update sprite status and check if should be rendered
        # Updating sprite
        la t1,MARU_MARI_INFO # Loads Maru Mari's info address
        lbu t2, 1(t1)        # Loads status sprite
        li t3, 3             # t3 = max_sprite
        beq t2,t3,RESET_MARU_MARI # If status == 3, reset it
            addi t2,t2,1     # Increments status 
            sb t2, 1(t1)     # Stores status sprite
            j UPDATE_MARU_MARI_TRY_RENDER
        RESET_MARU_MARI:
            sb zero, 1(t1)   # Stores status sprite
            # j UPDATE_MARU_MARI_TRY_RENDER
        UPDATE_MARU_MARI_TRY_RENDER:
        # Checking if should be rendered
        lbu a1, 6(t0)     # Loads Current Map's X
        li t2,maru_mari_x # Loads Maru_Mari's X
        sub t1,t2,a1      # t1 = Maru_Mari's X - Current Map's X
        bge t1,zero,UPDATE_MARU_MARI_RENDER # If t1 >= 0, render maru mari
        # Otherwise, finish procedure
            j END_UPDATE_MARU_MARI
        UPDATE_MARU_MARI_RENDER:
            lw a0,0(t0)
            # a1 is already set (X in map matrix that corresponds to 0x0 on the screen matrix)
            lbu a2, 7(t0)     # Loads Current Map's Y
            lbu a3, 8(t0)   # Loads current X offset on Map
            lbu a4, 9(t0)   # Loads current Y offset on Map	
            mv a5, s0		# Frame = s0
            li a6, 1        # Width of rendering area will always be 1
            li a7, 1        # Height of rendering area will always be 1
            li t3, maru_mari_x  # X from map matrix where rendering will start from
            li t2, maru_mari_y  # Y from map matrix where rendering will start from
            li tp, 0        # Map won't be dislocated		
            mv s11,ra
            call RENDER_MAP		
            mv ra,s11
    
    END_UPDATE_MARU_MARI:
        ret
