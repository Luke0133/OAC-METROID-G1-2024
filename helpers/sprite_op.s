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
    lbu t1, 0(t0) # Loads sprite number
    li t2, 3 # t2 = max_sprite
    beq t1,t2,RESET_SPRITE_BALL # t1 == t2 ? RESET_SPRITE : INC_SPRITE
    addi t1,t1,1 # INC_SPRITE
    sb t1, 0(t0) # Store sprite number in status
    j CHECK_HORIZONTAL_MOV

RESET_SPRITE_BALL:
    sb zero, 0(t0) # Reset sprite number

CHECK_VERTICAL_MOV:
    lbu t1, 2(t0) # Check if samus is facing up
    bnez t1, SPRITE_UP_GROUND # t1 != 0 ? SPRITE_UP_GROUND
    lbu t1, 3(t0) # Check if samus is falling
   # bnez t1, SPRITE_FALLING # t1 != 0 ? SPRITE_FALLING
    j CHECK_HORIZONTAL_MOV # Check for movement in horizontal direction

SPRITE_UP_GROUND:
    lbu t1, 3(t0) # Check if samus is falling 
    bnez t1, SPRITE_UP_FREEFALL # t1 != 0 ? SPRITE_UP_FREEFALL

    lbu t1, 0(t0) # Loads sprite number
    # Max-sprite-up = 1
    bnez t1, RESET_SPRITE_UP # t1 == 1 ? RESET_SPRITE_UP : INC SPRITE_UP_GROUND
    addi t1,t1,1 # INC SPRITE_UP_GROUND
    sb t1, 0(t0) # Store sprite number in status
    j CHECK_HORIZONTAL_MOV # Check for movement in horizontal direction


SPRITE_UP_FREEFALL:
    lbu t1, 0(t0) # Loads sprite number
    # Max-sprite-up = 1
    bnez t1, RESET_SPRITE_UP # t1 != 0 ? RESET_SPRITE_UP : INC_SPRITE_UP_FREEFALL
    addi t1, t1, 1 # INC_SPRITE_UP_FREEFALL
    sb t1, 0(t0) # Store sprite number in status
    j CHECK_HORIZONTAL_MOV

RESET_SPRITE_UP:
    sb zero, 0(t0) # Reset sprite number
    j CHECK_HORIZONTAL_MOV # movex or end update status?

CHECK_HORIZONTAL_MOV:
    la t1,MOVE_X # Loads Move X
    lb t1, 0(t1) # Loads Move X byte
    blt zero, t1, SPRITE_LEFT # zero < moveX ? SPRITE_LEFT : SPRITE_RIGHT 
    j SPRITE_RIGHT

SPRITE_LEFT:
    lbu t1, 0(t0)   # Loads sprite number
    li t2,2    # t2 = max sprite-number
    blt t1,t2, ASC_LEFT_SPRITE # t1 < t2 ? ASC_ESQ_SPRITE  : DESC_LEFT_SPRITE
    j RESET_SPRITE_LEFT

ASC_LEFT_SPRITE:
    addi t1,t1,1 # Increments sprite number
    sb t1, 0(t0) # Stores sprite_number in PLYR_STATUS
    j END_UPDATE_STATUS
        
RESET_SPRITE_LEFT:
    sb zero, 0(t0) # returns to sprite 0
    j END_UPDATE_STATUS
    
SPRITE_RIGHT:
    lbu t1, 0(t0)   # Loads sprite number
    li t2,2        # t2 = end of sprites
    blt t1,t2, ASC_RIGHT_SPRITE # t1 < t2 ? ASC_RIGHT_SPRITE  
    j RESET_SPRITE_RIGHT

ASC_RIGHT_SPRITE:
    addi t1,t1,1 # increments sprite number
    sb t1, 0(t0) # stores in PLYR_POS
    j END_UPDATE_STATUS
        
RESET_SPRITE_RIGHT:
    sb zero, 0(t0) # returns to sprite 0
  
END_UPDATE_STATUS:
    ret
    
