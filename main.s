.include "MACROSv21.s" # Macros para bitmap display
 
.data
####### Informations related to frame rate  ####### 
.eqv frame_rate 90 # T ms por frame 
RUN_TIME: .word 0 # Guarda quanto tempo passou 
####### .eqv related to tiles  ####### 
.eqv tile_size 16	# Tile size (use powers of 2 in order to use tile_size_shift)
.eqv tile_size_shift 4  # Power value that gives tile size (2^tile_size_shift = tile_size)
####### .eqv related to screen  ####### 
.eqv m_screen_width 20
.eqv m_screen_height 15
.eqv left_hor_border 112
.eqv right_hor_border 184

####### Map informations ####### 
CURRENT_MAP: .word 0
MAP_INFO: .byte 23, 0, 0, 0 # num_map,x of matrix,y of matrix ,no_use

####### Player informations #########
PLYR_INFO: .byte 100, 0 # Stores player's health points, number of habilities (0 - none, 1 - ball, 2 - ball + bomb)
PLYR_POS: .half 148, 0  # Stores Player's current and old top left X respectively, both related to the screen  
	  .byte 160, 0,   # Stores Player's current and old top left Y respectively, both related to the screen 
	        8, 0 # Stores Player's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
PLYR_MATRIX: .byte 33, 0, 0, 0 # Stores Player's top left new and old X and new and old Y respectively, all related to the map matrix 
PLYR_STATUS: .byte 0,0,0,0 # Sprite's Number, Facing Direction (0 = Right, 1 = Left), Vertical Direciton (0 - Normal, 1 - Facing Up), Ground Postition (0 - On Ground, 1 - Freefall)
		   0,0 # Ball Mode (0 - Disabled, 1 - Enabled), Attacking (0 - no, 1 - yes) 
MOVE_X: .byte 0 # -1 esq, 1 dir, 0 parado
MOVE_Y: .byte 0

.eqv standing_front_hitbox 8 # offset from the front of Samus' standing sprite 
.eqv standing_back_hitbox 4  # offset from the back of Samus' standing sprite 
.eqv PLYR_HEALTH 100
.eqv SAM_WALK 20
.eqv SAM_SHOOT 28
.eqv SAM_BALL 16
.eqv JUMP_FORCE -5 
.eqv GRAVITY 10

## ZOOMER ##
ZOOMER_INFO: .byte 0, 0 # Stores Zoomer's health points, Rendering (0 - Disabled, 1 - Enabled)
ZOOMER_POS: .half 240, 0 # Stores Zoomer's current and old top left X respectively, both related to the screen  
	    .byte 96, 0 # Stores Zoomer's current and old top left Y respectively, both related to the screen 
	     	  0, 0 # Stores Zoomer's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
ZOOMER_MATRIX: .byte 0, 0, 0, 0 # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
ZOOMER_STATUS: .byte 0,0 # Sprite's Number, Movement Direction (Clockwise: 0 - Right/Top, 1 - Down/Right, 2 - Left/Bottom, 3 - Up/Left and
			 #                                      Counter-Clockwise: 4 - Left/Top, 5 - Down/Left, 6 - Right/Bottom, 7 - Up/Right)
.eqv ZOOMER_HEALTH 50

## RIPPER ##
RIPPER_INFO: .byte 0, 0 # Stores Ripper's health points, Rendering (0 - Disabled, 1 - Enabled)
RIPPER_POS: .half 80, 0 # Stores Ripper's current and old top left X respectively, both related to the screen  
	    .byte 180, 0 # Stores Ripper's current and old top left Y respectively, both related to the screen 
	     	  0, 0 # Stores Ripper's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
RIPPER_MATRIX: .byte 0, 0, 0, 0 # Stores Ripper's top left new and old X and new and old Y respectively, all related to the map matrix 
RIPPER_STATUS: .byte 0,0 # Sprite's Number, Movement Direction (0 = Right, 1 = Left)
.eqv ZOOMER_HEALTH 50

## RIDLEY ##
RIDLEY_INFO: .byte 0, 0 # Stores Ridley's health points, Rendering (0 - Disabled, 1 - Enabled)
RIDLEY_POS: .half 80, 0 # Stores Ridley's current and old top left X respectively, both related to the screen  
	    .byte 180, 0 # Stores Ridley's current and old top left Y respectively, both related to the screen 
