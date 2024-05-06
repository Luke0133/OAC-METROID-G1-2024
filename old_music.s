.data
music.num: .word 31
music.note_and_duration: .half 62,3573,62,397,60,397,62,397,64,2382,59,1191,53,397,59,397,60,397,62,3573,62,397,60,397,62,397,64,2382,59,1191,59,397,64,397,65,397,67,4764,65,2382,64,2382,65,3573,69,397,67,397,65,397,67,2382,64,1191,64,397,67,397,71,397,73,9528
music.initial_time: .word 0 		# guarda o tempo que a nota come�ou a tocar
music.counter: .half 0, 1		# para manter refer�ncia de qual nota deve tocar
music.note_counter: .word 0		# conta a quant. de notas
music.current_duration: .half 0		# dura��o da nota que est� tocando agora

.text
GAME_LOOP:
    call music.NOTE


# toca a musica, vendo se passou tempo suficiente pra tocar a proxima
# (bug que so toca ate a metade, ja tava no meu codigo de musica de ISC)
music.NOTE:
  # pega a dura��o da nota atual
  	la t1, music.current_duration
  	lhu t1, 0(t1)
  # faz a syscall de tempo para comparar com o tempo inicial salvo
  	li a7, 30
  	ecall					# a0 = low order 32 bits of the current time in milliseconds since 1 January 1970

  	la t0, music.initial_time		# low order 32 bits of the time when the current note started playing
  	lw t0, 0(t0)

  # gets the difference between the stored time and the current time and check it that's greater than the duration
  	sub t0, a0, t0

  # in case there was a rare exception in which that difference is zero, play the note anyway to keep the music playing
 	blt t0, zero, music.PLAY

  # now check if that difference is equal or greater than the note duration
  	bgeu t0, t1, music.PLAY

	ret		# if not, just go back

music.PLAY:
  # gets the current time and stores it in memory
	li a7, 30
	ecall
	la t0, music.initial_time
	sw a0, 0(t0)
  # gets the next note and duration in memory
  	la t0, music.counter
  	lhu t1, 0(t0)
  	lhu t2, 2(t0)
  	slli t1, t1, 1		# multiplies by 2 because we are dealing with halfword addresses
  	slli t2, t2, 1
  	la t3, music.note_and_duration
  	add t4, t3, t2		# duration address
  	add t3, t3, t1		# note address
  	lhu a0, 0(t3)		# note
  	lhu a1, 0(t4)		# duration
  	
  # setting up the rest of the parameters of the syscall
  	li a2,51
  	li a3, 127		# volume 
  	li a7, 31		# MIDI Out Syscall
  	ecall
  	
  # stores new duration and counters in memory
  	srli t1, t1, 1		# restores the original form of the note counters
  	srli t2, t2, 1
  	addi t1, t1, 1		# goes to next note and duration
  	addi t2, t2, 1 
  	sh t1, 0(t0)
  	sh t2, 2(t0)
  	
  	la t0, music.current_duration
  	sh a1, 0(t0)		# stores the duration of the current note
  	
  	la t0, music.note_counter
  	lw t0, 0(t0)
  	la t1, music.num
  	lw t1, 0(t1)		# total number of notes
  	
  	bgt t0, t1, music.RESET	# if the number of notes played is bigger than what is avilable, reset
  	
  	la t1, music.note_counter
  	addi t0, t0, 1		# number of notes that have been played
  	sw t0, 0(t1)
  	
  	ret
  	
music.RESET:
	la t0, music.note_counter
	sw zero, 0(t0)
	
	la t0, music.counter
	li t1, 1
	sh zero, 0(t0)
	sh t1, 2(t0)
	
	ret
