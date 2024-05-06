######## INPUT ###########################
# Uso de Registradores temporarios

INPUT_CHECK:
        li t1,0xFF210000
        lw t0, 0(t1)
        andi t0, t0, 1
        beqz t0, INPUT.ZERO # input == 0 => INPUT.ZERO 
        lw t0, 4(t1) # input != 0 => check input 

        li t1, 'w'
        bne t0, t1, CHECK_INPUT.A
        j INPUT.W
        
        CHECK_INPUT.A:
        li t1, 'a'
        bne t0,t1, CHECK_INPUT.S
        j INPUT.A

        CHECK_INPUT.S:
        li t1, 's'
        bne t0, t1, CHECK_INPUT.D
        j INPUT.S

        CHECK_INPUT.D:
        li t1, 'd'
        bne t0,t1, CHECK_INPUT.SPACE
        j INPUT.D
        
        CHECK_INPUT.SPACE:
        li t1, 32
        bne t0,t1, CHECK_INPUT.K
        j INPUT.SPACE 
        
        CHECK_INPUT.K:
        li t1, 'k'
        bne t0,t1, INPUT.ZERO
        j INPUT.K 

INPUT.ZERO:
        sw zero, 0(t0)
        sw zero, 4(t0)
        ret 

INPUT.W:
        j END_INPUT_CHECK

INPUT.A:
        la t0, PLYR_POS 
        lh t1, 0(t0)
        addi t1, t1, -3 
        sh t1, 0(t0)
        j END_INPUT_CHECK

INPUT.S:
        j END_INPUT_CHECK
INPUT.D:
        la t0, PLYR_POS 
        lh t1, 0(t0)
        addi t1, t1, 4
        sh t1,0(t0)
        j END_INPUT_CHECK

INPUT.SPACE:
        j END_INPUT_CHECK

INPUT.K:
        call SHOOT
        j END_INPUT_CHECK


SHOOT:
END_INPUT_CHECK:
        ret
