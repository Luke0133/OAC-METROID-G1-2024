    .data
WINDOW_WIDTH:    .word 320         # Largura da janela
WINDOW_HEIGHT:   .word 240         # Altura da janela
PLAYER_WIDTH:    .byte 20          # Largura do jogador
PLAYER_HEIGHT:   .byte 20          # Altura do jogador
PLAYER_SPEED:    .byte 5           # Velocidade do jogador

player_x:    .word 160              # Posição x inicial do jogador
player_y:    .word 220              # Posição y inicial do jogador
vel_x:       .word 0                # Velocidade x do jogador
is_jumping:  .byte 0                # Indicador se o jogador está pulando
is_charging: .byte 0                # Indicador se o jogador está carregando o pulo (basicamente se o espaço está sendo pressionado)
jump_charge: .byte 0                # Força do pulo carregado
    .text

main_loop:
    call read_input                 # Ler entrada do usuário
    call handle_input               # Processar a entrada
    call update_player              # Atualizar posição do jogador
    j main_loop                     # Loop principal

update_player:
    lw t0, is_charging              # Carrega o valor de is_charging no registrador t0 (0 ou 1) (assumimos que o estado do pulo está armazenado em t0 pós mapeamento do espaço)
    beqz t0, no_charging            # Se is_charging for 0, pula para no_charging
    lw t0, jump_charge              # Caso esteja carregando, carrega o valor atual de jump_charge no registrador t0
    li t1, 15                       # Carrega o valor máximo do pulo em t1
    blt t0, t1, inc_charge          # Se jump_charge for menor que o valor máximo do pulo, branch to inc_charge
    j no_charge                     # Caso contrário, pula para no_charge

# Se estivermos no máximo e não soltarmos o espaço, usamos o no_charge para não fazer nada
no_charge: 



inc_charge:
    addi t0, t0, 1                  # Incrementa jump_charge em 1
    sw t0, jump_charge              # Armazena o novo valor de jump_charge na memória

no_charging:                        # Se não estiver carregando o pulo, pula para aqui
    lw t0, player_x                 # Carrega o valor de player_x no registrador t0
    lw t1, vel_x                    # Carrega o valor de vel_x no registrador t1
    add t0, t0, t1                  # Adiciona vel_x a player_x
    sw t0, player_x                 # Armazena o novo valor de player_x na memória

    lw t0, player_y                 # Carrega o valor de player_y no registrador t0
    lw t1, jump_charge              # Carrega o valor de jump_charge no registrador t1
    sub t1, 0, t1                   # Define t1 como -jump_charge (direção para cima)
    add t0, t0, t1                  # Adiciona jump_charge a player_y
    sw t0, player_y                 # Armazena o novo valor de player_y na memória

    # Verifica se existe a necessidade de aplicar gravidade
    lw t0, player_y                 # Carrega o valor de player_y no registrador t0
    li t1, 220                      # Valor do chão em t1
    blt t0, t1, apply_gravity       # Se player_y for menor que 220, pula para apply_gravity
    j on_ground                     # Caso contrário, pula para on_ground

apply_gravity:
    lw t0, jump_charge              # Carrega o valor de vel_y no registrador t0
    addi t0, t0, 1                  # Incrementa vel_y em 1 (GRAVITY)
    sw t0, jump_charge              # Armazena o novo valor de vel_y na memória           

on_ground:
    li t0, 220                      # Carrega o valor 220 no registrador t0
    sw t0, player_y                 # Armazena o valor 220 em player_y
    li t0, 0                        # Carrega o valor 0 no registrador t0
    sw t0, is_jumping               # Armazena 0 em is_jumping (o jogador não está mais pulando)
    sw t0, jump_charge              # Armazena 0 em jump_charge (resetando o valor)

