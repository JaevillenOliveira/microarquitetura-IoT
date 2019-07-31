.data
.global _start
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
.equ remain_bytes, 0x0D
.equ msb, 0x00
.equ lsb, 0x07
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

_start:
	addi r14, r0, 1
	movia r5, 0x3030 # endereço de memórios dos botões
	movia r6, 0x3020 # endereço de memória das colunas
	movia r13, 0x2010 # endereço de memória das linhas
	movia r15, 0x2030 # endereço de memória da uart
	
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

send_AT:
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x0D
	stwio r11, 0(r15)
	movia r11, 0x0A
	stwio r11, 0(r15)	
	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3
	call read_from_uart
	custom 0, r2, r14, r3

send_AT_RST:
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x2B
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x52
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x53
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x0D
	stwio r11, 0(r15)
	movia r11, 0x0A
	stwio r11, 0(r15)	
	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3	
	call read_from_uart
	custom 0, r2, r14, r3

send_AT_CWMODE:
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x2B
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x57
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x4D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x4F
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x44
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x45
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x5F
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x55
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x52
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x3D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x31
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x0D
	stwio r11, 0(r15)
	movia r11, 0x0A
	stwio r11, 0(r15)	
	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3	
	call read_from_uart
	custom 0, r2, r14, r3

send_AT_CIPMUX:
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x2B
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x49
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x50
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x4D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x55
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x58
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x3D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x30
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x0D
	stwio r11, 0(r15)
	movia r11, 0x0A
	stwio r11, 0(r15)	
	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3	
	call read_from_uart
	custom 0, r2, r14, r3


send_AT_CWJAP:
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x2B
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x57
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x4A
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x50
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x3D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x42
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, virgula
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Dois
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Dois
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Dois
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Dois
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x0D
	stwio r11, 0(r15)
	movia r11, 0x0A
	stwio r11, 0(r15)	
	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3	
	call read_from_uart
	custom 0, r2, r14, r3

send_AT_CIPSTART:
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x2B
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x49
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x50
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x53
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x52
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x3D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x50
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, virgula
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x31
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x39
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x32
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x2E
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x31
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x36
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x38
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x2E
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Quatro
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Tres
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x2E
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Tres
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x39
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, aspas
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, virgula
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x38
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x38
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Tres
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x0D
	stwio r11, 0(r15)
	movia r11, 0x0A
	stwio r11, 0(r15)	
	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3
	call read_from_uart	
	custom 0, r2, r14, r3

send_AT_CIPSEND_17:
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x2B
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x49
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x50
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x53
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x45
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x4E
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x44
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x3D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x37
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x0D
	stwio r11, 0(r15)
	movia r11, 0x0A
	stwio r11, 0(r15)	
	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3	
	call read_from_uart
	custom 0, r2, r14, r3

init_mqtt:	
	# FIDEX HEADER
	movia r11, 0x10 # CONNECT
	stwio r11, 0(r15)
	movia r11, 0x0F # REMAING LENGTH
	# VARIABLE HEADER
	stwio r11, 0(r15)
	movia r11, 0x00 # MSB
	stwio r11, 0(r15)	
	movia r11, 0x04 # LSB
	stwio r11, 0(r15)	
	movia r11, 0x4D # M
	stwio r11, 0(r15)
	movia r11, 0x51 # Q
	stwio r11, 0(r15)
	movia r11, 0x54 # T
	stwio r11, 0(r15)
	movia r11, 0x54 # T
	stwio r11, 0(r15)
	movia r11, 0x04 # PROTOCOL LEVEL
	stwio r11, 0(r15)
	movia r11, 0x02 # FLAGS
	stwio r11, 0(r15)
	movia r11, 0x00 # KEEP ALIVE MSB
	stwio r11, 0(r15)	
	movia r11, 0x0A # KEEP ALIVE LSB
	stwio r11, 0(r15)	
	#PAYLOAD
	movia r11, 0x00 #MSB
	stwio r11, 0(r15)
	movia r11, 0x03 #LSB
	stwio r11, 0(r15)	
	movia r11, 0x47 #G
	stwio r11, 0(r15)
	movia r11, 0x50 #P
	stwio r11, 0(r15)
	movia r11, 0x33 #3
	stwio r11, 0(r15)
	br led1

send_AT_CIPSEND_15:
	subi sp, sp, 4
	stw ra, 0(sp)
	movia r11, 0x41
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x2B
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x43
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x49
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x50
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x53
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x45
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, 0x4E
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x44
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x3D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, Um
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x35
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x0D
	stwio r11, 0(r15)
	movia r11, 0x0A
	stwio r11, 0(r15)	
	addi r10, r0, 0
	movia r11, 1000000
	call delay
	movia r3, clear # Limpa o display
	custom 0, r2, r0, r3	
	call read_from_uart
	custom 0, r2, r14, r3
	br send_mqtt

send_mqtt:
	movia r11, publish
	stwio r11, 0(r15)
	movia r11, remain_bytes
	stwio r11, 0(r15)
	movia r11, msb
	stwio r11, 0(r15)
	movia r11, lsb
	stwio r11, 0(r15)
	movia r11, S
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x54
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x6F
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x70
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x69
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, 0x63
	stwio r11, 0(r15)
	custom 0, r2, r14, r11	
	movia r11, L
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, E
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	movia r11, D
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	add r11, r0, r4
	stwio r11, 0(r15)
	custom 0, r2, r14, r11
	addi r10, r0, 0
	movia r11, 1000000
	call delay
	ldw ra, 0(sp)
	addi sp, sp, 8
	ret 

read_from_uart:
	ldwio r3, 0(r15)
	andi r7, r3, 0x8000
	bne r7, r0, read_from_uart_private
	mov r3, r0

read_from_uart_private:
	andi r7, r3, 0x00ff
	mov r3, r7
	ret

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
	
	call send_AT_CIPSEND_15
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

	call send_AT_CIPSEND_15
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
	
	call send_AT_CIPSEND_15
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

	call send_AT_CIPSEND_15
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
	
	call send_AT_CIPSEND_15
	nextpc r8
	ldbuio r3, 0(r5)
	beq r3, r14, led5
	callr r8
