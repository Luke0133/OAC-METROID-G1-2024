.data

# ----> Summary: stores everything (YES, EVERY SINGLE BYTE) that's used in the game
# 0 - WARNING  (READ IT BEFORE PLAYING)
# 1 - General Data (Information related to game)
# 2 - Doors
# 3 - Door Frames
# 4 - Map Parameters
# 5 - Tiles (Game's Tileset)
# 6 - Matrixes (Map Matrixes)
# 7 - Samus (Player's sprites)
# 8 - Beam (Samus' projectiles)

###############################################################################################
# WARNING!!!! Due to compatibility errors, make sure to comment/uncomment the modes bellow    #
# deppending on where you're running the game, in order to execute it properly  ;D            #
#                                                                                             #
#  For RARS:                                                                                  #
   #   .eqv KDMMIO_ADDRESS 0xFF200000                                                         #
#                                                                                             #
#  For FPGRARS:                                                                               #
     .eqv KDMMIO_ADDRESS 0xFF210000                                                         #
#                                                                                             #
#  For FPGA (DE1, using custom processor RISCV-V24):                                          #
#      --> go to helpers.s, comment "input.s" and uncomment"input_fpga.s                      # 
#                                                                                             #
###############################################################################################
.eqv RandIntRangeEcall 142

#MUSIC.INFO:  .byte 31,0
MUSIC_NOTAS: .word 43,391,43,130,38,130,43,130,43,391,43,130,38,130,43,130,46,391,46,130,41,130,46,130,46,391,46,130,41,130,46,130,43,391,43,130,38,130,43,130,43,391,43,130,38,130,43,130,46,391,46,130,41,130,46,130,46,391,46,130,41,130,46,130,43,347,0,44,43,130,55,130,50,130,43,260,0,130,43,130,50,130,43,130,46,347,0,44,46,130,53,130,46,130,46,260,0,130,46,130,53,130,46,130,43,347,0,43,43,130,55,130,50,130,43,260,0,131,43,130,50,130,43,130,46,347,0,43,46,130,53,130,46,130,46,260,0,131,46,130,53,130,46,130,43,347,0,44,43,130,55,130,50,130,43,260,0,130,43,130,50,130,43,130,46,347,0,44,46,130,53,130,46,130,46,260,0,130,46,130,53,130,46,130,43,260,0,130,50,130,43,130,43,130,43,260,0,131,50,130,43,130,43,130,43,260,0,130,50,130,43,130,43,130,43,260,0,131,50,130,43,130,43,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,39,326,0,65,39,130,36,130,39,130,39,326,0,65,39,130,36,130,39,130,38,326,0,65,38,130,34,130,38,130,38,326,0,65,38,130,34,130,38,130,39,326,0,66,39,130,36,130,39,130,39,326,0,65,39,130,36,130,39,130,38,326,0,65,38,130,34,130,38,130,38,326,0,65,38,130,34,130,38,130,43,260,0,130,33,260,0,130,35,260,0,131,36,260,0,131,38,260,0,130,40,260,0,131,42,260,0,131,43,260,0,130,44,260,0,130,44,130,39,130,36,130,32,260,0,130,32,130,36,130,32,130,34,260,0,131,38,260,0,130,36,260,0,130,34,260,0,131,45,260,0,131,45,260,0,130,45,260,0,130,45,260,0,131,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,0,6261,43,347,0,43,43,130,55,130,50,130,43,260,0,131,43,130,50,130,43,130,46,347,0,43,46,130,53,130,46,130,46,260,0,130,46,130,53,130,46,130,43,347,0,44,43,130,55,130,50,130,43,260,0,130,43,130,50,130,43,130,46,347,0,44,46,130,53,130,46,130,46,260,0,130,46,130,53,130,46,130,43,347,0,43,43,130,55,130,50,130,43,260,0,131,43,130,50,130,43,130,46,347,0,43,46,130,53,130,46,130,46,260,0,131,46,130,53,130,46,130,43,260,0,130,50,130,43,130,43,130,43,260,0,130,50,130,43,130,43,130,43,260,0,131,50,130,43,130,43,130,43,260,0,130,50,130,43,130,43,130,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,39,326,0,66,39,130,36,130,39,130,39,326,0,65,39,130,36,130,39,130,38,326,0,65,38,130,34,130,38,130,38,326,0,65,38,130,34,130,38,130,39,326,0,65,39,130,36,130,39,130,39,326,0,66,39,130,36,130,39,130,38,326,0,65,38,130,34,130,38,130,38,326,0,65,38,130,34,130,38,130,43,260,0,131,33,260,0,131,35,260,0,130,36,260,0,130,38,260,0,131,40,260,0,130,42,260,0,130,43,260,0,131,44,260,0,130,44,130,39,130,36,130,32,260,0,131,32,130,36,130,32,130,34,260,0,130,38,260,0,130,36,260,0,131,34,260,0,130,45,260,0,130,45,260,0,131,45,260,0,130,45,260,0,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,0,0
MUSIC_STATUS:  .word 0,0


Brinstar: .byte 0 # whether should play it or not
.word 0
Brinstar_Lead_0: .half 78,0    # Total number of notes, Current note number
                 .word 0,0     # Time last note played + its duration, Next note's address,  Note list (bellow)
Brinstar_Lead_0_Notes: .word 59,1565,60,1565,59,1565,60,1565,67,1565,60,782,65,652,0,22,65,108,67,1565,60,782,65,652,0,22,65,108,67,1565,60,782,65,652,0,22,65,108,67,3130,64,1173,67,130,60,130,67,130,65,782,62,782,64,1173,67,130,60,130,67,130,65,782,62,782,64,1173,67,130,60,130,67,130,65,782,62,782,64,1565,55,1565,65,391,60,391,57,391,69,130,58,130,60,130,62,391,65,391,60,391,60,391,63,391,57,391,53,391,48,391,70,782,58,391,50,130,55,130,57,130,59,782,57,782,55,782,71,782,63,391,65,391,56,391,55,130,53,130,51,130,53,391,58,391,55,391,53,130,62,130,62,130,62,1565,59,782,55,782,

Brinstar_Lead_1: .half 87,0    # Total number of notes, Current note number
                 .word 0,0     # Time last note played + its duration, Next note's address,  Note list (bellow)
Brinstar_Lead_1_Notes: .word 0,6260,59,782,62,782,70,1130,69,108,70,108,69,108,0,109,59,782,62,782,70,1130,69,108,70,108,69,108,0,108,59,782,62,782,70,1130,69,108,70,108,69,108,0,109,59,1565,60,782,62,782,72,1173,64,130,0,131,64,130,70,1130,69,108,70,108,69,108,65,108,72,1173,64,130,0,130,64,130,70,1130,69,108,70,108,69,108,65,108,72,1173,64,130,0,131,64,130,70,1130,69,108,70,108,69,108,65,108,67,1565,64,1565,69,1173,60,130,67,130,69,130,70,782,65,391,67,130,65,130,67,130,69,1173,69,130,67,130,69,130,50,391,53,391,65,391,65,130,70,130,72,130,74,1565,72,782,62,782,72,1173,75,130,74,130,72,130,74,782,70,391,70,130,74,130,77,130,78,1565,78,1565,

Brinstar_Bass:   .half 287,0    # Total number of notes, Current note number
                 .word 0,0      # Time last note played + its duration, Next note's address,  Note list (bellow)
Brinstar_Bass_Notes:  .word 43,391,43,130,38,130,43,130,43,391,43,130,38,130,43,130,46,391,46,130,41,130,46,130,46,391,46,130,41,130,46,130,43,391,43,130,38,130,43,130,43,391,43,130,38,130,43,130,46,391,46,130,41,130,46,130,46,391,46,130,41,130,46,130,,43,347,0,44,43,130,55,130,50,130,43,260,0,130,43,130,50,130,43,130,46,347,0,44,46,130,53,130,46,130,46,260,0,130,46,130,53,130,46,130,43,347,0,43,43,130,55,130,50,130,43,260,0,131,43,130,50,130,43,130,46,347,0,43,46,130,53,130,46,130,46,260,0,131,46,130,53,130,46,130,43,347,0,44,43,130,55,130,50,130,43,260,0,130,43,130,50,130,43,130,46,347,0,44,46,130,53,130,46,130,46,260,0,130,46,130,53,130,46,130,43,260,0,130,50,130,43,130,43,130,43,260,0,131,50,130,43,130,43,130,43,260,0,130,50,130,43,130,43,130,43,260,0,131,50,130,43,130,43,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,36,130,43,130,36,130,36,260,0,130,36,130,43,130,36,130,36,260,0,131,39,326,0,65,39,130,36,130,39,130,39,326,0,65,39,130,36,130,39,130,38,326,0,65,38,130,34,130,38,130,38,326,0,65,38,130,34,130,38,130,39,326,0,66,39,130,36,130,39,130,39,326,0,65,39,130,36,130,39,130,38,326,0,65,38,130,34,130,38,130,38,326,0,65,38,130,34,130,38,130,43,260,0,130,33,260,0,130,35,260,0,131,36,260,0,131,38,260,0,130,40,260,0,131,42,260,0,131,43,260,0,130,44,260,0,130,44,130,39,130,36,130,32,260,0,130,32,130,36,130,32,130,34,260,0,131,38,260,0,130,36,260,0,130,34,260,0,131,45,260,0,131,45,260,0,130,45,260,0,130,45,260,0,131,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,45,130,


Item_Get: .byte 0 # whether should play it or not
.word 0
Item_Get_0:       .half 18,0    # Total number of notes, Current note number
                  .word 0,0     # Time last note played + its duration, Next note's address,  Note list (bellow)
Item_Get_0_Notes: .word 72,500,69,500,67,250,64,250,60,250,64,250,74,250,70,250,67,250,63,250,64,125,66,125,64,125,66,125,64,125,66,125,64,125,66,125,

Item_Get_1:       .half 13,0    # Total number of notes, Current note number
                  .word 0,0     # Time last note played + its duration, Next note's address,  Note list (bellow)
Item_Get_1_Notes: .word 53,250,58,250,60,250,62,250,64,250,60,250,55,250,60,250,65,250,62,250,58,250,55,250,62,1250,

Item_Get_2:        .half 2,0    # Total number of notes, Current note number
                   .word 0,0      # Time last note played + its duration, Next note's address,  Note list (bellow)
Item_Get_2_Notes:  .word 0,3000,54,1250,

Item_Get_3: .half 2,0    # Total number of notes, Current note number
                 .word 0,0     # Time last note played + its duration, Next note's address,  Note list (bellow)
Item_Get_3_Notes: .word 0,3000,57,1250,

Item_Get_4: .half 4,0    # Total number of notes, Current note number
                 .word 0,0     # Time last note played + its duration, Next note's address,  Note list (bellow)
Item_Get_4_Notes: .word 46,1000,45,1000,39,1000,38,1250,

Item_Get_5:        .half 4,0    # Total number of notes, Current note number
                   .word 0,0      # Time last note played + its duration, Next note's address,  Note list (bellow)
Item_Get_5_Notes:  .word 58,1000,57,1000,51,1000,50,1250,






####### Informations related to frame rate  ####### 
.eqv frame_rate 50 # T ms por frame 
.eqv closing_door 4   # default number of iterations before opening door goes to closed state
.eqv opening_door -2  # default number of iterations before opening door goes to open state
.eqv open_door   60   # default number of iterations before open door starts to close 
####### .eqv related to tiles  ####### 
.eqv tile_size 16	# Tile size (use powers of 2 in order to use tile_size_shift)
.eqv tile_size_shift 4  # Power value that gives tile size (2^tile_size_shift = tile_size)
.eqv door_Y_distance 6  # Distance between map's top Y and Player's top Y after comming out of a door
####### .eqv related to screen  ####### 
.eqv m_screen_width 20            # Width of screen in 16x16 tiles
.eqv m_screen_height 15           # Height of screen in 16x16 tiles
.eqv screen_width 320             # Width of screen in pixels
.eqv screen_height 240            # Height of screen in pixels
.eqv left_hor_border 119          # X on screen (in pixels) from where screen will move left instead of player
.eqv right_hor_border 184         # X on screen (in pixels) from where screen will move right instead of player
.eqv top_ver_border 94            # Y on screen (in pixels) from where screen will move up instead of player
.eqv bottom_ver_border 96         # Y on screen (in pixels) from where screen will move down instead of player
.eqv m_door_right_X_distance 18   # Distance between a door on right side of screen to the left side of screen in 16x16 tiles
                                  # It won't be needed for doors on the left, but the distance is 1
.eqv m_render_distance 4          # Distance in tiles where procedures such as moving entities should happen

####### .eqv for player's sprite #######
.eqv green 32
.eqv cyan 240
START_TXT: .string "START"
CONTINUE_TXT: .string "CONTINUE"
GAME_OVER_TXT: .string "GAME  OVER"			

####### Map informations ####### 
CURRENT_MAP: .word 0  # Stores the address of current map
MAP_INFO: .byte 1, 0, # Current Map's Number, render byte (0 - don't render, 1 - render once, 2 - render twice, 3 - switch map (through door), 4 - switch map (through cheat input))
                23, 0 # x on matrix, y on matrix
                8, 0  # X, and Y Tile Offset (0, 4, 8 or 12)
                0, 0  # X dislocation, direction of map switch (0 - next map on the right, 1 - next map on the left) 

####### Map informations for switching between maps ####### 
NEXT_MAP: .word 0    # Stores the address of next map
NEXT_MAP_INFO: .byte 0, 0 # Next Map's Number, Number of iterations on switch
                     0, 0 # x of matrix, y of matrix
                     0, 0 # X dislocation, next door number
			      0, 0 # Render Next Map Door, Player's MOVE_X for switch


####### Player informations #########
.eqv initial_player_health 30
PLYR_INFO: .byte initial_player_health, 3 # Stores player's health points, number of habilities (0 - none, 1 - ball, 2 - ball + bomb)
PLYR_POS:  .half 152, 0  # Stores Player's current and old top left X respectively, both related to the screen  
           .byte 160, 0  # Stores Player's current and old top left Y respectively, both related to the screen 
		 0, 0    # Stores Player's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)

PLYR_MATRIX: .byte 33, 0, 10, 0 # Stores Player's top left new and old X and new and old Y respectively, all related to the map matrix 
PLYR_STATUS: .byte 0,0,0,0 # Sprite's Number, Horizontal Direction (0 = Right, 1 = Left), Vertical Direciton (0 - Normal, 1 - Facing Up), Ground Postition (0 - On Ground, 1 - Freefall)
                   0,0 # Ball Mode (0 - Disabled, 1 - Enabled), Attacking (0 - no, 1 - yes) 

MOVE_X: .byte 0 # -1 left, 1 right, 0 not moving on X axis
MOVE_Y: .byte 0 # -1 up, 1 down, 0 not moving on Y axis
JUMP: .byte 0 # counter of current height
PLYR_INPUT: .byte 0  # 0 If no input, 1 if input, 2 if input but can't move horizontally

.eqv damage_jump -3
.eqv damage_iframes 20
PLYR_INFO_2: .byte 0,0,0  # Missile mode (0 - disabled, 1 - enabled), cooldown to switch, number of missiles
                   0,0,0  # Taking damage (0 - no, 1 - yes), DAMAGE_MOVE_X (+-4), damage cooldown, 
                   0,0    # reset move_x (3 -> 0), render status (0 - don't, 1 - render normally)
                   
.eqv max_jump 80      # Maximum dislocation in jump
.eqv min_jump 32      # Minimum dislocation for a jump
.eqv max_speed 8      # Maximum downwards speed
GRAVITY_FACTOR: .float 0.4   # Calculated beforhand: gravity x delta time -> (gravity = 8; delta time = 0.05s = frame_rate)  
JUMP_SPEED: .float -9

DEATH_1E_POS:  .half 0,0    # X and Y related to Death 1E
DEATH_2E_POS:  .half 0,0    # X and Y related to Death 1E
DEATH_3E_POS:  .half 0,0    # X and Y related to Death 1E
DEATH_1D_POS:  .half 0,0    # X and Y related to Death 1E
DEATH_2D_POS:  .half 0,0    # X and Y related to Death 1E
DEATH_3D_POS:  .half 0,0    # X and Y related to Death 1E

####### Power-Ups Info #########
.eqv power_up_delay 1000
.eqv maru_mari_x 15
.eqv maru_mari_y 9
MARU_MARI_INFO: 0 # Sprite status (0 -> 1 -> 2 -> 3 -> 0)


.eqv bomb_power_x 11
.eqv bomb_power_y 3
BOMB_POWER_INFO: 0 # Capsule status (0 - closed, 1 - open)

ITEM_CAPSULE_INFO: 0 # Capsule status (0 - closed, 1 - breaking1, 2 - breaking, 3 - open )

## BEAM_ARRAY ##
BEAMS_ARRAY: .byte 0   # Attack cooldown 
BEAM_0_INFO: .byte 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled, 2 - To be disabled, 3 - Hit, to be disabled), Direction (0=up,1=right,-1=left), Number of times that has been rendered
BEAM_0_POS:  .byte 0, 0         # Stores beam's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
BEAM_0_MATRIX: .byte 0, 0, 0, 0 # Stores beam's top left new and old X and new and old Y respectively, all related to the map matrix 

BEAM_1_INFO: .byte 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled, 2 - To be disabled, 3 - Hit, to be disabled), Direction (0=up,1=right,-1=left), Number of times that has been rendered
BEAM_1_POS:  .byte 0, 0         # Stores beam's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
BEAM_1_MATRIX: .byte 0, 0, 0, 0 # Stores beam's top left new and old X and new and old Y respectively, all related to the map matrix 

BEAM_2_INFO: .byte 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled, 2 - To be disabled, 3 - Hit, to be disabled), Direction (0=up,1=right,-1=left), Number of times that has been rendered
BEAM_2_POS:  .byte 0, 0         # Stores beam's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
BEAM_2_MATRIX: .byte 0, 0, 0, 0 # Stores beam's top left new and old X and new and old Y respectively, all related to the map matrix 

.eqv beams_number 3
.eqv beams_size 9             # number of bytes per beam
.eqv beams_disable_threshold  6
.eqv beams_attack_cooldown 2

## BOMB_ARRAY ##
BOMBS_ARRAY: .byte 0   # Attack cooldown 
BOMB_0_INFO: .byte 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled, 2 - To be disabled, 3 - Hit, to be disabled), sprite status, Number of times that has been rendered
BOMB_0_POS:  .byte 0, 0         # Stores bomb's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
BOMB_0_MATRIX: .byte 0, 0, 0, 0 # Stores bomb's top left new and old X and new and old Y respectively, all related to the map matrix 

BOMB_1_INFO: .byte 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled, 2 - To be disabled, 3 - Hit, to be disabled), sprite status, Number of times that has been rendered
BOMB_1_POS:  .byte 0, 0         # Stores bomb's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
BOMB_1_MATRIX: .byte 0, 0, 0, 0 # Stores bomb's top left new and old X and new and old Y respectively, all related to the map matrix 

BOMB_2_INFO: .byte 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled, 2 - To be disabled, 3 - Hit, to be disabled), MOVE_Y (0 - no mov, 1 - down), Number of times that has been rendered
BOMB_2_POS:  .byte 0, 0         # Stores bomb's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
BOMB_2_MATRIX: .byte 0, 0, 0, 0 # Stores bomb's top left new and old X and new and old Y respectively, all related to the map matrix 

.eqv bombs_number 3
.eqv bombs_size 9             # number of bytes per bomb
.eqv bombs_explosion_countdown  20
.eqv bombs_attack_cooldown 8


EXPLOSION_ARRAY: .byte
Explosion_0: 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled), explosion type (small/big), Number of times that has been rendered
             0, 0         # Stores explosion's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
             0, 0, 0, 0   # Stores explosion's top left new and old X and new and old Y respectively, all related to the map matrix 

Explosion_1: 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled), explosion type (small/big), Number of times that has been rendered
             0, 0         # Stores explosion's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
             0, 0, 0, 0   # Stores explosion's top left new and old X and new and old Y respectively, all related to the map matrix 

Explosion_2: 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled), explosion type (small/big), Number of times that has been rendered
             0, 0         # Stores explosion's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
             0, 0, 0, 0   # Stores explosion's top left new and old X and new and old Y respectively, all related to the map matrix 

Explosion_3: 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled), explosion type (small/big), Number of times that has been rendered
             0, 0         # Stores explosion's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
             0, 0, 0, 0   # Stores explosion's top left new and old X and new and old Y respectively, all related to the map matrix 

Explosion_4: 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled), explosion type (small/big), Number of times that has been rendered
             0, 0         # Stores explosion's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
             0, 0, 0, 0   # Stores explosion's top left new and old X and new and old Y respectively, all related to the map matrix 

Explosion_5: 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled), explosion type (small/big), Number of times that has been rendered
             0, 0         # Stores explosion's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
             0, 0, 0, 0   # Stores explosion's top left new and old X and new and old Y respectively, all related to the map matrix 

Explosion_6: 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled), explosion type (small/big), Number of times that has been rendered
             0, 0         # Stores explosion's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
             0, 0, 0, 0   # Stores explosion's top left new and old X and new and old Y respectively, all related to the map matrix 

Explosion_7: 0, 0, 0      # Rendering (0 - Disabled, 1 - Enabled), explosion type (small/big), Number of times that has been rendered
             0, 0         # Stores explosion's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
             0, 0, 0, 0   # Stores explosion's top left new and old X and new and old Y respectively, all related to the map matrix 

.eqv explosion_number 8   # total number of explosions 
.eqv explosion_size 9     # number of bytes per explosion
.eqv big_explosion 7      # Number of loops before freeing big explosion
.eqv small_explosion 3    # Number of loops before freeing small explosion

LOOT_ARRAY:
Loot_0: .half  0            # Times Loot has been rendered (lifetime)
        .byte  0, 0,        # Rendering (0 - Disabled, 1 - Enabled), loot type (0 - energy, 1 - missile), 
               0, 0         # Stores Loot's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
               0, 0, 0, 0   # Stores Loot's top left new and old X and new and old Y respectively, all related to the map matrix 

Loot_1: .half  0            # Times Loot has been rendered (lifetime)
        .byte  0, 0,        # Rendering (0 - Disabled, 1 - Enabled), loot type (0 - energy, 1 - missile), 
               0, 0         # Stores Loot's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
               0, 0, 0, 0   # Stores Loot's top left new and old X and new and old Y respectively, all related to the map matrix 

Loot_2: .half  0            # Times Loot has been rendered (lifetime)
        .byte  0, 0,        # Rendering (0 - Disabled, 1 - Enabled), loot type (0 - energy, 1 - missile), 
               0, 0         # Stores Loot's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
               0, 0, 0, 0   # Stores Loot's top left new and old X and new and old Y respectively, all related to the map matrix 

Loot_3: .half  0            # Times Loot has been rendered (lifetime)
        .byte  0, 0,        # Rendering (0 - Disabled, 1 - Enabled), loot type (0 - energy, 1 - missile), 
               0, 0         # Stores Loot's X and Y offset (0, 4, 8 or 12), respectively (one of them is always 0 in this game)
               0, 0, 0, 0   # Stores Loot's top left new and old X and new and old Y respectively, all related to the map matrix 


.eqv loot_number 4   # total number of explosions 
.eqv loot_size 10    # number of bytes per explosion
.eqv loot_time 100   # 5 seconds for loot to despawn



#####     Breakable block   ######
Blocks: .word 0 # Holds the current "BlocksA" label based on the current map (0 if none exist in current map)
Blocks_Next: .word 0 # Holds the current "BlocksA" label based on next map (0 if none exist on next map)

# In this game, only map 2 has breakable blocks
Blocks2:  .byte 4,6,12,3     # Starting X, starting Y, width and height
          .byte -1,-1,0,0,0,0,-1,0,0,0,0,-1,              # 0 if blocked
                -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,      # 1 -> 2 -> 3 if broken
                0,0,0,0,0,-1,-1,-1,-1,0,0,0,              # -1 if not a breakable block


##############           Zoomer            ##############

Zoomers: .word 0 # Holds the current "ZoomersA" label based on the current map (0 if none exist in current map)
Zoomers_Next: .word 0 # Holds the "ZoomersA" label based on the next map (0 if none exist in next map)  
#                     +-->   only changed when switching maps

# With a varied amount of zoomers in each map, we have 432 + 5 bytes used (each zoomer is 12 bytes appart from each other)
.eqv zoomer_size 12             # number of bytes per zoomer
.eqv zoomer_normal_health 6     # number of shots for a normal zoomer to die
.eqv zoomer_variant_health 12    # number of shots for a variant zoomer to die

# type: 0 (normal), 1 (variant), 2 (normal damage), 3 (variant damage)
.byte
Zoomers1: 6
Zoomer1_0: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           34, 0, 7, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 3, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile)
Zoomer1_1: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           32, 0, 5, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 1, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer1_2: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           9, 0, 7, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 1, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer1_3: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           55, 0, 2, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 2, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer1_4: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           55, 0, 9, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 2, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer1_5: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           48, 0, 12, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile

Zoomers2: 9
Zoomer2_0: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           15, 0, 5, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile)
Zoomer2_1: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           9, 0, 7, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer2_2: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           4, 0, 9, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 1, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer2_3: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           12, 0, 11, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer2_4: zoomer_variant_health, 1, 0, 0 # Zoomer's health points, type, X and Y offset
           6, 0, 18, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 3, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer2_5: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           12, 0, 22, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer2_6: zoomer_variant_health, 1, 0, 0 # Zoomer's health points, type, X and Y offset
           4, 0, 28, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 0, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer2_7: zoomer_variant_health, 1, 0, 0 # Zoomer's health points, type, X and Y offset
           7, 0, 33, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer2_8: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           17, 0, 34, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 3, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile

Zoomers3: 6
Zoomer3_0: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           2, 0, 10, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 1, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile)
Zoomer3_1: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           18, 0, 12, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer3_2: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           31, 0, 2, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 3, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer3_3: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           40, 0, 3, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 2, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer3_4: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           43, 0, 12, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer3_5: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           48, 0, 1, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 1, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile

Zoomers4: 11
Zoomer4_0: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           5, 0, 41, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 3, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile)
Zoomer4_1: zoomer_variant_health, 1, 0, 0 # Zoomer's health points, type, X and Y offset
           15, 0, 38, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 0, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer4_2: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           8, 0, 33, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer4_3: zoomer_variant_health, 1, 0, 0 # Zoomer's health points, type, X and Y offset
           10, 0, 26, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 1, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer4_4: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           10, 0, 22, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer4_5: zoomer_variant_health, 1, 0, 0 # Zoomer's health points, type, X and Y offset
           4, 0, 21, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer4_6: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           17, 0, 21, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 3, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer4_7: zoomer_variant_health, 1, 0, 0 # Zoomer's health points, type, X and Y offset
           12, 0, 15, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 2, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer4_8: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           7, 0, 11, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer4_9: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           5, 0, 8, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 1, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer4_10: zoomer_variant_health, 1, 0, 0 # Zoomer's health points, type, X and Y offset
           8, 0, 3, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile

Zoomers5: 4
Zoomer5_0: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           30, 0, 12, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile)
Zoomer5_1: zoomer_variant_health, 1, 0, 0 # Zoomer's health points, type, X and Y offset
           21, 0, 12, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 0, 0, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer5_2: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           19, 0, 12, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 0, 0   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile
Zoomer5_3: zoomer_normal_health, 0, 0, 0 # Zoomer's health points, type, X and Y offset
           9, 0, 8, 0  # Stores Zoomer's top left new and old X and new and old Y respectively, all related to the map matrix 
           0, 1, 1, 1   # Sprite's Number, Movement Direction Clockwise (0=Clockwise,1=Counter-clockwise),
                        # Where is the platform (0 - Down, 1 - Left, 2 - Up, 3 - Right), Drop (0 - none, 1 - health, 2 - missile

##############           Ripper            ##############
Rippers: .word 0 # Holds the current "RippersA" label based on the current map (0 if none exist in current map)
Rippers_Next: .word 0 # Holds the "RippersA" label based on the next map (0 if none exist in next map)  
#                     +-->   only changed when switching maps

# With 5 rippers in each map, we have 72 bytes used (each ripper is 7 bytes appart from each other)
.eqv ripper_size 7   # number of bytes per ripper
.byte
Rippers2: 5
Ripper2_0: 0, 1, 0        # Stores Ripper's type (0 - normal, 1 - red), movement direction (0 - right, 1 - left), X offset
           5, 5, 12, 12   # Stores Ripper's top left new and old X and new and old Y respectively, all related to the map matrix 
Ripper2_1: 0, 0, 0        # Type, direction, X offset
           11, 11, 18, 18 # X, old X, Y, old Y related to matrix
Ripper2_2: 1, 0, 0    # Type, direction, X offset
           2, 2, 26, 26 # X, old X, Y, old Y related to matrix
Ripper2_3: 0, 1, 0    # Type, direction, X offset
           17, 17, 31, 31 # X, old X, Y, old Y related to matrix
Ripper2_4: 1, 0, 8    # Type, direction, X offset
           3, 3, 34, 34 # X, old X, Y, old Y related to matrix

Rippers4: 5
Ripper4_0: 0, 0, 0        # Stores Ripper's type (0 - normal, 1 - red), movement direction (0 - right, 1 - left), X offset
           9, 9, 30, 30   # Stores Ripper's top left new and old X and new and old Y respectively, all related to the map matrix 
Ripper4_1: 0, 0, 8        # Type, direction, X offset
           3, 3, 26, 26   # X, old X, Y, old Y related to matrix
Ripper4_2: 0, 0, 0        # Type, direction, X offset
           15, 15, 23, 23 # X, old X, Y, old Y related to matrix
Ripper4_3: 1, 1, 0        # Type, direction, X offset
           12, 12, 18, 18 # X, old X, Y, old Y related to matrix
Ripper4_4: 1, 1, 0        # Type, direction, X offset
           2, 2, 12, 12   # X, old X, Y, old Y related to matrix

