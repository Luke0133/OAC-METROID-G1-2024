.text

#t0 = BEAMS
#t1 = BEAMS_NUMBER

BEAM_OPERATIONS_RENDER:    
    la t0,BEAMS
    li t1, BEAMS_NUMBER
    li t3,0
    la t5, MAP_INFO
   
    BEAM_LOOP:
        lbu t2,0(t0) #loads if beam is active
        bnez t2, RENDER_BEAM # if it is active, render beam
        j PROCEED_LOOP_BEAM

        RENDER_BEAM:
            li t4, 4 #max of times that has been rendered 
            lbu t2, 2(t0) #number of times that has been rendered
            blt t2,t4,CONTINUE_RENDER_BEAM
            j DELETE_BEAM

            CONTINUE_RENDER_BEAM:
                lbu t2, 1(t0) # loads direction
                beqz t2,CHECK_Y_AXIS_RENDER_BEAM #if direction=0, then check it for y move (up)
                j CHECK_X_AXIS_RENDER_BEAM #else, check for x-axis movement

                CHECK_Y_AXIS_RENDER_BEAM:
                    la a0,Beam_Vertical
                    j PRINT_BEAM

                CHECK_X_AXIS_RENDER_BEAM:   
                     la a0,Beam_Horizontal 

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

                    lbu t2, 5(t0) #loads new x of matrix
                    lbu t3, 2(t5) #loads map x of matrix
                    sub t2,t2,t3 # load x - load x map
                    slli t2, t2,tile_size_shift
                    
                    lbu t3, 3(t0) #loads offset of beam
                    add t2,t2,t3 #sum with offset x beam 
                    lbu t3, 4(t5) #loads offset x map

                    #x direction
                    sub a1,t2,t3 #subtract offset x map


                    lbu t2, 6(t0) #loads new y of matrix
                    lbu t3, 3(t5) #loads map y of matrix
                    sub t2,t2,t3 # load y - load y map
                    slli t2, t2,tile_size_shift
                    
                    lbu t3, 4(t0) #loads offset of beam
                    add t2,t2,t3 #sum with offset y beam 
                    lbu t3, 5(t5) #loads offset y map

                    #y direction
                    sub a2,t2,t3 #subtract offset y map
                                        
                    #size
                    li a3, 16
                    li a4, 16
                    
                    #frame and sprite status
                    li a5, 0
                    li a6, 0
                    li a7, 0

                    addi sp,sp,-20
                    sw ra,0(sp)
                    sw t0,4(sp)
                    sw t1,8(sp)
                    sw t3,12(sp)
                    sw t5,16(sp)

                    call RENDER
                    
                    sw t5,16(sp)
                    lw t3,12(sp)
                    lw t1,8(sp)
                    lw t0,4(sp)
                    lw ra,0(sp)
                    addi sp,sp,20                

        PROCEED_LOOP_BEAM:
                blt t3,t1,CONTINUE_LOOP_BEAM #counter < number_beams? : continue_loop : end_beam_operations
                j END_BEAM_OPERATIONS
        
        CONTINUE_LOOP_BEAM:
                    addi t3,t3,1
                    addi t0,t0,9
                    lb t2, 1(t0) # loads direction
                    beqz t2,INC_Y_NEW   
                    j INC_X_NEW
                    
                    INC_Y_NEW:
                        lbu t2,4(t0)
                        addi t2,t2,-4
                        bge t2,zero,STORE_BEAM_Y
                        lbu tp, 6(t0)
                        sb tp,8(t0)
                        addi tp,tp,-1
                        addi t2,t2,tile_size

                            STORE_BEAM_Y:
                                sb t2,4(t0)
                                j BEAM_LOOP
                    
                    INC_X_NEW:
                            slli tp,t2,2 

                            lbu t2,3(t0)
                            add t2,t2,tp

                            bge t2,zero,CHECK_INC_X

                            lbu tp, 5(t0)
                            sb tp,7(t0)
                            addi tp,tp,-1
                            addi t2,t2,tile_size
                            j STORE_BEAM_X

                            CHECK_INC_X:
                                li tp,tile_size
                                blt t2,tp,STORE_BEAM_X
                                sub t2,t2,tp

                                lbu tp, 5(t0)
                                sb tp,7(t0)
                                addi tp,tp,1

                            STORE_BEAM_X:
                                sb t2,3(t0)
                                j BEAM_LOOP

        DELETE_BEAM:
            sb zero,0(t0)
            addi t3,t3,1
            addi t0,t0,9
            j BEAM_LOOP

            
    END_BEAM_OPERATIONS:
        ret
