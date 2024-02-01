;******************************************************************************
; Universidad Del Valle De Guatemala
; IE2023: Programación de Microcontroladores
; main.asm
; Autor: Samuel Tortola - 22094
; Proyecto: Laboratorio 1: Sumador de 4 bits
; Hardware: Atmega238p
; Creado: 25/01/2024
; Última modificación: 31/01/2024 
;******************************************************************************



;******************************************************************************
;ENCABEZADO
;******************************************************************************
.include "M328PDEF.inc"
.CSEG
.ORG 0x0000 //Iniciar en la posición 0


;******************************************************************************
;STACK POINTER
;******************************************************************************
LDI R16, LOW(RAMEND)  
OUT SPL, R16
 LDI R17, HIGH(RAMEND)
OUT SPH, R17


;******************************************************************************
;CONFIGURACIÓN
;******************************************************************************

SETUP:
	LDI R16, 0b1000_0000
	LDI R16, (1 << CLKPCE) //Corrimiento a CLKPCE
	STS CLKPR, R16        // Habilitando el prescaler 

	LDI R16, 0b0000_0100
	STS CLKPR, R16   //Frecuencia del sistema de 1MHz



;******************************************************************************
    LDI R16, 0b01111100  //Configurar el pin PD2, PD3, PD4, PD5, PD6 como entrada con pullup
	OUT PORTD, R16     //Habilitando el PULLUP en los pines
	LDI R16, 0b10000000
	OUT DDRD, R16  //Configurar PD2 a PD6 como entrada y PD7 como salida



    LDI R16, 0b00111111
	OUT DDRB, R16  //Colocar los pines PB0 - PB5 como salidas

	LDI R16, 0b0111111
	OUT DDRC, R16 //Colocar los pines PC0 - PC5 como salidas


	LDI R18, 1  //Suma o resta para el contador
	LDI R19, 0
	LDI R20, 0
	LDI R22, 0


LOOP:
	IN R16, PIND   //Obtener el estado del puerto D
	SBRS R16, PD2  //La instrucción salta si el bit PD2 está en 1
	RJMP DelayBounce1   //Antirrebote

	SBRS R16, PD3  //La instrucción salta si el bit PD3 está en 1
	RJMP DelayBounce12  //Antirrebote

	SBRS R16, PD4  //La instrucción salta si el bit PD4 está en 1
	RJMP DelayBounce121  //Antirrebote

	SBRS R16, PD5  //La instrucción salta si el bit PD5 está en 1
	RJMP DelayBounce122  //Antirrebote

	SBRS R16, PD6  //La instrucción salta si el bit PD6 está en 1
	RJMP DelayBounce7  //Antirrebote

	RJMP LOOP //salta de regreso al loop