##############           Ridley            ##############
.eqv ridley_health 30 # Number of shots to destroy ridley
.eqv ridley_X 9 # Ridley doesn't move arround the X axis
.eqv ridley_X_Offset 6 # Ridley doesn't move arround the X axis
.eqv ridley_original_Y 5
.eqv ridley_jump_cooldown 20
.eqv ridley_attack_cooldown 8
.eqv ridley_jump_animation 80
.byte
RIDLEY_INFO:  ridley_health, 0, 10 # Stores Ridley's health points, type (0 - Normal, 1 - Damage), Y offset
              5, 5             # Top Y and old Y
              0, 0             # Sprite's Number, Ground Position (0 - On Ground, 1 - Freefall)

RIDLEY_MOVE_Y: .byte 0         # -1 up, 1 down, 0 not moving on Y axis
RIDLEY_JUMP: .byte 0, ridley_jump_cooldown                  # counter of current height
RIDLEY_ATTACK: .byte ridley_attack_cooldown                                   # Attack cooldown

# 1 bytes available here :)

.eqv ridley_max_jump 40      # Maximum dislocation in jump
RIDLEY_JUMP_SPEED: .float -6

##############           Plasma Breath           ##############

.eqv plasma_number 5       # Total number of plasma breaths available
.eqv plasma_size 10         # number of bytes per plasma breath
.eqv plasma_max_speed 8
.eqv top_threshold 1       # matrix Y where plasma breath must switch down  
.eqv disable_threshold 16  # matrix X where plasma breath will be disabled           
# Obs.: X movement will always be positive (between 0 and 6)

PLASMA_BREATH_ARRAY:  # address where plasma breath will start 
PLASMA_0: .byte 0, 0, 0  # Rendering (0 - Disabled, 1 - Enabled, 2 - To be Disabled), X movement, MOVE_Y (-1 up, 1 down, 0 not moving on Y axis) 
          .byte 0, 0, 0  # X offset, Y offset, Sprite status
          .byte 0, 0, 0, 0 # X, old X, Y, old Y
PLASMA_1: .byte 0, 0, 0  # Rendering (0 - Disabled, 1 - Enabled, 2 - To be Disabled), X movement, MOVE_Y (-1 up, 1 down, 0 not moving on Y axis) 
          .byte 0, 0, 0  # X offset, Y offset, Sprite status
          .byte 0, 0, 0, 0 # X, old X, Y, old Y
PLASMA_2: .byte 0, 0, 0  # Rendering (0 - Disabled, 1 - Enabled, 2 - To be Disabled), X movement, MOVE_Y (-1 up, 1 down, 0 not moving on Y axis) 
          .byte 0, 0, 0  # X offset, Y offset, Sprite status
          .byte 0, 0, 0, 0 # X, old X, Y, old Y          
PLASMA_3: .byte 0, 0, 0  # Rendering (0 - Disabled, 1 - Enabled, 2 - To be Disabled), X movement, MOVE_Y (-1 up, 1 down, 0 not moving on Y axis) 
          .byte 0, 0, 0  # X offset, Y offset, Sprite status
          .byte 0, 0, 0, 0 # X, old X, Y, old Y
PLASMA_4: .byte 0, 0, 0  # Rendering (0 - Disabled, 1 - Enabled, 2 - To be Disabled), X movement, MOVE_Y (-1 up, 1 down, 0 not moving on Y axis) 
          .byte 0, 0, 0  # X offset, Y offset, Sprite status
          .byte 0, 0, 0, 0 # X, old X, Y, old Y

##############           Doors            ##############
Doors: .word 0 # Holds the current "DoorsA" label based on the current map
Doors_Next: .word 0 # Holds the "DoorsA" label based on the next map   
#                     +-->   only changed when switching maps
#                     +-->   used in RENDER_MAP if Render Next Map Door == 1
.byte
# Bellow here all labels will follow the rules:
# DoorsA: N --> holds the number (N) of doors on map A
# DoorA_B: X, Y, S, T --> holds the door's X and uppermost Y (on matrix), its state (S), 
#                         and counter (C) set to go down when positive, or go up when negative
# Obs.: the state can be: 0 - closed, 1 - opening, 2 - open (background color)
# Obs2.: the direction of a door is: left (if X = 1) or right (if X != 1)
# Obs3.: the C parameter will be positive when door needs to close and negative when door needs to open, staying on 0 when finished.
#        When positive, it can be the number of iterations for a door that is on the "open" state to go to the "opening" state, 
#        or on the "opening" state to a closed state. When negative, it is the number of iterations for a door that is 
#        on the "opening" state to an open state.
Doors1:  1
Door1_0: 58,5,0,0

Doors2: 3
Door2_0: 1,5,0,0
Door2_1: 18,5,0,0
Door2_2: 1,35,0,0

Doors3: 2
Door3_0: 1,5,0,0 
Door3_1: 58,5,0,0

Doors4: 2
Door4_0: 1,35,0,0
Door4_1: 1,5,0,0

Doors5: 2
Door5_0: 38,5,0,0
Door5_1: 1,5,0,0

Doors6: 1
Door6_0: 18,5,0,0

Doors7: 1
Door7_0: 18,5,0,0

##############           Door Frames            ##############
Frames: .word 0 # Holds the current "FrameA" label based on the current map
.byte
# Bellow here all labels will follow the rules:
# FramesA: N --> holds the number (N) of door frames on map A
# FrameA_B: X, Y, M, D, Dir, Ydoor --> holds the door's X and uppermost Y (on matrix), the number of the map to which player will go next (M),
# the number of the door from which the player will leave on next map (D), direction (Dir) to where screen will go (0 = right, 1 = left), 
# top left Y (Ydoor) of map matrix where switch will be set (for vertical maps, doors can be on different Y levels)

Frames1:  1
Frame1_0: 59,5,2,0,0,0

Frames2: 3
Frame2_0: 0,5,1,0,1,0
Frame2_1: 19,5,3,0,0,0
Frame2_2: 0,35,7,0,1,0

Frames3: 2
Frame3_0: 59,5,4,0,1,0
Frame3_1: 0,5,2,1,0,30

Frames4: 2
Frame4_0: 0,35,3,1,1,0
Frame4_1: 0,5,5,0,1,0

Frames5: 2
Frame5_0: 39,5,4,1,0,0
Frame5_1: 0,5,6,0,1,0

Frames6: 1
Frame6_0: 19,5,5,1,0,0

Frames7: 1
Frame7_0: 19,5,2,2,0,30

############################################        Map Parameters        ############################################

## Parameters for Map 1 Reset ## 
.eqv resetmap1X 23
.eqv resetmap1Y 0
.eqv resetmap1Xoff 8
.eqv resetmap1Yoff 0
.eqv resetmap1plyrXscreen 152
.eqv resetmap1plyrYscreen 160
.eqv resetmap1plyrX 33
.eqv resetmap1plyrY 10
.eqv resetmap1plyrXoff 0
.eqv resetmap1plyrYoff 0

## Parameters for Map 2 Reset ## 
.eqv resetmap2X 0
.eqv resetmap2Y 0
.eqv resetmap2Xoff 0
.eqv resetmap2Yoff 0
.eqv resetmap2plyrXscreen 32
.eqv resetmap2plyrYscreen 96
.eqv resetmap2plyrX 2
.eqv resetmap2plyrY 6
.eqv resetmap2plyrXoff 0
.eqv resetmap2plyrYoff 0

## Parameters for Map 3 Reset ## 
.eqv resetmap3X 0
.eqv resetmap3Y 0
.eqv resetmap3Xoff 0
.eqv resetmap3Yoff 0
.eqv resetmap3plyrXscreen 32
.eqv resetmap3plyrYscreen 96
.eqv resetmap3plyrX 2
.eqv resetmap3plyrY 6
.eqv resetmap3plyrXoff 0
.eqv resetmap3plyrYoff 0

## Parameters for Map 4 Reset ## 
.eqv resetmap4X 0
.eqv resetmap4Y 30
.eqv resetmap4Xoff 0
.eqv resetmap4Yoff 0
.eqv resetmap4plyrXscreen 32
.eqv resetmap4plyrYscreen 96
.eqv resetmap4plyrX 2
.eqv resetmap4plyrY 36
.eqv resetmap4plyrXoff 0
.eqv resetmap4plyrYoff 0

## Parameters for Map 5 Reset ## 
.eqv resetmap5X 20
.eqv resetmap5Y 0
.eqv resetmap5Xoff 0
.eqv resetmap5Yoff 0
.eqv resetmap5plyrXscreen 272
.eqv resetmap5plyrYscreen 96
.eqv resetmap5plyrX 37
.eqv resetmap5plyrY 6
.eqv resetmap5plyrXoff 0
.eqv resetmap5plyrYoff 0

## Parameters for Map 6 Reset ## 
.eqv resetmap6X 0
.eqv resetmap6Y 0
.eqv resetmap6Xoff 0
.eqv resetmap6Yoff 0
.eqv resetmap6plyrXscreen 272
.eqv resetmap6plyrYscreen 96
.eqv resetmap6plyrX 17
.eqv resetmap6plyrY 6
.eqv resetmap6plyrXoff 0
.eqv resetmap6plyrYoff 0

## Parameters for Map 7 Reset ## 
.eqv resetmap7X 0
.eqv resetmap7Y 0
.eqv resetmap7Xoff 0
.eqv resetmap7Yoff 0
.eqv resetmap7plyrXscreen 272
.eqv resetmap7plyrYscreen 96
.eqv resetmap7plyrX 17
.eqv resetmap7plyrY 6
.eqv resetmap7plyrXoff 0
.eqv resetmap7plyrYoff 0


################################################        UI elements        ################################################

Energy_UI: # 24 x 8
.byte 234,234,234,234,234,234,234,199,234,234,199,199,199,234,234,199,199,199,199,199,199,199,199,199,
234,234,209,209,209,209,209,199,234,234,234,199,199,234,234,199,199,199,199,199,199,199,199,199,
234,234,199,199,199,199,199,199,234,234,234,234,199,234,234,199,199,199,199,199,199,199,199,199,
234,234,234,234,234,234,199,199,234,234,234,234,234,234,234,199,199,103,103,199,199,103,103,199,
234,234,209,209,209,209,199,199,234,234,209,234,234,234,234,199,199,103,103,199,199,103,103,199,
234,234,199,199,199,199,199,199,234,234,199,209,234,234,234,199,199,14,14,199,199,14,14,199,
234,234,234,234,234,234,234,199,234,234,199,199,209,234,234,199,199,199,199,199,199,199,199,199,
209,209,209,209,209,209,209,199,209,209,199,199,199,209,209,199,199,199,199,199,199,199,199,199,

Select_UI: # 8 x 8
.byte 234,234,234,234,234,234,234,78,
234,78,78,78,78,78,234,78,
234,78,0,0,0,0,234,78,
234,78,0,0,0,0,234,78,
234,78,0,0,0,0,234,78,
234,78,0,0,0,0,234,78,
234,234,234,234,234,234,234,78,
78,78,78,78,78,78,78,78,

################################################        Tiles        ################################################
# Stores all tiles used in the game, that can be rendered by checking the value on the map matrixes (search "Matrixes")
# 
# --> Total ammount of data: 13,568 bytes (256 bytes per tile) or 13.25 KiB + word
#
# There is a total of 51 tiles looked by matrixes: 
# The number 0 on matrixes is not a tile, and will be rendered as black
#
#  Obs.: BreakBlock_Break1 and BreakBlock_Break2 don't make part of the array 
# 
#  +------------------+-------------------+----------------------+
#  | 01. BreakBlock   | 18. Tile2A        | 35. Tile3C           |
#  | 02. Bush2A       | 19. Pipe2H        | 36. LavaB            |
#  | 03. Bush2B       | 20. Pipe2V        | 37. LavaT            |
#  | 04. DoorFrame    | 21. ItemHolderA   | 38. SpikeL           |
#  | 05. Ground1A     | 22. ItemHolderB   | 39. SpikeR           |
#  | 06. Ground1B     | 23. ItemHolderC   | 40. DoorLeftTop      |
#  | 07. Ground1C     | 24. ItemHolderD   | 41. DoorLeftTopO     |
#  | 08. Ground1D     | 25. ItemHolderE   | 42. DoorLeftMiddle   |
#  | 09. Tile1A       | 26. ItemHolderF   | 43. DoorLeftMiddleO  |
#  | 10. Tile1B       | 27. ItemHolderG   | 44. DoorLeftBottom   |
#  | 11. Pipe1H       | 28. Ground3A      | 45. DoorLeftBottomO  |
#  | 12. Pipe1V       | 29. Ground3B      | 46. DoorRightTop     |
#  | 13. Slide1L      | 30. Ground3C      | 47. DoorRightTopO    |
#  | 14. Slide1R      | 31. Pipe3V        | 48. DoorRightMiddle  |
#  | 15. Ground2A     | 32. Pipe3V2       | 49. DoorRightMiddleO |
#  | 16. Ground2B     | 33. Tile3A        | 50. DoorRightBottom  |
#  | 17. Ground2C     | 34. Tile3B        | 51. DoorRightBottomO |
#  +------------------+-------------------+----------------------+

.word 0 # Aligning bytes
BreakBlock_Break1: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,160,209,0,0,0,160,227,160,0,
0,0,227,0,0,0,209,160,160,227,0,0,0,160,160,0,
0,0,0,0,0,0,0,160,209,209,209,0,0,0,0,0,
0,0,0,160,209,0,0,0,227,209,209,0,0,209,0,0,
0,209,160,160,209,0,0,0,0,0,0,0,209,0,0,0,
0,0,209,227,209,160,0,227,0,227,209,209,209,209,0,0,
0,227,0,209,209,0,0,209,0,0,0,209,160,160,0,0,
0,0,0,227,0,0,0,209,209,0,0,0,0,160,0,0,
209,0,0,0,160,227,160,0,0,0,0,0,0,0,0,160,
160,227,0,0,0,160,160,0,0,0,227,0,0,0,209,160,
209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,160,
227,209,209,0,0,209,0,0,0,0,0,160,209,0,0,0,
0,0,0,0,209,0,0,0,0,209,160,160,209,0,0,0,
0,227,209,209,209,209,0,0,0,0,209,227,209,160,0,227,
0,0,0,209,160,160,0,0,0,227,0,209,209,0,0,209,
209,0,0,0,0,160,0,0,0,0,0,227,0,0,0,209,

BreakBlock_Break2: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,209,0,0,0,0,0,0,0,0,0,0,
0,209,0,209,0,0,0,209,0,209,0,0,209,0,209,0,
0,0,0,0,160,0,0,209,209,0,209,0,0,0,0,0,
0,209,0,160,0,227,0,0,0,0,0,0,0,0,209,0,
0,0,0,0,0,0,160,0,160,0,227,0,0,160,0,0,
209,0,160,0,160,0,0,0,0,0,0,160,0,160,0,209,
0,0,0,0,0,0,0,227,0,0,0,0,160,0,160,0,
227,0,160,0,0,160,0,0,160,0,227,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,0,0,
0,209,0,0,209,0,209,0,0,209,0,209,0,0,0,209,
209,0,209,0,0,0,0,0,0,0,0,0,160,0,0,209,
0,0,0,0,0,0,209,0,0,209,0,160,0,227,0,0,
160,0,227,0,0,160,0,0,0,0,0,0,0,0,160,0,
0,0,0,160,0,160,0,209,209,0,160,0,160,0,0,0,
0,0,0,0,160,0,160,0,0,0,0,0,0,0,0,227,
160,0,227,0,0,0,0,0,227,0,160,0,0,160,0,0,

Tileset:
BreakBlock: # 16 x 16 = 256 bytes
.byte 0,0,227,227,0,227,227,0,227,227,227,227,227,0,0,0,
0,227,227,0,0,227,227,227,0,227,227,227,227,160,0,0,
227,227,0,209,209,209,209,209,0,0,209,209,0,160,160,0,
227,227,0,209,209,209,209,0,0,209,209,209,209,0,0,0,
227,227,209,209,209,0,0,209,209,209,209,209,209,160,0,0,
227,227,209,209,0,0,209,209,209,209,209,209,209,160,160,0,
227,0,0,0,209,209,0,209,0,0,0,0,209,160,160,0,
0,227,0,209,209,209,0,0,0,209,209,0,0,160,160,0,
227,227,209,209,209,209,209,0,209,209,209,209,0,160,160,0,
227,227,209,209,209,209,209,0,209,209,209,209,209,160,160,0,
0,227,209,209,209,209,0,209,209,209,209,209,209,160,0,0,
227,0,0,209,209,0,209,209,209,209,209,209,0,0,160,0,
227,227,0,0,209,0,0,209,209,209,209,0,0,160,160,0,
0,227,160,0,160,160,160,0,160,160,160,160,0,160,0,0,
0,0,160,160,0,160,160,160,0,160,160,0,160,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Bush2A: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,209,209,209,0,209,209,0,0,0,0,0,
0,0,0,209,0,209,0,209,209,209,209,209,209,0,0,0,
0,0,209,0,209,209,209,209,209,209,209,209,209,209,0,0,
0,209,209,209,209,209,209,209,209,0,209,209,0,209,209,0,
0,0,209,0,209,209,209,209,209,209,209,209,209,0,209,0,
0,209,0,209,209,209,209,209,209,0,209,209,0,0,0,209,
209,209,209,209,209,209,0,209,209,209,209,209,0,0,0,0,
0,209,209,209,209,209,209,209,0,209,209,0,209,0,209,0,
209,0,209,209,209,209,209,209,209,209,209,0,0,0,0,0,
0,209,209,209,209,209,209,209,209,209,0,209,0,209,0,0,
209,209,209,209,209,209,209,0,209,0,0,209,0,0,0,0,
0,209,209,209,209,209,209,209,209,209,209,0,209,0,0,0,
0,209,0,209,209,209,209,0,209,209,0,0,0,0,0,0,
0,0,209,209,209,0,209,209,0,0,0,0,0,0,0,209,
0,0,0,209,209,209,0,209,0,209,0,0,209,0,0,0,

Bush2B: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,209,209,209,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,0,209,0,0,0,0,0,0,0,
0,209,209,0,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,209,0,0,0,0,0,
209,0,209,209,209,209,209,209,209,0,0,0,0,0,0,0,
0,209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,
0,209,209,209,209,209,0,209,209,0,0,209,0,0,0,0,
0,209,209,209,209,209,209,0,0,0,0,209,0,0,0,0,
0,209,0,209,209,0,209,209,0,209,0,0,0,0,0,0,
209,209,209,209,209,209,0,0,0,0,0,0,0,0,0,0,
0,209,209,209,0,0,0,0,0,0,209,0,0,0,0,0,
0,0,209,209,0,0,209,0,0,0,0,0,0,0,0,0,

DoorFrame: # 16 x 16 = 256 bytes
.byte 103,103,103,103,103,103,103,103,103,103,103,103,103,103,103,103,
103,216,216,216,216,216,216,3,103,216,216,216,216,216,216,3,
103,216,3,3,3,3,216,3,103,216,3,3,3,3,216,3,
103,216,3,216,216,103,216,3,103,216,3,216,216,103,216,3,
103,216,3,216,216,103,216,3,103,216,3,216,216,103,216,3,
103,216,3,103,103,103,216,3,103,216,3,103,103,103,216,3,
103,216,216,216,216,216,216,3,103,216,216,216,216,216,216,3,
3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,
103,103,103,103,103,103,103,103,103,103,103,103,103,103,103,103,
103,216,216,216,216,216,216,3,103,216,216,216,216,216,216,3,
103,216,3,3,3,3,216,3,103,216,3,3,3,3,216,3,
103,216,3,216,216,103,216,3,103,216,3,216,216,103,216,3,
103,216,3,216,216,103,216,3,103,216,3,216,216,103,216,3,
103,216,3,103,103,103,216,3,103,216,3,103,103,103,216,3,
103,216,216,216,216,216,216,3,103,216,216,216,216,216,216,3,
3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,

Ground1A: # 16 x 16 = 256 bytes
.byte 0,0,227,227,227,227,227,0,0,0,0,227,227,0,0,0,
0,227,227,227,227,160,160,227,227,227,227,160,160,160,160,0,
227,227,227,160,160,160,160,160,160,160,0,0,0,0,0,160,
0,227,227,227,0,0,0,0,0,0,0,0,160,160,160,160,
0,0,0,0,0,227,227,227,160,160,160,0,0,0,0,0,
227,227,227,227,227,160,160,160,160,0,0,0,0,0,160,0,
160,160,227,160,227,227,0,0,0,0,0,160,160,160,160,160,
0,0,0,160,160,160,160,0,160,0,0,0,0,0,0,0,
227,227,0,0,0,0,0,227,227,160,160,0,0,0,160,160,
160,160,227,227,227,227,227,160,160,160,160,160,160,160,160,160,
0,0,160,227,227,227,227,227,227,227,0,0,0,160,160,0,
227,0,0,160,160,0,0,0,0,0,0,0,160,160,160,0,
227,227,0,0,0,0,160,160,0,0,160,160,0,0,0,0,
160,227,227,227,160,160,160,160,160,0,0,0,0,160,160,160,
0,160,160,160,160,160,160,0,0,0,0,0,0,0,160,160,
0,0,0,160,160,160,160,160,160,160,160,160,160,160,0,0,

Ground1B: # 16 x 16 = 256 bytes
.byte 0,0,0,0,227,227,0,0,0,0,0,0,0,0,0,0,
0,0,227,227,0,0,227,0,0,0,0,0,227,227,0,0,
0,227,227,227,227,160,160,227,0,0,0,0,227,160,160,0,
0,227,0,160,160,160,227,227,227,0,0,227,160,160,227,0,
227,227,160,0,0,0,0,227,0,0,0,0,227,227,0,227,
227,0,227,227,227,160,160,160,227,0,0,160,160,227,227,0,
227,227,160,160,160,0,0,0,227,227,227,227,0,160,227,227,
227,0,0,0,227,227,227,0,0,160,0,227,227,0,0,227,
227,227,0,0,0,0,0,227,227,160,160,0,0,0,160,160,
160,160,227,227,227,227,227,160,160,160,160,160,160,160,160,160,
0,0,160,227,227,227,227,227,227,227,0,0,0,160,160,0,
227,0,0,160,160,0,0,0,0,0,0,0,160,160,160,0,
227,227,0,0,0,0,160,160,0,0,160,160,0,0,0,0,
160,227,227,227,160,160,160,160,160,0,0,0,0,160,160,160,
0,160,160,160,160,160,160,0,0,0,0,0,0,0,160,160,
0,0,0,160,160,160,160,160,160,160,160,160,160,160,0,0,

Ground1C: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,160,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,160,0,0,160,0,0,0,0,
0,0,0,0,160,0,0,160,0,160,160,0,160,0,0,0,
0,0,0,160,0,0,0,0,160,0,0,160,0,0,0,0,
0,0,0,0,160,0,160,0,227,160,160,160,0,160,0,0,
0,0,160,0,0,160,0,160,160,0,160,227,160,0,160,0,
0,0,0,0,160,0,160,0,160,160,160,160,160,160,0,0,
0,0,0,0,0,160,160,160,160,0,160,160,0,160,0,0,
0,0,160,0,160,0,160,160,0,160,160,0,160,0,160,0,
0,0,0,160,0,160,0,160,160,160,0,0,160,0,0,0,
0,0,0,0,0,0,160,0,0,0,160,0,0,0,160,0,
0,0,160,0,0,0,0,160,0,0,160,0,160,0,0,0,
0,0,0,0,0,160,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Ground1D: # 16 x 16 = 256 bytes
.byte 0,0,227,0,0,0,227,0,160,0,0,160,0,0,0,0,
0,160,160,160,0,160,160,0,0,160,227,0,0,0,0,0,
160,160,160,160,227,160,160,160,160,160,160,0,0,0,0,0,
227,160,160,160,160,160,160,160,160,160,0,160,0,0,0,0,
160,160,227,160,160,227,160,160,160,160,160,160,0,0,0,0,
0,160,160,160,160,160,160,160,160,0,160,0,160,160,0,0,
160,160,160,160,160,160,160,160,160,160,0,160,0,0,0,0,
0,160,227,160,160,160,160,0,160,160,160,160,160,0,0,0,
160,160,160,160,160,160,160,160,160,160,160,0,0,160,0,0,
160,160,160,0,160,160,160,0,0,160,0,0,0,0,0,0,
160,0,160,160,160,160,0,160,160,0,160,0,160,0,0,0,
0,160,160,160,160,0,160,160,0,160,0,0,0,0,0,0,
0,0,160,160,160,160,160,0,0,160,0,0,0,0,0,0,
0,160,0,160,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Tile1A: # 16 x 16 = 256 bytes
.byte 0,227,227,227,0,0,227,227,227,227,0,0,227,227,0,0,
227,160,160,160,160,0,0,160,160,160,0,160,160,160,0,0,
227,160,227,227,227,227,227,227,227,227,227,227,227,160,0,0,
0,160,227,160,160,160,160,160,160,160,160,160,0,160,0,0,
0,0,227,160,227,227,227,227,227,227,227,160,0,0,0,0,
227,0,227,160,227,160,160,160,160,160,0,160,0,160,0,0,
227,160,227,160,227,160,227,227,227,160,0,160,0,160,0,0,
227,160,227,160,227,160,227,160,0,160,0,160,0,160,0,0,
227,160,227,160,227,160,0,0,0,160,0,160,0,0,0,0,
227,160,227,160,227,160,160,160,160,227,0,160,0,160,0,0,
227,0,227,160,0,0,0,0,0,0,0,160,0,160,0,0,
0,160,227,160,160,160,160,160,160,160,160,227,0,160,0,0,
227,160,0,0,0,0,0,0,0,0,0,0,0,160,0,0,
227,160,160,160,0,160,160,160,160,160,0,0,160,227,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Tile1B: # 16 x 16 = 256 bytes
.byte 0,0,160,160,160,160,0,0,0,0,160,160,160,160,0,0,
0,160,227,227,227,160,160,0,0,160,160,227,227,227,160,0,
0,227,0,0,0,227,160,160,160,160,227,0,0,0,160,0,
160,227,0,160,160,0,160,0,0,227,0,160,160,0,160,160,
0,160,0,0,227,0,0,160,160,0,0,227,0,0,160,0,
160,160,160,0,0,0,160,0,0,160,0,0,0,160,160,160,
0,160,0,160,160,160,0,0,0,0,160,160,160,0,160,0,
160,160,0,227,0,160,0,160,160,0,160,0,0,0,160,160,
160,227,0,0,160,0,160,0,0,160,0,160,0,0,227,160,
227,0,0,0,227,0,227,0,0,227,0,227,0,0,0,227,
227,0,160,0,0,0,0,0,0,0,0,0,0,160,0,227,
0,0,160,0,0,0,0,0,0,0,0,0,0,160,0,0,
227,0,160,0,227,0,227,0,0,227,0,227,0,160,0,227,
227,0,160,160,160,0,160,0,0,160,0,160,160,160,0,227,
0,227,0,160,0,160,0,160,160,0,160,0,160,0,227,0,
0,0,0,0,160,160,160,160,160,160,160,160,0,0,0,0,

Pipe1H: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,
227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Pipe1V: # 16 x 16 = 256 bytes
.byte 0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,
0,160,160,160,227,227,160,160,0,160,0,160,160,0,0,0,

Slide1L: # 16 x 16 = 256 bytes
.byte 0,227,160,227,227,227,227,227,0,0,227,227,227,227,227,0,
227,227,160,160,227,227,160,160,0,227,227,227,227,160,160,227,
0,160,227,227,227,0,0,227,227,227,227,160,160,160,160,160,
0,160,0,0,0,0,227,227,0,227,227,227,0,0,0,0,
0,227,0,227,227,227,227,0,0,0,0,0,0,227,227,227,
0,0,0,227,227,227,227,160,227,227,227,227,227,160,160,160,
0,0,0,0,227,0,227,227,160,160,227,160,227,227,0,0,
0,0,0,0,0,227,227,0,0,0,0,160,160,160,160,0,
0,0,0,0,0,0,0,0,0,227,160,227,227,227,227,227,
0,0,0,0,0,0,0,0,227,227,160,160,227,227,160,160,
0,0,0,0,0,0,0,0,0,160,227,227,227,0,0,227,
0,0,0,0,0,0,0,0,0,160,0,0,0,0,227,227,
0,0,0,0,0,0,0,0,0,227,0,227,227,227,227,0,
0,0,0,0,0,0,0,0,0,0,0,227,227,227,227,160,
0,0,0,0,0,0,0,0,0,0,0,0,227,0,227,227,
0,0,0,0,0,0,0,0,0,0,0,0,0,227,227,0,

Slide1R: # 16 x 16 = 256 bytes
.byte 227,160,160,0,0,0,160,160,227,0,160,160,160,0,0,160,
160,160,160,160,160,160,160,160,0,0,0,160,160,160,160,0,
227,227,0,0,0,160,160,0,160,160,0,0,0,160,160,0,
0,0,0,0,160,160,160,0,227,227,160,160,0,160,0,0,
0,0,160,160,0,0,0,0,0,0,160,160,160,160,0,0,
160,0,0,0,0,160,160,160,160,160,160,160,0,0,0,0,
0,0,0,0,0,0,160,160,0,160,0,0,0,0,0,0,
160,160,160,160,160,160,0,0,160,0,0,0,0,0,0,0,
227,0,160,160,160,0,0,160,0,0,0,0,0,0,0,0,
0,0,0,160,160,160,160,0,0,0,0,0,0,0,0,0,
160,160,0,0,0,160,160,0,0,0,0,0,0,0,0,0,
227,227,160,160,0,160,0,0,0,0,0,0,0,0,0,0,
0,0,160,160,160,160,0,0,0,0,0,0,0,0,0,0,
160,160,160,160,0,0,0,0,0,0,0,0,0,0,0,0,
0,160,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
160,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Ground2A: # 16 x 16 = 256 bytes
.byte 0,216,216,103,216,216,216,216,216,216,216,0,0,216,216,0,
0,216,216,103,216,216,216,216,216,216,216,0,0,216,216,0,
0,216,216,103,216,216,216,216,216,216,216,0,0,216,216,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,216,103,216,216,216,216,216,0,0,216,0,0,0,
0,0,0,216,103,216,216,216,216,216,0,0,216,0,0,0,
0,0,0,216,103,216,216,216,216,216,0,0,216,0,0,0,
0,0,0,216,103,216,216,216,216,216,0,0,216,0,0,0,
0,216,216,103,216,216,216,216,216,216,216,0,0,216,216,0,
0,216,216,103,216,216,216,216,216,216,216,0,0,216,216,0,
0,216,216,103,216,216,216,216,216,216,216,0,0,216,216,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,216,103,216,216,216,216,216,0,0,216,0,0,0,
0,0,0,216,103,216,216,216,216,216,0,0,216,0,0,0,
0,0,0,216,103,216,216,216,216,216,0,0,216,0,0,0,
0,0,0,216,103,216,216,216,216,216,0,0,216,0,0,0,

