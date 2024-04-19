.include "MACROSv21.s" # Macros para bitmap display


.data
.eqv frame_rate 90 # T ms por frame 
RUN_TIME: .word 0 # Guarda quanto tempo passou 

PLYR_POS: .half 40, 0, 0, 0 # Guarda a posicao do jogador (topo esquerdo X e Y) e sua antiga posicao (topo esquerdo X e Y)

.text

SETUP:		
	la a0, map 		# Endereco do mapa
	li a1, 0		# Topo esquerdo X
	li a2, 0		# Topo esquerdo Y		
	li a3, 320		# Largura da imagem
	li a4, 240		# Altura da imagem	
	li a5, 0		# Frame = 0
	call RENDER	
	la a0, map 		# Endereco do mapa
	li a1, 0		# Topo esquerdo X
	li a2, 0		# Topo esquerdo Y		
	li a3, 320		# Largura da imagem
	li a4, 240		# Altura da imagem	
	li a5, 0		# Frame = 0
	li a5, 1		# Frame = 1
	call RENDER	
	li s0, 0	

ENGINE_SETUP:
	li a7,30	# Ecall 30: Pega o tempo que passou
	ecall 		# Syscall
	la t0,RUN_TIME	# Carrega o endereco de RUN_TIME
	sw a0,0(t0)	# Novo tempo eh guardado em RUN_TIME, a fim de ser comparado depois
	j ENGINE_LOOP   # Comeca o loop do jogo 

	# Esse loop ira se repetir enquanto o tempo 		
	ENGINE_LOOP:
		li a7,30		# Ecall 30: Pega o tempo que passou
		ecall 			# syscall
		la t0,RUN_TIME		# Carrega o endereco de RUN_TIME
		lw t1,0(t0)		# Carrega o tempo guardado por ultimo (tempo antigo)
		sub t1,a0,t1		# Tempo novo - Tempo antigo
		li t2,frame_rate	# Carrega a frame_rate (T ms por frame)
		bge t1,t2,GAME_LOOP	# Se o tempo novo - tempo antigo >= frame rate (T ms por frame), vai para o GAME_LOOP,
		j ENGINE_LOOP		# caso contrario voltar para o inicio do loop
	
GAME_LOOP:
	call INPUT_CHECK	# Checa input do jogador
	xori s0,s0,1			# inverte o valor frame atual (somente o registrador)
	
		
			
	la a0, walk_right 		# Gets sprite address# Endereco do mapa
	la t0,PLYR_POS
	lh a1, 0(t0)		# Topo esquerdo X
	lh a2, 2(t0)		# Topo esquerdo Y		
	li a3, 24		# Largura da imagem
	li a4, 32		# Altura da imagem	
	mv a5, s0		# Frame
	
	call RENDER
		
	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)
	
	##### LIMPEZA DE RASTRO
	
	mv a5, s0		# Frame
	mv a5,s0			# carrega o frame atual (que esta na tela em a3)
	xori a5,a5,1			# inverte a3 (0 vira 1, 1 vira 0)
	
	la a0, walk_right 		# Gets sprite address# Endereco do mapa
	la t0,PLYR_POS
	lh a1, 0(t0)		# Topo esquerdo X
	lh a2, 2(t0)		# Topo esquerdo Y		
	li a3, 24		# Largura da imagem
	li a4, 32		# Altura da imagem	
	call RENDER			# imprime

	j ENGINE_LOOP	# Volta para ENGINE_LOOP

RENDER:
	#Propper rendering

	li t0,0xFF0	# t0 = 0xFF0
	add t0,t0,a5	# Printing address corresponds to 0x0FF0 + frame
	slli t0,t0,20	# shifts 20 bits, making printing adress correct (0xFF00 0000 or 0xFF10 0000)
	
	add t0,t0,a1	# t0 = 0xFF00 0000 + X or 0xFF10 0000 + X
	
	li t4,320	# t4 = 320
	mul t4,t4,a2	# t4 = 320 * Y 
	add t0,t0,t4	# t0 = 0xFF00 0000 + X + (Y * 320) or 0xFF10 0000 + X + (Y * 320)
	
	addi a0,a0,8			# t1 = a0 + 8
	
	mv t2,zero	# t2 = 0
	mv t3,zero	# t3 = 0
	
	PRINT_LINE:
		
			
		lw t4,0(a0)	# loads word(4 pixels) on t4
		sw t4,0(t0)	# prints 4 pixels from t4
		
		addi t0,t0,4	# increments bitmap address
		addi a0,a0,4	# increments image address
		
		addi t3,t3,4	# increments column counter
		blt t3,a3,PRINT_LINE	# if column counter < width, repeat
		
		addi t0,t0,320
		sub t0,t0,a3
		
		mv t3,zero		# t3 = 0
		addi t2,t2,1		# increments line counter
		bgt a4,t2,PRINT_LINE	#if height > line counter, repeat
		ret	

INPUT_CHECK:
	li t1,0xFF200000 # Endereco do controle KDMMIO
	lw t0,0(t1) # Le o bit de controle do teclado
	andi t0,t0,0x0001
	
	bnez t0, CONTINUE_INPUT_CHECK
	j END_INPUT_CHECK
	CONTINUE_INPUT_CHECK:
		lw t2,4(t1)	# Le o valor do input
		
		li t0, 'w'
		bne t0,t2, INPUT_CHECK_D
		j CHAR_LOOK_UP
		
		INPUT_CHECK_D:
		li t0, 'd'
		bne t0,t2,INPUT_CHECK_A
		j CHAR_RIGHT
		
		INPUT_CHECK_A:
		li t0, 'a'
		bne t0,t2, INPUT_CHECK_S
		j CHAR_LEFT
		
		INPUT_CHECK_S:
		li t0, 's'
		bne t0,t2, INPUT_CHECK_SPACE
		j CHAR_CROUCH
		
		INPUT_CHECK_SPACE:
		li t0, 32
		bne t0,t2,INPUT_CHECK_NOPE
		j CHAR_JUMP
		
		INPUT_CHECK_NOPE:
		j END_INPUT_CHECK
	
	CHAR_LOOK_UP:
		li a0,'w'
		li a7, 1
		ecall
		j END_INPUT_CHECK
	CHAR_RIGHT:
		li a0,'d'
		li a7, 1
		ecall
		
		la t0,PLYR_POS
		lh t1, 0(t0)		# Topo esquerdo X
		addi t1,t1,4
		sh t1, 0(t0)		# Topo esquerdo X
		
		j END_INPUT_CHECK
	CHAR_LEFT:
		li a0,'a'
		li a7, 1
		ecall
		
		la t0,PLYR_POS
		lh t1, 0(t0)		# Topo esquerdo X
		addi t1,t1,-4
		sh t1, 0(t0)		# Topo esquerdo X
		
		j END_INPUT_CHECK
	CHAR_CROUCH:
		li a0,'s'
		li a7, 1
		ecall
		j END_INPUT_CHECK
	CHAR_JUMP:
		li a0,32
		li a7, 1
		ecall
		j END_INPUT_CHECK
	END_INPUT_CHECK:
		ret				
					
.include "SYSTEMv21.s"

# Sprites
.data
.include "sprites/data/walk_right.data"
.include "sprites/data/map.data"