;******************* CONTADOR 1**************************************
DelayBounce1:
	LDI R16, 255   //Cargar con un valor a R16
	delay:
		DEC R16 //Decrementa R16
		BRNE delay   //Si R16 no es igual a 0, tira al delay
	LDI R16, 255   //Cargar con un valor a R16
	delay1:
		DEC R16 //Decrementa R16
		BRNE delay1   //Si R16 no es igual a 0, tira al delay

		//Se vuelve a leer
	SBIS PIND, PD2    //La instrucción salta si el bit PD2 está en 1
	RJMP DelayBounce1  //Repetir verificación, hasta que sea estable el pulsador

	

	ADD R19, R18 //Incrementa el valor del registro 19


  
	CPI R19, 16   //Compara el registro 19 con un inmediato
	BREQ  tramp5  //Salta si el resgitro y la bandera Z es igual.
	CPI R19, 1   // Se hace esto para los 15 Números del contador
	BREQ CASE1
	CPI R19, 2
	BREQ CASE2
	CPI R19, 3
	BREQ CASE3
	CPI R19, 4
	BREQ CASE4
	CPI R19, 5
	BREQ CASE5
	CPI R19, 6
	BREQ tramp1177
	CPI R19, 7
	BREQ tramp10
	CPI R19, 8
	BREQ tramp9
	CPI R19, 9
	BREQ tramp8
	CPI R19, 10
	BREQ tramp7
	CPI R19, 11
	BREQ tramp6
	CPI R19, 12
	BREQ tramp4
	CPI R19, 13
	BREQ tramp2
	CPI R19, 14
	BREQ tramp1
	CPI R19, 15
	BREQ tramp3
	
	
	
	DEFAULT:       //Condicional switch-case
		RJMP DONE
	tramp1:
		RJMP CASE14
	tramp2:
		RJMP CASE13
	tramp3:
		RJMP CASE15
	tramp4:
		RJMP CASE12
	tramp5:
		RJMP conteo
	tramp6:
		RJMP CASE11
	tramp7:
		RJMP CASE10
	tramp8:
		RJMP CASE9
	tramp9:
		RJMP CASE8
	tramp10:
		RJMP CASE7
	tramp1177:
		RJMP CASE6
	CASE1:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000100  //Muestra el numero 1
	    OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

	CASE2:
		IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000010  //Muestra el numero 2
		OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

	CASE3:
	    IN R16, PINB
		OUT PINB, R16
	    LDI R16, 0b00000110  //Muestra el numero 3
	    OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

	CASE4:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000001  //Muestra el numero 4
		OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

	CASE5:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000101  //Muestra el numero 5
		OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

	CASE6:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000011  //Muestra el numero 6
		OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

	
	CASE7:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000111  //Muestra el numero 7
		OUT PINB, R16
		
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

	CASE8:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000000  //Muestra el numero 8
		OUT PINB, R16
		
		LDI R16, 0b10000000
		OUT PIND, R16
		RJMP DONE

    CASE9:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000100  //Muestra el numero 9
		OUT PINB, R16
		
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

     CASE10:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000010  //Muestra el numero 10
		OUT PINB, R16
		
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

	
     CASE11:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000110  //Muestra el numero 11
		OUT PINB, R16
		
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

	 CASE12:
	    IN R16, PINB
		OUT PINB, R16
	    LDI R16, 0b00000001  //Muestra el numero 12
	    OUT PINB, R16
		
	    LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

    CASE13:
	    IN R16, PINB
		OUT PINB, R16
	    LDI R16, 0b00000101  //Muestra el numero 13
	    OUT PINB, R16
		
	    LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

    CASE14:
	    IN R16, PINB
		OUT PINB, R16
	    LDI R16, 0b00000011  //Muestra el numero 14
	    OUT PINB, R16
		
	    LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE

    CASE15:
	    IN R16, PINB
		OUT PINB, R16
	    LDI R16, 0b00000111  //Muestra el numero 15
	    OUT PINB, R16
		
	    LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE
	conteo:
		LDI R16, 15
		MOV R19, R16


	DONE:
		LDI R24, 0b0000000 //Borrar el puertoC
	    OUT PORTC,R24
        RJMP switch1 //saltar para colocar el valor del contador 2 otra vez
		


	RJMP LOOP  //Regresar a LOOP