Ground2B: # 16 x 16 = 256 bytes
.byte 0,209,209,227,209,209,209,209,209,209,209,0,0,209,209,0,
0,209,209,227,209,209,209,209,209,209,209,0,0,209,209,0,
0,209,209,227,209,209,209,209,209,209,209,0,0,209,209,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,209,227,209,209,209,209,209,0,0,209,0,0,0,
0,0,0,209,227,209,209,209,209,209,0,0,209,0,0,0,
0,0,0,209,227,209,209,209,209,209,0,0,209,0,0,0,
0,0,0,209,227,209,209,209,209,209,0,0,209,0,0,0,
0,209,209,227,209,209,209,209,209,209,209,0,0,209,209,0,
0,209,209,227,209,209,209,209,209,209,209,0,0,209,209,0,
0,209,209,227,209,209,209,209,209,209,209,0,0,209,209,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,209,227,209,209,209,209,209,0,0,209,0,0,0,
0,0,0,209,227,209,209,209,209,209,0,0,209,0,0,0,
0,0,0,209,227,209,209,209,209,209,0,0,209,0,0,0,
0,0,0,209,227,209,209,209,209,209,0,0,209,0,0,0,

Ground2C: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,0,0,209,209,209,209,209,209,209,
227,227,227,227,227,227,209,209,209,227,227,227,227,227,227,227,
209,209,209,209,209,209,209,160,227,209,209,209,209,209,209,209,
209,209,209,209,209,209,160,160,160,209,209,209,209,209,209,209,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
160,160,160,160,160,160,160,0,0,160,160,160,160,160,160,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,209,209,209,209,209,209,209,209,209,209,209,209,209,209,0,
209,227,227,227,227,227,227,227,227,227,227,227,227,227,209,209,
227,209,209,209,209,209,209,209,209,209,209,209,209,209,209,160,
160,209,209,209,209,209,209,209,209,209,209,209,209,209,160,160,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
0,160,160,160,160,160,160,160,160,160,160,160,160,160,160,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Tile2A: # 16 x 16 = 256 bytes
.byte 0,227,227,227,227,227,227,0,0,227,227,227,227,227,227,0,
227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,160,
227,227,209,209,209,209,209,209,209,209,209,209,209,209,160,160,
227,227,209,0,209,209,209,209,209,209,209,209,0,209,160,160,
227,227,209,209,209,209,209,209,209,209,209,209,209,209,160,160,
227,227,209,209,227,227,227,227,160,160,160,160,209,209,160,160,
227,227,209,209,209,0,0,0,0,0,0,0,209,209,160,160,
0,227,209,209,227,227,227,227,160,160,160,160,209,209,160,0,
0,227,209,209,209,0,0,0,0,0,0,0,209,209,160,0,
227,227,209,209,227,227,227,227,160,160,160,160,209,209,160,160,
227,227,209,209,209,0,0,0,0,0,0,0,209,209,160,160,
227,227,209,209,209,209,209,209,209,209,209,209,209,209,160,160,
227,227,209,0,209,209,209,209,209,209,209,209,0,209,160,160,
227,227,209,209,209,209,209,209,209,209,209,209,209,209,160,160,
227,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
0,160,160,160,160,160,160,0,0,160,160,160,160,160,160,0,

Pipe2H: # 16 x 16 = 256 bytes
.byte 209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,
209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,
209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,
209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,
209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,
227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,
209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,
209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,209,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Pipe2V: # 16 x 16 = 256 bytes
.byte 0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,
0,0,0,160,209,209,227,209,209,160,209,160,160,0,0,0,

ItemHolderA: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,227,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,227,227,227,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,160,160,
0,0,0,0,0,0,0,0,0,0,0,227,227,160,160,160,
0,0,0,0,0,0,0,0,0,0,227,0,0,0,0,160,

ItemHolderB: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,160,160,160,160,160,160,160,160,0,0,0,0,0,0,0,
160,227,227,160,160,160,160,160,160,160,160,160,0,0,0,0,
227,160,160,160,0,0,0,0,0,160,160,160,160,0,0,0,
160,160,0,160,0,227,227,227,227,0,160,160,160,160,0,0,
160,0,0,0,227,227,160,160,160,227,160,160,160,160,0,0,
160,160,0,227,227,160,0,0,0,160,160,160,160,160,160,0,
160,0,0,227,160,0,0,0,0,160,160,0,160,160,160,0,
160,160,160,227,160,0,0,0,0,160,0,0,160,160,0,0,

ItemHolderC: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,160,160,160,160,0,0,
0,0,0,0,0,0,0,0,0,0,160,227,160,160,0,0,
0,0,0,0,0,0,0,0,0,0,160,227,160,0,160,0,
0,0,0,0,0,0,0,0,0,160,227,160,160,0,160,160,
0,0,0,0,0,0,0,0,0,160,227,160,0,227,227,160,
0,0,0,0,0,0,0,0,0,160,227,0,227,160,160,160,
0,0,0,0,0,0,0,0,0,160,160,0,227,0,0,160,
0,0,0,0,0,0,0,0,0,0,227,160,160,160,0,0,
0,0,0,0,0,0,0,0,0,227,160,160,0,0,0,0,
0,0,0,0,0,0,0,0,0,227,160,160,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,160,160,0,0,
0,0,0,0,0,0,0,0,0,0,227,160,0,0,160,0,
0,0,0,0,0,0,0,0,0,0,160,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,227,160,160,0,0,
0,0,0,0,0,0,0,0,0,0,0,160,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,227,160,0,

ItemHolderD: # 16 x 16 = 256 bytes
.byte 160,160,0,227,0,0,0,160,160,160,160,160,0,160,160,0,
160,0,0,0,227,0,0,160,0,0,209,0,0,0,160,0,
0,0,0,0,0,160,160,160,0,209,209,0,227,0,0,0,
160,160,0,0,0,160,160,0,209,209,0,227,227,227,0,0,
0,0,227,0,0,0,0,0,209,0,0,160,160,227,227,0,
0,0,0,227,227,227,0,0,209,0,0,160,160,160,227,0,
160,0,0,0,0,227,227,227,0,209,0,0,0,160,227,227,
0,0,0,0,0,0,0,0,0,0,209,0,0,160,160,227,
0,0,0,160,160,160,0,0,0,0,0,209,0,0,160,227,
0,160,160,227,227,160,160,0,0,0,0,209,0,0,160,227,
0,160,227,160,160,0,0,0,0,0,209,0,0,0,160,227,
160,227,160,160,0,0,160,160,0,0,0,0,0,0,0,227,
160,227,160,160,0,0,0,160,160,0,227,160,0,0,0,227,
160,227,160,0,0,0,0,160,0,0,0,227,160,0,0,0,
160,160,0,0,0,0,160,0,0,0,0,0,227,160,0,0,
0,160,160,160,0,0,160,160,227,160,0,0,227,160,0,0,

ItemHolderE: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,227,160,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,227,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,227,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,227,160,
0,0,0,0,0,0,0,0,0,0,0,0,227,227,160,160,
0,0,0,0,0,0,0,0,0,0,0,0,227,160,160,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,160,0,
0,0,0,0,0,0,0,0,0,0,0,227,160,160,160,160,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,160,0,
0,0,0,0,0,0,0,0,0,0,0,0,227,160,160,160,
0,0,0,0,0,0,0,0,0,0,0,227,160,0,160,160,
0,0,0,0,0,0,0,0,0,0,0,160,0,0,0,160,
0,0,0,0,0,0,0,0,160,160,227,160,0,0,0,0,

ItemHolderF: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,160,160,227,160,0,0,227,160,0,
0,160,0,0,160,0,0,0,160,160,227,227,0,0,0,0,
0,160,0,0,0,160,160,0,0,0,160,160,0,0,0,227,
0,0,160,160,0,0,0,0,0,0,0,0,160,0,227,227,
0,0,0,160,160,160,160,0,160,0,0,0,0,0,227,160,
160,160,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
160,0,0,0,0,0,0,227,227,227,160,0,227,227,227,227,
0,160,160,0,0,227,227,160,160,160,0,0,227,0,0,160,
0,0,0,227,227,160,160,160,0,0,160,0,0,227,227,0,
0,0,227,160,160,160,0,0,0,227,160,227,227,227,160,0,
0,227,160,160,0,0,0,0,0,227,0,160,227,0,0,0,
0,227,160,0,0,0,0,227,227,160,0,160,0,0,160,0,
0,0,0,0,0,227,227,160,0,0,160,0,0,0,160,160,
0,160,0,227,227,160,160,0,160,160,0,0,0,0,0,160,
0,0,0,160,160,0,0,160,0,0,0,0,0,0,0,0,
0,160,160,160,160,160,160,0,0,0,0,0,0,0,0,0,

ItemHolderG: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,227,0,0,0,0,160,227,0,0,0,
0,0,0,0,0,0,227,160,0,227,227,160,0,0,0,0,
0,160,160,160,0,160,160,160,160,160,160,160,0,0,0,0,
160,0,0,0,227,0,0,160,160,0,0,0,0,0,0,0,
160,0,227,227,160,160,160,0,0,0,0,0,0,0,0,0,
0,0,227,0,160,160,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
227,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,227,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,160,227,227,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,160,227,0,0,0,0,227,227,227,0,0,0,0,
227,227,0,0,227,0,0,0,227,160,160,160,227,227,0,0,
160,160,227,0,160,227,0,160,227,227,0,160,160,160,160,0,
160,160,160,227,0,227,227,160,0,0,0,0,0,0,160,0,
0,0,160,160,160,160,0,160,160,160,227,0,0,0,227,0,

Ground3A: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,70,68,0,0,70,68,68,68,68,68,0,0,68,68,0,
0,68,0,68,68,68,68,68,68,68,68,68,68,0,68,0,
0,0,68,68,68,0,0,0,0,0,0,68,68,68,0,0,
0,0,70,68,0,0,14,14,14,14,0,0,68,68,0,0,
0,70,68,0,0,14,70,14,14,14,14,0,0,68,68,0,
0,70,68,0,14,70,14,14,14,14,14,14,0,68,68,0,
0,70,68,0,14,14,14,14,14,14,14,14,0,68,68,0,
0,68,68,0,14,14,14,14,14,14,14,14,0,68,68,0,
0,68,68,0,14,14,14,14,14,14,14,14,0,68,68,0,
0,68,68,0,0,14,14,14,14,14,14,0,0,68,68,0,
0,0,68,68,0,0,14,14,14,14,0,0,68,68,0,0,
0,0,68,68,68,0,0,0,0,0,0,68,68,68,0,0,
0,68,0,68,68,68,68,68,68,68,68,68,68,0,68,0,
0,70,68,0,0,68,68,68,68,68,68,0,0,68,68,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Ground3B: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,70,70,70,0,0,70,70,70,70,0,0,70,70,0,
0,70,68,68,68,68,0,0,68,68,68,0,68,68,68,0,
0,70,68,70,70,70,70,70,70,70,70,70,70,70,68,0,
0,0,68,70,68,68,68,68,68,68,68,68,68,0,68,0,
0,0,0,70,68,70,70,70,70,70,70,70,68,0,0,0,
0,70,0,70,68,70,68,68,68,68,68,0,68,0,68,0,
0,70,68,70,68,70,68,70,70,70,68,0,68,0,68,0,
0,70,68,70,68,70,68,70,68,0,68,0,68,0,68,0,
0,70,68,70,68,70,68,0,0,0,68,0,68,0,0,0,
0,70,68,70,68,70,68,68,68,68,70,0,68,0,68,0,
0,70,0,70,68,0,0,0,0,0,0,0,68,0,68,0,
0,0,68,70,68,68,68,68,68,68,68,68,70,0,68,0,
0,70,68,0,0,0,0,0,0,0,0,0,0,0,68,0,
0,70,68,68,68,0,68,68,68,68,68,0,0,68,70,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Ground3C: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,14,14,14,70,14,0,0,0,0,0,14,14,14,14,14,
0,68,68,68,68,14,70,0,0,0,70,14,68,68,68,68,
0,0,0,0,0,68,14,14,0,14,14,68,0,0,0,0,
0,14,14,14,0,0,68,14,0,14,68,0,0,70,14,14,
0,68,68,14,14,0,68,14,68,68,68,0,70,14,68,68,
0,0,0,68,14,0,68,14,14,68,0,14,14,68,0,0,
0,0,0,68,0,14,14,68,70,14,0,0,68,68,0,0,
0,14,14,14,14,14,68,0,68,70,14,14,14,14,14,14,
0,68,68,68,68,68,0,0,0,68,68,68,68,68,68,68,
0,0,0,0,68,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,14,68,0,0,0,0,0,0,0,14,68,0,0,
0,14,0,14,68,0,14,14,14,14,14,0,14,68,0,14,
0,68,68,14,68,0,68,68,68,68,68,68,14,68,68,68,
0,0,0,14,14,70,0,0,0,0,0,14,14,68,0,0,
0,14,14,0,14,14,14,14,14,14,14,14,68,0,14,14,

Pipe3V: # 16 x 16 = 256 bytes
.byte 0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,
0,0,0,68,14,14,70,14,14,68,14,68,68,0,0,0,

Pipe3V2: # 16 x 16 = 256 bytes
.byte 0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,
0,0,0,91,173,173,255,173,173,91,173,91,91,0,0,0,

Tile3A: # 16 x 16 = 256 bytes
.byte 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,
173,255,91,91,255,255,255,255,255,255,255,91,91,255,91,0,
173,173,255,255,255,255,255,255,255,255,255,255,255,91,91,0,
173,91,173,255,255,255,255,255,255,255,255,255,91,0,91,0,
173,91,173,173,255,255,255,255,255,255,255,91,91,0,91,0,
173,173,173,173,173,255,255,255,255,255,91,91,91,91,91,0,
173,173,173,173,173,173,255,255,255,91,91,91,91,91,91,0,
173,173,173,173,173,173,173,255,91,91,91,91,91,91,91,0,
173,173,173,173,173,173,173,91,173,91,91,91,91,91,91,0,
173,173,173,173,173,173,91,91,91,173,91,91,91,91,91,0,
173,173,173,173,173,91,91,91,91,91,173,91,91,0,91,0,
173,91,173,173,91,91,91,91,91,91,91,173,91,0,91,0,
173,91,173,91,91,91,91,91,91,91,91,91,173,91,91,0,
173,173,91,0,0,91,91,91,91,91,0,0,91,173,91,0,
173,91,91,91,91,91,91,91,91,91,91,91,91,91,173,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

Tile3B: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,14,14,14,14,0,0,0,0,0,
0,0,0,0,0,14,14,14,14,14,14,14,14,0,0,0,
0,0,0,0,14,14,14,14,14,14,14,68,14,14,0,0,
0,0,0,14,14,70,70,14,14,14,14,14,68,14,14,0,
0,0,0,14,70,70,14,14,14,14,14,14,14,68,14,0,
0,0,14,14,70,70,14,14,14,14,14,14,14,68,14,14,
0,0,14,14,70,14,14,14,14,14,14,14,14,68,68,14,
0,0,14,14,14,14,14,14,14,14,14,14,14,68,68,14,
0,0,14,14,14,14,14,14,14,14,14,14,14,68,68,14,
0,0,14,14,14,14,14,14,14,14,14,14,14,68,68,14,
0,0,0,14,14,14,14,14,14,14,14,14,68,68,14,0,
0,0,0,14,14,68,14,14,14,14,68,68,68,68,14,0,
0,0,0,0,14,14,68,68,68,68,68,68,68,14,0,0,
0,0,0,0,0,14,14,14,68,68,68,14,14,0,0,0,
0,0,0,0,0,0,0,14,14,14,14,0,0,0,0,0,

Tile3C: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,234,234,234,234,234,234,234,234,234,234,234,234,234,234,0,
0,234,234,234,234,234,234,234,234,234,234,234,234,234,196,0,
0,234,234,133,133,133,133,133,133,133,133,133,133,196,196,0,
0,234,234,133,234,0,133,133,133,133,234,0,133,196,196,0,
0,234,234,133,133,133,133,133,133,133,133,133,133,196,196,0,
0,234,234,133,133,133,133,133,133,133,133,133,133,196,196,0,
0,234,234,133,133,133,133,133,133,133,133,133,133,196,196,0,
0,234,234,133,133,133,133,133,133,133,133,133,133,196,196,0,
0,234,234,133,133,133,133,133,133,133,133,133,133,196,196,0,
0,234,234,133,133,133,133,133,133,133,133,133,133,196,196,0,
0,234,234,133,234,0,133,133,133,133,234,0,133,196,196,0,
0,234,234,133,133,133,133,133,133,133,133,133,133,196,196,0,
0,234,234,196,196,196,196,196,196,196,196,196,196,196,196,0,
0,234,196,196,196,196,196,196,196,196,196,196,196,196,196,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

LavaB: # 16 x 16 = 256 bytes
.byte 70,70,70,70,70,14,70,70,70,70,70,70,70,14,70,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
70,14,70,70,70,14,70,70,70,14,70,70,70,14,70,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
70,70,70,14,70,70,70,70,70,70,70,14,70,70,70,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
14,70,70,70,70,70,70,70,14,70,70,70,70,70,70,70,
70,70,70,70,70,70,14,70,70,70,70,70,70,70,14,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
70,14,70,70,70,14,70,70,70,14,70,70,70,14,70,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
70,70,70,14,70,70,70,70,70,70,70,14,70,70,70,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
14,70,70,70,70,70,70,70,14,70,70,70,70,70,70,70,

LavaT: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,70,0,0,0,70,0,70,0,70,0,0,0,70,0,70,
70,70,0,70,0,70,70,70,70,70,0,70,0,70,70,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
70,70,70,70,70,70,14,70,70,70,70,70,70,70,14,70,
70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,
70,14,70,70,70,70,70,70,70,14,70,70,70,70,70,70,

SpikeL: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,70,14,14,14,14,14,14,14,14,14,68,0,0,
0,0,0,70,14,14,14,14,14,14,14,68,68,0,0,0,
0,0,0,70,14,14,14,14,14,14,68,0,0,0,0,0,
0,0,0,0,70,14,14,14,14,68,68,0,0,0,0,0,
0,0,0,0,70,14,14,14,14,68,0,0,0,0,0,0,
0,0,0,0,0,70,14,14,68,68,0,0,0,0,0,0,
0,0,0,0,0,70,14,14,68,0,0,0,0,0,0,0,
0,0,0,0,0,70,14,14,68,0,0,0,0,0,0,0,
0,0,0,0,0,0,70,14,68,0,0,0,0,0,0,0,
0,0,0,0,0,0,70,14,68,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,70,68,68,0,0,0,0,0,0,
0,0,0,0,0,0,0,70,14,68,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,70,14,68,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,70,14,68,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,70,70,0,0,0,

SpikeR: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,68,14,14,14,14,14,14,14,14,14,70,0,0,0,
0,0,0,68,68,14,14,14,14,14,14,14,70,0,0,0,
0,0,0,0,0,68,14,14,14,14,14,14,70,0,0,0,
0,0,0,0,0,68,68,14,14,14,14,70,0,0,0,0,
0,0,0,0,0,0,68,14,14,14,14,70,0,0,0,0,
0,0,0,0,0,0,68,68,14,14,70,0,0,0,0,0,
0,0,0,0,0,0,0,68,14,14,70,0,0,0,0,0,
0,0,0,0,0,0,0,68,14,14,70,0,0,0,0,0,
0,0,0,0,0,0,0,68,14,70,0,0,0,0,0,0,
0,0,0,0,0,0,0,68,14,70,0,0,0,0,0,0,
0,0,0,0,0,0,68,68,70,0,0,0,0,0,0,0,
0,0,0,0,0,0,68,14,70,0,0,0,0,0,0,0,
0,0,0,0,0,68,14,70,0,0,0,0,0,0,0,0,
0,0,0,0,68,14,70,0,0,0,0,0,0,0,0,0,
0,0,0,70,70,0,0,0,0,0,0,0,0,0,0,0,

DoorLeftTop: # 16 x 16 = 256 bytes
.byte 209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
209,255,209,209,209,0,0,0,0,0,0,0,0,0,0,0,
209,255,255,209,209,0,0,0,0,0,0,0,0,0,0,0,
209,255,255,209,209,209,0,0,0,0,0,0,0,0,0,0,
209,209,255,255,209,209,0,0,0,0,0,0,0,0,0,0,
209,209,209,255,209,209,0,0,0,0,0,0,0,0,0,0,
209,209,209,255,209,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,209,255,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,209,255,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,

DoorLeftTopO: # 16 x 16 = 256 bytes
.byte 209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
255,209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,209,209,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,209,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

DoorLeftMiddle: # 16 x 16 = 256 bytes
.byte 209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,

DoorLeftMiddleO: # 16 x 16 = 256 bytes
.byte 209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

DoorLeftBottom: # 16 x 16 = 256 bytes
.byte 209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,209,209,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,209,255,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,209,255,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,255,209,209,209,0,0,0,0,0,0,0,0,0,
209,209,209,255,209,209,0,0,0,0,0,0,0,0,0,0,
209,209,255,255,209,209,0,0,0,0,0,0,0,0,0,0,
209,255,255,209,209,209,0,0,0,0,0,0,0,0,0,0,
209,255,255,209,209,0,0,0,0,0,0,0,0,0,0,0,
209,255,209,209,209,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

DoorLeftBottomO: # 16 x 16 = 256 bytes
.byte 209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,209,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,209,209,0,0,0,0,0,0,0,0,0,0,0,
0,0,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,209,209,0,0,0,0,0,0,0,0,0,0,0,0,
255,209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
209,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

DoorRightTop: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,209,209,209,255,209,
0,0,0,0,0,0,0,0,0,0,0,209,209,255,255,209,
0,0,0,0,0,0,0,0,0,0,209,209,209,255,255,209,
0,0,0,0,0,0,0,0,0,0,209,209,255,255,209,209,
0,0,0,0,0,0,0,0,0,0,209,209,255,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,209,255,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,255,209,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,255,209,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,

DoorRightTopO: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,255,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,0,0,
0,0,0,0,0,0,0,0,0,0,0,209,209,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,209,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,

DoorRightMiddle: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,

DoorRightMiddleO: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,

DoorRightBottom: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,209,209,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,255,209,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,255,209,209,209,209,
0,0,0,0,0,0,0,0,0,209,209,209,255,209,209,209,
0,0,0,0,0,0,0,0,0,0,209,209,255,209,209,209,
0,0,0,0,0,0,0,0,0,0,209,209,255,255,209,209,
0,0,0,0,0,0,0,0,0,0,209,209,209,255,255,209,
0,0,0,0,0,0,0,0,0,0,0,209,209,255,255,209,
0,0,0,0,0,0,0,0,0,0,0,209,209,209,255,209,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,

DoorRightBottomO: # 16 x 16 = 256 bytes
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,209,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,209,209,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,209,209,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,255,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,209,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,209,

################################################        Matrixes        ################################################
# Stores matrixes related to the maps (Each byte represents a tile, see more on tile.data)
# 
# --> Total ammount of data: 4.800 bytes or ~4.6 KiB
#
# --> The matrixes can't be larger than 255x255 (since we're using bytes to store it's coordinates)


Map1: # 60 x 15 (Horizontal Map) -- 900 bytes
.byte 1,60,15 # Map type (1 - Horizontal Camera Movement, Width, Height)
.byte 5,5,11,5,5,5,11,5,5,7,5,5,5,5,14,5,7,5,6,6,6,6,5,6,6,7,5,5,5,5,14,5,7,7,5,5,5,5,14,5,7,7,5,5,5,5,14,5,7,7,5,5,5,5,6,6,5,6,9,9,
12,5,7,5,12,5,7,5,12,5,14,13,14,0,0,5,5,5,5,7,7,5,5,7,5,5,14,13,14,0,0,5,5,5,14,13,14,0,0,5,5,5,14,13,14,0,0,5,5,5,14,13,14,0,7,5,5,7,7,5,
5,12,5,5,5,12,5,5,5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,5,12,
5,5,11,5,5,5,5,7,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
5,5,7,5,12,5,11,5,5,0,0,0,0,0,0,0,0,0,0,5,11,5,5,0,0,0,0,0,0,0,16,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
12,12,5,5,5,5,7,5,12,0,0,0,0,0,0,0,0,0,0,5,7,5,12,0,0,0,0,0,0,0,9,9,0,0,0,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,46,4,
5,5,5,7,5,12,5,5,5,0,0,0,0,0,0,0,0,0,0,12,5,11,5,5,0,0,0,0,0,0,7,5,0,0,0,7,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,4,
5,5,11,5,5,5,5,7,5,0,0,0,0,0,0,0,0,0,0,5,5,7,5,12,0,0,0,0,0,0,5,12,0,0,0,5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,4,
12,5,7,5,12,5,11,5,5,0,0,0,0,0,0,0,0,0,0,0,12,5,11,5,5,0,0,0,0,0,12,12,0,0,0,12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,11,11,5,9,9,
5,12,5,5,5,5,7,5,12,0,0,0,0,0,0,0,0,0,0,0,5,5,7,5,12,0,0,0,0,0,5,5,0,0,0,5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
5,5,5,7,5,12,5,5,5,0,0,0,0,0,0,18,0,0,0,0,0,12,5,5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
5,5,11,5,5,5,5,7,5,0,0,0,10,0,0,18,0,0,10,0,0,5,5,7,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
12,5,7,5,12,5,11,5,5,0,0,0,18,18,0,20,0,18,18,0,0,0,0,0,0,0,0,0,0,0,18,18,18,18,18,18,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
5,12,5,5,5,5,7,5,12,5,6,6,6,6,6,6,6,6,6,6,6,6,5,6,6,5,6,6,6,6,5,6,6,5,6,6,6,6,5,6,6,5,6,6,5,6,6,6,6,5,6,6,5,6,6,6,6,5,6,6,
5,5,5,7,5,12,5,5,5,5,5,7,7,5,5,7,5,5,5,7,7,5,5,7,5,5,5,7,7,5,5,7,5,5,5,7,7,5,5,7,5,5,7,5,5,5,7,7,5,5,7,5,5,5,7,7,5,5,7,5,

Map2: # 20 x 45 (Vertical Map) -- 900 bytes 
.byte 2,20,45 # Map type (2 - Vertical Camera Movement, Widht, Height)
.byte 9,7,5,5,5,5,14,5,7,7,5,5,7,7,5,5,5,5,9,9,
7,5,14,13,14,0,0,5,5,5,14,5,5,5,14,13,14,0,7,5,
5,5,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
4,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,46,4,
4,42,0,0,5,7,1,1,1,1,7,1,1,1,1,5,0,0,48,4,
4,44,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,4,
8,8,8,8,1,1,1,1,1,5,5,7,5,1,1,1,5,11,5,5,
8,7,7,8,0,0,0,0,0,0,0,0,0,0,0,0,5,7,5,12,
7,8,7,7,0,0,0,0,0,0,0,0,0,0,0,0,12,5,5,5,
9,9,8,8,0,0,0,0,0,0,0,0,0,0,0,0,5,5,9,9,
7,5,0,0,0,0,5,11,11,11,11,11,11,5,0,0,0,0,7,5,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
7,5,5,11,5,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,5,11,5,0,0,0,0,0,0,0,0,12,12,
5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
9,9,0,0,0,0,0,0,0,0,0,0,0,5,11,11,5,0,9,9,
7,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
5,12,0,5,11,5,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,0,0,0,5,11,11,11,5,0,0,0,12,12,
5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
7,5,0,0,0,0,5,11,11,5,0,0,0,0,0,0,0,0,7,5,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,5,11,5,5,12,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
9,9,5,11,11,5,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
7,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
5,12,0,0,0,0,0,0,0,0,5,11,11,11,5,0,0,0,5,12,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
9,9,0,0,0,0,5,11,5,0,0,0,0,0,0,0,0,0,9,9,
4,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
4,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
4,44,0,0,0,0,0,0,0,0,0,0,0,0,0,5,11,5,9,9,
5,5,5,11,5,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
7,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
5,12,0,0,0,0,0,5,11,11,5,0,0,0,0,0,0,0,5,5,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
5,11,5,5,5,11,5,5,5,11,5,5,5,11,5,5,5,5,5,5,

