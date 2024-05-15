.include "MACROSv21.s" # Macros para bitmap display

.data
.eqv tile_size 16
.eqv frame_rate 90 # T ms por frame 
RUN_TIME: .word 0 # Guarda quanto tempo passou 

PLYR_POS: .half 40, 180, 0, 0 # Guarda a posicao do jogador (topo esquerdo X e Y) e sua antiga posicao (topo esquerdo X e Y)

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
##
	la a0, Map1 		# Endereco do mapa
	li a1, 40		# Topo esquerdo X
	li a2, 0		# Topo esquerdo Y		
	li a3, 0		# Largura da imagem
	li a4, 0		# Altura da imagem	
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
	la a0, Map1 		# Endereco do mapa
	li a1, 40		# Topo esquerdo X
	li a2, 0		# Topo esquerdo Y		
	li a3, 0		# Largura da imagem
	li a4, 0		# Altura da imagem	
	li a5, 1		# Frame = 0
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
	call INPUT_CHECK	# Checa input do jogador
	xori s0,s0,1			# inverte o valor frame atual (somente o registrador)
			
	la a0, walk_right 		# Gets sprite address# Endereco do mapa
	la t0,PLYR_POS
	lh a1, 0(t0)		# Topo esquerdo X
	lh a2, 2(t0)		# Topo esquerdo Y		
	li a3, 24		# Largura da imagem
	li a4, 32		# Altura da imagem	
	mv a5, s0		# Frame
	li a6, 0
	li a7, 0
	
	call RENDER
	

	la a0, beam 		# Gets sprite address# Endereco do mapa
	li a1, 76		# Topo esquerdo X
	li a2, 180		# Topo esquerdo Y		
	li a3, 8		# Largura da imagem
	li a4, 8		# Altura da imagem	
	mv a5, s0		# Frame
	li a6, 0
	li a7, 0
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
	mv a5, s0		# Frame
	li a6, 0
	li a7, 0
	
	call RENDER


	la a0, beam 		# Gets sprite address# Endereco do mapa
	li a1, 76		# Topo esquerdo X
	li a2, 190		# Topo esquerdo Y		
	li a3, 8		# Largura da imagem
	li a4, 8		# Altura da imagem	
	mv a5, s0		# Frame
	li a6, 0
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
