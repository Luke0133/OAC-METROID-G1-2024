.include "MACROSv21.s" # Macros para bitmap display


.data
.eqv frame_rate 90 # T ms por frame 
RUN_TIME: .word 0 # Guarda quanto tempo passou 

# Player Info
.eqv PLYR_HEALTH 100
PLYR_POS: .half 40, 200, 0, 0 # Guarda a posicao do jogador (topo esquerdo X e Y) e sua antiga posicao (topo esquerdo X e Y)
LIFE_POS: .half 40,200, 0, 0
PLYR_INFO: .half 0, 0 # Guarda a vida e numero de armas especiais

#Enemies Info
.eqv ZOOMER_HEALTH 50
.eqv RIPPER_HEALTH 50
.eqv RIDLEY_HEALTH 200


.text

BEGIN:
	la t0,PLYR_INFO
	lh t1, 0(t0) # pega a vida da samus
	bnez t1, SETUP # se nao for zero, vai pro setup
	li t1, PLYR_HEALTH # carrega a vida da samus
	sh t1,0(t0) # guarda a vida da samus em PLYR_INFO
	j SETUP

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
	li a1, 84		# Topo esquerdo X
	li a2, 160		# Topo esquerdo Y		
	li a3, 24		# Largura da imagem
	li a4, 32		# Altura da imagem	
	mv a5, s0		# Frame
	
	call RENDER

	###############################				

	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)
	
	##### LIMPEZA DE RASTRO
	
	mv a5, s0		# Frame
	mv a5,s0			# carrega o frame atual (que esta na tela em a3)
	xori a5,a5,1			# inverte a3 (0 vira 1, 1 vira 0)
	
	la a0, walk_right 		# Gets sprite address# Endereco do mapa
	li a1, 84		# Topo esquerdo X
	li a2, 160		# Topo esquerdo Y		
	li a3, 24		# Largura da imagem
	li a4, 32		# Altura da imagem	
	call RENDER			# imprime
	
	##### CARREGAR A VIDA ##########
	##### "EN" #############
	la a0, health
	li a1, 30 # Topo esquerdo X
	li a2, 60 # Topo esquerdo Y
	li a3, 24 # Largura da imagem
	li a4, 8 # Altura da imagem
	mv a5, s0 # Frame
	call RENDER

	###### LIFE POINTS ############
	li a0,100
	li a1,60
	li a2,60
	li a3,0xc9
	li a4,1
	li a7,101
	ecall

	###############################

	##### RENDERIZAR TIRO ##########

	la a0, beam
	li a1, 150 # Topo esquerdo X
	li a2, 160 # Topo esquerdo Y
	li a3, 8 # Largura da imagem
	li a4, 8 # Altura da imagem
	mv a5, s0 # Frame
	call RENDER

	###############################

	##### RENDERING VILLAINS #######

	#### Ridley ####
	la a0, kraid_sit
	li a1, 200 # Topo esquerdo X
	li a2, 140 # Topo esquerdo Y
	li a3, 32 # Largura da imagem
	li a4, 40 # Altura da imagem
	mv a5, s0 # Frame
	call RENDER

	#### Ripper ####
	la a0, ripper
	li a1, 260 # Topo esquerdo X
	li a2, 140 # Topo esquerdo Y
	li a3, 16 # Largura da imagem
	li a4, 8 # Altura da imagem
	mv a5, s0 # Frame
	call RENDER

	################################

	#### Zoomer ####
	#la a0, zoomer_vertical
	#li a1, 260 # Topo esquerdo X
	#li a2, 140 # Topo esquerdo Y
	#li a3, 16 # Largura da imagem
	#li a4, 4 # Altura da imagem
	#mv a5, s0 # Frame
	#call RENDER

	################################

	################################

	j ENGINE_LOOP	# Volta para ENGINE_LOOP

# samus sofreu dano dos inimigos!!!
IF_HURT:
		lh t1, 0(t0)
		addi t1,t1,-20
		sh t1, 0(t0)
		bge zero, t1, KILL_PLYR
		ret

# vida de samus == 0!!!!!!!!!
KILL_PLYR:
		la a0, gameover 		# Endereco do mapa
		li a1, 0		# Topo esquerdo X
		li a2, 0		# Topo esquerdo Y		
		li a3, 320		# Largura da imagem
		li a4, 240		# Altura da imagem	
		li a5, 0		# Frame = 0
		call RENDER	
		la a0, gameover 	# Endereco do mapa
		li a1, 0		# Topo esquerdo X
		li a2, 0		# Topo esquerdo Y		
		li a3, 320		# Largura da imagem
		li a4, 240		# Altura da imagem	
		li a5, 0		# Frame = 0
		li a5, 1		# Frame = 1
		call RENDER	
		li s0, 0
		ret

RENDER:
	li t0,0xFF0	# t0 = 0xFF0
	add t0,t0,a5	# Rendering Address corresponds to 0x0FF0 + frame
	slli t0,t0,20	# Shifts 20 bits, making printing adress correct (0xFF00 0000 or 0xFF10 0000)
	
	add t0,t0,a1	# t0 = 0xFF00 0000 + X or 0xFF10 0000 + X
	
	li t1,320	# t1 = 320
	mul t1,t1,a2	# t1 = 320 * Y 
	add t0,t0,t1	# t0 = 0xFF00 0000 + X + (Y * 320) or 0xFF10 0000 + X + (Y * 320)
	
	addi a0,a0,8			# t1 = a0 + 8
	
	mv t2,zero	# t2 = 0 (Resets line counter)
	mv t3,zero	# t3 = 0 (Resets column counter)
	
	PRINT_LINE:
		lw t4,0(a0)	# loads word(4 pixels) on t4
		sw t4,0(t0)	# prints 4 pixels from t4
		
		addi t0,t0,4	# increments bitmap address
		addi a0,a0,4	# increments image address
		
		addi t3,t3,4		# increments column counter
		blt t3,a3,PRINT_LINE	# if column counter < width, repeat
		
		addi t0,t0,320	# goes to next line on bitmap display
		sub t0,t0,a3	# goes to right X on bitmap display (current address - width)
		
		mv t3,zero		# t3 = 0
		addi t2,t2,1		# increments line counter
		bgt a4,t2,PRINT_LINE	# if height > line counter, repeat
		ret	
####### THINKING ABOUT ENEMIES! ##########
## Ridley:
#-Up
#-Down
#-Attack
#
## Zoomer:
#-Left
#-Right 
#-Up 
#-Down 
#
## Ripper:
#-Left 
#-Right 

.include "SYSTEMv21.s"
.include "teclado.s"
#.include "render.s"

# Sprites
.data

.include "sprites/data/walk_right.data"
.include "sprites/data/map.data"
.include "sprites/data/health.data"
.include "sprites/data/beam.data"
.include "sprites/data/full_health.data"
.include "sprites/data/gameover.data"
.include "sprites/data/kraid_sit.data"
.include "sprites/data/ripper.data"
.include "sprites/data/zoomer_vertical.data"
.include "sprites/data/zoomer_horizontal.data"