Map3: # 60 x 15 (Horizontal Map) -- 900 bytes
.byte 1,60,15 # Map type (1 - Horizontal Camera Movement, Widht, Height)
.byte 9,9,7,5,5,7,7,5,5,5,5,14,7,5,5,5,5,14,5,7,7,5,5,5,5,7,5,7,5,6,6,6,8,8,8,8,8,8,8,8,7,5,5,5,7,5,5,5,5,14,5,5,6,6,6,6,5,6,9,9,
7,5,5,14,13,5,5,14,13,14,0,0,5,14,13,14,0,0,5,5,5,14,13,14,0,0,5,5,5,5,5,7,8,7,7,8,8,7,7,8,5,14,13,14,5,14,13,14,0,0,5,5,5,7,7,5,5,7,7,5,
5,12,5,0,0,0,5,0,0,0,0,0,5,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,7,8,7,7,7,8,7,7,5,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,7,8,8,8,7,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
4,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,7,7,8,8,7,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,46,4,
4,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,8,7,7,7,8,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,4,
4,44,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,7,8,8,8,7,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,4,
9,9,5,11,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,11,11,5,9,9,
7,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,7,7,8,8,7,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,8,7,7,7,8,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,7,8,8,8,7,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
5,6,6,6,6,5,6,6,6,5,6,6,5,6,6,6,6,5,6,6,5,6,6,6,6,5,6,6,8,8,8,8,8,8,8,8,5,6,6,6,6,5,6,6,5,6,6,6,6,5,6,6,5,6,6,6,6,5,6,6,
5,5,7,7,5,5,7,5,5,5,7,5,5,5,7,7,5,5,7,5,5,5,7,7,5,5,7,5,8,7,7,8,8,7,7,8,5,5,7,7,5,5,7,5,5,5,7,7,5,5,7,5,5,5,7,7,5,5,7,5,

Map4: # 20 x 45 (Vertical Map) -- 900 bytes 
.byte 2,20,45 # Map type (2 - Vertical Camera Movement, Widht, Height)
.byte 12,5,5,5,12,5,5,5,12,5,5,5,5,7,5,5,5,7,5,12,
9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
5,5,0,0,0,0,0,5,11,11,5,0,0,0,0,0,0,0,5,5,
4,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
4,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
4,44,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
9,9,5,11,5,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
7,5,0,0,0,0,0,0,0,0,0,0,5,11,11,11,11,5,5,5,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
9,9,0,0,0,0,5,11,5,0,0,0,0,0,0,0,0,0,5,12,
7,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
5,12,0,0,0,0,0,0,0,0,0,5,11,11,5,0,0,0,5,5,
9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
7,5,5,11,5,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,5,11,5,0,0,0,0,0,5,11,5,12,12,
5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
7,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
5,12,0,5,11,5,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,0,0,0,5,11,5,0,0,0,0,0,12,12,
5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
7,5,0,0,0,0,5,11,11,5,0,0,0,0,5,11,11,5,7,5,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
9,9,0,0,5,11,5,0,0,0,0,0,5,11,5,0,0,0,9,9,
7,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
12,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
5,5,0,0,0,0,0,5,11,11,5,0,0,0,0,0,0,0,5,5,
4,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
4,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,5,
4,44,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,12,
9,9,5,11,5,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,
7,5,0,0,0,0,0,0,0,0,0,0,5,11,11,11,11,5,5,5,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,
12,12,0,0,0,0,5,11,5,0,0,0,0,0,0,0,0,0,7,5,
5,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,
5,11,5,5,5,11,5,5,5,11,5,5,5,11,5,5,5,11,5,5,
5,7,5,12,5,7,5,12,5,7,5,12,5,7,5,12,5,7,5,12,

Map5: # 40 x 15 (Horizontal Map) -- 600 bytes
.byte 1,40,15 # Map type (1 - Horizontal Camera Movement, Width, Height)
.byte 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,
15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,
15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,
15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,
15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,
4,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,46,4,
4,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,4,
4,44,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,4,
15,17,17,17,17,17,17,17,17,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,17,17,17,17,17,17,17,15,
15,0,0,0,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,0,15,
15,0,0,0,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,0,15,
15,0,0,0,0,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20,0,0,0,0,15,
15,0,0,0,0,20,0,0,0,0,2,3,0,0,0,2,3,2,3,0,0,0,0,0,0,0,0,2,3,0,0,0,0,0,20,0,0,0,0,15,
15,15,15,15,15,16,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,
15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,

Map6: # 20 x 15 (One Screen Map) -- 300 bytes
.byte 0,20,15 # Map type (0 - No Camera Movement, Widht, Height)
.byte 5,11,5,5,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,18,
5,7,5,12,18,0,0,0,18,0,0,0,0,0,0,0,0,0,0,18,
12,5,5,5,18,0,0,0,18,21,22,0,0,0,0,0,0,0,0,20,
5,5,7,5,20,0,0,0,20,23,24,255,0,0,0,0,0,0,0,20,
5,11,5,5,20,0,0,0,20,25,26,27,0,0,0,0,0,0,0,18,
5,7,5,12,17,17,17,17,17,17,17,17,18,18,0,0,0,0,46,4,
12,5,5,5,17,17,17,17,17,17,17,17,0,0,0,0,0,0,48,4,
5,5,7,5,19,19,19,19,19,19,19,19,0,0,0,0,0,0,50,4,
5,11,5,5,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,
5,7,5,12,18,18,18,18,18,18,18,0,0,18,18,18,18,18,18,18,
12,5,5,5,18,17,18,16,18,17,18,0,0,18,17,18,16,18,17,18,
5,5,7,5,0,0,0,18,0,0,0,0,0,0,0,0,18,0,0,0,
5,11,5,5,0,0,0,18,0,0,0,0,0,0,0,0,18,0,0,0,
5,7,5,12,0,0,0,20,0,0,0,0,0,0,0,0,20,0,0,0,
12,5,5,5,0,0,0,20,0,0,0,0,0,0,0,0,20,0,0,0,

Map7: # 20 x 15 (One Screen Map) -- 300 bytes
.byte 0,20,15 # Map type (0 - No Camera Movement, Widht, Height)
.byte 29,29,29,29,29,29,28,28,28,28,28,28,28,28,28,28,28,28,29,29,
29,30,30,29,31,0,0,34,38,38,38,38,39,39,39,39,34,0,29,31,
29,30,30,29,29,33,0,0,0,0,0,0,0,0,0,0,0,0,30,29,
29,29,29,29,29,32,0,0,0,0,0,0,0,0,0,0,0,0,31,29,
29,29,29,29,29,32,0,0,0,0,0,0,0,0,0,0,0,0,29,29,
29,30,30,29,29,32,0,0,0,0,0,0,0,0,0,0,0,0,46,4,
29,30,30,29,31,33,0,0,0,0,0,0,0,0,0,0,0,0,48,4,
29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,50,4,
29,30,30,29,29,0,0,28,28,28,28,0,0,0,0,0,0,33,33,29,
29,30,30,29,31,33,0,0,28,28,28,28,28,28,28,28,0,0,32,29,
29,29,29,29,29,32,0,0,0,0,0,0,0,0,0,0,0,0,33,30,
29,29,29,29,29,33,0,0,0,0,0,0,0,0,0,0,0,0,0,29,
29,30,30,29,31,37,37,37,37,37,37,37,37,37,37,37,37,37,37,29,
29,30,30,29,29,36,36,36,36,36,36,36,36,36,36,36,36,36,36,29,
35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,

################################################        Samus        ################################################
# Stores all sprites used for Samus in the game
# 
# --> Total ammount of data: 31,664 bytes or ~31 KiB + 2 bytes (half word alignment)
#
#
# Facing Right:								  Facing Left:
#   01. Samus_Right_Idle - 20 x 64 --- 1280 bytes               10. Samus_Left_Idle: - 20 x 64 --- 1280 bytes	
#   02. Samus_Right_Idle_Up - 20 x 76 --- 1520 bytes            11. Samus_Left_Idle_Up - 20 x 76 --- 1520 bytes
#   03. Samus_Righ - 20 x 96 --- 1920 bytes                     12. Samus_Left - 28 x 96 --- 2688 bytes
#   04. Samus_Right_Attack - 28 x 96 --- 2688 bytes             13. Samus_Left_Attack - 28 x 96 --- 2688 bytes
#   05. Samus_Right_Up - 20 x 114 --- 2280 bytes                14. Samus_Left_Up - 20 x 114 --- 2280 bytes
#   06. Samus_Right_Up_Attack - 20 x 114 --- 2280 bytes         15. Samus_Left_Up_Attack - 20 x 114 --- 2280 bytes
#   07. Samus_Right_Jump - 24 x 64 --- 1536 bytes               16. Samus_Left_Jump - 24 x 64 --- 1536 bytes
#   08. Samus_Right_Jump_Up - 20 x 64 --- 1280 bytes            17. Samus_Left_Jump_Up - 24 x 64 --- 1536 bytes
#   09. Samus_Right_Jump_Spin - 24 x 96 --- 2304 bytes          18. Samus_Left_Jump_Spin - 24 x 96 --- 2304 bytes
#
# Direction Defines Sprite Rotation:
# 19. Morph_Ball - 16 x 64 --- 1024 bytes
#
######################################################################################################################

.half 0 # aligning to half

# 01. Samus_Right_Idle: Status 0 - Normal, 1 - Shooting
Samus_Right_Idle: # 20 x 64, Height per sprite: 32
# 1280 bytes -- 1.25 KiB 
.byte 199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,14,103,14,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,14,103,14,14,14,32,14,14,32,103,199,199,199,199,199,199,199,
199,199,199,14,14,14,14,14,14,32,14,199,32,103,199,199,199,199,199,199,
199,199,199,14,14,14,14,14,32,14,14,199,32,32,199,199,199,199,199,199,
199,199,199,199,14,103,103,103,103,199,14,14,199,32,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,32,103,199,14,14,14,199,199,199,199,199,199,
199,199,199,103,103,103,103,32,103,32,103,14,103,103,103,32,32,103,32,199,
199,199,199,103,103,103,32,103,103,103,103,103,103,103,103,32,32,32,32,32,
199,199,199,103,103,103,199,103,103,103,14,14,103,103,32,32,32,32,32,32,
199,199,199,103,103,103,103,32,14,103,103,14,14,199,32,32,32,103,32,199,
199,199,199,199,103,103,103,32,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,14,14,103,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,32,32,103,103,14,14,14,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,199,199,14,14,199,14,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,199,103,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,199,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,14,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,14,14,14,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,103,14,103,103,103,199,199,199,199,199,199,199,199,199,
199,14,103,103,103,103,199,199,103,103,14,199,199,199,199,199,199,199,199,199,
14,14,103,14,14,199,199,14,103,14,14,199,199,199,199,199,199,199,199,199,
14,14,14,14,199,199,199,14,14,14,32,14,199,199,199,199,199,199,199,199,
14,14,32,32,199,199,199,14,14,32,14,14,14,199,199,199,199,199,199,199,
199,32,14,14,14,199,199,199,14,32,14,14,14,14,199,199,199,199,199,199,
199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,14,103,14,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,14,103,14,14,14,32,14,14,32,103,199,199,199,199,199,199,199,
199,199,199,14,14,14,14,14,14,32,14,199,32,103,199,199,199,199,199,199,
199,199,199,14,14,14,14,14,32,14,14,199,32,32,199,199,199,199,199,199,
199,199,199,199,14,103,103,103,103,199,14,14,199,32,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,32,103,199,14,14,14,199,199,199,199,199,199,
199,199,199,103,103,103,103,32,103,32,103,14,103,103,103,32,32,199,199,199,
199,199,199,103,103,103,32,103,103,103,103,103,103,103,103,32,32,32,199,199,
199,199,199,103,103,103,199,103,103,103,14,14,103,103,32,32,32,32,199,199,
199,199,199,103,103,103,103,32,14,103,103,14,14,32,32,32,32,199,199,199,
199,199,199,199,103,103,103,32,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,14,14,103,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,32,32,103,103,14,14,14,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,199,199,14,14,199,14,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,199,103,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,199,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,14,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,14,14,14,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,103,14,103,103,103,199,199,199,199,199,199,199,199,199,
199,14,103,103,103,103,199,199,103,103,14,199,199,199,199,199,199,199,199,199,
14,14,103,14,14,199,199,14,103,14,14,199,199,199,199,199,199,199,199,199,
14,14,14,14,199,199,199,14,14,14,32,14,199,199,199,199,199,199,199,199,
14,14,32,32,199,199,199,14,14,32,14,14,14,199,199,199,199,199,199,199,
199,32,14,14,14,199,199,199,14,32,14,14,14,14,199,199,199,199,199,199,
199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

# 02. Samus_Right_Idle_Up: Status 0 - Normal, 1 - Shooting
Samus_Right_Idle_Up: # 20 x 76, Height per sprite: 38
# 1520 bytes -- ~ 1.48 KiB 
.byte 199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,14,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,14,14,14,14,14,14,103,14,14,199,199,199,199,199,199,199,199,199,
199,199,14,14,14,14,32,103,14,14,14,14,199,199,199,199,199,199,199,199,
199,14,103,14,14,32,32,103,103,14,103,14,199,199,199,199,199,199,199,199,
199,14,103,14,103,32,103,103,103,103,14,14,199,199,199,199,199,199,199,199,
199,14,14,14,103,32,103,103,103,103,14,14,199,199,199,199,199,199,199,199,
199,199,14,103,103,32,103,103,103,32,14,199,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,103,103,103,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,32,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,32,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,199,103,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,199,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,14,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,14,14,14,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,103,14,103,103,103,199,199,199,199,199,199,199,199,199,
199,14,103,103,103,103,199,199,103,103,14,199,199,199,199,199,199,199,199,199,
14,14,103,14,14,199,199,14,103,14,14,199,199,199,199,199,199,199,199,199,
14,14,14,14,199,199,199,14,14,14,32,14,199,199,199,199,199,199,199,199,
14,14,32,32,199,199,199,14,14,32,14,14,14,199,199,199,199,199,199,199,
199,32,14,14,14,199,199,199,14,32,14,14,14,14,199,199,199,199,199,199,
199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,14,103,103,32,32,199,199,199,199,199,199,199,199,199,
199,199,14,14,14,14,14,14,103,14,14,199,199,199,199,199,199,199,199,199,
199,199,14,14,14,14,32,103,14,14,14,14,199,199,199,199,199,199,199,199,
199,14,103,14,14,32,32,103,103,14,103,14,199,199,199,199,199,199,199,199,
199,14,103,14,103,32,103,103,103,103,14,14,199,199,199,199,199,199,199,199,
199,14,14,14,103,32,103,103,103,103,14,14,199,199,199,199,199,199,199,199,
199,199,14,103,103,32,103,103,103,32,14,199,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,103,103,103,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,32,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,32,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,199,103,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,199,199,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,14,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,14,14,14,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,103,14,103,103,103,199,199,199,199,199,199,199,199,199,
199,14,103,103,103,103,199,199,103,103,14,199,199,199,199,199,199,199,199,199,
14,14,103,14,14,199,199,14,103,14,14,199,199,199,199,199,199,199,199,199,
14,14,14,14,199,199,199,14,14,14,32,14,199,199,199,199,199,199,199,199,
14,14,32,32,199,199,199,14,14,32,14,14,14,199,199,199,199,199,199,199,
199,32,14,14,14,199,199,199,14,32,14,14,14,14,199,199,199,199,199,199,
199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

# 03. Samus_Right: Status 0 - 2 (Loop animation going from 0 > 1 > 2 > 0 > ...)
Samus_Right: # 20 x 96, Height per sprite: 32
# 1920 bytes -- 1.875 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,14,14,14,14,14,14,14,199,199,199,
199,199,199,199,199,199,199,14,103,14,14,14,32,14,14,32,103,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,32,14,199,32,103,199,199,
199,199,199,199,199,199,199,14,14,199,199,14,32,14,14,199,32,32,199,199,
199,199,199,199,199,199,199,199,14,103,103,103,199,14,14,14,199,32,199,199,
199,199,199,199,199,199,199,199,32,103,32,103,103,199,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,103,103,103,32,103,32,14,14,14,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,32,14,32,14,199,199,199,199,
199,199,199,199,199,199,103,103,103,199,199,199,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,103,103,103,103,14,14,14,32,199,199,199,199,
199,199,199,199,199,199,14,103,103,103,103,14,14,32,32,32,32,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,14,199,199,199,199,32,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,14,14,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,103,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,14,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,103,103,14,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,14,32,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,32,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,32,14,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,14,103,14,14,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,14,103,14,14,14,32,14,14,32,103,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,14,32,14,199,32,103,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,32,14,14,199,32,32,199,199,199,199,
199,199,199,199,199,199,103,103,103,199,14,14,14,14,199,32,199,199,199,199,
199,199,199,199,199,32,103,32,103,103,199,14,14,14,14,14,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,103,14,14,14,199,199,199,199,
199,199,199,199,103,103,32,103,103,103,103,32,199,32,14,199,199,199,199,199,
199,199,199,199,103,103,32,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,103,103,103,14,103,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,103,103,14,103,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,199,14,103,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,14,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,14,103,103,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,199,103,103,103,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,14,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,199,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,199,14,14,32,32,199,199,199,199,199,199,
199,199,199,199,103,103,14,103,199,199,14,32,14,14,14,199,199,199,199,199,
199,14,14,103,103,103,14,14,199,199,199,199,14,14,14,14,199,199,199,199,
14,14,14,103,103,103,14,199,199,199,199,199,199,14,14,14,14,199,199,199,
32,32,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,32,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,199,199,14,103,14,14,14,14,14,14,14,199,
199,199,199,199,199,199,199,199,199,14,103,14,14,14,32,14,14,32,103,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,32,14,199,32,103,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,32,14,14,199,32,32,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,14,199,32,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,14,14,14,14,14,
199,199,199,199,199,199,103,103,103,103,103,32,103,103,199,14,14,14,199,199,
199,199,199,199,199,14,14,32,199,199,103,103,103,103,14,199,14,199,199,199,
199,199,199,199,199,103,103,103,103,103,32,32,32,32,32,103,103,103,199,199,
199,199,199,199,199,103,103,103,103,103,103,32,32,32,32,32,103,103,103,199,
199,199,199,199,199,199,103,103,103,103,103,32,199,199,199,32,103,103,103,199,
199,199,199,199,199,199,199,199,103,103,32,32,32,32,32,103,103,103,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,14,14,14,199,199,199,103,103,103,103,103,199,199,199,199,199,199,
199,199,32,14,14,14,199,199,199,103,103,103,103,103,103,199,199,199,199,199,
199,14,14,32,14,14,14,199,199,199,103,103,103,103,103,103,199,199,199,199,
199,14,14,32,14,103,103,103,199,103,103,103,199,103,103,103,199,199,199,199,
14,14,14,199,14,14,103,103,14,103,103,199,199,199,103,103,103,199,199,199,
14,14,199,199,199,14,103,103,14,103,103,199,199,199,103,103,103,199,199,199,
199,199,199,199,199,199,199,103,103,14,199,199,199,199,199,14,14,14,199,199,
199,199,199,199,199,199,199,199,14,14,199,199,199,199,199,103,103,14,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,32,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,

# 04. Samus_Right_Attack: Status 0 - 2 (Loop animation going from 0 > 1 > 2 > 0 > ...)
Samus_Right_Attack: # 28 x 96, Height per sprite: 32
# 2688 bytes -- 2.652 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,14,14,14,32,14,14,32,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,32,14,199,32,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,199,199,14,32,14,14,199,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,103,103,199,14,14,14,199,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,103,103,14,14,103,32,32,103,32,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,103,103,32,32,32,32,32,199,199,199,199,199,
199,199,199,199,199,14,103,103,103,103,103,32,103,103,103,103,103,32,32,32,32,32,32,199,199,199,199,199,
199,199,199,199,199,14,103,103,103,103,32,103,103,14,103,103,103,199,199,32,103,32,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,32,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,103,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,14,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,103,103,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,14,32,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,32,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,32,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,103,14,14,14,32,14,14,32,103,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,14,14,32,14,199,32,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,199,199,14,32,14,14,199,32,32,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,103,199,14,14,14,199,32,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,14,14,103,32,32,103,32,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,103,103,32,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,14,103,103,103,103,103,32,103,103,103,103,103,32,32,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,14,103,103,103,103,32,103,103,14,103,103,103,199,199,32,103,32,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,32,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,14,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,14,103,103,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,199,14,14,32,32,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,14,103,199,199,14,32,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,14,14,103,103,103,14,14,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,14,103,103,103,14,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
32,32,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,32,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,103,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,103,14,14,14,32,14,14,32,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,32,14,199,32,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,199,199,14,32,14,14,199,32,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,103,103,103,199,14,14,14,199,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,103,14,14,103,32,32,103,32,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,103,103,32,32,32,32,32,199,199,199,
199,199,199,199,199,199,199,14,103,103,103,103,103,32,103,103,103,103,103,32,32,32,32,32,32,199,199,199,
199,199,199,199,199,199,199,14,103,103,103,103,32,103,103,14,103,103,103,199,199,32,103,32,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,32,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,32,14,14,14,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,14,14,32,14,14,14,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,
199,14,14,32,14,103,103,103,199,103,103,103,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,14,199,14,14,103,103,14,103,103,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
14,14,199,199,199,14,103,103,14,103,103,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,14,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,199,199,199,199,199,103,103,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,32,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,

# 05. Samus_Right_Up: Status 0 - 2 (Loop animation going from 0 > 1 > 2 > 0 > ...)
Samus_Right_Up: # 20 x 114, Height per sprite: 38
# 2280 bytes -- ~2.226 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,14,103,14,14,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,32,103,14,14,14,14,199,199,199,199,199,
199,199,199,199,14,103,14,14,32,32,103,103,14,103,14,199,199,199,199,199,
199,199,199,199,14,103,14,103,32,103,103,103,103,14,14,199,199,199,199,199,
199,199,199,199,14,14,14,103,32,103,103,103,103,14,14,199,199,199,199,199,
199,199,199,199,199,14,103,103,32,103,103,103,32,14,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,32,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,103,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,14,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,103,103,14,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,14,32,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,32,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,32,14,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,14,14,14,14,14,14,103,14,14,199,199,199,199,199,199,199,
199,199,199,199,14,14,14,14,32,103,14,14,14,14,199,199,199,199,199,199,
199,199,199,14,103,14,14,32,32,103,103,14,103,14,199,199,199,199,199,199,
199,199,199,14,103,14,103,32,103,103,103,103,14,14,199,199,199,199,199,199,
199,199,199,14,14,14,103,32,103,103,103,103,14,14,199,199,199,199,199,199,
199,199,199,199,14,103,103,32,103,103,103,32,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,32,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,14,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,14,103,103,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,199,103,103,103,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,14,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,199,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,199,14,14,32,32,199,199,199,199,199,199,
199,199,199,199,103,103,14,103,199,199,14,32,14,14,14,199,199,199,199,199,
199,14,14,103,103,103,14,14,199,199,199,199,14,14,14,14,199,199,199,199,
14,14,14,103,103,103,14,199,199,199,199,199,199,14,14,14,14,199,199,199,
32,32,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,32,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,103,14,14,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,32,103,14,14,14,14,199,199,199,
199,199,199,199,199,199,14,103,14,14,32,32,103,103,14,103,14,199,199,199,
199,199,199,199,199,199,14,103,14,103,32,103,103,103,103,14,14,199,199,199,
199,199,199,199,199,199,14,14,14,103,32,103,103,103,103,14,14,199,199,199,
199,199,199,199,199,199,199,14,103,103,32,103,103,103,32,14,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,32,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,14,14,14,199,199,199,103,103,103,103,103,199,199,199,199,199,199,
199,199,32,14,14,14,199,199,199,103,103,103,103,103,103,199,199,199,199,199,
199,14,14,32,14,14,14,199,199,199,103,103,103,103,103,103,199,199,199,199,
199,14,14,32,14,103,103,103,199,103,103,103,199,103,103,103,199,199,199,199,
14,14,14,199,14,14,103,103,14,103,103,199,199,199,103,103,103,199,199,199,
14,14,199,199,199,14,103,103,14,103,103,199,199,199,103,103,103,199,199,199,
199,199,199,199,199,199,199,103,103,14,199,199,199,199,199,14,14,14,199,199,
199,199,199,199,199,199,199,199,14,14,199,199,199,199,199,103,103,14,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,32,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,

# 06. Samus_Right_Up_Attack: Status 0 - 2 (Loop animation going from 0 > 1 > 2 > 0 > ...)
Samus_Right_Up_Attack: # 20 x 114, Height per sprite: 38
# 2280 bytes -- ~2.226 KiB
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,103,103,32,32,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,14,103,14,14,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,32,103,14,14,14,14,199,199,199,199,199,
199,199,199,199,14,103,14,14,32,32,103,103,14,103,14,199,199,199,199,199,
199,199,199,199,14,103,14,103,32,103,103,103,103,14,14,199,199,199,199,199,
199,199,199,199,14,14,14,103,32,103,103,103,103,14,14,199,199,199,199,199,
199,199,199,199,199,14,103,103,32,103,103,103,32,14,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,32,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,103,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,14,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,103,103,14,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,14,32,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,14,14,32,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,32,14,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,103,103,32,32,199,199,199,199,199,199,199,
199,199,199,199,14,14,14,14,14,14,103,14,14,199,199,199,199,199,199,199,
199,199,199,199,14,14,14,14,32,103,14,14,14,14,199,199,199,199,199,199,
199,199,199,14,103,14,14,32,32,103,103,14,103,14,199,199,199,199,199,199,
199,199,199,14,103,14,103,32,103,103,103,103,14,14,199,199,199,199,199,199,
199,199,199,14,14,14,103,32,103,103,103,103,14,14,199,199,199,199,199,199,
199,199,199,199,14,103,103,32,103,103,103,32,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,32,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,14,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,14,103,103,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,199,103,103,103,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,14,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,199,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,199,14,14,32,32,199,199,199,199,199,199,
199,199,199,199,103,103,14,103,199,199,14,32,14,14,14,199,199,199,199,199,
199,14,14,103,103,103,14,14,199,199,199,199,14,14,14,14,199,199,199,199,
14,14,14,103,103,103,14,199,199,199,199,199,199,14,14,14,14,199,199,199,
32,32,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,32,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,32,32,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,103,103,32,32,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,103,14,14,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,32,103,14,14,14,14,199,199,199,
199,199,199,199,199,199,14,103,14,14,32,32,103,103,14,103,14,199,199,199,
199,199,199,199,199,199,14,103,14,103,32,103,103,103,103,14,14,199,199,199,
199,199,199,199,199,199,14,14,14,103,32,103,103,103,103,14,14,199,199,199,
199,199,199,199,199,199,199,14,103,103,32,103,103,103,32,14,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,32,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,14,14,14,199,199,199,103,103,103,103,103,199,199,199,199,199,199,
199,199,32,14,14,14,199,199,199,103,103,103,103,103,103,199,199,199,199,199,
199,14,14,32,14,14,14,199,199,199,103,103,103,103,103,103,199,199,199,199,
199,14,14,32,14,103,103,103,199,103,103,103,199,103,103,103,199,199,199,199,
14,14,14,199,14,14,103,103,14,103,103,199,199,199,103,103,103,199,199,199,
14,14,199,199,199,14,103,103,14,103,103,199,199,199,103,103,103,199,199,199,
199,199,199,199,199,199,199,103,103,14,199,199,199,199,199,14,14,14,199,199,
199,199,199,199,199,199,199,199,14,14,199,199,199,199,199,103,103,14,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,32,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,

# 07. Samus_Right_Jump: Status 0 - Normal, 1 - Shooting
Samus_Right_Jump: # 24 x 64, Height per sprite: 32
# 1536 bytes -- 1.5 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,14,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,14,14,14,32,14,14,32,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,32,14,199,32,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,199,199,14,32,14,14,199,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,103,103,199,14,14,14,199,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,32,103,32,103,103,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,32,103,32,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,32,14,32,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,199,199,199,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,103,103,103,103,14,14,14,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,103,103,103,103,14,14,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,14,199,199,199,199,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,14,14,32,32,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,199,103,103,103,103,103,103,103,103,103,14,199,199,199,199,199,199,199,
199,199,14,32,14,14,199,103,103,103,103,103,103,103,103,14,103,103,199,199,199,199,199,199,
199,14,14,14,32,14,14,199,103,103,103,103,103,103,199,103,103,103,199,199,199,199,199,199,
14,14,14,14,32,14,103,199,103,103,103,199,199,199,103,103,103,199,199,199,199,199,199,199,
14,14,199,199,14,14,103,103,14,103,103,199,14,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,14,103,103,14,103,199,14,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,14,14,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,199,199,14,32,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,14,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,14,14,14,32,14,14,32,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,32,14,199,32,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,199,199,14,32,14,14,199,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,103,103,199,14,14,14,199,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,103,103,14,14,103,32,32,103,32,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,103,103,32,32,32,32,32,199,
199,199,199,199,199,14,103,103,103,103,103,32,103,103,103,103,103,32,32,32,32,32,32,199,
199,199,199,199,199,14,103,103,103,103,32,103,103,14,103,103,103,199,199,32,103,32,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,32,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,32,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,199,103,103,103,103,103,103,103,103,103,14,199,199,199,199,199,199,199,
199,199,14,32,14,14,199,103,103,103,103,103,103,103,103,14,103,103,199,199,199,199,199,199,
199,14,14,14,32,14,14,199,103,103,103,103,103,103,199,103,103,103,199,199,199,199,199,199,
14,14,14,14,32,14,103,199,103,103,103,199,199,199,103,103,103,199,199,199,199,199,199,199,
14,14,199,199,14,14,103,103,14,103,103,199,14,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,14,103,103,14,103,199,14,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,14,14,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,199,199,14,32,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,

