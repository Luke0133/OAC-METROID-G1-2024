#.data
# Musica e status
#MUSIC_NOTAS: .word 62, 3573, 62, 397, 60, 397, 62, 397, 64, 2382, 59, 1191, 53, 397, 59, 397, 60, 397, 62, 3573, 62, 397, 60, 397, 62, 397, 64, 2382, 59, 1191, 59, 397, 64, 397, 65, 397, 67, 4764, 65, 2382, 64, 2382, 65, 3573, 69, 397, 67, 397, 65, 397, 67, 2382, 64, 1191, 64, 397, 67, 397, 71, 397, 73, 9528, 0, 0,
#MUSIC_STATUS:  .word 0, 0

.text
MUSIC.SETUP:		# guarda endereco da proxima nota nos status
			la		t0, MUSIC_NOTAS
			la		t1, MUSIC_STATUS
			sw		t0, 4(t1)
			sw		zero, 0(t1)
		
			ret

###################### PROCEDIMENTO MUSIC ######################
#	ARGUMENTOS:						#
#		a0 = endereco status				#
#		a1 = instrumento				#
#		a2 = volume					#
#################################################################
MUSIC.PLAY:		la		a0, MUSIC_STATUS
			li		a2, 0
			li		a3, 50

			lw		t0, 0(a0)
			beqz		t0, MUSIC.PLAY.NOTE

			csrr		t1, 3073		# current time
			bltu		t1, t0, MUSIC.RET	# if (now < next note) do nothing ELSE play note

MUSIC.PLAY.NOTE:	lw		t0, 4(a0)		# t0 = current note address
			lw		t1, 0(t0)		# nota
			lw		t2, 4(t0)		# duracao

			beqz		t1, MUSIC.LAST.PLAYED	# nota == 0, s� espera

			mv		t3, a0		# salva a0

			mv		a0, t1		# a0 = nota
			mv		a1, t2		# a1 = duracao
			li		a7, 31		# define a chamada de syscall
			ecall				# toca a nota

			mv		a0, t3		# restaura a0

MUSIC.LAST.PLAYED:	beqz		t2, MUSIC.SETUP	# nota == 0 e duracao == 0, recomeca

			csrr		t3, 3073	# current time
			add		t3, t3, t2	# current time + note duration = next note time
			sw		t3, 0(a0)	# save next note time

			addi		t0, t0, 8	# incrementa endere�o da proxima nota
			sw		t0, 4(a0)	# salva proxima nota

MUSIC.RET:		ret