.include "MACROSv21.s" # Macros para bitmap display

.data
# FRAMES,TILES AND TIME
.eqv tile_size 16
.eqv frame_rate 90 # T ms por frame 
RUN_TIME: .word 0 # Guarda quanto tempo passou 

### SAMUS INFO ###
PLYR_STATUS: .byte 0,0,0 # Numero da sprite, direcao do movimento (0 = s, 1 = w, 2 = d, 3 = a), jogador atacando = 1
PLYR_POS: .half 40, 180, 0, 0 # Guarda a posicao do jogador (topo esquerdo X e Y) e sua antiga posicao (topo esquerdo X e Y)
PLYR_MATRIX: .byte 0, 0, 0, 0 # Stores Player's top left new and old X and new and old Y respectively, all related to the map matrix 
PLYR_INFO: .byte 0, 0 # Guarda a vida, numero de armas especiais
.eqv PLYR_HEALTH 100

### ENEMIES INFO ###

## ZOOMER ##
ZOOMER_STATUS: .byte 0,0 # Numero da sprite, direcao do movimento (0 = s, 1 = w, 2 = d, 3 = a)
ZOOMER_POS: .half 240, 96, 0, 0 # Guarda a posicao do jogador (topo esquerdo X e Y) e sua antiga posicao (topo esquerdo X e Y)
ZOOMER_MATRIX: .byte 0, 0, 0, 0 # Stores Player's top left new and old X and new and old Y respectively, all related to the map matrix 
ZOOMER_INFO: .byte 0
.eqv ZOOMER_HEALTH 50

## RIPPER ##
RIPPER_STATUS: .byte 0,0 # Numero da sprite, direcao do movimento (0 = a, 1 = d)
RIPPER_POS: .half 80, 180, 0, 0 # Guarda a posicao do jogador (topo esquerdo X e Y) e sua antiga posicao (topo esquerdo X e Y)
RIPPER_MATRIX: .byte 0, 0, 0, 0 # Stores Player's top left new and old X and new and old Y respectively, all related to the map matrix 
RIPPER_INFO: .byte 0
.eqv RIPPER_HEALTH 50

## RIDLEY ##
RIDLEY_STATUS: .byte 0,0,0 # Numero da sprite, direcao do movimento (0 = s, 1 = w), attack = 1
RIDLEY_POS: .half 80, 180, 0, 0 # Guarda a posicao do jogador (topo esquerdo X e Y) e sua antiga posicao (topo esquerdo X e Y)
RIDLEY_MATRIX: .byte 0, 0, 0, 0 # Stores Player's top left new and old X and new and old Y respectively, all related to the map matrix 
RIDLEY_INFO: .byte 0, 0 # Guarda a vida, numero de armas especiais
.eqv RIDLEY_HEALTH 200

DELETE: .word 0
		
.text

SETUP:
## DEBUG
	li a0, 0x66 		# Endereco do mapa
	li a1, 0		# Topo esquerdo X
	li a2, 0		# Topo esquerdo Y		
	li a3, 320		# Largura da imagem
	li a4, 240		# Altura da imagem	
	li a5, 0		# Frame = 0
	call RENDER_COLOR

	la a0, Map2 		# Endereco do mapa
	li a1, 0		# starting X on Matrix (top left)
	li a2, 30		# starting Y on Matrix (top left)		
	li a3, 0		# X offset (0, 4, 8, 12)
	li a4, 0		# Y offset (0, 4, 8, 12)	
	li a5, 0		# Frame = 0
	call RENDER_MAP
## DEBUG
	li a0, 0x66 		# Endereco do mapa
	li a1, 0		# Topo esquerdo X
	li a2, 0		# Topo esquerdo Y		
	li a3, 320		# Largura da imagem
	li a4, 240		# Altura da imagem	
	li a5, 1		# Frame = 0
	call RENDER_COLOR