DelayBounce12:
	LDI R16, 255   //Cargar con un valor a R16
	delay12:
		DEC R16 //Decrementa R16
		BRNE delay12   //Si R16 no es igual a 0, tira al delay
	LDI R16, 255   //Cargar con un valor a R16
	delay111:
		DEC R16 //Decrementa R16
		BRNE delay111   //Si R16 no es igual a 0, tira al delay

		//Se vuelve a leer
	SBIS PIND, PD3    //La instrucción salta si el bit PD2 está en 1
	RJMP DelayBounce12  //Repetir verificación, hasta que sea estable el pulsador


	SUB R19, R18



	CPI R19, -1
	BREQ  tramp51
	CPI R19, 1
	BREQ CASE111
	CPI R19, 2
	BREQ CASE21
	CPI R19, 3
	BREQ CASE31
	CPI R19, 4
	BREQ CASE41
	CPI R19, 5
	BREQ CASE51
	CPI R19, 6
	BREQ tramp111
	CPI R19, 7
	BREQ tramp101
	CPI R19, 8
	BREQ tramp91
	CPI R19, 9
	BREQ tramp81
	CPI R19, 10
	BREQ tramp71
	CPI R19, 11
	BREQ tramp61
	CPI R19, 12
	BREQ tramp41
	CPI R19, 13
	BREQ tramp21
	CPI R19, 14
	BREQ tramp11
	CPI R19, 0
	BREQ tramp31
	
	
	
	DEFAULT1: 
		RJMP DONE1
	tramp11:
		RJMP CASE141
	tramp21:
		RJMP CASE131
	tramp31:
		RJMP CASE151
	tramp41:
		RJMP CASE121
	tramp51:
		RJMP conteo1
	tramp61:
		RJMP CASE1112
	tramp71:
		RJMP CASE101
	tramp81:
		RJMP CASE91
	tramp91:
		RJMP CASE81
	tramp101:
		RJMP CASE71
	tramp111:
		RJMP CASE61
	CASE111:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000100  //Muestra el numero 1
	    OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

	CASE21:
		IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000010  //Muestra el numero 2
		OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

	CASE31:
	    IN R16, PINB
		OUT PINB, R16
	    LDI R16, 0b00000110  //Muestra el numero 3
	    OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

	CASE41:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000001  //Muestra el numero 4
		OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

	CASE51:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000101  //Muestra el numero 5
		OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

	CASE61:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000011  //Muestra el numero 6
		OUT PINB, R16
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

	
	CASE71:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000111  //Muestra el numero 7
		OUT PINB, R16
		
		LDI R16, 0b10000000
		OUT PIND, R16
		RJMP DONE1

	CASE81:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000000  //Muestra el numero 8
		OUT PINB, R16
		
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

    CASE91:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000100  //Muestra el numero 9
		OUT PINB, R16
		
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

     CASE101:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000010  //Muestra el numero 10
		OUT PINB, R16
		
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

	
     CASE1112:
	    IN R16, PINB
		OUT PINB, R16
		LDI R16, 0b00000110  //Muestra el numero 11
		OUT PINB, R16
		
		LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

	 CASE121:
	    IN R16, PINB
		OUT PINB, R16
	    LDI R16, 0b00000001  //Muestra el numero 12
	    OUT PINB, R16
		
	    LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

    CASE131:
	    IN R16, PINB
		OUT PINB, R16
	    LDI R16, 0b00000101  //Muestra el numero 13
	    OUT PINB, R16
		
	    LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

    CASE141:
	    IN R16, PINB
		OUT PINB, R16
	    LDI R16, 0b00000011  //Muestra el numero 14
	    OUT PINB, R16
		
	    LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1

    CASE151:
	    IN R16, PINB
		OUT PINB, R16
	    LDI R16, 0b00000000  //Muestra el numero 0
	    OUT PINB, R16
		
	    LDI R16, 0b00000000
		OUT PIND, R16
		RJMP DONE1
	conteo1:
		LDI R16, 0
		MOV R19, R16


	DONE1:
		LDI R24, 0b0000000 //Borrar el puertoC
	    OUT PORTC,R24
	    RJMP switch1//saltar para colocar el valor del contador 2 otra vez
		


