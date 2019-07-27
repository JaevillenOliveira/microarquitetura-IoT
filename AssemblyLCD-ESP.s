.data

.global _start

# .equ <nome> <valor hex>
# Este bloco armazena os valores, em hexadecimal, correspondentes ao que deve ser printado no display 
.equ L, 0x4C
.equ E, 0x45
.equ D, 0x44
.equ Um, 0x31
.equ Dois, 0x32
.equ Tres, 0x33
.equ Quatro, 0x34
.equ Cinco, 0x35
.equ Y, 0x59
.equ O, 0x4F
.equ U, 0x55
.equ C, 0x43
.equ H, 0x48
.equ S, 0x53
.equ clear, 0x01
.equ space, 0x20

.equ virgula, 0x2C
.equ aspas, 0x22
.equ treze, 13
.equ dez, 10
.equ publish, 0x30
.equ remain_bytes, 0x09
.equ msb, 0x00
.equ lsb, 0x03
.equ a, 0x61
.equ bar, 0x2F
.equ b, 0x62

at1: .ascii "AT+CWJAP_CUR="
at1_p1: .ascii "WLessLEDS"
at1_p2: .ascii "HelloWorldMP31"

at2: .ascii "AT+CIPSTART="
at2_p1: .ascii "TCP"
at2_p2:.ascii "192.168.1.201"
at2_p3: .ascii "1883"

at3: .ascii "AT+CIPSEND=11"

.text

# r2 guarda recebe os resultados da intrução customizada do lcd
# r3 guarda valores temporários 
# r4 guarda os números das leds a serem alterados no display (de acordo com a rolagem do menu) [
# r5 guarda o endereço de memória dos  botões
# r6 guarda o endereço de memória das colunas da matriz de leds
# r7 guarda valores temporários
# r8 guarda endereços de instruções temporariamente
# r10 é usado para fazer contadores em loops
# r11 é usado para fazer contadores em loops
# r13 o endereço de memória das linhas da matriz de leds
# r14 contêm o valor 1 (um)
# r15 contêm o endereço de memória da UART

# Codificação dos Botões:
# 1 - volta ao menu -  0001 (1)
# 2 - seleciona -      0010 (2)
# 3 - rola pra baixo - 0100 (4)
# 4 - rola pra cima -  1000 (8)

# Codificação das Leds
# LED1 - 00001 (1)
# LED2 - 00010 (2)
# LED3 - 00100 (4)
# LED4 - 01000 (8)
# LED5 - 10000 (16)

# custom <id da instrução> <result> <dataA> <dataB>

# Nesta label a instrução customizada é chamada com os parâmetros dos registradores r0 e r14
# Nesse caso r0 indica ao lcd que está sendo enviado um comando e r14 é o comando a ser executado

_start:
	movia r5, 0x3030 # endereço de memórios dos botões
	movia r6, 0x3020 # endereço de memória das colunas
	movia r13, 0x2010 # endereço de memória das linhas
	movia r15, 0x2030 # endereço de memória da uart


loop_write_uart:
	add r3, r7, r12
	ldb r11, 0(r3)
	stbio r11, 0(r15)
	addi r12, r12, 1
	bgt r12, r10, loop_write_uart_next_destine
	br loop_write_uart	

loop_write_uart_end:
	add r3, r7, r12
	ldb r11, 0(r3)
	stbio r11, 0(r15)
	addi r12, r12, 1
	bgt r12, r10, loop_write_uart_next_destine_end
	br loop_write_uart_end

loop_write_uart_next_destine:
	callr r8

loop_write_uart_next_destine_end:
	movia r11, aspas
	stbio r11, 0(r15)
	call end_command
	callr r8

send_at1:
	movia r7, at1
	addi r10, r0, 13
	add r12, r0, r0
	movia r8, send_at1_p1
	call loop_write_uart

send_at1_p1:
	movia r11, aspas
	stbio r11, 0(r15)
	movia r7, at1_p1
	addi r10, r0, 9
	add r12, r0, r0
	movia r8, send_at1_p2
	call loop_write_uart

send_at1_p2:
	movia r11, aspas
	stbio r11, 0(r15)
	movia r11, virgula
	stbio r11, 0(r15)
	movia r11, aspas
	stbio r11, 0(r15)
	movia r7, at1_p2
	addi r10, r0, 14
	add r12, r0, r0
	movia r8, send_at2
	call loop_write_uart_end

send_at2:
	movia r7, at2
	addi r10, r0, 12
	add r12, r0, r0
	movia r8, send_at2_p1
	call loop_write_uart

send_at2_p1:
	movia r11, aspas
	stbio r11, 0(r15)
	movia r7, at2_p1
	addi r10, r0, 3
	add r12, r0, r0
	movia r8, send_at2_p2
	call loop_write_uart

