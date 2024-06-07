.data
last_key: .byte 0 #0=0,1=w,2=a,3=s,4=d

#0 1 2 3

.text

UPDATE_STATUS:
    la t0, PLYR_STATUS # loads sprite's number
    la t1, MOVE_X # if it is moving in x axis
    lb t1, 0(t1) # if it is moving in x axis
    beqz t1, NO_SPRITE
    blt zero, t1,SPRITE_ESQ # a0 < t1 ? SPRITE_ESQ : SPRITE_DIR
    j SPRITE_DIR

NO_SPRITE:
    j END_SPRITE_OP

SPRITE_ESQ:
    la t1, 0(t0) #loads sprite number
    beqz t1, asc_esq_sprite
    j desc_esq_sprite  

    asc_esq_sprite:
        addi t1, 


    li t1,1 # t1 = looking_left
    sb t1, 1(t0) #PLYR_STATUS = looking_left
    lb t1, 0(t0) # t1 = sprite_number
    li t2, 3 #aux pra sprite fin
    beqz t1, asc_esq #if t1= 0, asc_esq
    beq t1,t2, desc_esq
    
    la t1,desc
    lb t2, 0(t1)
    beqz t2, asc_counter
    j desc_count
    asc_esq: 
            la t2, desc 
            sb zero,0(t2) #desc => 0 == is_a
    asc_counter:
            lb t1, 0(t0) # t1 = sprite_number
            addi t1,t1,1 # sprime_number += 1
            sb t1, 0(t0) #sprime_number += 1
            j last_e
    desc_esq: 
            la t2, desc
            li t1,1 
            sb t1,0(t2) #desc => 0 == is_a
    desc_counter: 
            lb t1, 0(t0) # t1 = sprite_number
            addi t1,t1,-1 # sprime_number -= 1
            sb t1, 0(t0) # sprite_number -=
    last_esq: 
            la t0,last_key
            li t1,2
            sb t1,0(t0)

### if dir 

la t0, PLYR_STATUS # loads sprite's number
                sb zero, 1(t0) #PLYR_STATUS = looking_right
                lb t1, 0(t0) # t1 = sprite_number
                li t2, 3 #aux pra sprite final

                beqz t1, asc_dir #t1 = 0 ? asc_dir
                beq t1,t2, desc_dir # t1 = 3 ? desc_dir
                
                la t1,desc #t1 = desc_address
                lb t2, 0(t1) # t2 = desc_byte
                beqz t2, asc_counter_dir #t2 = 0 ? asc_counter
                j desc_counter_dir #

                asc_dir: 
                        la t2, desc 
                        sb zero,0(t2) #desc => 0 == is_asc

                asc_counter_dir:
                        lb t1, 0(t0) # t1 = sprite_number
                        addi t1,t1,1 # sprime_number += 1
                        sb t1, 0(t0) #sprime_number += 1
                        j last_dir

                desc_dir: 
                        la t2, desc
                        li t1,1 
                        sb t1,0(t2) #desc => 0 == is_asc

                desc_counter_dir: 
                        lb t1, 0(t0) # t1 = sprite_number
                        addi t1,t1,-1 # sprime_number -= 1
                        sb t1, 0(t0) # sprite_number -= 1

                last_dir: 
                        la t0,last_key
                        li t1,4
                        sb t1,0(t0)
                        
                        j END_INPUT_CHECK

### if up


### if down


END_SPRITE_OP:
    ret