##
	la a0, Map2 		# Endereco do mapa
	li a1, 0		# starting X on Matrix (top left)
	li a2, 30		# starting Y on Matrix (top left)		
	li a3, 0		# X offset (0, 4, 8, 12)
	li a4, 0		# Y offset (0, 4, 8, 12)	
	li a5, 1		# Frame = 1
	call RENDER_MAP
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

	############# SPRITES ACESSORIAS #####################
			##### CARREGAR A VIDA ##########
			##### "EN" #############
			la a0, health
			li a1, 32 # Topo esquerdo X
			li a2, 20 # Topo esquerdo Y
			li a3, 24 # Largura da imagem
			li a4, 8 # Altura da imagem
			mv a5, s0 # Frame
			li a6, 0
			li a7, 0
			call RENDER

			###### LIFE POINTS ############
			
			#a3 = bgr fundo e bgr frente no a4
			li a0,100 # a0 = inteiro
			li a1,60 # a1 = coluna
			li a2,20 # a2 = linha 
			li a3,0x00ff # a3 = cores 
			li a4,1 # a4 = frame
			li a7,101 #syscal pra print integer
			ecall

			li a0,100 # a0 = inteiro
			li a1,60 # a1 = coluna
			li a2,20 # a2 = linha 
			li a3,0x00ff # a3 = cores 
			li a4,0 # a4 = frame
			li a7,101 #syscal pra print integer
			ecall
			
			###############################

				
			########## tiro ################

			la a0, beam 		# Gets sprite address# Endereco do mapa
			li a1, 76		# Topo esquerdo X
			li a2, 184		# Topo esquerdo Y		
			li a3, 8		# Largura da imagem
			li a4, 8		# Altura da imagem	
			mv a5, s0		# Frame
			li a6, 0
			li a7, 0
			call RENDER

			#############################

	####### sprite 0 do zoomer ###########

	la a0, zoomer_horizontal
	la t0,ZOOMER_POS
	lh a1, 0(t0)
	lh a2, 2(t0)
	li a3, 16
	li a4, 16
	mv a5,s0

	la t0, ZOOMER_STATUS
	lb a6, 0(t0) 

	li a7, 0

	call RENDER

	############################################

	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)
	
	##### LIMPEZA DE RASTRO
	
	mv a5, s0		# Frame
	mv a5,s0			# carrega o frame atual (que esta na tela em a3)
	xori a5,a5,1			# inverte a3 (0 vira 1, 1 vira 0)
	
	
	la a0, zoomer_horizontal		# Gets sprite address# Endereco do mapa
	la t0,ZOOMER_POS
	lh a1, 0(t0)		# Topo esquerdo X
	lh a2, 2(t0)		# Topo esquerdo Y		
	li a3, 16		# Largura da imagem
	li a4, 16		# Altura da imagem	
	mv a5, s0		# Frame
	
	la t0, ZOOMER_STATUS
	lb a6, 0(t0) 

	li a7, 0
	
	call RENDER

	############################################		
	
	############# SPRITES ACESSORIAS #####################


	call INPUT_CHECK	# Checa input do jogador
	xori s0,s0,1			# inverte o valor frame atual (somente o registrador)
									
	la a0, sam_walk_vertical 		# Gets sprite address# Endereco do mapa
	la t0,PLYR_POS
	lh a1, 0(t0)		# Topo esquerdo X
	lh a2, 2(t0)		# Topo esquerdo Y		
	li a3, 20		# Largura da imagem
	li a4, 32		# Altura da imagem	
	mv a5, s0		# Frame
	
	la t0, PLYR_STATUS
	lb a6, 0(t0)

	li a7, 0
	
	call RENDER					
									
	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)
	
	##### LIMPEZA DE RASTRO
	
	mv a5, s0		# Frame
	mv a5,s0		# carrega o frame atual (que esta na tela em a3)
	xori a5,a5,1		# inverte a3 (0 vira 1, 1 vira 0)
	
	la a0, sam_walk_vertical 	# Gets sprite address
	la t0,PLYR_POS
	lh a1, 0(t0)		# Topo esquerdo X
	lh a2, 2(t0)		# Topo esquerdo Y		
	li a3, 20		# Largura da imagem
	li a4, 32		# Altura da imagem	
	mv a5, s0		# Frame
	
	la t0, PLYR_STATUS
	lb a6, 0(t0)

	li a7, 0
	
	call RENDER
	
	j ENGINE_LOOP	# Volta para ENGINE_LOOP



.include "teclado.s"
.include "render.s"										
.include "SYSTEMv21.s"
# Sprites

.data
.include "sprites/data/walk_right.data"
.include "sprites/data/matrix.data"
.include "sprites/data/tiles.data"
.include "sprites/data/beam.data"
.include "sprites/data/sam_walk_vertical.data"
.include "sprites/data/health.data"
.include "sprites/data/full_health.data"
.include "sprites/data/gameover.data"
.include "sprites/data/kraid_sit.data"
.include "sprites/data/ripper.data"
.include "sprites/data/zoomer_vertical.data"
.include "sprites/data/zoomer_horizontal.data"