send_at2_p2:
	movia r11, aspas
	stbio r11, 0(r15)
	movia r11, virgula
	stbio r11, 0(r15)
	movia r11, aspas
	stbio r11, 0(r15)
	movia r7, at2_p2
	addi r10, r0, 13
	add r12, r0, r0
	movia r8, send_at2_p3
	call loop_write_uart

send_at2_p3:
	movia r11, aspas
	stbio r11, 0(r15)
	movia r11, virgula
	stbio r11, 0(r15)
	movia r11, aspas
	stbio r11, 0(r15)
	movia r7, at2_p3
	addi r10, r0, 4
	add r12, r0, r0
	movia r8, init_lcd
	call loop_write_uart_end

send_at3:
	movia r7, at3
	addi r10, r0, 13
	add r12, r0, r0
	movia r8, send_mqtt
	subi sp, sp, 4
	stw ra, 0(sp)
	call loop_write_uart

send_mqtt:
	call end_command

	movia r3, publish
	stbio r3, 0(r15)
	movia r3, remain_bytes
	stbio r3, 0(r15)
	movia r3, msb
	stbio r3, 0(r15)
	movia r3, lsb
	stbio r3, 0(r15)
	movia r3, a
	stbio r3, 0(r15)	
	movia r3, bar
	stbio r3, 0(r15)
	movia r3, b
	stbio r3, 0(r15)	
	movia r3, L
	stbio r3, 0(r15)	
	movia r3, E
	stbio r3, 0(r15)
	movia r3, D
	stbio r3, 0(r15)
	stbio r4, 0(r15)

	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

end_command:
	movia r11, treze
	stbio r11, 0(r15)
	movia r11, dez
	stbio r11, 0(r15)

	subi sp, sp, 4
	stw ra, 0(sp)

	addi r10, r0, 0
	movia r11, 400000
	call delay
	call clear_uart

	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

clear_uart:
	ldb r3, 0(r15)
	bne r3, r0, clear_uart
	ret


init_lcd:
	movia r3, 0x30
	custom 0, r2, r0, r3
	custom 0, r2, r0, r3
	movia r3, 0x39
	custom 0, r2, r0, r3
	movia r3, 0x14
	custom 0, r2, r0, r3
	movia r3, 0x56
	custom 0, r2, r0, r3
	movia r3, 0x6D
	custom 0, r2, r0, r3
	movia r3, 0x70
	custom 0, r2, r0, r3
	movia r3, 0x0C
	custom 0, r2, r0, r3
	movia r3, 0x06
	custom 0, r2, r0, r3
	movia r3, 0x01
	custom 0, r2, r0, r3
	br led1

# Nesta label a instrução customizada está sendo chamada novamente: 
# r3 indica que está sendo enviado um dado e r14 é o dado a ser escrito no display
menu_lcd:
	movi r7, 31
	stbio r7, 0(r6) # Apaga todas as colunas
	movi r7, 255
	stbio r7, 0(r13) # Apaga todas as linhas
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3
	movia r3, L
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, D
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	custom 0, r2, r14, r4
	ret
	
led1:
	movia r4, Um
	call menu_lcd # atualiza o display

	nextpc r8 # pega o endereço da próxima instrução
	addi r10, r0, 0
	movia r11, 400000
	call delay #chama label delay para captar apenas um sinal dos botões

	ldbuio r3, 0(r5) # carrega a situação dos botões
	addi r7, r0, 2
	beq r3, r7, frase_selection1 # se o valor dos botões for igual a 2 desvia para a label frase_selection1
	addi r7, r0, 4
	beq r3, r7, led2 # se o valor dos botões for igual a 4 desvia para a label led2 (rola pra baixo)
	addi r7, r0, 8
	beq r3, r7, led5 # se o valor dos botões for igual a 8 desvia para a label led5 (rola pra cima)
	callr r8

delay:
	addi r10, r10, 1
	ble r10, r11, delay
	ret

led2:
	movia r4, Dois	
	call menu_lcd

	nextpc r8
	addi r10, r0, 0
	movia r11, 400000
	call delay

	ldbuio r3, 0(r5) 
	addi r7, r0, 2
	beq r3, r7, frase_selection2
	addi r7, r0, 4
	beq r3, r7, led3 
	addi r7, r0, 8
	beq r3, r7, led1 
	callr r8
	
led3:
	movia r4, Tres
	call menu_lcd 
	
	nextpc r8
	addi r10, r0, 0
	movia r11, 400000
	call delay

	ldbuio r3, 0(r5) 
	addi r7, r0, 2
	beq r3, r7, frase_selection3
	addi r7, r0, 4
	beq r3, r7, led4 
	addi r7, r0, 8
	beq r3, r7, led2
	callr r8