# 08. Samus_Right_Jump_Up: Status 0 - Normal, 1 - Shooting
Samus_Right_Jump_Up: # 20 x 64, Height per sprite: 32
# 1280 bytes -- 1.25 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,14,103,14,14,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,32,103,14,14,14,14,199,199,199,199,199,
199,199,199,199,14,103,14,14,32,32,103,103,14,103,14,199,199,199,199,199,
199,199,199,199,14,103,14,103,32,103,103,103,103,14,14,199,199,199,199,199,
199,199,199,199,14,14,14,103,32,103,103,103,103,14,14,199,199,199,199,199,
199,199,199,199,199,14,103,103,32,103,103,103,32,14,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,32,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,199,103,103,103,103,103,103,103,103,103,14,199,199,199,
199,199,14,32,14,14,199,103,103,103,103,103,103,103,103,14,103,103,199,199,
199,14,14,14,32,14,14,199,103,103,103,103,103,103,199,103,103,103,199,199,
14,14,14,14,32,14,103,199,103,103,103,199,199,199,103,103,103,199,199,199,
14,14,199,199,14,14,103,103,14,103,103,199,14,103,103,14,199,199,199,199,
199,199,199,199,199,14,103,103,14,103,199,14,14,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,14,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,199,199,14,32,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,103,103,32,32,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,14,103,14,14,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,32,103,14,14,14,14,199,199,199,199,199,
199,199,199,199,14,103,14,14,32,32,103,103,14,103,14,199,199,199,199,199,
199,199,199,199,14,103,14,103,32,103,103,103,103,14,14,199,199,199,199,199,
199,199,199,199,14,14,14,103,32,103,103,103,103,14,14,199,199,199,199,199,
199,199,199,199,199,14,103,103,32,103,103,103,32,14,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,32,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,199,103,103,103,103,103,103,103,103,103,14,199,199,199,
199,199,14,32,14,14,199,103,103,103,103,103,103,103,103,14,103,103,199,199,
199,14,14,14,32,14,14,199,103,103,103,103,103,103,199,103,103,103,199,199,
14,14,14,14,32,14,103,199,103,103,103,199,199,199,103,103,103,199,199,199,
14,14,199,199,14,14,103,103,14,103,103,199,14,103,103,14,199,199,199,199,
199,199,199,199,199,14,103,103,14,103,199,14,14,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,199,14,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,199,199,14,32,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,

# 09. Samus_Right_Jump_Spin: Status 0 - 3 (Loop animation going from 0 > 1 > 2 > 3 > 0 > ...)
Samus_Right_Jump_Spin: # 24 x 96, Height per sprite: 24
# 2304 bytes -- 2.25 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,14,32,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,32,32,103,32,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,32,103,103,103,14,14,32,14,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,32,103,103,103,103,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,103,103,103,32,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,199,199,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,32,199,103,103,103,103,14,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,32,32,199,103,103,14,14,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,32,103,103,103,103,14,103,14,14,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,103,32,103,103,103,14,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,32,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,14,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,32,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,32,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,32,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,14,199,103,103,103,103,103,103,103,103,103,103,103,103,14,199,199,199,
199,199,199,199,199,14,14,14,103,103,103,103,32,103,103,103,103,103,103,103,103,14,14,199,
199,199,199,199,199,14,14,14,32,103,103,103,103,32,103,103,103,103,103,103,103,14,103,199,
199,199,199,199,199,32,14,14,103,32,103,103,103,103,32,103,199,32,103,103,103,14,14,103,
199,199,199,199,199,14,32,14,14,103,32,103,103,103,103,199,103,103,32,103,103,14,14,14,
199,199,199,199,199,14,14,32,14,103,103,32,103,103,32,103,103,103,103,32,103,14,14,14,
199,199,199,199,199,14,14,199,14,103,103,103,32,103,199,103,103,103,103,199,14,14,14,14,
199,199,199,199,199,14,14,199,199,103,103,103,14,103,199,103,103,103,103,14,14,14,14,199,
199,199,199,199,199,14,199,199,199,199,103,103,103,14,199,103,103,103,14,14,14,14,14,199,
199,199,199,199,199,199,199,199,199,199,199,103,14,14,103,103,103,103,32,14,14,14,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,199,14,103,103,199,32,32,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,32,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,32,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,14,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,32,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,14,103,103,103,32,103,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,14,14,103,14,103,103,103,103,32,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,14,14,103,103,199,32,32,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,14,103,103,103,103,199,32,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,199,199,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,32,103,103,103,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,32,32,14,103,103,103,103,32,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,14,32,14,14,103,103,103,32,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,32,103,32,32,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,32,14,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,103,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,32,32,199,103,103,14,199,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,14,14,14,32,103,103,103,103,14,14,103,199,199,199,199,199,199,199,199,199,199,199,
199,14,14,14,14,14,103,103,103,199,14,103,103,103,199,199,199,199,14,199,199,199,199,199,
199,14,14,14,14,103,103,103,103,199,103,14,103,103,103,199,199,14,14,199,199,199,199,199,
14,14,14,14,199,103,103,103,103,199,103,32,103,103,103,14,199,14,14,199,199,199,199,199,
14,14,14,103,32,103,103,103,103,32,103,103,32,103,103,14,32,14,14,199,199,199,199,199,
14,14,14,103,103,32,103,103,199,103,103,103,103,32,103,14,14,32,14,199,199,199,199,199,
103,14,14,103,103,103,32,199,103,32,103,103,103,103,32,103,14,14,32,199,199,199,199,199,
199,103,14,103,103,103,103,103,103,103,32,103,103,103,103,32,14,14,14,199,199,199,199,199,
199,14,14,103,103,103,103,103,103,103,103,32,103,103,103,103,14,14,14,199,199,199,199,199,
199,199,199,14,103,103,103,103,103,103,103,103,103,103,103,103,199,14,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

# 10. Samus_Left_Idle: Status 0 - Normal, 1 - Shooting
Samus_Left_Idle: # 20 x 64, Height per sprite: 32
# 1280 bytes -- 1.25 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,14,103,14,199,199,199,199,
199,199,199,199,199,199,199,103,32,14,14,32,14,14,14,103,14,199,199,199,
199,199,199,199,199,199,103,32,199,14,32,14,14,14,14,14,14,199,199,199,
199,199,199,199,199,199,32,32,199,14,14,32,14,14,14,14,14,199,199,199,
199,199,199,199,199,199,32,199,14,14,199,103,103,103,103,14,199,199,199,199,
199,199,199,199,199,199,14,14,14,199,103,32,103,103,103,103,199,199,199,199,
199,32,103,32,32,103,103,103,14,103,32,103,32,103,103,103,103,199,199,199,
32,32,32,32,32,103,103,103,103,103,103,103,103,32,103,103,103,199,199,199,
32,32,32,32,32,32,103,103,14,14,103,103,103,199,103,103,103,199,199,199,
199,32,103,32,32,32,199,14,14,103,103,14,32,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,32,103,103,103,199,199,199,199,
199,199,199,199,199,199,14,14,14,103,14,14,103,103,103,103,199,199,199,199,
199,199,199,199,199,14,14,14,103,103,32,32,103,103,103,199,199,199,199,199,
199,199,199,199,199,14,199,14,14,199,199,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,103,199,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,199,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,14,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,14,14,14,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,14,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,103,103,199,199,103,103,103,103,14,199,
199,199,199,199,199,199,199,199,199,14,14,103,14,199,199,14,14,103,14,14,
199,199,199,199,199,199,199,199,14,32,14,14,14,199,199,199,14,14,14,14,
199,199,199,199,199,199,199,14,14,14,32,14,14,199,199,199,32,32,14,14,
199,199,199,199,199,199,14,14,14,14,32,14,199,199,199,14,14,14,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,14,103,14,199,199,199,199,
199,199,199,199,199,199,199,103,32,14,14,32,14,14,14,103,14,199,199,199,
199,199,199,199,199,199,103,32,199,14,32,14,14,14,14,14,14,199,199,199,
199,199,199,199,199,199,32,32,199,14,14,32,14,14,14,14,14,199,199,199,
199,199,199,199,199,199,32,199,14,14,199,103,103,103,103,14,199,199,199,199,
199,199,199,199,199,199,14,14,14,199,103,32,103,103,103,103,199,199,199,199,
199,199,199,32,32,103,103,103,14,103,32,103,32,103,103,103,103,199,199,199,
199,199,32,32,32,103,103,103,103,103,103,103,103,32,103,103,103,199,199,199,
199,199,32,32,32,32,103,103,14,14,103,103,103,199,103,103,103,199,199,199,
199,199,199,32,32,32,32,14,14,103,103,14,32,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,32,103,103,103,199,199,199,199,
199,199,199,199,199,199,14,14,14,103,14,14,103,103,103,103,199,199,199,199,
199,199,199,199,199,14,14,14,103,103,32,32,103,103,103,199,199,199,199,199,
199,199,199,199,199,14,199,14,14,199,199,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,103,199,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,199,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,14,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,14,14,14,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,14,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,103,103,199,199,103,103,103,103,14,199,
199,199,199,199,199,199,199,199,199,14,14,103,14,199,199,14,14,103,14,14,
199,199,199,199,199,199,199,199,14,32,14,14,14,199,199,199,14,14,14,14,
199,199,199,199,199,199,199,14,14,14,32,14,14,199,199,199,32,32,14,14,
199,199,199,199,199,199,14,14,14,14,32,14,199,199,199,14,14,14,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,

# 11. Samus_Left_Idle_Up: Status 0 - Normal, 1 - Shooting
Samus_Left_Idle_Up: # 20 x 76, Height per sprite: 38
# 1520 bytes -- ~1.48 KiB
.byte 199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,103,14,14,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,103,32,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,14,103,14,103,103,32,32,14,14,103,14,199,
199,199,199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,103,14,199,
199,199,199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,14,14,199,
199,199,199,199,199,199,199,199,199,14,32,103,103,103,32,103,103,14,199,199,
199,199,199,199,199,199,199,199,199,199,14,103,103,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,32,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,103,199,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,199,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,14,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,14,14,14,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,14,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,103,103,199,199,103,103,103,103,14,199,
199,199,199,199,199,199,199,199,199,14,14,103,14,199,199,14,14,103,14,14,
199,199,199,199,199,199,199,199,14,32,14,14,14,199,199,199,14,14,14,14,
199,199,199,199,199,199,199,14,14,14,32,14,14,199,199,199,32,32,14,14,
199,199,199,199,199,199,14,14,14,14,32,14,199,199,199,14,14,14,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,32,32,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,103,103,14,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,103,14,14,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,103,32,14,14,14,14,199,199,
199,199,199,199,199,199,199,199,14,103,14,103,103,32,32,14,14,103,14,199,
199,199,199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,103,14,199,
199,199,199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,14,14,199,
199,199,199,199,199,199,199,199,199,14,32,103,103,103,32,103,103,14,199,199,
199,199,199,199,199,199,199,199,199,199,14,103,103,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,32,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,103,199,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,199,199,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,14,14,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,14,14,14,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,14,103,103,103,103,199,199,199,
199,199,199,199,199,199,199,199,199,14,103,103,199,199,103,103,103,103,14,199,
199,199,199,199,199,199,199,199,199,14,14,103,14,199,199,14,14,103,14,14,
199,199,199,199,199,199,199,199,14,32,14,14,14,199,199,199,14,14,14,14,
199,199,199,199,199,199,199,14,14,14,32,14,14,199,199,199,32,32,14,14,
199,199,199,199,199,199,14,14,14,14,32,14,199,199,199,14,14,14,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,

# 12. Samus_Left: Status 0 - 2 (Loop animation going from 0 > 1 > 2 > 0 > ...)
Samus_Left: # 28 x 96, Height per sprite: 32
# 2688 bytes -- 2.625 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,32,14,14,32,14,14,14,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,32,199,14,32,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,199,14,14,32,14,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,199,14,14,14,199,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,103,103,32,103,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,103,32,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,32,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,199,199,199,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,14,14,14,103,103,103,103,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,14,14,103,103,103,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,32,199,199,199,199,14,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,14,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,103,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,103,103,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,32,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,103,32,14,14,32,14,14,14,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,32,199,14,32,14,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,32,199,14,14,32,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,199,14,14,14,14,199,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,103,103,32,103,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,103,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,199,32,103,103,103,103,32,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,32,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,14,103,103,103,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,14,103,103,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,14,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,14,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,14,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,14,199,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,14,199,199,103,14,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,14,14,103,103,103,14,14,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,14,103,103,103,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,103,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,32,14,14,32,14,14,14,103,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,32,199,14,32,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,32,32,199,14,14,32,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,32,199,14,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,14,199,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,199,103,103,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,199,14,103,103,103,103,199,199,32,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,32,32,32,32,32,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,32,32,32,32,32,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,32,199,199,199,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,32,32,32,32,32,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,14,14,14,32,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,14,14,14,32,14,14,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,103,103,103,199,103,103,103,14,32,14,14,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,14,103,103,14,14,199,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,14,103,103,14,199,199,199,14,14,
199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,14,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,103,103,199,199,199,199,199,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,32,32,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,32,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

# 13. Samus_Left_Attack: Status 0 - 2 (Loop animation going from 0 > 1 > 2 > 0 > ...)
Samus_Left_Attack: # 28 x 96, Height per sprite: 32
# 2688 bytes -- 2.625 KiB
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,32,14,14,32,14,14,14,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,32,199,14,32,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,199,14,14,32,14,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,199,14,14,14,199,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,103,32,32,103,14,14,103,103,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,32,32,32,32,32,103,103,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,32,32,32,32,32,32,103,103,103,103,103,32,103,103,103,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,32,103,32,199,199,103,103,103,14,103,103,32,103,103,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,103,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,103,103,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,32,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,32,14,14,32,14,14,14,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,32,199,14,32,14,14,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,32,32,199,14,14,32,14,199,199,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,32,199,14,14,14,199,103,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,103,32,32,103,14,14,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,32,32,32,103,103,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,32,32,32,32,32,32,103,103,103,103,103,32,103,103,103,103,103,14,199,199,199,199,
199,199,199,199,199,199,199,32,103,32,199,199,103,103,103,14,103,103,32,103,103,103,103,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,14,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,14,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,14,199,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,14,199,199,103,14,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,14,14,103,103,103,14,14,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,14,103,103,103,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,103,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,32,14,14,32,14,14,14,103,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,32,199,14,32,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,32,32,199,14,14,32,14,199,199,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,32,199,14,14,14,199,103,103,103,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,32,103,32,32,103,14,14,103,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,32,32,32,32,32,103,103,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,32,32,32,32,32,32,103,103,103,103,103,32,103,103,103,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,32,103,32,199,199,103,103,103,14,103,103,32,103,103,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,32,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,14,14,14,32,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,14,14,14,32,14,14,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,103,103,103,199,103,103,103,14,32,14,14,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,14,103,103,14,14,199,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,14,103,103,14,199,199,199,14,14,
199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,14,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,103,103,199,199,199,199,199,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,103,103,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,32,32,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,32,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

# 14. Samus_Left_Up: Status 0 - 2 (Loop animation going from 0 > 1 > 2 > 0 > ...)
Samus_Left_Up: # 20 x 114, Height per sprite: 38
# 2280 bytes -- ~2.22 KiB
.byte 199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,103,14,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,103,32,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,14,103,14,103,103,32,32,14,14,103,14,199,199,199,199,
199,199,199,199,199,14,14,103,103,103,103,32,103,14,103,14,199,199,199,199,
199,199,199,199,199,14,14,103,103,103,103,32,103,14,14,14,199,199,199,199,
199,199,199,199,199,199,14,32,103,103,103,32,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,32,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,103,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,103,103,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,14,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,32,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,32,14,199,199,199,199,
199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,103,14,14,14,14,14,14,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,103,32,14,14,14,14,199,199,199,199,
199,199,199,199,199,199,14,103,14,103,103,32,32,14,14,103,14,199,199,199,
199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,103,14,199,199,199,
199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,14,14,199,199,199,
199,199,199,199,199,199,199,14,32,103,103,103,32,103,103,14,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,14,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,103,103,14,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,103,103,103,199,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,103,103,103,199,199,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,14,103,103,14,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,199,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,14,14,199,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,32,14,199,199,103,14,103,103,199,199,199,199,
199,199,199,199,14,14,14,14,199,199,199,199,14,14,103,103,103,14,14,199,
199,199,199,14,14,14,14,199,199,199,199,199,199,14,103,103,103,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,
199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,32,32,103,103,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,103,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,14,14,14,14,103,32,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,14,103,14,103,103,32,32,14,14,103,14,199,199,199,199,199,199,
199,199,199,14,14,103,103,103,103,32,103,14,103,14,199,199,199,199,199,199,
199,199,199,14,14,103,103,103,103,32,103,14,14,14,199,199,199,199,199,199,
199,199,199,199,14,32,103,103,103,32,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,14,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,32,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,199,199,199,14,14,14,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,199,199,199,14,14,14,32,199,199,
199,199,199,199,103,103,103,103,103,103,199,199,199,14,14,14,32,14,14,199,
199,199,199,199,103,103,103,199,103,103,103,199,103,103,103,14,32,14,14,199,
199,199,199,103,103,103,199,199,199,103,103,14,103,103,14,14,199,14,14,14,
199,199,199,103,103,103,199,199,199,103,103,14,103,103,14,199,199,199,14,14,
199,199,14,14,14,199,199,199,199,199,14,103,103,199,199,199,199,199,199,199,
199,199,14,103,103,199,199,199,199,199,14,14,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,103,103,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,32,32,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,14,14,14,14,32,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

# 15. Samus_Left_Up_Attack: Status 0 - 2 (Loop animation going from 0 > 1 > 2 > 0 > ...)
Samus_Left_Up_Attack: # 20 x 114, Height per sprite: 38
# 2280 bytes -- ~2.22 KiB
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,32,32,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,103,103,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,103,14,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,103,32,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,14,103,14,103,103,32,32,14,14,103,14,199,199,199,199,
199,199,199,199,199,14,14,103,103,103,103,32,103,14,103,14,199,199,199,199,
199,199,199,199,199,14,14,103,103,103,103,32,103,14,14,14,199,199,199,199,
199,199,199,199,199,199,14,32,103,103,103,32,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,32,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,103,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,32,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,103,103,103,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,103,103,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,14,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,32,14,14,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,32,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,103,103,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,103,14,14,14,14,14,14,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,103,32,14,14,14,14,199,199,199,199,
199,199,199,199,199,199,14,103,14,103,103,32,32,14,14,103,14,199,199,199,
199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,103,14,199,199,199,
199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,14,14,199,199,199,
199,199,199,199,199,199,199,14,32,103,103,103,32,103,103,14,199,199,199,199,
199,199,199,199,199,199,199,199,14,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,14,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,103,103,14,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,103,103,103,199,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,103,103,103,199,199,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,14,103,103,14,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,199,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,14,14,199,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,32,14,199,199,103,14,103,103,199,199,199,199,
199,199,199,199,14,14,14,14,199,199,199,199,14,14,103,103,103,14,14,199,
199,199,199,14,14,14,14,199,199,199,199,199,199,14,103,103,103,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,32,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,32,32,32,32,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,32,32,103,103,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,103,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,14,14,14,14,103,32,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,14,103,14,103,103,32,32,14,14,103,14,199,199,199,199,199,199,
199,199,199,14,14,103,103,103,103,32,103,14,103,14,199,199,199,199,199,199,
199,199,199,14,14,103,103,103,103,32,103,14,14,14,199,199,199,199,199,199,
199,199,199,199,14,32,103,103,103,32,103,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,14,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,32,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,199,199,199,14,14,14,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,199,199,199,14,14,14,32,199,199,
199,199,199,199,103,103,103,103,103,103,199,199,199,14,14,14,32,14,14,199,
199,199,199,199,103,103,103,199,103,103,103,199,103,103,103,14,32,14,14,199,
199,199,199,103,103,103,199,199,199,103,103,14,103,103,14,14,199,14,14,14,
199,199,199,103,103,103,199,199,199,103,103,14,103,103,14,199,199,199,14,14,
199,199,14,14,14,199,199,199,199,199,14,103,103,199,199,199,199,199,199,199,
199,199,14,103,103,199,199,199,199,199,14,14,199,199,199,199,199,199,199,199,
199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,103,103,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,32,32,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,14,14,14,14,32,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

# 16. Samus_Left_Jump: Status 0 - Normal, 1 - Shooting
Samus_Left_Jump: # 24 x 64, Height per sprite: 32
# 1536 bytes -- 1.5 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,14,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,32,14,14,32,14,14,14,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,32,199,14,32,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,199,14,14,32,14,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,199,14,14,14,199,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,103,103,32,103,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,32,103,32,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,32,14,32,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,199,199,199,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,32,14,14,14,103,103,103,103,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,32,32,32,14,14,103,103,103,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,199,199,199,199,14,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,32,32,14,14,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,103,103,103,103,103,103,103,199,14,14,199,199,199,199,
199,199,199,199,199,199,103,103,14,103,103,103,103,103,103,103,103,199,14,14,32,14,199,199,
199,199,199,199,199,199,103,103,103,199,103,103,103,103,103,103,199,14,14,32,14,14,14,199,
199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,103,199,103,14,32,14,14,14,14,
199,199,199,199,199,199,199,199,14,103,103,14,199,103,103,14,103,103,14,14,199,199,14,14,
199,199,199,199,199,199,199,199,14,14,14,14,14,199,103,14,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,14,14,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,32,14,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,14,14,14,103,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,32,14,14,32,14,14,14,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,32,199,14,32,14,14,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,32,199,14,14,32,14,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,32,199,14,14,14,199,103,103,103,14,199,199,199,199,199,199,199,199,
199,199,32,103,32,32,103,14,14,103,103,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,32,32,32,32,32,103,103,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,199,
199,32,32,32,32,32,32,103,103,103,103,103,32,103,103,103,103,103,14,199,199,199,199,199,
199,199,32,103,32,199,199,103,103,103,14,103,103,32,103,103,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,32,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,103,103,103,103,103,103,103,199,14,14,199,199,199,199,
199,199,199,199,199,199,103,103,14,103,103,103,103,103,103,103,103,199,14,14,32,14,199,199,
199,199,199,199,199,199,103,103,103,199,103,103,103,103,103,103,199,14,14,32,14,14,14,199,
199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,103,199,103,14,32,14,14,14,14,
199,199,199,199,199,199,199,199,14,103,103,14,199,103,103,14,103,103,14,14,199,199,14,14,
199,199,199,199,199,199,199,199,14,14,14,14,14,199,103,14,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,14,14,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,32,14,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

# 17. Samus_Left_Jump_Up: Status 0 - Normal, 1 - Shooting
Samus_Left_Jump_Up: # 24 x 64, Height per sprite: 32
# 1536 bytes -- 1.5 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,103,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,103,103,103,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,103,14,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,103,32,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,103,14,103,103,32,32,14,14,103,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,103,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,32,103,103,103,32,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,32,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,103,103,103,103,103,103,103,199,14,14,199,199,199,199,
199,199,199,199,199,199,103,103,14,103,103,103,103,103,103,103,103,199,14,14,32,14,199,199,
199,199,199,199,199,199,103,103,103,199,103,103,103,103,103,103,199,14,14,32,14,14,14,199,
199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,103,199,103,14,32,14,14,14,14,
199,199,199,199,199,199,199,199,14,103,103,14,199,103,103,14,103,103,14,14,199,199,14,14,
199,199,199,199,199,199,199,199,14,14,14,14,14,199,103,14,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,14,14,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,32,14,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,103,32,32,103,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,103,103,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,103,14,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,103,32,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,103,14,103,103,32,32,14,14,103,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,103,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,103,103,103,103,32,103,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,32,103,103,103,32,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,32,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,32,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,103,103,103,103,103,103,103,103,199,14,14,199,199,199,199,
199,199,199,199,199,199,103,103,14,103,103,103,103,103,103,103,103,199,14,14,32,14,199,199,
199,199,199,199,199,199,103,103,103,199,103,103,103,103,103,103,199,14,14,32,14,14,14,199,
199,199,199,199,199,199,199,103,103,103,199,199,199,103,103,103,199,103,14,32,14,14,14,14,
199,199,199,199,199,199,199,199,14,103,103,14,199,103,103,14,103,103,14,14,199,199,14,14,
199,199,199,199,199,199,199,199,14,14,14,14,14,199,103,14,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,32,14,14,199,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,32,14,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

# 18. Samus_Left_Jump_Spin: Status 0 - 3 (Loop animation going from 0 > 1 > 2 > 3 > 0 > ...)
Samus_Left_Jump_Spin: # 24 x 96, Height per sprite: 24
# 2304 bytes -- 2.25 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,103,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,103,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,32,14,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,32,103,32,32,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,14,32,14,14,103,103,103,32,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,32,32,14,103,103,103,103,32,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,32,103,103,103,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,199,199,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,14,103,103,103,103,199,32,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,14,14,103,103,199,32,32,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,14,14,103,14,103,103,103,103,32,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,14,103,103,103,32,103,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,32,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,14,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,14,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,32,14,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,32,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,14,103,103,103,103,103,103,103,103,103,103,103,103,199,14,199,199,199,199,199,199,
199,14,14,103,103,103,103,103,103,103,103,32,103,103,103,103,14,14,14,199,199,199,199,199,
199,103,14,103,103,103,103,103,103,103,32,103,103,103,103,32,14,14,14,199,199,199,199,199,
103,14,14,103,103,103,32,199,103,32,103,103,103,103,32,103,14,14,32,199,199,199,199,199,
14,14,14,103,103,32,103,103,199,103,103,103,103,32,103,14,14,32,14,199,199,199,199,199,
14,14,14,103,32,103,103,103,103,32,103,103,32,103,103,14,32,14,14,199,199,199,199,199,
14,14,14,14,199,103,103,103,103,199,103,32,103,103,103,14,199,14,14,199,199,199,199,199,
199,14,14,14,14,103,103,103,103,199,103,14,103,103,103,199,199,14,14,199,199,199,199,199,
199,14,14,14,14,14,103,103,103,199,14,103,103,103,199,199,199,199,14,199,199,199,199,199,
199,199,14,14,14,32,103,103,103,103,14,14,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,14,32,32,199,103,103,14,199,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,32,14,14,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,32,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,14,14,32,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,14,103,103,103,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,32,103,103,103,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,103,32,103,103,103,14,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,32,103,103,103,103,14,103,14,14,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,32,103,103,103,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,103,103,103,103,103,103,103,32,32,199,103,103,14,14,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,32,199,103,103,103,103,14,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,199,199,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,103,103,103,32,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,32,103,103,103,103,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,103,103,32,103,103,103,14,14,32,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,32,32,103,32,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,14,32,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,14,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,14,199,14,103,103,199,32,32,14,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,14,14,103,103,103,103,32,14,14,14,199,199,
199,199,199,199,199,14,199,199,199,199,103,103,103,14,199,103,103,103,14,14,14,14,14,199,
199,199,199,199,199,14,14,199,199,103,103,103,14,103,199,103,103,103,103,14,14,14,14,199,
199,199,199,199,199,14,14,199,14,103,103,103,32,103,199,103,103,103,103,199,14,14,14,14,
199,199,199,199,199,14,14,32,14,103,103,32,103,103,32,103,103,103,103,32,103,14,14,14,
199,199,199,199,199,14,32,14,14,103,32,103,103,103,103,199,103,103,32,103,103,14,14,14,
199,199,199,199,199,32,14,14,103,32,103,103,103,103,32,103,199,32,103,103,103,14,14,103,
199,199,199,199,199,14,14,14,32,103,103,103,103,32,103,103,103,103,103,103,103,14,103,199,
199,199,199,199,199,14,14,14,103,103,103,103,32,103,103,103,103,103,103,103,103,14,14,199,
199,199,199,199,199,199,14,199,103,103,103,103,103,103,103,103,103,103,103,103,14,199,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,103,103,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,103,103,103,103,103,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

# 19. Morph_Ball: Status 0 - 3 (Moving Right: Loop animation going from 0 > 1 > 2 > 3 > 0 > ...)
#                              (Moving Left: Loop animation going from 3 > 2 > 1 > 0 > 3 > ...)
Morph_Ball: # 16 x 64, Height per sprite: 16
# 1024 bytes -- 1 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,14,14,14,199,199,199,199,
199,199,199,103,103,103,103,103,103,103,14,14,14,199,199,199,
199,199,199,103,103,103,14,14,103,103,32,14,14,199,199,199,
199,199,103,103,103,103,14,103,103,103,32,32,14,14,199,199,
199,199,103,103,103,103,103,103,103,103,103,32,14,14,199,199,
199,199,103,103,103,103,103,14,14,103,103,103,103,14,199,199,
199,199,103,103,103,103,103,103,14,103,103,14,103,103,199,199,
199,199,103,103,103,103,103,103,103,103,14,14,14,103,199,199,
199,199,199,103,103,103,103,103,103,103,103,14,14,199,199,199,
199,199,199,103,103,103,103,14,103,103,103,103,103,199,199,199,
199,199,199,199,103,14,14,32,103,103,14,103,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,103,14,14,32,103,103,14,103,199,199,199,199,
199,199,199,103,103,103,103,14,103,103,103,103,103,199,199,199,
199,199,199,103,103,103,103,103,103,103,103,14,14,199,199,199,
199,199,103,103,103,103,103,103,103,103,14,14,14,103,199,199,
199,199,103,103,103,103,103,103,14,103,103,14,103,103,199,199,
199,199,103,103,103,103,103,14,14,103,103,103,103,14,199,199,
199,199,103,103,103,103,103,103,103,103,103,32,14,14,199,199,
199,199,103,103,103,103,14,103,103,103,32,32,14,14,199,199,
199,199,199,103,103,103,14,14,103,103,32,14,14,199,199,199,
199,199,199,103,103,103,103,103,103,103,14,14,14,199,199,199,
199,199,199,199,103,103,103,103,103,14,14,14,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,103,14,103,103,32,14,14,103,199,199,199,199,
199,199,199,103,103,103,103,103,14,103,103,103,103,199,199,199,
199,199,199,14,14,103,103,103,103,103,103,103,103,199,199,199,
199,199,103,14,14,14,103,103,103,103,103,103,103,103,199,199,
199,199,103,103,14,103,103,14,103,103,103,103,103,103,199,199,
199,199,14,103,103,103,103,14,14,103,103,103,103,103,199,199,
199,199,14,14,32,103,103,103,103,103,103,103,103,103,199,199,
199,199,14,14,32,32,103,103,103,14,103,103,103,103,199,199,
199,199,199,14,14,32,103,103,14,14,103,103,103,199,199,199,
199,199,199,14,14,14,103,103,103,103,103,103,103,199,199,199,
199,199,199,199,14,14,14,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,14,14,14,103,103,103,103,103,199,199,199,199,
199,199,199,14,14,14,103,103,103,103,103,103,103,199,199,199,
199,199,199,14,14,32,103,103,14,14,103,103,103,199,199,199,
199,199,14,14,32,32,103,103,103,14,103,103,103,103,199,199,
199,199,14,14,32,103,103,103,103,103,103,103,103,103,199,199,
199,199,14,103,103,103,103,14,14,103,103,103,103,103,199,199,
199,199,103,103,14,103,103,14,103,103,103,103,103,103,199,199,
199,199,103,14,14,14,103,103,103,103,103,103,103,103,199,199,
199,199,199,14,14,103,103,103,103,103,103,103,103,199,199,199,
199,199,199,103,103,103,103,103,14,103,103,103,103,199,199,199,
199,199,199,199,103,14,103,103,32,14,14,103,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,