;******************* CONTADOR 2**************************************
DelayBounce121:
	LDI R16, 255   //Cargar con un valor a R16
	delay3:
		DEC R16 //Decrementa R16
		BRNE delay3   //Si R16 no es igual a 0, tira al delay
	LDI R16, 255   //Cargar con un valor a R16
	delay13:
		DEC R16 //Decrementa R16
		BRNE delay13   //Si R16 no es igual a 0, tira al delay
			

		//Se vuelve a leer
	SBIS PIND, PD4    //La instrucción salta si el bit PD4 está en 1
	RJMP DelayBounce121  //Repetir verificación, hasta que sea estable el pulsador


	ADD R20, R18 //Sumar al contador


  switch1:
	CPI R20, 16
	BREQ  tramp556
	CPI R20, 1
	BREQ CASE156
	CPI R20, 2
	BREQ CASE256
	CPI R20, 3
	BREQ CASE356
	CPI R20, 4
	BREQ CASE456
	CPI R20, 5
	BREQ CASE556
	CPI R20, 6
	BREQ CASE656
	CPI R20, 7
	BREQ CASE756
	CPI R20, 8
	BREQ CASE856
	CPI R20, 9
	BREQ ta2
	CPI R20, 10
	BREQ ta1
	CPI R20, 11
	BREQ ta
	CPI R20, 12
	BREQ tramp456
	CPI R20, 13
	BREQ tramp256
	CPI R20, 14
	BREQ tramp156
	CPI R20, 15
	BREQ tramp356
	
	
	
	
	DEFAULT56: 
		RJMP DONE56
	tramp156:
		RJMP CASE1456
	tramp256:
		RJMP CASE1356
	tramp356:
		RJMP CASE1556
	tramp456:
		RJMP CASE1256
	tramp556:
		RJMP conteo56
	ta:
		RJMP CASE1156
	ta1:
		RJMP CASE1056
	ta2:
		RJMP CASE956
	

	CASE156:
		IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00000010  //Muestra el numero 1
	    OUT PINC, R16
		RJMP DONE56

	CASE256:
		IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00000100  //Muestra el numero 2
		OUT PINC, R16
		RJMP DONE56

	CASE356:
	    IN R16, PINC
		OUT PINC, R16
	    LDI R16, 0b00000110  //Muestra el numero 3
	    OUT PINC, R16
		RJMP DONE56

	CASE456:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00001000  //Muestra el numero 4
		OUT PINC, R16
		RJMP DONE56

	CASE556:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00001010  //Muestra el numero 5
		OUT PINC, R16
		RJMP DONE56

	CASE656:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00001100  //Muestra el numero 6
		OUT PINC, R16
		RJMP DONE56

	
	CASE756:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00001110  //Muestra el numero 7
		OUT PINC, R16
		RJMP DONE56

	CASE856:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00010000  //Muestra el numero 8
		OUT PINC, R16
		RJMP DONE56

    CASE956:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00010010  //Muestra el numero 9
		OUT PINC, R16
		RJMP DONE56

     CASE1056:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00010100  //Muestra el numero 10
		OUT PINC, R16
		RJMP DONE56

	
     CASE1156:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00010110  //Muestra el numero 11
		OUT PINC, R16
		RJMP DONE56

	 CASE1256:
	    IN R16, PINC
		OUT PINC, R16
	    LDI R16, 0b00011000 //Muestra el numero 12
	    OUT PINC, R16
		RJMP DONE56

    CASE1356:
	    IN R16, PINC
		OUT PINC, R16
	    LDI R16, 0b00011010  //Muestra el numero 13
	    OUT PINC, R16
		RJMP DONE56

    CASE1456:
	    IN R16, PINC
		OUT PINC, R16
	    LDI R16, 0b00011100  //Muestra el numero 14
	    OUT PINC, R16
		RJMP DONE56

    CASE1556:
	    IN R16, PINC
		OUT PINC, R16
	    LDI R16, 0b00011110  //Muestra el numero 15
	    OUT PINC, R16
		RJMP DONE56

	conteo56:
		LDI R16, 15
		MOV R20, R16


	DONE56:
		
		RJMP LOOP


	RJMP LOOP  //Regresar a LOOP



