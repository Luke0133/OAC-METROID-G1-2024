#t0 = BEAMS
#t1 = BEAMS_NUMBER

BEAM_OPERATIONS:
    la t0,BEAMS
    la t1, BEAMS_NUMBER
    li t3,0
    la t5, MAP_INFO
    
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
                #load x 
                #load x do mapa
                #load x - load x do mapa
                #slli tile_size_shift
                #above sum offset x beam
                #sub offset x map
                #same for y

                #coordinates -> x = a1, y = a2
                
                lb t2, 5(t0) #loads new x of matrix
                lb t3, 2(t5) #loads map x of matrix
                sub t2,t2,t3 # load x - load x map
                slli t2, tile_size_shift
                
                lb t3, 3(t0) #loads offset of beam
                add t2,t2,t3 #sum with offset x beam 
                lb t3, 4(t5) #loads offset x map

                #x direction
                sub a1,t2,t3 #subtract offset x map


                lb t2, 6(t0) #loads new y of matrix
                lb t3, 3(t5) #loads map y of matrix
                sub t2,t2,t3 # load y - load y map
                slli t2, tile_size_shift
                
                lb t3, 4(t0) #loads offset of beam
                add t2,t2,t3 #sum with offset y beam 
                lb t3, 5(t5) #loads offset y map

                #y direction
                sub a2,t2,t3 #subtract offset y map
                
                #size
                li a3, 16
                li a4, 16
                
                #frame and sprite status
                li a5, 0
                li a6, 0
                li a7, 0

                addi sp,sp,-16
                sw ra,0(sp)
                sw t0,4(sp)
                sw t1,8(sp)
                sw a0,12(sp)
                call RENDER
                lw a0,12(sp)
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