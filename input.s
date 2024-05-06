######## INPUT ###########################
# Uso de Registradores temporarios

INPUT:
        li t1,0xFF210000
        lw t0, 0(t1)
        andi t0, t0, 1
        beqz t0, INPUT.ZERO # input == 0 => INPUT.ZERO 
        lw t0, 4(t1) # input != 0 => check input 

        li t1, 'w'
        beq t0, t1, INPUT.W
        li t1, 'a'
        beq t0, t1, INPUT.A
        li t1, 's'
        beq t0, t1, INPUT.S
        li t1, 'd'
        beq t0, t1, INPUT.D
        li t1, 32
        beq t0, t1, INPUT.SPACE 
        li t1, 'k'
        beq t0,t1, INPUT.K 
