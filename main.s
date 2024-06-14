.include "helpers/MACROSv21.s" # Macros para bitmap display
.include "helpers/data.s"

.data
DEBUG: .string "\n"
DEBUG1: .string "rarara\n"
		
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
	######################
#	li a0, 3000
#	li a7, 32
#	ecall
##################
	call PHYSICS

#la a0, MOVE_X#
#	lb a0,0(a0)
#    li a7, 1
#    ecall
#la a0, MAP_INFO
#	lb a0,1(a0)
#    li a7, 1
#    ecall
	
	
#	la a0, DEBUG
#    li a7, 4
#    ecall




	call MAP_MOVE_RENDER
	


	
######################
#	li a0, 20
#	li a7, 32
#	ecall
##################
	li a0, 0
	call RENDER_PLAYER
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
									
	li t0,0xFF200604		# carrega em t0 o endereco de troca de frame
	sw s0,0(t0)
	
######################
#	li a0, 3000
#	li a7, 32
#	ecall
##################


	li a0, 1
	call RENDER_PLAYER

	##### LIMPEZA DE RASTRO
	
	#mv a5,s0		# carrega o frame atual (que esta na tela em a3)
	
	
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
	li a7,30	# gets time passed
	ecall 		# syscall
	la t0,RUN_TIME	# Loads RUN_TIME address
	sw a0,0(t0)	# new time is stored in RUN_TIME, in order to be compared later		

	j ENGINE_LOOP	# Volta para ENGINE_LOOP


.include "helpers/helpers.s"

.include "sprites/sprites.s"

