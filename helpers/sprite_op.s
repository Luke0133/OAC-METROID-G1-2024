#.data
#last_key: .byte 0 #0=0,1=w,2=a,3=s,4=d

# 0 1 2  -> 0 1 2

# ground position -> la t0 PLYR_STATUS -> lb t0, 3(t0)

.text

UPDATE_STATUS:
    la t0,PLYR_STATUS # Loads Player Status
    lb t1, 4(t0) # Loads Ball Byte 
    bnez t1, SPRITE_BALL # t1 != 0 ? SPRITE_BALL : CHECK_VERTICAL_MOV
    j CHECK_VERTICAL_MOV

SPRITE_BALL:
    # CHECAR DIREÇÃO 0 (dir 0 -> 1 -> 2 -> 3 -> 0) 1 (esq 0 -> 3 -> 2 -> 1 -> 0)
    lbu t1, 6(t0) # Loads MOVE_X to t1
    blt t1, zero, BALL_SPRITE_LEFT # t1 < 0 ? BALL_SPRITE_LEFT : BALL_SPRITE_RIGHT
    j BALL_SPRITE_RIGHT

BALL_SPRITE_LEFT:
    lbu t1, 0(t0) # Loads sprite number
    li t2, 3 # t2 = max_sprite
    beq t1,t2,RESET_SPRITE_BALL # t1 == t2 ? RESET_SPRITE : INC_SPRITE
    addi t1,t1,1 # INC_SPRITE
    sb t1, 0(t0) # Store sprite number in status
    j END_UPDATE_STATUS

BALL_SPRITE_RIGHT:
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
    
