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

.equ A, 0x41
.equ T, 0x54
.equ W, 0x57
.equ J, 0x4A
.equ P, 0x50
.equ R, 0x52
.equ I, 0x49
.equ N, 0x4E
.equ plus, 0x2B
.equ minus, 0x2D
.equ equal, 0x3D
.equ bar, 0x2F 
.equ underline, 0x5F

esp_at_1: .ascii "AT+CWJAP_CUR="WLessLEDS","HelloWorldMP31""
esp_at_2: .ascii "AT+CIPSTART="TCP","IP","PORTA""
esp_at_3: .ascii "AT-CIPSEND=TAMMSG"

.text


# r2 guarda recebe os resultados da intrução customizada do lcd
# r3 guarda valores temporários 
# r4 guarda os números das leds a serem alterados no display (de acordo com a rolagem do menu) [
# r5 guarda o endereço de memória dos  botões
# r6 guarda o endereço de memória das colunas da matriz de leds
# r7 guarda valores temporários
# r8 guarda endereços de instruções temporariamente
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

	

init_esp1:

	movia r7, esp_at_1
	addi r10, r0, 41
	add r12, r0, r0

	nextpc r8

	add r3, r7, r12

	ldb r11, 0(r3)
	stbio r11, 0(r15)

	addi r12, r12, 1

	bgt r12, r10, init_esp2

	callr r8 

init_esp2:

	movia r7, esp_at_2
	addi r10, r0, 41
	add r12, r0, r0

	nextpc r8

	add r3, r7, r12

	ldb r11, 0(r3)
	stbio r11, 0(r15)

	addi r12, r12, 1

	bgt r12, r10, led1

	callr r8 

	# movia r3, A
	# stbio r3, 0(r15)

	# movia r3, T
	# stbio r3, 0(r14)

	# movia r3, plus
	# stbio r3, 0(r14)	

	# movia r3, C
	# stbio r3, 0(r14)

	# movia r3, W
	# stbio r3, 0(r14)

	# movia r3, J
	# stbio r3, 0(r14)	

	# movia r3, A
	# stbio r3, 0(r14)

	# movia r3, P
	# stbio r3, 0(r14)

	# movia r3, underline
	# stbio r3, 0(r14)	

	# movia r3, C
	# stbio r3, 0(r14)

	# movia r3, U
	# stbio r3, 0(r14)

	# movia r3, R
	# stbio r3, 0(r14)	

	# movia r3, equal
	# stbio r3, 0(r14)


	# ##
	# ## nome e senha?
	# ##

	# movia r3, A
	# stbio r3, 0(r14)

	# movia r3, T
	# stbio r3, 0(r14)

	# movia r3, plus
	# stbio r3, 0(r14)

	# movia r3, C
	# stbio r3, 0(r14)		
	
	# movia r3, I
	# stbio r3, 0(r14)

	# movia r3, P
	# stbio r3, 0(r14)	

	# movia r3, S
	# stbio r3, 0(r14)

	# movia r3, T
	# stbio r3, 0(r14)

	# movia r3, A
	# stbio r3, 0(r14)

	# movia r3, R
	# stbio r3, 0(r14)

	# movia r3, T
	# stbio r3, 0(r14)

	# movia r3, equal
	# stbio r3, 0(r14)

	# movia r3, T
	# stbio r3, 0(r14)

	# movia r3, C
	# stbio r3, 0(r14)

	# movia r3, P
	# stbio r3, 0(r14)

	# movia r3, 
	# stbio r3, 0(r14)

	# # ##
	# # ## ip e porta?]
	# # ##


# Nesta label a instrução customizada está sendo chamada novamente: 
# r3 indica que está sendo enviado um dado e r14 é o dado a ser escrito no display
	
menu_lcd:

	movi r7, 31
	stbio r7, 0(r6) # Apaga todas as colunas

	movi r7, 255
	stbio r7, 0(r13) # Apaga todas as linhas
	
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

	nextpc r8
	
	ldbuio r3, 0(r5)
	
	beq r3, r14, led1
	
	callr r8


frase_selection2:

	movi r7, 29
	stbio r7, 0(r6) # colunas

	stbio r0, 0(r13) # linhas
	
	nextpc r8
	
	ldbuio r3, 0(r5)
	
	beq r3, r14, led2
	
	callr r8
	
	
frase_selection3:

	movi r7, 27
	stbio r7, 0(r6) # colunas


	stbio r0, 0(r13) # linhas
	nextpc r8
	
	ldbuio r3, 0(r5)
	
	beq r3, r14, led3
	
	callr r8
	
	
frase_selection4:

	movi r7, 23
	stbio r7, 0(r6) # colunas


	stbio r0, 0(r13) # linhas

	nextpc r8
	
	ldbuio r3, 0(r5)
	
	beq r3, r14, led4
	
	callr r8
	
	
frase_selection5:

	movi r7, 15
	stbio r7, 0(r6) # colunas


	stbio r0, 0(r13) # linhas

	nextpc r8
	
	ldbuio r3, 0(r5)
	
	beq r3, r14, led5
	
	callr r8
	
