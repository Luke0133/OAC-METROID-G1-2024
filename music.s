#ATENCAO MODULARIZAR!!!!!!!!!!!!!!!!!

.data


#Pre-Chorus
TAMANHO_PRE: 23
NOTAS_PRE: 65,3555,60,1185,64,3555,62,296,64,296,62,296,59,296,65,3555,60,1185,64,3555,62,296,64,296,62,296,59,296,65,3555,60,1185,64,3555,62,296,64,296,62,296,59,296,60,4740,57,4740


#Chorus
TAMANHO_CHORUS: 31
NOTAS_CHORUS: 62,3573,62,397,60,397,62,397,64,2382,59,1191,53,397,59,397,60,397,62,3573,62,397,60,397,62,397,64,2382,59,1191,59,397,64,397,65,397,67,4764,65,2382,64,2382,65,3573,69,397,67,397,65,397,67,2382,64,1191,64,397,67,397,71,397,73,9528


#Verse
TAMANHO_VERSE: 19
NOTAS_VERSE: 60,4740,64,3555,62,296,64,296,62,296,59,296,60,4740,64,3555,62,296,64,296,62,296,59,296,60,4740,64,3555,62,296,64,296,62,296,59,296,60,9480

.text
        la s0, TAMANHO_CHORUS
        lw s1, 0(s0)
        la s0,NOTAS_CHORUS
        li t0,0
        li a2,96
        li a3, 127

LOOP:   
        beq t0,s1, FIM
        lw a0,0(s0)
        lw a1,4(s0)
        li a7,31
        ecall
        mv a0,a1
        li a7,32
        ecall
        addi s0,s0,8
        addi t0,t0,1
        j LOOP

FIM:
        li a7,10
        ecall