Death_E1: # 8 x 32, Height per sprite: 8
# 256 bytes
.byte 199,199,199,199,199,199,199,199,
199,199,14,199,199,14,14,103,
199,199,199,199,14,32,199,14,
199,199,199,199,32,199,32,199,
32,199,199,14,32,32,103,199,
199,199,199,199,32,199,199,32,
199,103,103,199,199,14,199,199,
199,199,199,199,199,14,199,199,
199,103,14,199,199,32,199,199,
199,14,199,32,103,199,199,199,
199,14,32,199,32,199,14,14,
199,199,14,32,32,32,199,199,
199,199,199,199,14,199,199,199,
199,14,199,199,199,199,103,199,
199,199,199,199,199,199,103,199,
199,199,199,199,32,199,199,199,
199,199,14,199,199,199,199,199,
199,199,14,199,199,103,103,199,
32,199,199,32,199,199,199,199,
199,103,32,32,14,199,199,32,
199,32,199,32,199,199,199,199,
14,199,32,14,199,199,199,199,
103,14,14,199,199,14,199,199,
199,199,199,199,199,199,199,199,
199,199,199,32,199,199,199,199,
199,103,199,199,199,199,199,199,
199,103,199,199,199,199,14,199,
199,199,199,14,199,199,199,199,
199,199,32,32,32,14,199,199,
14,14,199,32,199,32,14,199,
199,199,199,103,32,199,14,199,
199,199,32,199,199,14,103,199,

Death_E2: # 8 x 32, Height per sprite: 8
# 256 bytes
.byte 199,199,199,199,103,199,14,199,
103,103,199,103,103,199,199,199,
199,32,103,199,14,103,199,199,
199,103,103,14,199,199,199,199,
199,199,199,14,199,199,199,14,
14,103,199,199,199,199,199,199,
199,199,199,199,32,199,199,199,
199,199,199,199,199,199,199,103,
199,199,199,199,14,199,199,103,
14,199,199,199,199,199,199,199,
199,199,103,199,199,199,199,199,
103,103,14,199,199,199,32,199,
199,103,199,14,14,199,199,199,
199,199,103,103,199,199,199,199,
199,103,32,103,199,103,199,199,
199,103,199,199,199,14,199,199,
103,199,199,199,199,199,199,199,
199,199,199,32,199,199,199,199,
199,199,199,199,199,199,103,14,
14,199,199,199,14,199,199,199,
199,199,199,199,14,103,103,199,
199,199,103,14,199,103,32,199,
199,199,199,103,103,199,103,103,
199,14,199,103,199,199,199,199,
199,199,14,199,199,199,103,199,
199,199,103,199,103,32,103,199,
199,199,199,199,103,103,199,199,
199,199,199,14,14,199,103,199,
199,32,199,199,199,14,103,103,
199,199,199,199,199,103,199,199,
199,199,199,199,199,199,199,14,
103,199,199,14,199,199,199,199,

Death_E3: # 8 x 32, Height per sprite: 8
# 256 bytes
.byte 199,199,103,199,199,199,199,199,
199,199,14,14,103,199,199,199,
199,14,14,199,199,199,14,199,
199,14,199,14,14,199,199,199,
199,199,199,32,14,199,199,199,
14,14,199,199,32,199,199,199,
14,199,199,14,14,199,199,199,
199,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,
199,199,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,
199,103,199,14,14,32,14,199,
199,14,199,14,32,199,14,14,
103,14,14,199,199,199,199,14,
199,199,14,14,199,14,199,14,
199,199,199,199,199,14,14,199,
199,199,199,199,14,14,14,199,
199,199,199,14,14,199,199,14,
199,199,199,32,199,199,14,14,
199,199,199,14,32,199,199,199,
199,199,199,14,14,199,14,199,
199,14,199,199,199,14,14,199,
199,199,199,103,14,14,199,199,
199,199,199,199,199,103,199,199,
199,14,14,199,199,199,199,199,
14,199,14,199,14,14,199,199,
14,199,199,199,199,14,14,103,
14,14,199,32,14,199,14,199,
199,14,32,14,14,199,103,199,
199,199,199,199,199,199,199,199,
199,199,199,199,199,14,199,199,
199,199,199,199,199,199,199,199,

Death_D1: # 8 x 32, Height per sprite: 8
# 256 bytes
.byte 14,199,199,199,199,103,199,199,
199,14,14,199,199,199,199,199,
199,14,32,14,199,199,199,199,
199,199,103,32,199,199,199,199,
32,103,32,32,14,199,199,199,
199,32,199,32,199,199,199,199,
199,199,14,199,14,199,199,199,
199,199,199,199,199,103,199,199,
199,199,199,32,199,199,199,14,
199,199,32,103,199,14,14,199,
199,14,199,32,103,32,14,199,
199,199,32,32,32,14,199,199,
199,14,199,14,199,199,199,199,
103,199,199,199,199,199,199,103,
199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,
199,199,103,199,199,199,199,199,
199,199,199,14,199,14,199,199,
199,199,199,199,32,199,32,199,
199,199,199,14,32,32,103,32,
199,199,199,199,32,103,199,199,
199,199,199,199,14,32,14,199,
199,199,199,199,199,14,14,199,
199,199,103,199,199,199,199,14,
199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,
103,199,199,199,199,199,199,103,
199,199,199,199,14,199,14,199,
199,199,14,32,32,32,199,199,
199,14,32,103,32,199,14,199,
199,14,14,199,103,32,199,199,
14,199,199,199,32,199,199,199,

Death_D2: # 8 x 32, Height per sprite: 8
# 256 bytes
.byte 199,14,199,103,199,199,199,199,
14,199,199,14,199,199,103,103,
14,103,14,199,103,199,199,199,
199,14,14,199,14,103,103,199,
199,199,199,14,199,199,199,199,
199,199,14,199,32,199,199,199,
32,199,199,199,199,199,199,199,
199,199,199,199,199,14,199,199,
199,32,199,199,199,14,14,199,
199,199,199,199,14,103,199,14,
199,199,14,199,14,14,199,199,
199,199,199,14,199,199,14,103,
199,199,32,199,14,103,199,199,
14,199,199,199,103,199,199,199,
199,199,199,199,103,199,103,199,
199,199,199,199,199,199,103,199,
199,199,14,199,199,199,199,199,
199,199,199,199,199,199,199,32,
199,199,199,32,199,14,199,199,
199,199,199,199,14,199,199,199,
199,103,103,14,199,14,14,199,
199,199,199,103,199,14,103,14,
103,103,199,199,14,199,199,14,
199,199,199,199,103,199,14,199,
199,103,199,199,199,199,199,199,
199,103,199,103,199,199,199,199,
199,199,199,103,199,199,199,14,
199,199,103,14,199,32,199,199,
103,14,199,199,14,199,199,199,
199,199,14,14,199,14,199,199,
14,199,103,14,199,199,199,199,
199,14,14,199,199,199,32,199,

Death_D3: # 8 x 32, Height per sprite: 8
# 256 bytes
.byte 199,199,199,199,199,199,199,199,
199,199,199,199,199,14,199,199,
199,199,199,199,199,14,14,199,
199,199,199,14,199,199,14,199,
199,199,199,14,199,32,32,199,
199,14,199,32,14,199,14,14,
199,199,199,199,199,14,199,14,
199,199,199,199,14,14,14,199,
199,199,199,199,199,199,199,199,
199,199,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,
199,199,32,14,14,199,199,199,
14,199,14,199,199,199,199,199,
14,14,199,32,199,14,14,199,
14,199,14,32,14,14,199,199,
199,14,14,199,199,199,199,199,
199,199,199,199,199,14,14,199,
199,199,14,14,32,14,199,14,
199,14,14,199,32,199,14,14,
199,199,199,199,199,14,199,14,
199,199,199,14,14,32,199,199,
199,199,199,199,199,199,199,199,
199,199,199,199,199,14,199,199,
199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,
199,199,199,199,199,14,199,199,
199,199,199,199,199,14,14,199,
199,199,199,14,199,199,14,199,
199,199,199,14,199,32,32,199,
199,14,199,32,14,199,14,14,
199,199,199,199,199,14,199,14,
199,199,199,199,14,14,14,199,



################################################        Beam        ################################################
# Stores all sprites used for Samus' projectiles in the game
# 
# --> Total ammount of data: 512 bytes
#
######################################################################################################################

Beam_Horizontal: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,14,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,32,199,199,199,199,199,199,
199,199,199,199,199,199,103,14,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,199,199,199,199,199,199,199,199,
199,199,199,199,32,199,199,103,199,199,32,199,199,199,199,199,
199,199,199,199,199,103,14,32,14,103,199,199,199,199,199,199,
199,199,199,199,103,14,32,32,32,14,103,199,199,199,199,199,
199,199,199,199,103,14,32,32,32,14,103,199,199,199,199,199,
199,199,199,199,199,103,14,32,14,103,199,199,199,199,199,199,
199,199,199,199,32,199,199,103,199,199,32,199,199,199,199,199,
199,199,199,199,199,199,199,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

Beam_Vertical: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,14,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,32,199,199,199,199,199,199,
199,199,199,199,199,199,103,14,103,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,32,199,199,199,199,199,199,199,199,
199,199,199,199,32,199,199,103,199,199,32,199,199,199,199,199,
199,199,199,199,199,103,14,32,14,103,199,199,199,199,199,199,
199,199,199,199,103,14,32,32,32,14,103,199,199,199,199,199,
199,199,199,199,103,14,32,32,32,14,103,199,199,199,199,199,
199,199,199,199,199,103,14,32,14,103,199,199,199,199,199,199,
199,199,199,199,32,199,199,103,199,199,32,199,199,199,199,199,
199,199,199,199,199,199,199,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

Bomb: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,14,103,14,14,14,14,199,199,199,199,199,
199,199,199,199,14,14,14,14,199,199,14,14,199,199,199,199,
199,199,199,199,14,14,199,199,199,199,199,14,199,199,199,199,
199,199,199,199,14,14,199,199,199,199,199,14,199,199,199,199,
199,199,199,199,14,14,14,14,199,199,14,14,199,199,199,199,
199,199,199,199,199,14,103,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,14,103,14,14,14,14,199,199,199,199,199,
199,199,199,199,14,14,14,14,199,199,14,14,199,199,199,199,
199,199,199,199,14,14,199,199,32,32,199,14,199,199,199,199,
199,199,199,199,14,14,199,199,32,32,199,14,199,199,199,199,
199,199,199,199,14,14,14,14,199,199,14,14,199,199,199,199,
199,199,199,199,199,14,103,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

Explosions_1: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,32,199,32,199,199,32,199,32,199,199,199,199,
199,199,199,199,199,32,199,103,103,199,32,199,199,199,199,199,
199,199,199,32,199,103,32,14,14,32,103,199,32,199,199,199,
199,199,199,199,14,32,199,14,14,199,32,14,199,199,199,199,
199,199,199,32,103,199,14,32,32,14,199,103,32,199,199,199,
199,199,199,32,103,199,14,32,32,14,199,103,32,199,199,199,
199,199,199,199,14,32,199,14,14,199,32,14,199,199,199,199,
199,199,199,32,199,103,32,14,14,32,103,199,32,199,199,199,
199,199,199,199,199,32,199,103,103,199,32,199,199,199,199,199,
199,199,199,199,32,199,32,199,199,32,199,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,199,199,14,199,199,199,199,199,199,
199,14,199,199,14,32,199,199,199,199,32,14,199,199,14,199,
199,199,14,103,32,103,32,14,14,32,103,32,103,14,199,199,
199,14,32,32,103,199,14,199,199,14,199,103,32,32,14,199,
199,199,103,14,199,14,103,199,199,103,14,199,14,103,199,199,
14,32,199,103,14,199,199,199,199,199,199,14,103,199,32,14,
199,199,103,103,199,199,199,199,199,199,199,199,103,103,199,199,
199,32,14,199,199,199,199,199,199,199,199,199,199,14,32,199,
199,32,14,199,199,199,199,199,199,199,199,199,199,14,32,199,
199,199,103,103,199,199,199,199,199,199,199,199,103,103,199,199,
14,32,199,103,14,199,199,199,199,199,199,14,103,199,32,14,
199,199,103,14,199,14,103,199,199,103,14,199,14,103,199,199,
199,14,32,32,103,199,14,199,199,14,199,103,32,32,14,199,
199,199,14,103,32,103,32,14,14,32,103,32,103,14,199,199,
199,14,199,199,14,32,199,199,199,199,32,14,199,199,14,199,
199,199,199,199,199,199,14,199,199,14,199,199,199,199,199,199,

Explosions_2: # 32 x 32, Height per sprite: 32
# 1024 bytes -- 1 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,14,199,199,103,199,199,103,199,199,14,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,199,199,199,199,14,199,14,14,199,14,199,199,199,199,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,199,199,103,199,103,199,14,103,199,199,103,14,199,103,199,103,199,199,103,199,199,199,199,199,199,
199,199,199,199,199,14,199,199,14,199,14,14,103,199,103,14,14,103,199,103,14,14,199,14,199,199,14,199,199,199,199,199,
199,199,199,199,199,199,199,103,199,103,32,103,199,103,32,103,103,32,103,199,103,32,103,199,103,199,199,199,199,199,199,199,
199,199,103,199,199,103,199,14,103,103,32,199,32,14,199,199,199,199,14,32,199,32,103,103,14,199,103,199,199,103,199,199,
199,199,199,199,199,14,199,14,103,103,14,199,32,199,199,32,32,199,199,32,199,14,103,103,14,199,14,199,199,199,199,199,
199,199,14,199,14,103,103,32,103,32,199,199,199,199,199,199,199,199,199,199,199,199,32,103,32,103,103,14,199,14,199,199,
199,199,199,14,199,103,32,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,32,103,199,14,199,199,199,
199,199,14,103,14,199,103,32,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,199,14,103,14,199,199,
199,14,199,103,199,32,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,32,199,103,199,14,199,
103,199,14,14,103,199,199,32,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,199,199,103,14,14,199,103,
199,14,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,14,199,
199,103,14,199,103,199,32,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,199,103,199,14,103,199,
103,199,103,14,199,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,199,14,103,199,103,
199,199,14,199,103,32,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,199,14,199,199,
199,199,14,199,103,32,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,199,14,199,199,
103,199,103,14,199,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,199,14,103,199,103,
199,103,14,199,103,199,32,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,199,103,199,14,103,199,
199,14,199,103,103,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,103,199,14,199,
103,199,14,14,103,199,199,32,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,199,199,103,14,14,199,103,
199,14,199,103,199,32,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,32,199,103,199,14,199,
199,199,14,103,14,199,103,32,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,199,14,103,14,199,199,
199,199,199,14,199,103,32,103,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,32,103,199,14,199,199,199,
199,199,14,199,14,103,103,32,103,32,199,199,199,199,199,199,199,199,199,199,199,199,32,103,32,103,103,14,199,14,199,199,
199,199,199,199,199,14,199,14,103,103,14,199,32,199,199,32,32,199,199,32,199,14,103,103,14,199,14,199,199,199,199,199,
199,199,103,199,199,103,199,14,103,103,32,199,32,14,199,199,199,199,14,32,199,32,103,103,14,199,103,199,199,103,199,199,
199,199,199,199,199,199,199,103,199,103,32,103,199,103,32,103,103,32,103,199,103,32,103,199,103,199,199,199,199,199,199,199,
199,199,199,199,199,14,199,199,14,199,14,14,103,199,103,14,14,103,199,103,14,14,199,14,199,199,14,199,199,199,199,199,
199,199,199,199,199,199,103,199,199,103,199,103,199,14,103,199,199,103,14,199,103,199,103,199,199,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,14,199,199,199,199,14,199,14,14,199,14,199,199,199,199,14,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,199,199,103,199,199,103,199,199,14,199,199,199,199,199,199,199,199,199,199,199,

################################################        Power Up        ################################################
# Stores all sprites used for Samus' projectiles in the game
# 
# --> Total ammount of data: 1024 bytes
#
######################################################################################################################
Energy: # 16 x 32, Height per sprite: 16
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,14,14,14,199,199,14,14,14,199,199,199,199,
199,199,199,199,14,14,199,103,103,199,14,14,199,199,199,199,
199,199,199,199,14,14,199,103,103,199,14,14,199,199,199,199,
199,199,199,199,14,14,14,199,199,14,14,14,199,199,199,199,
199,199,199,199,199,14,14,14,14,14,14,199,199,199,199,199,
199,199,199,199,199,199,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,209,209,209,209,199,199,199,199,199,199,
199,199,199,199,199,209,209,209,209,209,209,199,199,199,199,199,
199,199,199,199,209,209,209,199,199,209,209,209,199,199,199,199,
199,199,199,199,209,209,199,234,234,199,209,209,199,199,199,199,
199,199,199,199,209,209,199,234,234,199,209,209,199,199,199,199,
199,199,199,199,209,209,209,199,199,209,209,209,199,199,199,199,
199,199,199,199,199,209,209,209,209,209,209,199,199,199,199,199,
199,199,199,199,199,199,209,209,209,209,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

Missile_Collectable: # 16 x 32, Height per sprite: 16
.byte 199,199,199,199,199,199,199,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,14,14,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,103,103,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,14,14,199,199,199,199,199,199,199,
199,199,199,199,103,199,14,103,14,14,199,103,199,199,199,199,
199,199,199,199,103,199,32,103,14,32,199,103,199,199,199,199,
199,199,199,199,103,103,103,103,14,103,103,103,199,199,199,199,
199,199,199,199,103,199,14,103,14,14,199,103,199,199,199,199,
199,199,199,199,199,199,199,103,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,234,234,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,209,209,199,199,199,199,199,199,199,
199,199,199,199,199,199,234,209,209,234,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,234,234,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,209,209,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,209,209,199,199,199,199,199,199,199,
199,199,199,199,234,199,209,234,209,209,199,234,199,199,199,199,
199,199,199,199,234,199,255,234,209,255,199,234,199,199,199,199,
199,199,199,199,234,234,234,234,209,234,234,234,199,199,199,199,
199,199,199,199,234,199,209,234,209,209,199,234,199,199,199,199,
199,199,199,199,199,199,199,234,209,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

MaruMari: # 16 x 64, Height per sprite: 16
# 1024 bytes -- 1 KiB 
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,103,103,103,14,14,103,103,103,199,199,199,199,
199,199,199,103,103,14,14,103,103,103,103,103,103,199,199,199,
199,199,199,103,14,14,14,103,103,103,103,103,103,199,199,199,
199,199,103,103,14,14,103,103,103,103,103,103,103,103,199,199,
199,199,103,14,103,103,103,103,103,103,103,103,103,103,199,199,
199,199,103,14,103,103,103,103,103,103,103,103,103,103,199,199,
199,199,103,103,103,103,103,103,103,103,103,103,103,103,199,199,
199,199,103,103,103,103,103,103,103,103,103,103,103,103,199,199,
199,199,199,103,103,103,103,103,103,103,103,199,103,199,199,199,
199,199,199,103,103,103,103,103,103,199,199,103,103,199,199,199,
199,199,199,199,103,103,103,199,199,199,103,103,199,199,199,199,
199,199,199,199,199,199,103,103,103,103,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,234,234,234,234,199,199,199,199,199,199,
199,199,199,199,234,234,234,209,209,234,234,234,199,199,199,199,
199,199,199,234,234,209,209,234,234,234,234,234,234,199,199,199,
199,199,199,234,209,209,209,234,234,234,234,234,234,199,199,199,
199,199,234,234,209,209,234,234,234,234,234,234,234,234,199,199,
199,199,234,209,234,234,234,234,234,234,234,234,234,234,199,199,
199,199,234,209,234,234,234,234,234,234,234,234,234,234,199,199,
199,199,234,234,234,234,234,234,234,234,234,234,234,234,199,199,
199,199,234,234,234,234,234,234,234,234,234,234,234,234,199,199,
199,199,199,234,234,234,234,234,234,234,234,199,234,199,199,199,
199,199,199,234,234,234,234,234,234,199,199,234,234,199,199,199,
199,199,199,199,234,234,234,199,199,199,234,234,199,199,199,199,
199,199,199,199,199,199,234,234,234,234,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,252,252,252,252,199,199,199,199,199,199,
199,199,199,199,252,252,252,103,103,252,252,252,199,199,199,199,
199,199,199,252,252,103,103,252,252,252,252,252,252,199,199,199,
199,199,199,252,103,103,103,252,252,252,252,252,252,199,199,199,
199,199,252,252,103,103,252,252,252,252,252,252,252,252,199,199,
199,199,252,103,252,252,252,252,252,252,252,252,252,252,199,199,
199,199,252,103,252,252,252,252,252,252,252,252,252,252,199,199,
199,199,252,252,252,252,252,252,252,252,252,252,252,252,199,199,
199,199,252,252,252,252,252,252,252,252,252,252,252,252,199,199,
199,199,199,252,252,252,252,252,252,252,252,199,252,199,199,199,
199,199,199,252,252,252,252,252,252,199,199,252,252,199,199,199,
199,199,199,199,252,252,252,199,199,199,252,252,199,199,199,199,
199,199,199,199,199,199,252,252,252,252,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,183,183,183,183,199,199,199,199,199,199,
199,199,199,199,183,183,183,14,14,183,183,183,199,199,199,199,
199,199,199,183,183,14,14,183,183,183,183,183,183,199,199,199,
199,199,199,183,14,14,14,183,183,183,183,183,183,199,199,199,
199,199,183,183,14,14,183,183,183,183,183,183,183,183,199,199,
199,199,183,14,183,183,183,183,183,183,183,183,183,183,199,199,
199,199,183,14,183,183,183,183,183,183,183,183,183,183,199,199,
199,199,183,183,183,183,183,183,183,183,183,183,183,183,199,199,
199,199,183,183,183,183,183,183,183,183,183,183,183,183,199,199,
199,199,199,183,183,183,183,183,183,183,183,199,183,199,199,199,
199,199,199,183,183,183,183,183,183,199,199,183,183,199,199,199,
199,199,199,199,183,183,183,199,199,199,183,183,199,199,199,199,
199,199,199,199,199,199,183,183,183,183,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

Item_Capsule: # 16 x 48, Height per sprite: 16
.byte 199,199,199,199,199,199,199,209,209,209,209,199,199,199,199,199,
199,199,199,199,199,209,209,209,209,209,209,209,209,199,199,199,
199,199,199,199,209,209,209,209,209,209,209,160,209,209,199,199,
199,199,199,209,209,227,227,209,209,209,209,209,160,209,209,199,
199,199,199,209,227,227,209,209,209,209,209,209,209,160,209,199,
199,199,209,209,227,227,209,209,209,209,209,209,209,160,209,209,
199,199,209,209,227,209,209,209,209,209,209,209,209,160,160,209,
199,199,209,209,209,209,209,209,209,209,209,209,209,160,160,209,
199,199,209,209,209,209,209,209,209,209,209,209,209,160,160,209,
199,199,209,209,209,209,209,209,209,209,209,209,209,160,160,209,
199,199,199,209,209,209,209,209,209,209,209,209,160,160,209,199,
199,199,199,209,209,160,209,209,209,209,160,160,160,160,209,199,
199,199,199,199,209,209,160,160,160,160,160,160,160,209,199,199,
199,199,199,199,199,209,209,209,160,160,160,209,209,199,199,199,
199,199,199,199,199,199,199,209,209,209,209,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,160,209,199,199,199,160,227,160,199,
199,199,227,199,199,199,209,160,160,227,199,199,199,160,160,199,
199,199,199,199,199,199,199,160,209,209,209,199,199,199,199,199,
199,199,199,160,209,199,199,199,227,209,209,199,199,209,199,199,
199,209,160,160,209,199,199,199,199,199,199,199,209,199,199,199,
199,199,209,227,209,160,199,227,199,227,209,209,209,209,199,199,
199,227,199,209,209,199,199,209,199,199,199,209,160,160,199,199,
199,199,199,227,199,199,199,209,209,199,199,199,199,160,199,199,
209,199,199,199,160,227,160,199,199,199,199,199,199,199,199,160,
160,227,199,199,199,160,160,199,199,199,227,199,199,199,209,160,
209,209,209,199,199,199,199,199,199,199,199,199,199,199,199,160,
227,209,209,199,199,209,199,199,199,199,199,160,209,199,199,199,
199,199,199,199,209,199,199,199,199,209,160,160,209,199,199,199,
199,227,209,209,209,209,199,199,199,199,209,227,209,160,199,227,
199,199,199,209,160,160,199,199,199,227,199,209,209,199,199,209,
209,199,199,199,199,160,199,199,199,199,199,227,199,199,199,209,
199,199,199,199,199,209,199,199,199,199,199,199,199,199,199,199,
199,209,199,209,199,199,199,209,199,209,199,199,209,199,209,199,
199,199,199,199,160,199,199,209,209,199,209,199,199,199,199,199,
199,209,199,160,199,227,199,199,199,199,199,199,199,199,209,199,
199,199,199,199,199,199,160,199,160,199,227,199,199,160,199,199,
209,199,160,199,160,199,199,199,199,199,199,160,199,160,199,209,
199,199,199,199,199,199,199,227,199,199,199,199,160,199,160,199,
227,199,160,199,199,160,199,199,160,199,227,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,209,199,199,
199,209,199,199,209,199,209,199,199,209,199,209,199,199,199,209,
209,199,209,199,199,199,199,199,199,199,199,199,160,199,199,209,
199,199,199,199,199,199,209,199,199,209,199,160,199,227,199,199,
160,199,227,199,199,160,199,199,199,199,199,199,199,199,160,199,
199,199,199,160,199,160,199,209,209,199,160,199,160,199,199,199,
199,199,199,199,160,199,160,199,199,199,199,199,199,199,199,227,
160,199,227,199,199,199,199,199,227,199,160,199,199,160,199,199,

Bomb_Power: # 16 x 16
.byte 199,199,199,32,32,32,32,32,32,32,32,32,32,199,199,199,
199,199,32,199,199,199,199,199,199,199,199,199,199,32,199,199,
199,199,32,199,103,199,199,199,199,199,199,199,199,32,199,199,
199,32,199,103,199,199,199,199,199,199,199,199,199,199,32,199,
199,32,199,199,199,199,14,14,14,14,199,199,199,199,32,199,
199,32,199,199,199,14,103,14,14,14,14,199,199,199,32,199,
199,32,199,199,14,14,14,14,199,199,14,14,199,199,32,199,
199,32,199,199,14,14,199,199,32,32,199,14,199,199,32,199,
199,32,199,199,14,14,199,199,32,32,199,14,199,199,32,199,
199,32,199,199,14,14,14,14,199,199,14,14,199,199,32,199,
199,32,199,199,199,14,103,14,14,14,14,199,199,199,32,199,
199,32,199,199,199,199,14,14,14,14,199,199,199,199,32,199,
199,32,199,199,199,199,199,199,199,199,199,199,199,199,32,199,
199,32,199,199,199,199,199,32,32,199,199,199,199,199,32,199,
199,103,103,103,103,103,103,103,103,103,103,103,103,103,103,199,
199,199,199,103,103,103,103,103,103,103,103,103,103,199,199,199,




################################################        Enemies        ################################################
# Stores all sprites used for enemies in game                                                                         # 
#                                                                                                                     # 
# --> Total ammount of data: 1024 bytes (Ripper) + 6144 bytes (Zoomer) = 7 KiB                                        # 
#                                                                                                                     # 
# Zoomers:                                                                                                            # 							
#   01. Zoomer_Down - 16 x 32 --- 512 bytes                     07. Zoomer_Variant_Up - 16 x 32 --- 512 bytes         #        
#   02. Zoomer_Left - 16 x 32 --- 512 bytes                     08. Zoomer_Variant_Right - 16 x 32 --- 512 bytes      # 
#   03. Zoomer_Up - 16 x 32 --- 512 bytes                       09. Zoomer_Damage_Down - 16 x 32 --- 512 bytes        #          
#   04. Zoomer_Right - 16 x 32 --- 512 bytes                    10. Zoomer_Damage_Left - 16 x 32 --- 512 bytes        #            
#   05. Zoomer_Variant_Down - 16 x 32 --- 512 bytes             11. Zoomer_Damage_Up - 16 x 32 --- 512 bytes          #                     
#   06. Zoomer_Variant_Left - 16 x 32 --- 512 bytes             12. Zoomer_Damage_Right - 16 x 32 --- 512 bytes       #           
#                                                                                                                     # 
# Rippers:	                                                                                                          # 
#   01. Ripper - 16 x 32 --- 512 bytes                                                                                # 
#   02. Ripper_Variant - 16 x 32 --- 512 bytes                                                                        # 
#                                                                                                                     # 
# Ridley:                                                                                                             # 
#   01. Ridley - 32 x 80 --- 2560 bytes                         03. Ridley_Damage - 32 x 80 --- 2560 bytes            #
#   02. Ridley_Jump - 32 x 96 --- 3072 bytes                    04. Ridley_Damage_Jump - 32 x 96 --- 3072 bytes       # 
#                                                                                                                     # 
# Plasma Breath:                                                                                                      #   
#   01. Plasma_Breath - 16 x 64 --- 1024 bytes                                                                        # 
#######################################################################################################################

