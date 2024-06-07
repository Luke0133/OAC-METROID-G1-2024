.data
last_key: .byte 0 #0=0,1=w,2=a,3=s,4=d

# 0 1 2  -> 0 1 2

# ground position -> la t0 PLYR_STATUS -> lb t0, 3(t0)

.text

UPDATE_STATUS:
    la t0, PLYR_STATUS # Loads sprite's number
    la t1, MOVE_X      # Loads MOVE_X address
    lb t1, 0(t1)       # Loads MOVE_X byte on t1
    beqz t1, CHECK_SPRITE_UP # If there's no X movement
    blt zero, t1,SPRITE_LEFT # a0 < t1 ? SPRITE_LEFT : SPRITE_RIGHT
    j SPRITE_RIGHT

CHECK_SPRITE_UP:
    lb t1, 3(t0)
    bnez t1, JUMP_SPRITE_UP 
    j CHECK_SPRITE_VERTICAL

JUMP_SPRITE_UP:
    j SPRITE_UP_GROUND

SPRITE_LEFT:
    la t1, 0(t0)   #loads sprite number
    li t2,2        # t2 = end of sprites
    blt t1,t2, ASC_LEFT_SPRITE # t1 < t2 ? ASC_ESQ_SPRITE  
    j DESC_LEFT_SPRITE

    ASC_LEFT_SPRITE:
        addi t1,t1,1 # increments sprite number
        sb t1, 0(t0) # stores in PLYR_POS
        j SPRITE_UP_GROUND
    
    DESC_LEFT_SPRITE:
        sb zero, 0(t0) # returns to sprite 0
        j SPRITE_UP_GROUND


SPRITE_RIGHT:
    la t1, 0(t0)   #loads sprite number
    li t2,2        # t2 = end of sprites
    blt t1,t2, ASC_RIGHT_SPRITE # t1 < t2 ? ASC_RIGHT_SPRITE  
    j DESC_RIGHT_SPRITE

    ASC_RIGHT_SPRITE:
        addi t1,t1,1 # increments sprite number
        sb t1, 0(t0) # stores in PLYR_POS
        j SPRITE_UP_GROUND
    
    DESC_RIGHT_SPRITE:
        sb zero, 0(t0) # returns to sprite 0
        j SPRITE_UP_GROUND
   
SPRITE_UP_GROUND:
    la t1, 0(t0)
    li t2,1
    blt t1,t2, ASC_UP_SPRITE
    j DESC_UP_SPRITE

    ASC_UP_SPRITE:

    DESC_UP_SPRITE:

SPRITE_UP_FREEFALL:
    la t1, 0(t0)
    li t2,1
    blt t1,t2, ASC_UP_SPRITE
    j DESC_UP_SPRITE

    ASC_UP_SPRITE:

    DESC_UP_SPRITE:


END_SPRITE_OP:
    ret