DelayBounce122:
	LDI R16, 255   //Cargar con un valor a R16
	delay124:
		DEC R16 //Decrementa R16
		BRNE delay124   //Si R16 no es igual a 0, tira al delay
	LDI R16, 255   //Cargar con un valor a R16
	delay1114:
		DEC R16 //Decrementa R16
		BRNE delay1114   //Si R16 no es igual a 0, tira al delay

		//Se vuelve a leer
	SBIS PIND, PD5    //La instrucción salta si el bit PD5 está en 1
	RJMP DelayBounce122  //Repetir verificación, hasta que sea estable el pulsador

	SUB R20, R18 //Resta el contador



	CPI R20, -1  //Comparaciones 
	BREQ  tramp5178  //salta a cada caso según el conteo
	CPI R20, 1
	BREQ CASE11178
	CPI R20, 2
	BREQ CASE2178
	CPI R20, 3
	BREQ CASE3178
	CPI R20, 4
	BREQ CASE4178
	CPI R20, 5
	BREQ CASE5178
	CPI R20, 6
	BREQ tramp11178
	CPI R20, 7
	BREQ tramp10178
	CPI R20, 8
	BREQ tramp9178
	CPI R20, 9
	BREQ tramp8178
	CPI R20, 10
	BREQ tramp7178
	CPI R20, 11
	BREQ tramp6178
	CPI R20, 12
	BREQ tramp4178
	CPI R20, 13
	BREQ tramp2178
	CPI R20, 14
	BREQ tramp1178
	CPI R20, 0
	BREQ tramp3178
	
	
	
	DEFAULT178: 
		RJMP DONE178
	tramp1178:
		RJMP CASE14178
	tramp2178:
		RJMP CASE13178
	tramp3178:
		RJMP CASE15178
	tramp4178:
		RJMP CASE12178
	tramp5178:
		RJMP conteo178
	tramp6178:
		RJMP CASE111278
	tramp7178:
		RJMP CASE10178
	tramp8178:
		RJMP CASE9178
	tramp9178:
		RJMP CASE8178
	tramp10178:
		RJMP CASE7178
	tramp11178:
		RJMP CASE6178
	CASE11178:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00000010  //Muestra el numero 1
	    OUT PINC, R16
		RJMP DONE178

	CASE2178:
		IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00000100  //Muestra el numero 2
		OUT PINC, R16
		RJMP DONE178

	CASE3178:
	    IN R16, PINC
		OUT PINC, R16
	    LDI R16, 0b00000110  //Muestra el numero 3
	    OUT PINC, R16
		RJMP DONE178

	CASE4178:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00001000  //Muestra el numero 4
		OUT PINC, R16
		RJMP DONE178

	CASE5178:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00001010  //Muestra el numero 5
		OUT PINC, R16
		RJMP DONE178

	CASE6178:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00001100  //Muestra el numero 6
		OUT PINC, R16
		RJMP DONE178

	
	CASE7178:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00001110  //Muestra el numero 7
		OUT PINC, R16
		RJMP DONE178

	CASE8178:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00010000   //Muestra el numero 8
		OUT PINC, R16
		RJMP DONE178

    CASE9178:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00010010  //Muestra el numero 9
		OUT PINC, R16
		RJMP DONE178

     CASE10178:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00010100   //Muestra el numero 10
		OUT PINC, R16
		RJMP DONE178

	
     CASE111278:
	    IN R16, PINC
		OUT PINC, R16
		LDI R16, 0b00010110 //Muestra el numero 11
		OUT PINC, R16
		RJMP DONE178

	 CASE12178:
	    IN R16, PINC
		OUT PINC, R16
	    LDI R16, 0b00011000 //Muestra el numero 12
	    OUT PINC, R16
		RJMP DONE178

    CASE13178:
	    IN R16, PINC
		OUT PINC, R16
	    LDI R16, 0b00011010  //Muestra el numero 13
	    OUT PINC, R16
		RJMP DONE178

    CASE14178:
	    IN R16, PINC
		OUT PINC, R16
	    LDI R16, 0b00011100  //Muestra el numero 14
	    OUT PINC, R16
		RJMP DONE178

    CASE15178:
	    IN R16, PINC
		OUT PINC, R16
	    LDI R16, 0b00000000  //Muestra el numero 0
	    OUT PINC, R16
		RJMP DONE178

	conteo178:
		LDI R16, 0
		MOV R20, R16


	DONE178:
		
		RJMP LOOP


	RJMP LOOP  //Regresar a LOOP



//********************************************SUMA CON ACARREO DE LOS DOS CONTADORES**********************************************************