Zoomer_Down: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,252,199,199,199,199,199,199,199,199,
199,199,252,199,199,199,199,103,199,199,199,199,252,199,199,199,
199,199,103,252,199,199,252,103,252,199,199,252,103,199,199,199,
199,199,103,103,252,199,103,103,103,199,252,103,103,199,199,199,
199,199,199,103,103,103,103,103,103,103,103,103,199,199,199,199,
252,199,199,103,103,103,103,103,103,103,103,103,199,199,252,199,
103,103,252,103,103,103,103,103,103,103,103,103,103,252,103,199,
199,103,103,103,103,199,199,199,199,199,199,103,103,103,199,199,
199,199,103,103,199,199,103,103,103,103,199,199,103,199,199,199,
199,103,103,199,199,252,199,103,103,199,252,199,199,252,199,114,
199,114,103,199,199,252,252,199,199,252,252,199,199,103,114,199,
114,199,199,103,103,199,199,103,114,199,199,103,103,199,199,199,
114,199,199,114,199,199,199,199,114,199,199,199,114,199,199,199,
199,199,199,114,199,252,199,199,199,199,252,199,199,114,114,199,
199,199,199,199,114,199,252,199,199,252,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,252,199,199,199,199,199,199,199,
199,199,199,252,199,199,199,199,103,199,199,199,199,252,199,199,
199,199,199,103,252,199,199,252,103,252,199,199,252,103,199,199,
199,199,199,103,103,252,199,103,103,103,199,252,103,103,199,199,
199,199,199,199,103,103,103,103,103,103,103,103,103,199,199,199,
199,252,199,199,103,103,103,103,103,103,103,103,103,199,199,252,
199,103,252,103,103,103,103,103,103,103,103,103,103,252,103,103,
199,199,103,103,103,199,199,199,199,199,199,103,103,103,103,199,
199,199,199,103,199,199,103,103,103,103,199,199,103,103,199,199,
114,199,252,199,199,252,199,103,103,199,252,199,199,103,103,199,
199,114,103,199,199,252,252,199,199,252,252,199,199,103,114,199,
199,199,199,103,103,199,199,114,103,199,199,103,103,199,199,114,
199,199,199,114,199,199,199,114,199,199,199,199,114,199,199,114,
199,114,114,199,199,252,199,199,199,199,252,199,114,199,199,199,
199,199,199,199,199,199,252,199,199,252,199,114,199,199,199,199,

Zoomer_Left: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,114,114,199,199,199,103,252,199,199,199,199,199,199,199,
199,199,199,199,114,199,103,103,199,199,199,199,199,199,199,199,
199,199,199,103,103,252,103,252,199,199,103,103,252,199,199,199,
199,114,114,103,199,199,103,103,103,103,103,252,199,199,199,199,
114,199,199,103,199,199,199,103,103,103,252,199,199,199,199,199,
199,252,199,199,252,252,199,199,103,103,199,199,199,199,199,199,
252,199,199,199,252,199,103,199,103,103,103,252,199,199,199,199,
199,199,199,103,199,103,103,199,103,103,103,103,103,252,199,199,
199,199,114,114,199,103,103,199,103,103,103,252,199,199,199,199,
252,199,199,199,252,199,103,199,103,103,199,199,199,199,199,199,
199,252,199,199,252,252,199,199,103,103,252,199,199,199,199,199,
199,199,199,103,199,199,199,103,103,103,103,252,199,199,199,199,
199,199,114,103,199,199,103,103,103,199,103,103,252,199,199,199,
199,114,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,114,199,199,114,199,103,103,252,199,199,199,199,199,199,199,
199,199,199,199,199,114,199,199,103,252,199,199,199,199,199,199,
199,199,199,199,199,114,199,199,103,252,199,199,199,199,199,199,
199,114,199,199,114,199,103,103,252,199,199,199,199,199,199,199,
199,114,199,103,103,103,103,103,199,199,199,199,199,199,199,199,
199,199,114,103,199,199,103,103,103,199,103,103,252,199,199,199,
199,199,199,103,199,199,199,103,103,103,103,252,199,199,199,199,
199,252,199,199,252,252,199,199,103,103,252,199,199,199,199,199,
252,199,199,199,252,199,103,199,103,103,199,199,199,199,199,199,
199,199,114,114,199,103,103,199,103,103,103,252,199,199,199,199,
199,199,199,103,199,103,103,199,103,103,103,103,103,252,199,199,
252,199,199,199,252,199,103,199,103,103,103,252,199,199,199,199,
199,252,199,199,252,252,199,199,103,103,199,199,199,199,199,199,
114,199,199,103,199,199,199,103,103,103,252,199,199,199,199,199,
199,114,114,103,199,199,103,103,103,103,103,252,199,199,199,199,
199,199,199,103,103,252,103,252,199,199,103,103,252,199,199,199,
199,199,199,199,114,199,103,103,199,199,199,199,199,199,199,199,
199,199,114,114,199,199,199,103,252,199,199,199,199,199,199,199,

Zoomer_Up: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,114,199,252,199,199,252,199,199,199,199,199,199,
199,199,199,114,199,252,199,199,199,199,252,199,199,114,114,199,
114,199,199,114,199,199,199,199,114,199,199,199,114,199,199,199,
114,199,199,103,103,199,199,103,114,199,199,103,103,199,199,199,
199,114,103,199,199,252,252,199,199,252,252,199,199,103,114,199,
199,103,103,199,199,252,199,103,103,199,252,199,199,252,199,114,
199,199,103,103,199,199,103,103,103,103,199,199,103,199,199,199,
199,103,103,103,103,199,199,199,199,199,199,103,103,103,199,199,
103,103,252,103,103,103,103,103,103,103,103,103,103,252,103,199,
252,199,199,103,103,103,103,103,103,103,103,103,199,199,252,199,
199,199,199,103,103,103,103,103,103,103,103,103,199,199,199,199,
199,199,103,103,252,199,103,103,103,199,252,103,103,199,199,199,
199,199,103,252,199,199,252,103,252,199,199,252,103,199,199,199,
199,199,252,199,199,199,199,103,199,199,199,199,252,199,199,199,
199,199,199,199,199,199,199,252,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,252,199,199,252,199,114,199,199,199,199,
199,114,114,199,199,252,199,199,199,199,252,199,114,199,199,199,
199,199,199,114,199,199,199,114,199,199,199,199,114,199,199,114,
199,199,199,103,103,199,199,114,103,199,199,103,103,199,199,114,
199,114,103,199,199,252,252,199,199,252,252,199,199,103,114,199,
114,199,252,199,199,252,199,103,103,199,252,199,199,103,103,199,
199,199,199,103,199,199,103,103,103,103,199,199,103,103,199,199,
199,199,103,103,103,199,199,199,199,199,199,103,103,103,103,199,
199,103,252,103,103,103,103,103,103,103,103,103,103,252,103,103,
199,252,199,199,103,103,103,103,103,103,103,103,103,199,199,252,
199,199,199,199,103,103,103,103,103,103,103,103,103,199,199,199,
199,199,199,103,103,252,199,103,103,103,199,252,103,103,199,199,
199,199,199,103,252,199,199,252,103,252,199,199,252,103,199,199,
199,199,199,252,199,199,199,199,103,199,199,199,199,252,199,199,
199,199,199,199,199,199,199,199,252,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

Zoomer_Right: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,252,103,199,199,199,114,114,199,199,
199,199,199,199,199,199,199,199,103,103,199,114,199,199,199,199,
199,199,199,252,103,103,199,199,252,103,252,103,103,199,199,199,
199,199,199,199,252,103,103,103,103,103,199,199,103,114,114,199,
199,199,199,199,199,252,103,103,103,199,199,199,103,199,199,114,
199,199,199,199,199,199,103,103,199,199,252,252,199,199,252,199,
199,199,199,199,252,103,103,103,199,103,199,252,199,199,199,252,
199,199,252,103,103,103,103,103,199,103,103,199,103,199,199,199,
199,199,199,199,252,103,103,103,199,103,103,199,114,114,199,199,
199,199,199,199,199,199,103,103,199,103,199,252,199,199,199,252,
199,199,199,199,199,252,103,103,199,199,252,252,199,199,252,199,
199,199,199,199,252,103,103,103,103,199,199,199,103,199,199,199,
199,199,199,252,103,103,199,103,103,103,199,199,103,114,199,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,114,199,
199,199,199,199,199,199,199,252,103,103,199,114,199,199,114,199,
199,199,199,199,199,199,252,103,199,199,114,199,199,199,199,199,
199,199,199,199,199,199,252,103,199,199,114,199,199,199,199,199,
199,199,199,199,199,199,199,252,103,103,199,114,199,199,114,199,
199,199,199,199,199,199,199,199,103,103,103,103,103,199,114,199,
199,199,199,252,103,103,199,103,103,103,199,199,103,114,199,199,
199,199,199,199,252,103,103,103,103,199,199,199,103,199,199,199,
199,199,199,199,199,252,103,103,199,199,252,252,199,199,252,199,
199,199,199,199,199,199,103,103,199,103,199,252,199,199,199,252,
199,199,199,199,252,103,103,103,199,103,103,199,114,114,199,199,
199,199,252,103,103,103,103,103,199,103,103,199,103,199,199,199,
199,199,199,199,252,103,103,103,199,103,199,252,199,199,199,252,
199,199,199,199,199,199,103,103,199,199,252,252,199,199,252,199,
199,199,199,199,199,252,103,103,103,199,199,199,103,199,199,114,
199,199,199,199,252,103,103,103,103,103,199,199,103,114,114,199,
199,199,199,252,103,103,199,199,252,103,252,103,103,199,199,199,
199,199,199,199,199,199,199,199,103,103,199,114,199,199,199,199,
199,199,199,199,199,199,199,252,103,199,199,199,114,114,199,199,

Zoomer_Variant_Down: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,183,199,199,199,199,199,199,199,199,
199,199,183,199,199,199,199,70,199,199,199,199,183,199,199,199,
199,199,70,183,199,199,183,70,183,199,199,183,70,199,199,199,
199,199,70,70,183,199,70,70,70,199,183,70,70,199,199,199,
199,199,199,70,70,70,70,70,70,70,70,70,199,199,199,199,
183,199,199,70,70,70,70,70,70,70,70,70,199,199,183,199,
70,70,183,70,70,70,70,70,70,70,70,70,70,183,70,199,
199,70,70,70,70,199,199,199,199,199,199,70,70,70,199,199,
199,199,70,70,199,199,70,70,70,70,199,199,70,199,199,199,
199,70,70,199,199,183,199,70,70,199,183,199,199,183,199,234,
199,234,70,199,199,183,183,199,199,183,183,199,199,70,234,199,
234,199,199,70,70,199,199,70,234,199,199,70,70,199,199,199,
234,199,199,234,199,199,199,199,234,199,199,199,234,199,199,199,
199,199,199,234,199,183,199,199,199,199,183,199,199,234,234,199,
199,199,199,199,234,199,183,199,199,183,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,183,199,199,199,199,199,199,199,
199,199,199,183,199,199,199,199,70,199,199,199,199,183,199,199,
199,199,199,70,183,199,199,183,70,183,199,199,183,70,199,199,
199,199,199,70,70,183,199,70,70,70,199,183,70,70,199,199,
199,199,199,199,70,70,70,70,70,70,70,70,70,199,199,199,
199,183,199,199,70,70,70,70,70,70,70,70,70,199,199,183,
199,70,183,70,70,70,70,70,70,70,70,70,70,183,70,70,
199,199,70,70,70,199,199,199,199,199,199,70,70,70,70,199,
199,199,199,70,199,199,70,70,70,70,199,199,70,70,199,199,
234,199,183,199,199,183,199,70,70,199,183,199,199,70,70,199,
199,234,70,199,199,183,183,199,199,183,183,199,199,70,234,199,
199,199,199,70,70,199,199,234,70,199,199,70,70,199,199,234,
199,199,199,234,199,199,199,234,199,199,199,199,234,199,199,234,
199,234,234,199,199,183,199,199,199,199,183,199,234,199,199,199,
199,199,199,199,199,199,183,199,199,183,199,234,199,199,199,199,

Zoomer_Variant_Left: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,234,234,199,199,199,70,183,199,199,199,199,199,199,199,
199,199,199,199,234,199,70,70,199,199,199,199,199,199,199,199,
199,199,199,70,70,183,70,183,199,199,70,70,183,199,199,199,
199,234,234,70,199,199,70,70,70,70,70,183,199,199,199,199,
234,199,199,70,199,199,199,70,70,70,183,199,199,199,199,199,
199,183,199,199,183,183,199,199,70,70,199,199,199,199,199,199,
183,199,199,199,183,199,70,199,70,70,70,183,199,199,199,199,
199,199,199,70,199,70,70,199,70,70,70,70,70,183,199,199,
199,199,234,234,199,70,70,199,70,70,70,183,199,199,199,199,
183,199,199,199,183,199,70,199,70,70,199,199,199,199,199,199,
199,183,199,199,183,183,199,199,70,70,183,199,199,199,199,199,
199,199,199,70,199,199,199,70,70,70,70,183,199,199,199,199,
199,199,234,70,199,199,70,70,70,199,70,70,183,199,199,199,
199,234,199,70,70,70,70,70,199,199,199,199,199,199,199,199,
199,234,199,199,234,199,70,70,183,199,199,199,199,199,199,199,
199,199,199,199,199,234,199,199,70,183,199,199,199,199,199,199,
199,199,199,199,199,234,199,199,70,183,199,199,199,199,199,199,
199,234,199,199,234,199,70,70,183,199,199,199,199,199,199,199,
199,234,199,70,70,70,70,70,199,199,199,199,199,199,199,199,
199,199,234,70,199,199,70,70,70,199,70,70,183,199,199,199,
199,199,199,70,199,199,199,70,70,70,70,183,199,199,199,199,
199,183,199,199,183,183,199,199,70,70,183,199,199,199,199,199,
183,199,199,199,183,199,70,199,70,70,199,199,199,199,199,199,
199,199,234,234,199,70,70,199,70,70,70,183,199,199,199,199,
199,199,199,70,199,70,70,199,70,70,70,70,70,183,199,199,
183,199,199,199,183,199,70,199,70,70,70,183,199,199,199,199,
199,183,199,199,183,183,199,199,70,70,199,199,199,199,199,199,
234,199,199,70,199,199,199,70,70,70,183,199,199,199,199,199,
199,234,234,70,199,199,70,70,70,70,70,183,199,199,199,199,
199,199,199,70,70,183,70,183,199,199,70,70,183,199,199,199,
199,199,199,199,234,199,70,70,199,199,199,199,199,199,199,199,
199,199,234,234,199,199,199,70,183,199,199,199,199,199,199,199,

Zoomer_Variant_Up: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,234,199,183,199,199,183,199,199,199,199,199,199,
199,199,199,234,199,183,199,199,199,199,183,199,199,234,234,199,
234,199,199,234,199,199,199,199,234,199,199,199,234,199,199,199,
234,199,199,70,70,199,199,70,234,199,199,70,70,199,199,199,
199,234,70,199,199,183,183,199,199,183,183,199,199,70,234,199,
199,70,70,199,199,183,199,70,70,199,183,199,199,183,199,234,
199,199,70,70,199,199,70,70,70,70,199,199,70,199,199,199,
199,70,70,70,70,199,199,199,199,199,199,70,70,70,199,199,
70,70,183,70,70,70,70,70,70,70,70,70,70,183,70,199,
183,199,199,70,70,70,70,70,70,70,70,70,199,199,183,199,
199,199,199,70,70,70,70,70,70,70,70,70,199,199,199,199,
199,199,70,70,183,199,70,70,70,199,183,70,70,199,199,199,
199,199,70,183,199,199,183,70,183,199,199,183,70,199,199,199,
199,199,183,199,199,199,199,70,199,199,199,199,183,199,199,199,
199,199,199,199,199,199,199,183,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,183,199,199,183,199,234,199,199,199,199,
199,234,234,199,199,183,199,199,199,199,183,199,234,199,199,199,
199,199,199,234,199,199,199,234,199,199,199,199,234,199,199,234,
199,199,199,70,70,199,199,234,70,199,199,70,70,199,199,234,
199,234,70,199,199,183,183,199,199,183,183,199,199,70,234,199,
234,199,183,199,199,183,199,70,70,199,183,199,199,70,70,199,
199,199,199,70,199,199,70,70,70,70,199,199,70,70,199,199,
199,199,70,70,70,199,199,199,199,199,199,70,70,70,70,199,
199,70,183,70,70,70,70,70,70,70,70,70,70,183,70,70,
199,183,199,199,70,70,70,70,70,70,70,70,70,199,199,183,
199,199,199,199,70,70,70,70,70,70,70,70,70,199,199,199,
199,199,199,70,70,183,199,70,70,70,199,183,70,70,199,199,
199,199,199,70,183,199,199,183,70,183,199,199,183,70,199,199,
199,199,199,183,199,199,199,199,70,199,199,199,199,183,199,199,
199,199,199,199,199,199,199,199,183,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

Zoomer_Variant_Right: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,183,70,199,199,199,234,234,199,199,
199,199,199,199,199,199,199,199,70,70,199,234,199,199,199,199,
199,199,199,183,70,70,199,199,183,70,183,70,70,199,199,199,
199,199,199,199,183,70,70,70,70,70,199,199,70,234,234,199,
199,199,199,199,199,183,70,70,70,199,199,199,70,199,199,234,
199,199,199,199,199,199,70,70,199,199,183,183,199,199,183,199,
199,199,199,199,183,70,70,70,199,70,199,183,199,199,199,183,
199,199,183,70,70,70,70,70,199,70,70,199,70,199,199,199,
199,199,199,199,183,70,70,70,199,70,70,199,234,234,199,199,
199,199,199,199,199,199,70,70,199,70,199,183,199,199,199,183,
199,199,199,199,199,183,70,70,199,199,183,183,199,199,183,199,
199,199,199,199,183,70,70,70,70,199,199,199,70,199,199,199,
199,199,199,183,70,70,199,70,70,70,199,199,70,234,199,199,
199,199,199,199,199,199,199,199,70,70,70,70,70,199,234,199,
199,199,199,199,199,199,199,183,70,70,199,234,199,199,234,199,
199,199,199,199,199,199,183,70,199,199,234,199,199,199,199,199,
199,199,199,199,199,199,183,70,199,199,234,199,199,199,199,199,
199,199,199,199,199,199,199,183,70,70,199,234,199,199,234,199,
199,199,199,199,199,199,199,199,70,70,70,70,70,199,234,199,
199,199,199,183,70,70,199,70,70,70,199,199,70,234,199,199,
199,199,199,199,183,70,70,70,70,199,199,199,70,199,199,199,
199,199,199,199,199,183,70,70,199,199,183,183,199,199,183,199,
199,199,199,199,199,199,70,70,199,70,199,183,199,199,199,183,
199,199,199,199,183,70,70,70,199,70,70,199,234,234,199,199,
199,199,183,70,70,70,70,70,199,70,70,199,70,199,199,199,
199,199,199,199,183,70,70,70,199,70,199,183,199,199,199,183,
199,199,199,199,199,199,70,70,199,199,183,183,199,199,183,199,
199,199,199,199,199,183,70,70,70,199,199,199,70,199,199,234,
199,199,199,199,183,70,70,70,70,70,199,199,70,234,234,199,
199,199,199,183,70,70,199,199,183,70,183,70,70,199,199,199,
199,199,199,199,199,199,199,199,70,70,199,234,199,199,199,199,
199,199,199,199,199,199,199,183,70,199,199,199,234,234,199,199,

Zoomer_Damage_Down: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,245,199,199,199,199,199,199,199,199,
199,199,245,199,199,199,199,95,199,199,199,199,245,199,199,199,
199,199,95,245,199,199,245,95,245,199,199,245,95,199,199,199,
199,199,95,95,245,199,95,95,95,199,245,95,95,199,199,199,
199,199,199,95,95,95,95,95,95,95,95,95,199,199,199,199,
245,199,199,95,95,95,95,95,95,95,95,95,199,199,245,199,
95,95,245,95,95,95,95,95,95,95,95,95,95,245,95,199,
199,95,95,95,95,199,199,199,199,199,199,95,95,95,199,199,
199,199,95,95,199,199,95,95,95,95,199,199,95,199,199,199,
199,95,95,199,199,245,199,95,95,199,245,199,199,245,199,40,
199,40,95,199,199,245,245,199,199,245,245,199,199,95,40,199,
40,199,199,95,95,199,199,95,40,199,199,95,95,199,199,199,
40,199,199,40,199,199,199,199,40,199,199,199,40,199,199,199,
199,199,199,40,199,245,199,199,199,199,245,199,199,40,40,199,
199,199,199,199,40,199,245,199,199,245,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,245,199,199,199,199,199,199,199,
199,199,199,245,199,199,199,199,95,199,199,199,199,245,199,199,
199,199,199,95,245,199,199,245,95,245,199,199,245,95,199,199,
199,199,199,95,95,245,199,95,95,95,199,245,95,95,199,199,
199,199,199,199,95,95,95,95,95,95,95,95,95,199,199,199,
199,245,199,199,95,95,95,95,95,95,95,95,95,199,199,245,
199,95,245,95,95,95,95,95,95,95,95,95,95,245,95,95,
199,199,95,95,95,199,199,199,199,199,199,95,95,95,95,199,
199,199,199,95,199,199,95,95,95,95,199,199,95,95,199,199,
40,199,245,199,199,245,199,95,95,199,245,199,199,95,95,199,
199,40,95,199,199,245,245,199,199,245,245,199,199,95,40,199,
199,199,199,95,95,199,199,40,95,199,199,95,95,199,199,40,
199,199,199,40,199,199,199,40,199,199,199,199,40,199,199,40,
199,40,40,199,199,245,199,199,199,199,245,199,40,199,199,199,
199,199,199,199,199,199,245,199,199,245,199,40,199,199,199,199,

Zoomer_Damage_Left: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,40,40,199,199,199,95,245,199,199,199,199,199,199,199,
199,199,199,199,40,199,95,95,199,199,199,199,199,199,199,199,
199,199,199,95,95,245,95,245,199,199,95,95,245,199,199,199,
199,40,40,95,199,199,95,95,95,95,95,245,199,199,199,199,
40,199,199,95,199,199,199,95,95,95,245,199,199,199,199,199,
199,245,199,199,245,245,199,199,95,95,199,199,199,199,199,199,
245,199,199,199,245,199,95,199,95,95,95,245,199,199,199,199,
199,199,199,95,199,95,95,199,95,95,95,95,95,245,199,199,
199,199,40,40,199,95,95,199,95,95,95,245,199,199,199,199,
245,199,199,199,245,199,95,199,95,95,199,199,199,199,199,199,
199,245,199,199,245,245,199,199,95,95,245,199,199,199,199,199,
199,199,199,95,199,199,199,95,95,95,95,245,199,199,199,199,
199,199,40,95,199,199,95,95,95,199,95,95,245,199,199,199,
199,40,199,95,95,95,95,95,199,199,199,199,199,199,199,199,
199,40,199,199,40,199,95,95,245,199,199,199,199,199,199,199,
199,199,199,199,199,40,199,199,95,245,199,199,199,199,199,199,
199,199,199,199,199,40,199,199,95,245,199,199,199,199,199,199,
199,40,199,199,40,199,95,95,245,199,199,199,199,199,199,199,
199,40,199,95,95,95,95,95,199,199,199,199,199,199,199,199,
199,199,40,95,199,199,95,95,95,199,95,95,245,199,199,199,
199,199,199,95,199,199,199,95,95,95,95,245,199,199,199,199,
199,245,199,199,245,245,199,199,95,95,245,199,199,199,199,199,
245,199,199,199,245,199,95,199,95,95,199,199,199,199,199,199,
199,199,40,40,199,95,95,199,95,95,95,245,199,199,199,199,
199,199,199,95,199,95,95,199,95,95,95,95,95,245,199,199,
245,199,199,199,245,199,95,199,95,95,95,245,199,199,199,199,
199,245,199,199,245,245,199,199,95,95,199,199,199,199,199,199,
40,199,199,95,199,199,199,95,95,95,245,199,199,199,199,199,
199,40,40,95,199,199,95,95,95,95,95,245,199,199,199,199,
199,199,199,95,95,245,95,245,199,199,95,95,245,199,199,199,
199,199,199,199,40,199,95,95,199,199,199,199,199,199,199,199,
199,199,40,40,199,199,199,95,245,199,199,199,199,199,199,199,

Zoomer_Damage_Up: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,40,199,245,199,199,245,199,199,199,199,199,199,
199,199,199,40,199,245,199,199,199,199,245,199,199,40,40,199,
40,199,199,40,199,199,199,199,40,199,199,199,40,199,199,199,
40,199,199,95,95,199,199,95,40,199,199,95,95,199,199,199,
199,40,95,199,199,245,245,199,199,245,245,199,199,95,40,199,
199,95,95,199,199,245,199,95,95,199,245,199,199,245,199,40,
199,199,95,95,199,199,95,95,95,95,199,199,95,199,199,199,
199,95,95,95,95,199,199,199,199,199,199,95,95,95,199,199,
95,95,245,95,95,95,95,95,95,95,95,95,95,245,95,199,
245,199,199,95,95,95,95,95,95,95,95,95,199,199,245,199,
199,199,199,95,95,95,95,95,95,95,95,95,199,199,199,199,
199,199,95,95,245,199,95,95,95,199,245,95,95,199,199,199,
199,199,95,245,199,199,245,95,245,199,199,245,95,199,199,199,
199,199,245,199,199,199,199,95,199,199,199,199,245,199,199,199,
199,199,199,199,199,199,199,245,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,245,199,199,245,199,40,199,199,199,199,
199,40,40,199,199,245,199,199,199,199,245,199,40,199,199,199,
199,199,199,40,199,199,199,40,199,199,199,199,40,199,199,40,
199,199,199,95,95,199,199,40,95,199,199,95,95,199,199,40,
199,40,95,199,199,245,245,199,199,245,245,199,199,95,40,199,
40,199,245,199,199,245,199,95,95,199,245,199,199,95,95,199,
199,199,199,95,199,199,95,95,95,95,199,199,95,95,199,199,
199,199,95,95,95,199,199,199,199,199,199,95,95,95,95,199,
199,95,245,95,95,95,95,95,95,95,95,95,95,245,95,95,
199,245,199,199,95,95,95,95,95,95,95,95,95,199,199,245,
199,199,199,199,95,95,95,95,95,95,95,95,95,199,199,199,
199,199,199,95,95,245,199,95,95,95,199,245,95,95,199,199,
199,199,199,95,245,199,199,245,95,245,199,199,245,95,199,199,
199,199,199,245,199,199,199,199,95,199,199,199,199,245,199,199,
199,199,199,199,199,199,199,199,245,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

Zoomer_Damage_Right: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,245,95,199,199,199,40,40,199,199,
199,199,199,199,199,199,199,199,95,95,199,40,199,199,199,199,
199,199,199,245,95,95,199,199,245,95,245,95,95,199,199,199,
199,199,199,199,245,95,95,95,95,95,199,199,95,40,40,199,
199,199,199,199,199,245,95,95,95,199,199,199,95,199,199,40,
199,199,199,199,199,199,95,95,199,199,245,245,199,199,245,199,
199,199,199,199,245,95,95,95,199,95,199,245,199,199,199,245,
199,199,245,95,95,95,95,95,199,95,95,199,95,199,199,199,
199,199,199,199,245,95,95,95,199,95,95,199,40,40,199,199,
199,199,199,199,199,199,95,95,199,95,199,245,199,199,199,245,
199,199,199,199,199,245,95,95,199,199,245,245,199,199,245,199,
199,199,199,199,245,95,95,95,95,199,199,199,95,199,199,199,
199,199,199,245,95,95,199,95,95,95,199,199,95,40,199,199,
199,199,199,199,199,199,199,199,95,95,95,95,95,199,40,199,
199,199,199,199,199,199,199,245,95,95,199,40,199,199,40,199,
199,199,199,199,199,199,245,95,199,199,40,199,199,199,199,199,
199,199,199,199,199,199,245,95,199,199,40,199,199,199,199,199,
199,199,199,199,199,199,199,245,95,95,199,40,199,199,40,199,
199,199,199,199,199,199,199,199,95,95,95,95,95,199,40,199,
199,199,199,245,95,95,199,95,95,95,199,199,95,40,199,199,
199,199,199,199,245,95,95,95,95,199,199,199,95,199,199,199,
199,199,199,199,199,245,95,95,199,199,245,245,199,199,245,199,
199,199,199,199,199,199,95,95,199,95,199,245,199,199,199,245,
199,199,199,199,245,95,95,95,199,95,95,199,40,40,199,199,
199,199,245,95,95,95,95,95,199,95,95,199,95,199,199,199,
199,199,199,199,245,95,95,95,199,95,199,245,199,199,199,245,
199,199,199,199,199,199,95,95,199,199,245,245,199,199,245,199,
199,199,199,199,199,245,95,95,95,199,199,199,95,199,199,40,
199,199,199,199,245,95,95,95,95,95,199,199,95,40,40,199,
199,199,199,245,95,95,199,199,245,95,245,95,95,199,199,199,
199,199,199,199,199,199,199,199,95,95,199,40,199,199,199,199,
199,199,199,199,199,199,199,245,95,199,199,199,40,40,199,199,

###### Ripper Sprites 

Ripper: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,103,252,252,252,103,199,199,199,199,199,
199,199,199,199,103,103,252,103,103,103,103,103,199,199,199,199,
199,199,199,199,199,103,114,103,103,103,103,199,252,252,199,199,
199,199,103,252,199,199,103,114,103,103,199,103,103,103,252,199,
103,252,199,103,114,199,199,103,103,199,199,103,199,199,103,114,
199,103,114,199,103,199,199,199,103,199,199,199,252,252,199,103,
199,199,199,103,199,199,103,199,103,199,103,199,199,199,114,199,
199,199,103,199,199,103,199,199,199,199,103,103,103,103,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,103,252,252,252,103,199,199,199,199,199,199,
199,199,199,199,103,103,103,103,103,252,103,103,199,199,199,199,
199,199,252,252,199,103,103,103,103,114,103,199,199,199,199,199,
199,252,103,103,103,199,103,103,114,103,199,199,252,103,199,199,
114,103,199,199,103,199,199,103,103,199,199,114,103,199,252,103,
103,199,252,252,199,199,199,103,199,199,199,103,199,114,103,199,
199,114,199,199,199,103,199,103,199,103,199,199,103,199,199,199,
199,199,103,103,103,103,199,199,199,199,103,199,199,103,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

