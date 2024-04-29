##########################     RENDER IMAGE    ##########################
#     -----------           argument registers           -----------    #
#	a0 = Image Address						#
#	a1 = X coordinate where rendering will start (top left)		#
#	a2 = Y coordinate where rendering will start (top left)		#
#	a3 = width of printing area (usually the size of the sprite)	#
# 	a4 = height of printing area (usually the size of the sprite)	#
#	a5 = frame (0 or 1)						#
# --->	a6 = status of sprite (usually 0 for sprites that are alone)	#
# --->	a7 = operation (0 if normal printing, 1 if replacing trail)	#
#     -----------          temporary registers           -----------    #
# --->	t0 = bitmap display printing address				#
# --->	t1 = image address						#
# --->	t2 = line counter						#
# --->	t3 = column counter						#
# --->	t4 = temporary operations					#
#########################################################################
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

#######################      RENDER MAPA	############################
# Used for rendering parts of sprites bigger than the 320 x 240 resolution #
#     -----------           argument registers           -----------       #
#	a0 = Image Address						   #
#	a1 = X (topo esquerdo) de onde comecar a renderizar a sprite	   #	
#	a2 = Y (topo esquerdo) de onde comecar a renderizar a sprite	   #	 		  
#	a3 = largura a ser renderizada					   #
# 	a4 = altura a ser renderizada					   #
#	a5 = frame (0 ou 1)						   #
# --->	a6 = operation (0 if normal printing, 1 if replacing trail)	   #
#	s8? -> X inicial (topo esquerdo) da renderizacao da sprite	   #
#       s9? -> Y inicial (topo esquerdo) da renderizacao da sprite 	   #	
#	s10? -> largura da sprite do mapa				   #
#	s11? -> altura da sprite do mapa			   	   #
#     -----------          temporary registers           -----------       #
#	t0 = endereco do bitmap display				           #
#	t1 = endereco da imagem a ser renderizado			   #				
#	t2 = contador de linhas						   #
#  	t3 = contador de colunas					   #
#  	t4 = operacoes temporarias					   #
############################################################################
RENDER_MAP:
# -----> USO DE PILHA --- CHECAR NECESSIDADE NO FINAL DO PROJETO
	addi sp,sp,-16	# prepara pilha para guardar os registradores s10 e s11
	sw s8 12(sp)	# armazena s10 na pilha
	sw s9 8(sp)	# armazena s11 na pilha
	sw s10 4(sp)	# armazena s10 na pilha
	sw s11 0(sp)	# armazena s11 na pilha
# ---- Fim das operacoes com pilha
	# Preparacao para renderizar o mapa
	add a0,a0,s8	# Endereco da imagem + X relativo ao mapa
	mul t4,s9,a3	# t4 = (Y relativo ao mapa) * (largura da imagem)
	add a0,a0,t4	# a0 = Endereco da imagem + X relativo ao mapa + (Y relativo ao mapa) * (largura da imagem)
	addi a0,a0,8 	# pular informacoes sobre imagem
	#Propper rendering

	li t0,0xFF0	# t0 = 0xFF0
	add t0,t0,a5	# Endereco de renderizacao = 0x0FF0 + frame
	slli t0,t0,20	# Shift de 20 bits, pra o endereco correto (0xFF00 0000 or 0xFF10 0000)
	
	add t0,t0,a1	# t0 = 0xFF00 0000 + X (Relativo ao bitmap display) ou 0xFF10 0000 + X (Relativo ao bitmap display)
	
	li t4,320	# t4 = 320
	mul t4,t4,a2	# t4 = 320 * Y (Relativo ao bitmap display)
	add t0,t0,t4	# t0 = 0xFF00 0000 + X + (Y * 320) ou 0xFF10 0000 + X + (Y * 320) -- X e Y relativos ao bitmap display
	
	addi a0,a0,8	# a0 = a0 + 8
	
	mv t2,zero	# t2 = 0 (contador de linhas -- associado a altura e o Y atual)
	mv t3,zero	# t3 = 0 (contador de coluna -- associado a linha e o X atual)
	
	PRINT_LINE_MAP:
		
			
		lw t4,0(a0)	# carrega uma word (4 pixels) para t4
		sw t4,0(t0)	# renderiza esses 4 pixels de t4 no bitmap display
		
		addi t0,t0,4	# incrementa endereco do bitmap display
		addi a0,a0,4	# incrementa endereco da imagem
		
		addi t3,t3,4	# incrementa contador de coluna
		blt t3,a3,PRINT_LINE_MAP	# se contador de coluna < largura (a ser renderizada), continua no loop
		
		addi t0,t0,320  # vai para a proxima linha no endereco do bitmap display 
		sub t0,t0,a3	# subtrai do endereco do bitmap display a largura a ser renderizada
		
		add a0,a0,s3	# a0 += s10 
		sub a0,a0,a3	# a0 -= largura a ser renderizada
		
		mv t3,zero		# t3 = 0 -- reseta contador de coluna
		addi t2,t2,1		# incrementa o contador de linha
		bgt a4,t2,PRINT_LINE_MAP	# se altura > contador de linha, continua no loop
		
# -----> USO DE PILHA --- CHECAR NECESSIDADE NO FINAL DO PROJETO
	lw s8 12(sp)	# armazena s10 na pilha
	lw s9 8(sp)	# armazena s11 na pilha
	lw s10 4(sp)	# armazena s10 na pilha
	lw s11 0(sp)	# armazena s11 na pilha
	addi sp,sp,16	# volta o ponteiro da pilha para posicao original
# ---- Fim das operacoes com pilha	
	ret	
