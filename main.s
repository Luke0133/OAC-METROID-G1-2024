.include "MACROSv21.s"

.data

#.include ".data"

.text
        la a0, main_menu
        li a1, 0
        call printTela

        la a0, screen_play
        li a1, 1
        call printTela
        
        li t0, 0xFF200000

# imprime uma imagem em tela
# a0 = endereco da imagem
# a1 = frame

printTela:
        li t0, 0xFF0
        add t0, t0, a1
        slli t0, t0, 20 #endereco da tela com o frame desejado

        li t1, 76800
        add t1, t0, t1

loopPrTela:
        lw t2, 0(a0)
        sw t2, 0(t0)
        addi a0, a0, 4
        addi t0, t0, 4
        bne t0, t1, loopPrTela

        ret