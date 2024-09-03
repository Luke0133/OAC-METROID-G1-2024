#t0 = BEAMS
#t1 = BEAMS_NUMBER

BEAM_OPERATIONS:
    la t0,BEAMS
    la t1, BEAMS_NUMBER
    li t3,0
    
    BEAM_LOOP:
        lb t2,0(t0) #loads if beam is active
        beqz t2, PROCEED_LOOP # if it is active, proceed
            
        RENDER_BEAM:
            lb t2, 1(t0)
            beqz t2,CHECK_Y_AXIS_RENDER_BEAM
            
            j CHECK_X_AXIS_RENDER_BEAM
            
            CHECK_Y_AXIS_RENDER_BEAM:
                lb t2, 4(t0)
                li t4, 12
                bne t2,t4,PRINT_BEAM
                j DELETE_BEAM 

            PRINT_BEAM:
                #image
                la a0, Beam
                
                #load x 
                #load x do mapa
                #load x - load x do mapa
                #slli tile_size_shift
                #above sum offset x beam
                #sub offset x map
                #same for y

                #coordinates
                a1 
                a2
                
                #size
                li a3, 8
                li a4, 8
                
                #frame and sprite status
                li a5, 0
                li a6, 0
                li a7, 0

                addi sp,sp,-12
                sw ra,0(sp)
                sw t0,4(sp)
                sw t1,8(sp)
                call RENDER
                lw t1,8(sp)
                lw t0,4(sp)
                lw ra,0(sp)
                addi sp,sp,12


        PROCEED_LOOP_BEAM:
            bne t3,t1,CONTINUE_LOOP_BEAM
            j END_BEAM_OPERATIONS
            
            CONTINUE_LOOP_BEAM:
                addi t3,t3,1
                addi t0,t0,9
                j BEAM_LOOOP
        

END_BEAM_OPERATIONS