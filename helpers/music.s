.data
MUSIC.NOTES: .word 62,3573,62,397,60,397,62,397,64,2382,59,1191,53,397,59,397,60,397,62,3573,62,397,60,397,62,397,64,2382,59,1191,59,397,64,397,65,397,67,4764,65,2382,64,2382,65,3573,69,397,67,397,65,397,67,2382,64,1191,64,397,67,397,71,397,73,9528
MUSIC.STATUS: .word 0,0

.text

MUSIC.SETUP:
        la t0, MUSIC.NOTES
        la t1, MUSIC.STATUS
        sw t0, 4(t1)
        sw zero, 0(t1)
        ret

############ MUSIC PROCEDURE ###########################################
# Prodecures in order to be capable of play music while playing game
# --------------------------------------------------------------------
# a0 = status address 
# a1 = instrument
# a2 = volume
########################################################################

MUSIC.PLAY:        
        la a0, MUSIC.STATUS # loads status address
        li a2, 51 # instrument (range-ensemble)
        li a3, 50 # volume

        lw t0, 0(a0)
        beqz t0, MUSIC.PLAY.NOTE 
        csrr t1, 3073 # current time, read control and status register
        bltu t0, t1, MUSIC.PLAY.NOTE # next note > now ? play note : do nothing
        j MUSIC.RET

MUSIC.PLAY.NOTE:
        lw t0, 4(a0) # t0 = current note address 
        lw t1, 0(t0) # note 
        lw t2, 4(t0) # duration 

        beqz t1, MUSIC.LAST.PLAYED # note == 0, wait 

        mv t3, a0 # save a0 
        mv a0, t1 # a0 = note 
        mv a1, t2 # a1 = duration 
        li a7, 31 # Midi Out Syscall 
        ecall # play the note 

        mv a0, t3 # save a0 

MUSIC.LAST.PLAYED:
        bnez t2, MUSIC.LAST.PLAYED.SETUP # note != 0 && duration != 0 ? MUSIC.LAST.PLAYED.SETUP : restart
        j MUSIC.SETUP
        MUSIC.LAST.PLAYED.SETUP:
        csrr t3, 3073 # current time 
        add t3, t3, t2 # current time + note duration = next note time 
        sw t3, 0(a0) # save next note time 
        addi t0, t0, 8 # inc address of next note 
        sw t0, 4(a0) # save next note 

MUSIC.RET:
        ret
