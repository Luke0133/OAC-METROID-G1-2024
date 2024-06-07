.include "helpers/MACROSv21.s" # Macros para bitmap display
.include "helpers/data.s"

.data
DEBUG: .string "\n"

		
.text

main:
	call SETUP


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

	  
	xori s0,s0,1			# inverte o valor frame atual (somente o registrador)

	call INPUT_CHECK	# Checa input do jogador
	call PHYSICS
	call MAP_MOVE_RENDER
	##### DEBUG
    #  li a0, 3000
    #  li a7, 32
    #  ecall
      ##### DEBUG

	la a0, Samus_Right_Idle 		# Gets sprite address# Endereco do mapa
	la t0,PLYR_POS
	lh a1, 0(t0)		# Topo esquerdo X
	lbu a2, 4(t0)		# Topo esquerdo Y	
	li a3, 20		# Largura da imagem
	li a4, 32		# Altura da imagem	
	mv a5, s0		# Frame
	li a6, 0
	li a7, 0
	
	call RENDER					
									
	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)
	
	##### LIMPEZA DE RASTRO
	
	mv a5, s0		# Frame
	mv a5,s0		# carrega o frame atual (que esta na tela em a3)
	xori a5,a5,1		# inverte a3 (0 vira 1, 1 vira 0)
	
#	la a0, Samus_Right_Idle 		# Gets sprite address# Endereco do mapa
#	la t0,PLYR_POS
#	lh a1, 0(t0)		# Topo esquerdo X
#	lbu a2, 4(t0)		# Topo esquerdo Y	
#	li a3, 20		# Largura da imagem
#	li a4, 32		# Altura da imagem	
#	mv a5, s0		# Frame
#	li a6, 0
#	li a7, 0
#	
#	call RENDER	
	
	j ENGINE_LOOP	# Volta para ENGINE_LOOP


.include "helpers/helpers.s"

.include "sprites/sprites.s"