led4:
	movia r4, Quatro
	call menu_lcd 
	
	nextpc r8
	addi r10, r0, 0
	movia r11, 400000
	call delay

	ldbuio r3, 0(r5) 
	addi r7, r0, 2
	beq r3, r7, frase_selection4
	addi r7, r0, 4
	beq r3, r7, led5 
	addi r7, r0, 8
	beq r3, r7, led3 
	callr r8

led5:
	movia r4, Cinco
	call menu_lcd 
	
	nextpc r8
	addi r10, r0, 0
	movia r11, 400000
	call delay

	ldbuio r3, 0(r5) 
	addi r7, r0, 2
	beq r3, r7, frase_selection5
	addi r7, r0, 4
	beq r3, r7, led1 
	addi r7, r0, 8
	beq r3, r7, led4 
	callr r8
	
frase_selection1:
	addi r7, r0, 30
	stbio r7, 0(r6) # colunas
	stbio r0, 0(r13) # linhas

	movia r3, clear
	custom 0, r2, r0, r3
	movia r3, Y
	custom 0, r2, r14, r3
	movia r3, O
	custom 0, r2, r14, r3
	movia r3, U
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, C
	custom 0, r2, r14, r3
	movia r3, H
	custom 0, r2, r14, r3
	movia r3, O
	custom 0, r2, r14, r3
	movia r3, S
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, L
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, D
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, Um
	custom 0, r2, r14, r3

	call send_at3
	
	nextpc r8
	ldbuio r3, 0(r5)
	beq r3, r14, led1
	callr r8

frase_selection2:
	movi r7, 29
	stbio r7, 0(r6) # colunas
	stbio r0, 0(r13) # linhas

	movia r3, clear
	custom 0, r2, r0, r3
	movia r3, Y
	custom 0, r2, r14, r3
	movia r3, O
	custom 0, r2, r14, r3
	movia r3, U
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, C
	custom 0, r2, r14, r3
	movia r3, H
	custom 0, r2, r14, r3
	movia r3, O
	custom 0, r2, r14, r3
	movia r3, S
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, L
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, D
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, Dois
	custom 0, r2, r14, r3

	call send_at3
	
	nextpc r8
	ldbuio r3, 0(r5)
	beq r3, r14, led2
	callr r8
	
frase_selection3:
	movi r7, 27
	stbio r7, 0(r6) # colunas
	stbio r0, 0(r13) # linhas

	movia r3, clear
	custom 0, r2, r0, r3
	movia r3, Y
	custom 0, r2, r14, r3
	movia r3, O
	custom 0, r2, r14, r3
	movia r3, U
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, C
	custom 0, r2, r14, r3
	movia r3, H
	custom 0, r2, r14, r3
	movia r3, O
	custom 0, r2, r14, r3
	movia r3, S
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, L
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, D
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, Tres
	custom 0, r2, r14, r3

	call send_at3
	
	nextpc r8
	ldbuio r3, 0(r5)
	beq r3, r14, led3
	callr r8
	
frase_selection4:
	movi r7, 23
	stbio r7, 0(r6) # colunas
	stbio r0, 0(r13) # linhas

	movia r3, clear
	custom 0, r2, r0, r3
	movia r3, Y
	custom 0, r2, r14, r3
	movia r3, O
	custom 0, r2, r14, r3
	movia r3, U
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, C
	custom 0, r2, r14, r3
	movia r3, H
	custom 0, r2, r14, r3
	movia r3, O
	custom 0, r2, r14, r3
	movia r3, S
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, L
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, D
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, Quatro
	custom 0, r2, r14, r3

	call send_at3
	
	nextpc r8
	ldbuio r3, 0(r5)
	beq r3, r14, led4
	callr r8
	
frase_selection5:
	movi r7, 15
	stbio r7, 0(r6) # colunas
	stbio r0, 0(r13) # linhas

	movia r3, clear
	custom 0, r2, r0, r3
	movia r3, Y
	custom 0, r2, r14, r3
	movia r3, O
	custom 0, r2, r14, r3
	movia r3, U
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, C
	custom 0, r2, r14, r3
	movia r3, H
	custom 0, r2, r14, r3
	movia r3, O
	custom 0, r2, r14, r3
	movia r3, S
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, L
	custom 0, r2, r14, r3
	movia r3, E
	custom 0, r2, r14, r3
	movia r3, D
	custom 0, r2, r14, r3
	movia r3, space
	custom 0, r2, r14, r3
	movia r3, Cinco
	custom 0, r2, r14, r3

	call send_at3
	
	nextpc r8
	ldbuio r3, 0(r5)
	beq r3, r14, led5
	callr r8