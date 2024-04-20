.data
INTERFACE_HP_size:	.half 31, 94
BARRA_HP_size:		.half 4, 6
POWER_size:		.half 14, 14
NUMERO_size:		.half 8, 7
HP:			.byte 15
POWER:			.byte 1	#0 = shuriken selecionado, 1 = flash selecionado
MANA:			.byte 20
.text
.eqv SHURIKEN_COST	3
.eqv FLASH_COST		7
.eqv MANA_PLUS  	4

INTERFACE_HP:
#Prepara para o print

#a0:


li a1, 0
li a2, 0
la a3, Pocket_size
la a4, INTERFACE_HP_size
mv a5, s1
li a6, 5
li a7, 14
ret

BARRA_HP:
#Prepara para o print

#a0:


li a1, 4
li a2, 1
la a3, Pocket_size
la a4, BARRA_HP_size
mv a5, s1
li a6, 81
li a7, 98
ret

FLASH:
#Prepara para o print

#a0:


li a1, 14
li a2, 14
la a3, Pocket_size
la a4, POWER_size
mv a5, s1
li a6, 59
li a7, 138
ret

SHURIKEN:
#Prepara para o print

#a0:


li a1, 14
li a2, 14
la a3, Pocket_size
la a4, POWER_size
mv a5, s1
li a6, 22
li a7, 138
ret

SELECIONA_NUM:
	beq t5, zero, NUM_0
	li t6, 1
	beq t5, t6, NUM_1
	li t6, 2
	beq t5, t6, NUM_2
	li t6, 3
	beq t5, t6, NUM_3
	li t6, 4
	beq t5, t6, NUM_4
	li t6, 5
	beq t5, t6, NUM_5
	li t6, 6
	beq t5, t6, NUM_6
	li t6, 7
	beq t5, t6, NUM_7
	li t6, 8
	beq t5, t6, NUM_8
	li t6, 9
	beq t5, t6, NUM_9
	ret
	
NUM_0:
#Prepara para o print

#a0:


li a1, 12
li a2, 4
la a3, Pocket_size
la a4, NUMERO_size
mv a5, s1
li a6, 5
li a7, 109
ret

NUM_1:
#Prepara para o print

#a0:


li a1, 12
li a2, 4
la a3, Pocket_size
la a4, NUMERO_size
mv a5, s1
li a6, 13
li a7, 109
ret

NUM_2:
#Prepara para o print

#a0:


li a1, 12
li a2, 4
la a3, Pocket_size
la a4, NUMERO_size
mv a5, s1
li a6, 21
li a7, 109
ret

NUM_3:
#Prepara para o print

#a0:


li a1, 12
li a2, 4
la a3, Pocket_size
la a4, NUMERO_size
mv a5, s1
li a6, 29
li a7, 109
ret

NUM_4:
#Prepara para o print

#a0:


li a1, 12
li a2, 4
la a3, Pocket_size
la a4, NUMERO_size
mv a5, s1
li a6, 37
li a7, 109
ret

NUM_5:
#Prepara para o print

#a0:


li a1, 12
li a2, 4
la a3, Pocket_size
la a4, NUMERO_size
mv a5, s1
li a6, 45
li a7, 109
ret

NUM_6:
#Prepara para o print

#a0:


li a1, 12
li a2, 4
la a3, Pocket_size
la a4, NUMERO_size
mv a5, s1
li a6, 53
li a7, 109
ret

NUM_7:
#Prepara para o print

#a0:


li a1, 12
li a2, 4
la a3, Pocket_size
la a4, NUMERO_size
mv a5, s1
li a6, 61
li a7, 109
ret

NUM_8:
#Prepara para o print

#a0:


li a1, 12
li a2, 4
la a3, Pocket_size
la a4, NUMERO_size
mv a5, s1
li a6, 69
li a7, 109
ret

NUM_9:
#Prepara para o print

#a0:


li a1, 12
li a2, 4
la a3, Pocket_size
la a4, NUMERO_size
mv a5, s1
li a6, 77
li a7, 109
ret