DelayBounce7: //Función que suma con acarreo
	LDI R16, 255   //Cargar con un valor a R16
	delay222:
		DEC R16 //Decrementa R16
		BRNE delay222   //Si R16 no es igual a 0, tira al delay
	LDI R16, 255   //Cargar con un valor a R16
	delay333:
		DEC R16 //Decrementa R16
		BRNE delay333   //Si R16 no es igual a 0, tira al delay

		//Se vuelve a leer
	SBIS PIND, PD6    //La instrucción salta si el bit PD2 está en 1
	RJMP DelayBounce7  //Repetir verificación, hasta que sea estable el pulsador

	MOV R22, R19
	ADC R22, R20 //Suma con acarreo


	
	CPI R22, 1   //Comparar cada suma para verificar que LED encender
	BREQ CASE1569
	CPI R22, 2
	BREQ CASE2569
	CPI R22, 3
	BREQ CASE3569
	CPI R22, 4
	BREQ CASE4569
	CPI R22, 5
	BREQ CASE5569
	CPI R22, 6
	BREQ tamp5
	CPI R22, 7
	BREQ tamp4
	CPI R22, 8
	BREQ tamp3
	CPI R22, 9
	BREQ tamp2
	CPI R22, 10
	BREQ tamp1
	CPI R22, 11
	BREQ tamp
	CPI R22, 12
	BREQ tramp4569
	CPI R22, 13
	BREQ tramp2569
	CPI R22, 14
	BREQ tramp1569
	CPI R22, 15
	BREQ tramp3569
	CPI R22, 0
	BREQ tramp356910
	CPI R22, 16
	BRSH acarreo //Salta si es mayor o igual

	
	
	
	DEFAULT569:                 //Comienza switch-case
		RJMP DONE569
	tramp1569:       //Saltos para no sobrepasara los saltos de la instrucción BREQ
		RJMP CASE14569 
	tramp2569:
		RJMP CASE13569
	tramp3569:
		RJMP CASE15569
	tramp4569:
		RJMP CASE12569
	tramp356910:
		RJMP CASEM
	tamp:
		RJMP CASE11569
	tamp1:
		RJMP CASE10569
	tamp2:
		RJMP CASE9569
	tamp3:
		RJMP CASE8569
	tamp4:
		RJMP CASE7569
	tamp5:
		RJMP CASE6569
	acarreo:
		RJMP acarreos

	CASE1569:    //Muestra numero 1
		SBI PINB, PB3 // SBI pone a 1 el bit de un registro
		CBI PINB, PB4 //CBI pone a 0 el bit de un registro
		CBI PINB, PB5
		CBI PINC, PC0
		CBI PINC, PC5
		RJMP DONE569

	CASE2569:   //Muestra numero 2
		CBI PINB, PB3
		SBI PINB, PB4
		CBI PINB, PB5
		CBI PINC, PC0
		CBI PINC, PC5
		RJMP DONE569

	CASE3569://Muestra el numero 3
		SBI PINB, PB3
		SBI PINB, PB4
		CBI PINB, PB5
		CBI PINC, PC0
		CBI PINC, PC5
		RJMP DONE569

	CASE4569://Muestra el numero 4
		CBI PINB, PB3
		CBI PINB, PB4
		SBI PINB, PB5
		CBI PINC, PC0
		CBI PINC, PC5
		RJMP DONE569

	CASE5569: //Muestra el numero 5
		SBI PINB, PB3 
		SBI PINB, PB5
		CBI PINB, PB4
		CBI PINC, PC0
		CBI PINC, PC5
		RJMP DONE569

	CASE6569://Muestra el numero 6
	    SBI PINB, PB4
		SBI PINB, PB5
		CBI PINB, PB3
		CBI PINC, PC0
		CBI PINC, PC5
		RJMP DONE569

	
	CASE7569://Muestra el numero 7
	    SBI PINB, PB3
		SBI PINB, PB4
		SBI PINB, PB5
		CBI PINC, PC0
		CBI PINC, PC5
		RJMP DONE569

	CASE8569://Muestra el numero 8
	   SBI PINC, PC0
	   CBI PINB, PB3
	   CBI PINB, PB4
	   CBI PINB, PB5
	   CBI PINC, PC5
		RJMP DONE569

    CASE9569: //Muestra el numero 9
	    SBI PINC, PC0
		SBI PINB, PB3
		CBI PINB, PB4
		CBI PINB, PB5
		CBI PINC, PC5
		RJMP DONE569

     CASE10569://Muestra el numero 10
		SBI PINC, PC0
		SBI PINB, PB4
		CBI PINB, PB3
		CBI PINB, PB5
		CBI PINC, PC5
		RJMP DONE569

	
     CASE11569://Muestra el numero 11
	    SBI PINC, PC0
		CBI PINB, PB5
		SBI PINB, PB4
		SBI PINB, PB3
		CBI PINC, PC5
		RJMP DONE569

	 CASE12569://Muestra el numero 12
		SBI PINC, PC0
		SBI PINB, PB5
		CBI PINB, PB4
		CBI PINB, PB3
		CBI PINC, PC5
		RJMP DONE569

    CASE13569://Muestra el numero 13
	    SBI PINC, PC0
		SBI PINB, PB5
		SBI PINB, PB3
		CBI PINB, PB4
		CBI PINC, PC5
		RJMP DONE569

    CASE14569: //Muestra el numero 14
	    CBI PINB, PB3
		SBI PINB, PB4
		SBI PINB, PB5
		SBI PINC, PC0
		CBI PINC, PC5
		RJMP DONE569

    CASE15569:  //Muestra el numero 15
	    SBI PINB, PB3
	    SBI PINB, PB4
	    SBI PINB, PB5
	    SBI PINC, PC0
		CBI PINC, PC5
		RJMP DONE569

	CASEM:   //Muestra el numero 0
		CBI PINB, PB3
		CBI PINB, PB4
		CBI PINB, PB5
		CBI PINC, PC0
		CBI PINC, PC5
		RJMP DONE569

	acarreos:  //Si la suma es mayor a 15, enciende el bit de acarreo
		CBI PINB, PB3
		CBI PINB, PB4
		CBI PINB, PB5
		CBI PINC, PC0
		SBI PINC, PC5
		RJMP DONE569

	
	DONE569:
		
		RJMP LOOP //Regresa a LOOP
		

	RJMP LOOP  //Regresar a LOOP