RIDLEY_MATRIX: .byte 0, 0, 0, 0 # Stores Ridley's top left new and old X and new and old Y respectively, all related to the map matrix 
RIDLEY_STATUS: .byte 0,0 # Sprite's Number, Ground Position (0 - On Ground, 1 - Freefall)
.eqv RIDLEY_HEALTH 200
last_key: .byte 0 #0=0,1=w,2=a,3=s,4=d
desc: .byte 0

# BOMBA 1
## COORDENADAS
## RENDERIZAR/STATUS
# BOMBA 2



		
.text

SETUP:
## DEBUG
#	li a0, 0x66 		# Endereco do mapa
#	li a1, 0		# Topo esquerdo X
#	li a2, 0		# Topo esquerdo Y		
#	li a3, 320		# Largura da imagem
#	li a4, 240		# Altura da imagem	
#	li a5, 0		# Frame = 0
#	call RENDER_COLOR
#	li a0,1000
#	li a7,32
#	ecall
##
	la a0, Map1 		# Map Address
	li a1, 23		# starting X on Matrix (top left)
	li a2, 0		# starting Y on Matrix (top left)		
	li a3, 8		# X offset (0, 4, 8, 12)
	li a4, 0		# Y offset (0, 4, 8, 12)	
	li a5, 0		# Frame = 0
	li a6, m_screen_width	# Screen Width = 20
	li a7, m_screen_height	# Screen Height = 15
	li t3, 0		# Starting X for rendering (top left, related to Matrix)
	li t2, 0		# Starting Y for rendering (top left, related to Matrix)
	call RENDER_MAP
## DEBUG
#	li a0, 0x66 		# Endereco do mapa
#	li a1, 0		# Topo esquerdo X
#	li a2, 0		# Topo esquerdo Y		
#	li a3, 320		# Largura da imagem
#	li a4, 240		# Altura da imagem	
#	li a5, 1		# Frame = 0
#	call RENDER_COLOR
##
	la a0, Map1 		# Map Address
	li a1, 23		# starting X on Matrix (top left)
	li a2, 0		# starting Y on Matrix (top left)		
	li a3, 8		# X offset (0, 4, 8, 12)
	li a4, 0		# Y offset (0, 4, 8, 12)	
	li a5, 1		# Frame = 1
	li a6, m_screen_width	# Screen Width = 20
	li a7, m_screen_height	# Screen Height = 15
	li t3, 0		# Starting X for rendering (top left, related to Matrix)
	li t2, 0		# Starting Y for rendering (top left, related to Matrix)
	call RENDER_MAP
	
	la t0,Map1
	la t1,CURRENT_MAP
	sw t0,0(t1)

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
	call PHYSICS
	xori s0,s0,1			# inverte o valor frame atual (somente o registrador)
	
							
	la a0, sam_walk_vertical_esq 		# Gets sprite address# Endereco do mapa
	la t0,PLYR_POS
	lh a1, 0(t0)		# Topo esquerdo X
	lbu a2, 4(t0)		# Topo esquerdo Y	
#	li a1, 148		# Topo esquerdo X
#	li a2, 160		# Topo esquerdo Y	
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
	
	la a0, sam_walk_vertical_esq 		# Gets sprite address# Endereco do mapa
	la t0,PLYR_POS
	lh a1, 0(t0)		# Topo esquerdo X
	lbu a2, 4(t0)		# Topo esquerdo Y
#	li a1, 148		# Topo esquerdo X
#	li a2, 160		# Topo esquerdo Y		
	li a3, 20		# Largura da imagem
	li a4, 32		# Altura da imagem	
	mv a5, s0		# Frame
	li a6, 0
	li a7, 0
	
	call RENDER	
	
	j ENGINE_LOOP	# Volta para ENGINE_LOOP



.include "input.s"
.include "physics.s"
.include "render.s"										
.include "SYSTEMv21.s"
# Sprites
.data
DELETE:
.include "sprites/data/sam_walk_vertical.data"
.include "sprites/data/sam_walk_vertical_esq.data"
.include "sprites/data/walk_right.data"
.include "sprites/data/beam.data"
.include "sprites/data/health.data"
.include "sprites/data/full_health.data"
.include "sprites/data/gameover.data"
.include "sprites/data/kraid_sit.data"
.include "sprites/data/ripper.data"
.include "sprites/data/zoomer_vertical.data"
.include "sprites/data/zoomer_horizontal.data"
.include "sprites/data/matrix.data"
.include "sprites/data/tiles.data"
