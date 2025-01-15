##################################################################
#  Mostra todas as cores que o RARS possui, printando 
#  o número correspondente (decimal) no terminal
#
#  Controles: "w" para somar 1 ao valor da cor
#             "s" para subtrair 1 ao valor da cor
#             "del" para encerrar o código
#

.data

Newline: .string "\n"

.text

# Inicializa em 0 (Preto)
	li s0,0	

START:
	mv a0,s0
	li a7,1
	ecall
	la a0,Newline
	li a7 4
	ecall
	
	# Preparação para printar na tela
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	
LOOP: 	
	beq t1,t2,INPUT_CHECK		# Se for o último endereço então sai do loop
	sb s0,0(t1)		            # escreve a word na memória VGA
	addi t1,t1,1		        # soma 4 ao endereço
	j LOOP			            # volta a verificar

INPUT_CHECK:
    li t1,0xFF200000  	    # Endereço KDMMIO
    lw t0, 0(t1)	        # Lê bit do Keyboard Control 
    andi t0, t0, 0x0001	    # Mascara bit menos significante
    bnez t0, CONTINUE_CHECK # Se for detectado um input, continue
    j INPUT_CHECK	        # caso contrário, volte para INPUT_CHECK
    
    CONTINUE_CHECK:
    lw t0, 4(t1)   # Lê valor da tecla

    li t1, 'w'	   # Carrega valor da tecla 'w' 
    bne t0, t1, CHECK_INPUT.S
    j INPUT.W	   # Se tecla 'w' foi pressionada
    
    CHECK_INPUT.S:
    li t1, 's'	 # Carrega valor da tecla 's' key
    bne t0, t1, CHECK_INPUT.DEL
    j INPUT.S	 # Se tecla 's' foi pressionada

    CHECK_INPUT.DEL:
    li t1, 127	 # Carrega valor da tecla del
    bne t0,t1, INPUT_CHECK
    j FINISH	 # Se tecla del foi pressionada

INPUT.W:
	# Checagem para impedir passar de 254
    li t0 254
	blt t0,s0 INPUT_CHECK
	addi s0,s0,1
	j START
INPUT.S:
	# Checagem para impedir passar de 0
	beqz s0,INPUT_CHECK
	addi s0,s0,-1
	j START
	
FINISH:	li a7,10		# syscall de exit
	ecall