Ripper_Variant: # 16 x 32, Height per sprite: 16
# 512 bytes
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,70,183,183,183,70,199,199,199,199,199,
199,199,199,199,70,70,183,70,70,70,70,70,199,199,199,199,
199,199,199,199,199,70,234,70,70,70,70,199,183,183,199,199,
199,199,70,183,199,199,70,234,70,70,199,70,70,70,183,199,
70,183,199,70,234,199,199,70,70,199,199,70,199,199,70,234,
199,70,234,199,70,199,199,199,70,199,199,199,183,183,199,70,
199,199,199,70,199,199,70,199,70,199,70,199,199,199,234,199,
199,199,70,199,199,70,199,199,199,199,70,70,70,70,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,70,183,183,183,70,199,199,199,199,199,199,
199,199,199,199,70,70,70,70,70,183,70,70,199,199,199,199,
199,199,183,183,199,70,70,70,70,234,70,199,199,199,199,199,
199,183,70,70,70,199,70,70,234,70,199,199,183,70,199,199,
234,70,199,199,70,199,199,70,70,199,199,234,70,199,183,70,
70,199,183,183,199,199,199,70,199,199,199,70,199,234,70,199,
199,234,199,199,199,70,199,70,199,70,199,199,70,199,199,199,
199,199,70,70,70,70,199,199,199,199,70,199,199,70,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

###### Ridley Sprites 

Ridley: # 32 x 80, Height per sprite: 40
# 2560 bytes -- 2.5KiB
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,196,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,196,196,196,196,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,133,133,133,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,196,133,133,133,196,196,133,196,196,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,196,133,133,133,199,199,52,52,133,196,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,196,199,133,196,199,52,52,52,133,133,196,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,52,133,196,199,52,52,199,133,196,133,
199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,199,199,199,199,133,133,196,196,199,196,196,199,52,52,196,196,133,
199,199,199,199,199,199,199,199,199,199,199,196,196,133,196,196,199,199,199,199,133,133,196,199,199,196,196,199,196,196,196,199,
199,199,199,199,199,199,199,199,199,196,196,133,52,52,133,196,196,199,199,199,199,133,196,196,196,52,199,196,196,196,196,199,
199,199,199,199,199,199,199,199,196,133,133,52,52,52,196,133,133,196,199,199,199,199,133,196,196,196,199,133,133,196,196,199,
199,199,199,199,199,199,199,196,133,52,133,52,52,52,196,52,133,196,196,199,199,199,199,133,196,196,196,199,133,133,196,196,
199,199,199,199,199,199,199,196,52,52,196,52,52,196,52,52,52,133,196,196,133,133,133,199,133,196,196,133,199,133,133,196,
199,199,199,199,199,199,196,133,52,199,52,52,199,199,52,52,52,133,133,133,133,196,196,196,199,133,196,133,199,52,133,196,
199,199,199,199,199,199,196,52,199,199,199,199,199,199,199,199,52,133,133,196,133,133,196,196,196,199,196,196,196,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,199,133,196,196,196,196,196,196,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,196,196,199,196,196,199,196,196,133,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,196,199,196,196,199,196,199,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,133,196,196,199,133,133,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,133,133,196,196,199,199,133,196,196,196,196,52,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,196,133,196,196,199,199,199,199,196,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,196,196,133,196,196,199,133,199,133,133,52,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,133,196,196,196,196,196,133,199,52,133,199,52,199,
199,199,133,52,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,133,196,196,196,133,133,199,199,199,199,199,199,199,
199,199,133,199,199,133,133,133,199,199,199,199,199,199,199,199,133,133,133,196,196,133,199,199,199,199,199,199,199,199,199,199,
199,199,133,199,133,133,199,52,133,199,199,199,199,199,199,199,133,196,196,196,133,199,196,196,196,196,199,199,199,199,199,199,
199,199,133,133,133,199,199,199,196,199,199,199,199,196,196,199,196,196,196,196,196,196,196,196,196,196,133,199,199,199,199,199,
199,199,133,196,133,199,52,199,196,199,199,199,196,196,196,196,199,196,196,196,196,196,196,196,196,196,196,196,199,199,199,199,
199,133,196,133,133,133,133,199,196,199,199,199,133,196,196,196,196,199,133,133,196,196,196,196,196,196,196,133,199,199,199,199,
199,133,133,133,199,199,199,199,196,199,199,199,199,133,196,196,133,196,199,199,133,196,196,196,196,196,133,133,199,199,199,199,
199,133,199,199,199,199,199,199,133,196,199,199,199,199,133,196,196,133,133,133,196,196,196,196,196,133,133,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,133,196,199,199,199,199,133,196,196,196,196,196,196,196,196,196,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,133,196,196,196,199,133,196,196,196,196,196,196,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,133,196,196,196,199,196,196,196,196,196,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,199,196,196,196,199,199,196,196,196,196,196,199,196,196,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,196,196,196,196,196,133,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,133,133,196,196,52,199,133,52,52,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,133,133,133,199,199,133,196,52,52,199,199,52,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,52,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,196,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,196,196,196,196,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,133,133,133,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,196,133,133,133,196,196,133,196,196,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,196,133,133,133,199,199,52,52,133,196,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,196,199,133,196,199,52,52,52,133,133,196,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,52,133,196,199,52,52,199,133,196,133,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,199,196,196,199,52,52,196,196,133,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,199,199,196,196,199,196,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,196,52,199,196,196,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,199,199,199,199,133,196,196,196,199,133,133,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,199,199,199,199,133,196,196,196,199,133,133,196,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,133,196,196,133,133,133,199,133,196,196,133,199,133,133,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,52,133,133,133,196,196,196,199,133,196,133,199,52,133,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,52,133,196,133,133,196,196,196,199,196,196,196,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,133,196,196,133,199,133,196,196,196,196,196,196,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,133,196,196,196,196,199,196,196,199,196,196,133,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,52,133,196,196,196,199,196,196,199,196,199,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,52,133,196,133,196,196,199,133,133,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,52,52,133,133,133,133,196,196,199,199,133,196,196,196,196,52,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,52,133,133,196,196,196,133,196,196,199,199,199,199,196,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,52,133,133,196,196,196,196,133,196,196,199,133,199,133,133,52,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,199,133,196,196,133,196,196,196,196,196,133,199,52,133,199,52,199,
199,199,133,52,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,133,196,196,196,133,133,199,199,199,199,199,199,199,
199,199,133,199,199,133,133,133,199,199,199,199,199,199,199,199,133,133,133,196,196,133,199,199,199,199,199,199,199,199,199,199,
199,199,133,199,133,133,199,52,133,199,199,199,199,199,199,199,133,196,196,196,133,199,196,196,196,196,199,199,199,199,199,199,
199,199,133,133,133,199,199,199,196,199,199,199,199,196,196,199,196,196,196,196,196,196,196,196,196,196,133,199,199,199,199,199,
199,199,133,196,133,199,52,199,196,199,199,199,196,196,196,196,199,196,196,196,196,196,196,196,196,196,196,196,199,199,199,199,
199,133,196,133,133,133,133,199,196,199,199,199,133,196,196,196,196,199,133,133,196,196,196,196,196,196,196,133,199,199,199,199,
199,133,133,133,199,199,199,199,196,199,199,199,199,133,196,196,133,196,199,199,133,196,196,196,196,196,133,133,199,199,199,199,
199,133,199,199,199,199,199,199,133,196,199,199,199,199,133,196,196,133,133,133,196,196,196,196,196,133,133,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,133,196,199,199,199,199,133,196,196,196,196,196,196,196,196,196,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,133,196,196,196,199,133,196,196,196,196,196,196,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,133,196,196,196,199,196,196,196,196,196,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,199,196,196,196,199,199,196,196,196,196,196,199,196,196,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,196,196,196,196,196,133,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,133,133,196,196,52,199,133,52,52,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,133,133,133,199,199,133,196,52,52,199,199,52,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,52,199,199,199,

Ridley_Jump: # 32 x 96, Height per sprite: 48
# 3072 bytes -- 3KiB
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,196,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,196,196,196,196,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,133,133,133,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,196,133,133,133,196,196,133,196,196,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,196,133,133,133,199,199,52,52,133,196,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,196,199,133,196,199,52,52,52,133,133,196,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,52,133,196,199,52,52,199,133,196,133,
199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,199,199,199,199,133,133,196,196,199,196,196,199,52,52,196,196,133,
199,199,199,199,199,199,199,199,199,199,199,196,196,133,196,196,199,199,199,199,133,133,196,199,199,196,196,199,196,196,196,199,
199,199,199,199,199,199,199,199,199,196,196,133,52,52,133,196,196,199,199,199,199,133,196,196,196,52,199,196,196,196,196,199,
199,199,199,199,199,199,199,199,196,133,133,52,52,52,196,133,133,196,199,199,199,199,133,196,196,196,199,133,133,196,196,199,
199,199,199,199,199,199,199,196,133,52,133,52,52,52,196,52,133,196,196,199,199,199,199,133,196,196,196,199,133,133,196,196,
199,199,199,199,199,199,199,196,52,52,196,52,52,196,52,52,52,133,196,196,133,133,133,199,133,196,196,133,199,133,133,196,
199,199,199,199,199,199,196,133,52,199,52,52,199,199,52,52,52,133,133,133,133,196,196,196,199,133,196,133,199,52,133,196,
199,199,199,199,199,199,196,52,199,199,199,199,199,199,199,199,52,133,133,196,133,133,196,196,196,199,196,196,196,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,199,133,196,196,196,196,196,196,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,196,196,199,196,196,199,196,196,133,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,196,199,196,196,199,196,199,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,133,196,196,199,133,133,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,133,133,196,196,199,199,133,196,196,196,196,52,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,196,133,196,196,199,199,199,199,196,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,196,196,133,196,196,199,133,199,133,133,52,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,133,196,196,196,196,196,133,199,52,133,199,52,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,133,196,196,196,133,133,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,133,133,196,196,133,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,196,133,199,196,196,196,196,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,199,196,196,196,196,196,196,196,196,196,196,133,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,199,196,196,196,196,196,196,196,196,196,196,196,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,196,196,199,133,133,196,196,196,196,196,196,196,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,133,196,199,199,133,196,196,196,196,196,133,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,133,196,199,133,196,196,133,133,133,196,196,196,196,196,133,133,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,196,196,196,196,199,133,196,196,196,196,196,196,196,196,196,196,133,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,196,196,196,133,199,133,196,196,196,196,196,196,133,133,133,133,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,196,133,133,133,199,133,196,196,196,133,133,133,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,196,133,199,199,199,199,199,133,196,196,133,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,196,199,199,199,199,199,133,133,196,196,196,196,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,196,199,199,199,199,199,199,133,196,196,196,196,196,199,199,199,199,199,199,199,199,199,199,
199,199,133,52,199,199,199,199,199,196,199,199,199,199,199,199,199,133,196,196,196,196,199,199,199,199,199,199,199,199,199,199,
199,199,133,199,199,133,133,133,196,199,199,199,199,199,199,199,199,199,133,196,196,196,196,199,199,199,199,199,199,199,199,199,
199,199,133,199,133,133,199,52,199,199,199,199,199,199,199,199,199,199,133,133,196,196,196,199,199,199,199,199,199,199,199,199,
199,199,133,133,133,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,133,133,196,199,199,199,199,199,199,199,199,
199,199,133,196,133,199,52,199,199,199,199,199,199,199,199,199,199,199,199,196,133,199,196,196,199,199,199,199,199,199,199,199,
199,133,196,133,133,133,133,199,199,199,199,199,199,199,199,199,199,199,199,52,52,199,196,196,199,199,199,199,199,199,199,199,
199,133,133,133,199,199,199,199,199,199,199,199,199,199,199,199,199,199,52,52,199,199,52,133,199,199,199,199,199,199,199,199,
199,133,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,52,52,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,196,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,196,196,196,196,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,196,196,133,133,133,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,196,133,133,133,196,196,133,196,196,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,196,133,133,133,199,199,52,52,133,196,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,196,199,133,196,199,52,52,52,133,133,196,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,52,133,196,199,52,52,199,133,196,133,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,199,196,196,199,52,52,196,196,133,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,199,199,196,196,199,196,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,196,52,199,196,196,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,199,199,199,199,133,196,196,196,199,133,133,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,199,199,199,199,133,196,196,196,199,133,133,196,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,133,196,196,133,133,133,199,133,196,196,133,199,133,133,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,52,133,133,133,196,196,196,199,133,196,133,199,52,133,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,52,133,196,133,133,196,196,196,199,196,196,196,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,133,196,196,133,199,133,196,196,196,196,196,196,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,133,133,196,196,196,196,199,196,196,199,196,196,133,199,199,196,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,52,133,196,196,196,199,196,196,199,196,199,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,133,52,133,196,133,196,196,199,133,133,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,52,52,133,133,133,133,196,196,199,199,133,196,196,196,196,52,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,52,133,133,196,196,196,133,196,196,199,199,199,199,196,196,196,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,52,133,133,196,196,196,196,133,196,196,199,133,199,133,133,52,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,196,199,133,196,196,133,196,196,196,196,196,133,199,52,133,199,52,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,133,196,196,196,133,133,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,133,133,196,196,133,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,133,133,196,196,196,133,199,196,196,196,196,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,196,196,199,196,196,196,196,196,196,196,196,196,196,133,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,196,196,196,196,199,196,196,196,196,196,196,196,196,196,196,196,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,196,196,199,133,133,196,196,196,196,196,196,196,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,133,196,199,199,133,196,196,196,196,196,133,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,133,196,199,133,196,196,133,133,133,196,196,196,196,196,133,133,133,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,196,196,196,196,199,133,196,196,196,196,196,196,196,196,196,196,133,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,196,196,196,133,199,133,196,196,196,196,196,196,133,133,133,133,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,196,133,133,133,199,133,196,196,196,133,133,133,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,196,133,199,199,199,199,199,133,196,196,133,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,196,199,199,199,199,199,133,133,196,196,196,196,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,196,199,199,199,199,199,199,133,196,196,196,196,196,199,199,199,199,199,199,199,199,199,199,
199,199,133,52,199,199,199,199,199,196,199,199,199,199,199,199,199,133,196,196,196,196,199,199,199,199,199,199,199,199,199,199,
199,199,133,199,199,133,133,133,196,199,199,199,199,199,199,199,199,199,133,196,196,196,196,199,199,199,199,199,199,199,199,199,
199,199,133,199,133,133,199,52,199,199,199,199,199,199,199,199,199,199,133,133,196,196,196,199,199,199,199,199,199,199,199,199,
199,199,133,133,133,199,199,199,199,199,199,199,199,199,199,199,199,199,133,196,196,133,133,196,199,199,199,199,199,199,199,199,
199,199,133,196,133,199,52,199,199,199,199,199,199,199,199,199,199,199,199,196,133,199,196,196,199,199,199,199,199,199,199,199,
199,133,196,133,133,133,133,199,199,199,199,199,199,199,199,199,199,199,199,52,52,199,196,196,199,199,199,199,199,199,199,199,
199,133,133,133,199,199,199,199,199,199,199,199,199,199,199,199,199,199,52,52,199,199,52,133,199,199,199,199,199,199,199,199,
199,133,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,52,52,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

Ridley_Damage: # 32 x 80, Height per sprite: 40
# 2560 bytes -- 2.5KiB
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,14,14,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,32,14,14,14,32,32,14,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,32,14,14,14,199,199,103,103,14,32,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,32,199,14,32,199,103,103,103,14,14,32,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,103,14,32,199,103,103,199,14,32,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,14,14,32,32,199,32,32,199,103,103,32,32,14,
199,199,199,199,199,199,199,199,199,199,199,32,32,14,32,32,199,199,199,199,14,14,32,199,199,32,32,199,32,32,32,199,
199,199,199,199,199,199,199,199,199,32,32,14,103,103,14,32,32,199,199,199,199,14,32,32,32,103,199,32,32,32,32,199,
199,199,199,199,199,199,199,199,32,14,14,103,103,103,32,14,14,32,199,199,199,199,14,32,32,32,199,14,14,32,32,199,
199,199,199,199,199,199,199,32,14,103,14,103,103,103,32,103,14,32,32,199,199,199,199,14,32,32,32,199,14,14,32,32,
199,199,199,199,199,199,199,32,103,103,32,103,103,32,103,103,103,14,32,32,14,14,14,199,14,32,32,14,199,14,14,32,
199,199,199,199,199,199,32,14,103,199,103,103,199,199,103,103,103,14,14,14,14,32,32,32,199,14,32,14,199,103,14,32,
199,199,199,199,199,199,32,103,199,199,199,199,199,199,199,199,103,14,14,32,14,14,32,32,32,199,32,32,32,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,199,14,32,32,32,32,32,32,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,32,32,199,32,32,199,32,32,14,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,32,199,32,32,199,32,199,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,32,32,199,14,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,32,32,199,199,14,32,32,32,32,103,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,32,14,32,32,199,199,199,199,32,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,32,32,14,32,32,199,14,199,14,14,103,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,14,32,32,32,32,32,14,199,103,14,199,103,199,
199,199,14,103,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,14,32,32,32,14,14,199,199,199,199,199,199,199,
199,199,14,199,199,14,14,14,199,199,199,199,199,199,199,199,14,14,14,32,32,14,199,199,199,199,199,199,199,199,199,199,
199,199,14,199,14,14,199,103,14,199,199,199,199,199,199,199,14,32,32,32,14,199,32,32,32,32,199,199,199,199,199,199,
199,199,14,14,14,199,199,199,32,199,199,199,199,32,32,199,32,32,32,32,32,32,32,32,32,32,14,199,199,199,199,199,
199,199,14,32,14,199,103,199,32,199,199,199,32,32,32,32,199,32,32,32,32,32,32,32,32,32,32,32,199,199,199,199,
199,14,32,14,14,14,14,199,32,199,199,199,14,32,32,32,32,199,14,14,32,32,32,32,32,32,32,14,199,199,199,199,
199,14,14,14,199,199,199,199,32,199,199,199,199,14,32,32,14,32,199,199,14,32,32,32,32,32,14,14,199,199,199,199,
199,14,199,199,199,199,199,199,14,32,199,199,199,199,14,32,32,14,14,14,32,32,32,32,32,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,32,199,199,199,199,14,32,32,32,32,32,32,32,32,32,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,32,32,32,199,14,32,32,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,32,32,32,199,32,32,32,32,32,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,199,32,32,32,199,199,32,32,32,32,32,199,32,32,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,32,32,32,32,32,14,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,14,14,32,32,103,199,14,103,103,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,14,32,103,103,199,199,103,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,14,14,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,32,14,14,14,32,32,14,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,32,14,14,14,199,199,103,103,14,32,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,32,199,14,32,199,103,103,103,14,14,32,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,103,14,32,199,103,103,199,14,32,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,199,32,32,199,103,103,32,32,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,199,199,32,32,199,32,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,32,103,199,32,32,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,14,32,32,32,199,14,14,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,14,32,32,32,199,14,14,32,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,14,32,32,14,14,14,199,14,32,32,14,199,14,14,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,103,14,14,14,32,32,32,199,14,32,14,199,103,14,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,103,14,32,14,14,32,32,32,199,32,32,32,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,14,32,32,14,199,14,32,32,32,32,32,32,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,14,32,32,32,32,199,32,32,199,32,32,14,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,103,14,32,32,32,199,32,32,199,32,199,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,103,14,32,14,32,32,199,14,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,103,14,14,14,14,32,32,199,199,14,32,32,32,32,103,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,14,14,32,32,32,14,32,32,199,199,199,199,32,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,14,14,32,32,32,32,14,32,32,199,14,199,14,14,103,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,199,14,32,32,14,32,32,32,32,32,14,199,103,14,199,103,199,
199,199,14,103,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,14,32,32,32,14,14,199,199,199,199,199,199,199,
199,199,14,199,199,14,14,14,199,199,199,199,199,199,199,199,14,14,14,32,32,14,199,199,199,199,199,199,199,199,199,199,
199,199,14,199,14,14,199,103,14,199,199,199,199,199,199,199,14,32,32,32,14,199,32,32,32,32,199,199,199,199,199,199,
199,199,14,14,14,199,199,199,32,199,199,199,199,32,32,199,32,32,32,32,32,32,32,32,32,32,14,199,199,199,199,199,
199,199,14,32,14,199,103,199,32,199,199,199,32,32,32,32,199,32,32,32,32,32,32,32,32,32,32,32,199,199,199,199,
199,14,32,14,14,14,14,199,32,199,199,199,14,32,32,32,32,199,14,14,32,32,32,32,32,32,32,14,199,199,199,199,
199,14,14,14,199,199,199,199,32,199,199,199,199,14,32,32,14,32,199,199,14,32,32,32,32,32,14,14,199,199,199,199,
199,14,199,199,199,199,199,199,14,32,199,199,199,199,14,32,32,14,14,14,32,32,32,32,32,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,14,32,199,199,199,199,14,32,32,32,32,32,32,32,32,32,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,14,32,32,32,199,14,32,32,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,32,32,32,199,32,32,32,32,32,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,199,32,32,32,199,199,32,32,32,32,32,199,32,32,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,32,32,32,32,32,14,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,14,14,32,32,103,199,14,103,103,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,14,199,199,14,32,103,103,199,199,103,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,199,199,199,

Ridley_Damage_Jump: # 32 x 96, Height per sprite: 48
# 3072 bytes -- 3KiB
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,14,14,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,32,14,14,14,32,32,14,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,32,14,14,14,199,199,103,103,14,32,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,32,199,14,32,199,103,103,103,14,14,32,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,103,14,32,199,103,103,199,14,32,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,14,14,32,32,199,32,32,199,103,103,32,32,14,
199,199,199,199,199,199,199,199,199,199,199,32,32,14,32,32,199,199,199,199,14,14,32,199,199,32,32,199,32,32,32,199,
199,199,199,199,199,199,199,199,199,32,32,14,103,103,14,32,32,199,199,199,199,14,32,32,32,103,199,32,32,32,32,199,
199,199,199,199,199,199,199,199,32,14,14,103,103,103,32,14,14,32,199,199,199,199,14,32,32,32,199,14,14,32,32,199,
199,199,199,199,199,199,199,32,14,103,14,103,103,103,32,103,14,32,32,199,199,199,199,14,32,32,32,199,14,14,32,32,
199,199,199,199,199,199,199,32,103,103,32,103,103,32,103,103,103,14,32,32,14,14,14,199,14,32,32,14,199,14,14,32,
199,199,199,199,199,199,32,14,103,199,103,103,199,199,103,103,103,14,14,14,14,32,32,32,199,14,32,14,199,103,14,32,
199,199,199,199,199,199,32,103,199,199,199,199,199,199,199,199,103,14,14,32,14,14,32,32,32,199,32,32,32,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,199,14,32,32,32,32,32,32,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,32,32,199,32,32,199,32,32,14,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,32,199,32,32,199,32,199,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,14,32,32,199,14,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,32,32,199,199,14,32,32,32,32,103,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,32,14,32,32,199,199,199,199,32,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,32,32,14,32,32,199,14,199,14,14,103,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,14,32,32,32,32,32,14,199,103,14,199,103,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,14,32,32,32,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,32,32,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,32,14,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,199,32,32,32,32,32,32,32,32,32,32,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,32,32,32,32,32,32,32,32,32,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,32,32,199,14,14,32,32,32,32,32,32,32,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,14,32,199,199,14,32,32,32,32,32,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,32,199,14,32,32,14,14,14,32,32,32,32,32,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,14,32,32,32,32,32,32,32,32,32,32,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,14,199,14,32,32,32,32,32,32,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,14,14,14,199,14,32,32,32,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,14,199,199,199,199,199,14,32,32,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,199,199,199,199,199,14,14,32,32,32,32,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,199,199,199,199,199,199,14,32,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,14,103,199,199,199,199,199,32,199,199,199,199,199,199,199,14,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,14,199,199,14,14,14,32,199,199,199,199,199,199,199,199,199,14,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,14,199,14,14,199,103,199,199,199,199,199,199,199,199,199,199,14,14,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,14,14,32,199,199,199,199,199,199,199,199,
199,199,14,32,14,199,103,199,199,199,199,199,199,199,199,199,199,199,199,32,14,199,32,32,199,199,199,199,199,199,199,199,
199,14,32,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,103,103,199,32,32,199,199,199,199,199,199,199,199,
199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,199,199,103,14,199,199,199,199,199,199,199,199,
199,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,32,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,32,32,14,14,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,32,14,14,14,32,32,14,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,32,14,14,14,199,199,103,103,14,32,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,32,199,14,32,199,103,103,103,14,14,32,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,103,14,32,199,103,103,199,14,32,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,199,32,32,199,103,103,32,32,14,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,199,199,32,32,199,32,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,32,103,199,32,32,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,199,199,199,199,14,32,32,32,199,14,14,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,199,199,199,14,32,32,32,199,14,14,32,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,14,32,32,14,14,14,199,14,32,32,14,199,14,14,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,103,14,14,14,32,32,32,199,14,32,14,199,103,14,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,103,14,32,14,14,32,32,32,199,32,32,32,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,14,32,32,14,199,14,32,32,32,32,32,32,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,14,14,32,32,32,32,199,32,32,199,32,32,14,199,199,32,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,103,14,32,32,32,199,32,32,199,32,199,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,14,103,14,32,14,32,32,199,14,14,32,32,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,103,14,14,14,14,32,32,199,199,14,32,32,32,32,103,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,14,14,32,32,32,14,32,32,199,199,199,199,32,32,32,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,103,14,14,32,32,32,32,14,32,32,199,14,199,14,14,103,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,32,199,14,32,32,14,32,32,32,32,32,14,199,103,14,199,103,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,14,32,32,32,14,14,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,14,14,32,32,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,14,14,32,32,32,14,199,32,32,32,32,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,32,32,199,32,32,32,32,32,32,32,32,32,32,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,32,32,32,32,32,32,32,32,32,32,32,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,32,32,199,14,14,32,32,32,32,32,32,32,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,14,32,199,199,14,32,32,32,32,32,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,14,32,199,14,32,32,14,14,14,32,32,32,32,32,14,14,14,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,32,199,14,32,32,32,32,32,32,32,32,32,32,14,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,32,32,14,199,14,32,32,32,32,32,32,14,14,14,14,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,32,14,14,14,199,14,32,32,32,14,14,14,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,14,199,199,199,199,199,14,32,32,14,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,199,199,199,199,199,14,14,32,32,32,32,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,32,199,199,199,199,199,199,14,32,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,14,103,199,199,199,199,199,32,199,199,199,199,199,199,199,14,32,32,32,32,199,199,199,199,199,199,199,199,199,199,
199,199,14,199,199,14,14,14,32,199,199,199,199,199,199,199,199,199,14,32,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,14,199,14,14,199,103,199,199,199,199,199,199,199,199,199,199,14,14,32,32,32,199,199,199,199,199,199,199,199,199,
199,199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,14,32,32,14,14,32,199,199,199,199,199,199,199,199,
199,199,14,32,14,199,103,199,199,199,199,199,199,199,199,199,199,199,199,32,14,199,32,32,199,199,199,199,199,199,199,199,
199,14,32,14,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,103,103,199,32,32,199,199,199,199,199,199,199,199,
199,14,14,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,199,199,103,14,199,199,199,199,199,199,199,199,
199,14,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,103,103,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,

###### Plasma Breath Sprites 
Plasma_Breath: # 16 x 64, Height per sprite: 16
# 1024 bytes -- 1 KiB
.byte 199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,196,196,196,199,199,199,199,199,199,
199,199,199,199,199,199,196,196,199,196,196,199,199,199,199,199,
199,199,199,199,199,196,196,103,103,103,196,199,199,199,199,199,
199,199,199,199,199,196,103,103,103,103,196,199,199,199,199,199,
199,199,199,199,199,196,103,199,103,196,199,199,199,199,199,199,
199,199,199,199,199,196,103,199,199,199,199,196,199,199,199,199,
199,199,199,199,199,199,196,103,199,199,196,199,199,199,199,199,
199,199,199,199,199,199,199,196,196,196,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,196,196,199,199,199,199,199,199,199,
199,199,199,199,199,196,196,196,196,196,199,199,199,199,199,199,
199,199,199,199,199,196,103,103,103,196,196,199,199,199,199,199,
199,199,199,199,196,103,199,103,103,103,196,199,199,199,199,199,
199,199,199,199,196,103,199,103,103,199,196,199,199,199,199,199,
199,199,199,199,196,199,199,199,196,196,199,199,199,199,199,199,
199,199,199,199,199,196,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,196,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,196,196,196,199,199,199,199,199,199,199,
199,199,199,199,199,196,199,199,103,196,199,199,199,199,199,199,
199,199,199,199,196,199,199,199,199,103,196,199,199,199,199,199,
199,199,199,199,199,199,196,103,199,103,196,199,199,199,199,199,
199,199,199,199,199,196,103,103,103,103,196,199,199,199,199,199,
199,199,199,199,199,196,103,103,103,196,196,199,199,199,199,199,
199,199,199,199,199,196,196,199,196,196,199,199,199,199,199,199,
199,199,199,199,199,199,196,196,196,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,196,199,199,199,199,199,199,
199,199,199,199,199,199,199,199,199,199,196,199,199,199,199,199,
199,199,199,199,199,199,196,196,199,199,199,196,199,199,199,199,
199,199,199,199,199,196,199,103,103,199,103,196,199,199,199,199,
199,199,199,199,199,196,103,103,103,199,103,196,199,199,199,199,
199,199,199,199,199,196,196,103,103,103,196,199,199,199,199,199,
199,199,199,199,199,199,196,196,196,196,196,199,199,199,199,199,
199,199,199,199,199,199,199,196,196,199,199,199,199,199,199,199,



