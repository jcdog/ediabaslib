		;Select your processor
		LIST      P=18F25K80		; modify this
		#include "p18f25k80.inc"		; and this

		#define ORIGINAL    0

		#if ORIGINAL
		    #define SW_VERSION 000h
		    #define CODE_OFFSET 00000h
		    #define BASE_ADDR 00000h
		    #define DATA_OFFSET BASE_ADDR
		    #define TABLE_OFFSET BASE_ADDR
		    #define EEPROM_PAGE 0
		    #define WDT_RESET   0
		    #define DEFAULT_BAUD 068h		;38400
		#else
		    #define SW_VERSION 001h
		    #define CODE_OFFSET 00800h
		    #define BASE_ADDR 01000h
		    #define DATA_OFFSET BASE_ADDR
		    #define TABLE_OFFSET BASE_ADDR
		    #define EEPROM_PAGE 3
		    #define WDT_RESET   1

		    #if ADAPTER_TYPE == 0x02
			#define DEFAULT_BAUD 068h	;38400
		    #else
			#define DEFAULT_BAUD 023h	;115200
		    #endif
		#endif

		; CONFIG1L
		CONFIG RETEN = ON       ; VREG Sleep Enable bit (Ultra low-power regulator is Enabled (Controlled by SRETEN bit))
		CONFIG INTOSCSEL = HIGH ; LF-INTOSC Low-power Enable bit (LF-INTOSC in High-power mode during Sleep)
		CONFIG SOSCSEL = DIG    ; SOSC Power Selection and mode Configuration bits (Digital (SCLKI) mode)
		CONFIG XINST = OFF      ; Extended Instruction Set (Disabled)

		; CONFIG1H
		CONFIG FOSC = HS1       ; Oscillator (HS oscillator (Medium power, 4 MHz - 16 MHz))
		CONFIG PLLCFG = ON      ; PLL x4 Enable bit (Enabled)
		CONFIG FCMEN = OFF      ; Fail-Safe Clock Monitor (Disabled)
		CONFIG IESO = OFF       ; Internal External Oscillator Switch Over Mode (Disabled)

		; CONFIG2L
		CONFIG PWRTEN = ON      ; Power Up Timer (Enabled)
		CONFIG BOREN = SBORDIS  ; Brown Out Detect (Enabled in hardware, SBOREN disabled)
		CONFIG BORV = 0         ; Brown-out Reset Voltage bits (3.0V)
		CONFIG BORPWR = HIGH    ; BORMV Power level (BORMV set to high power level)

		; CONFIG2H
		CONFIG WDTEN = ON       ; Watchdog Timer (WDT controlled by SWDTEN bit setting)
		CONFIG WDTPS = 128      ; Watchdog Postscaler (1:128)

		; CONFIG3H
		CONFIG CANMX = PORTB    ; ECAN Mux bit (ECAN TX and RX pins are located on RB2 and RB3, respectively)
		CONFIG MSSPMSK = MSK7   ; MSSP address masking (7 Bit address masking mode)
		CONFIG MCLRE = ON       ; Master Clear Enable (MCLR Enabled, RE3 Disabled)

		; CONFIG4L
		CONFIG STVREN = ON      ; Stack Overflow Reset (Enabled)
		CONFIG BBSIZ = BB1K     ; Boot Block Size (1K word Boot Block size)

		; CONFIG5L
		CONFIG CP0 = OFF        ; Code Protect 00800-01FFF (Disabled)
		CONFIG CP1 = OFF        ; Code Protect 02000-03FFF (Disabled)
		CONFIG CP2 = OFF        ; Code Protect 04000-05FFF (Disabled)
		CONFIG CP3 = OFF        ; Code Protect 06000-07FFF (Disabled)

		; CONFIG5H
		CONFIG CPB = OFF        ; Code Protect Boot (Disabled)
		CONFIG CPD = OFF        ; Data EE Read Protect (Disabled)

		; CONFIG6L
		CONFIG WRT0 = OFF       ; Table Write Protect 00800-01FFF (Disabled)
		CONFIG WRT1 = OFF       ; Table Write Protect 02000-03FFF (Disabled)
		CONFIG WRT2 = OFF       ; Table Write Protect 04000-05FFF (Disabled)
		CONFIG WRT3 = OFF       ; Table Write Protect 06000-07FFF (Disabled)

		; CONFIG6H
		CONFIG WRTC = ON        ; Config. Write Protect (Enabled)
		CONFIG WRTB = ON        ; Table Write Protect Boot (Enabled)
		CONFIG WRTD = OFF       ; Data EE Write Protect (Disabled)

		; CONFIG7L
		CONFIG EBTR0 = OFF      ; Table Read Protect 00800-01FFF (Disabled)
		CONFIG EBTR1 = OFF      ; Table Read Protect 02000-03FFF (Disabled)
		CONFIG EBTR2 = OFF      ; Table Read Protect 04000-05FFF (Disabled)
		CONFIG EBTR3 = OFF      ; Table Read Protect 06000-07FFF (Disabled)

		; CONFIG7H
		CONFIG EBTRB = OFF      ; Table Read Protect Boot (Disabled)

		; EEPROM
#if SW_VERSION == 0
		ORG 0F00000h + (EEPROM_PAGE * 0100h)
#else
		ORG 0000400h
#endif
eep_start	DB 0FFh, 000h, 000h, 000h, 000h, 000h, 000h, 0FFh, 006h, 0AEh, 002h, 06Ah, 0FFh, 0FFh, 0FFh, 0FFh
		DB 0FFh, 0FFh, 032h, 0FFh, 001h, 0FFh, 0FFh, 0FFh, 0F1h, 0FFh, 009h, 0FFh, 0FFh, 0FFh, 000h, 0FFh
		DB 00Ah, 0FFh, 0FFh, 0FFh, DEFAULT_BAUD, 0FFh, 00Dh, 0FFh, 09Ah, 0FFh, 0FFh, 0FFh, 00Dh, 0FFh, 000h, 0FFh
		DB 0FFh, 0FFh, 032h, 0FFh, 0FFh, 0FFh, 00Ah, 0FFh, 0FFh, 0FFh, 092h, 0FFh, 000h, 0FFh, 028h, 0FFh
		DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
		DB 0FFh, 0FFh, 0FFh, 0FFh, 000h, 0FFh, 000h, 0FFh, 000h, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
		DB 038h, 0FFh, 002h, 0FFh, 0E0h, 0FFh, 004h, 0FFh, 080h, 0FFh, 00Ah, 0FFh
#if SW_VERSION == 0
		DB 000h, 000h, 000h, 000h
		DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh,
#else
		DB 0FFh, 0FFh, 0FFh, 0FFh
		DB "D", "E", "E", "P", "O", "B", "D", " ", 030h + (SW_VERSION / 16), 030h + (SW_VERSION % 16)
		DB 030h + (ADAPTER_TYPE / 16), 030h + (ADAPTER_TYPE % 16)
#endif
		DB 0FFh, 000h, 0FFh, 0FFh

#if SW_VERSION != 0
eep_end
eep_copy	movlw	024h
		movwf	EEADR
		call	p__838
		xorlw	DEFAULT_BAUD
		bnz	eep_init

		movlw	078h
		movwf	EEADR
		call	p__838
		xorlw	030h + (SW_VERSION / 16)
		bnz	eep_init

		movlw	079h
		movwf	EEADR
		call	p__838
		xorlw	030h + (SW_VERSION % 16)
		bnz	eep_init

		movlw	07Ah
		movwf	EEADR
		call	p__838
		xorlw	030h + (ADAPTER_TYPE / 16)
		bnz	eep_init

		movlw	07Bh
		movwf	EEADR
		call	p__838
		xorlw	030h + (ADAPTER_TYPE % 16)
		bnz	eep_init
		return

eep_init	movlw   low(eep_start)
		movwf   TBLPTRL
		movlw   high(eep_start)
		movwf   TBLPTRH
		movlw   upper(eep_start)
		movwf   TBLPTRU
		bsf	EECON1,2
		movlw	000h
		movwf	EEADR
eep_loop	tblrd   *+
	        movf    TABLAT, W
		call	p__A00
		movf    EEADR, W
		xorlw	low(eep_end - eep_start)
		bnz	eep_loop
		bcf	EECON1,2

		movlw	high(DATA_OFFSET) + 0
		movwf	TBLPTRH
		clrf	TBLPTRU
		return
#endif

#if ORIGINAL == 0
		ORG 07FFAh
		DATA 00015h		; adapter version
		DATA ADAPTER_TYPE	; adapter type
#endif

		ORG CODE_OFFSET + 0
		nop
		goto	p_1654

		ORG CODE_OFFSET + 008h
		btfsc	1Ch,7
		goto	p_1280
p____E	movlw	70h						; entry from: 18h
		goto	p__6CC

		ORG CODE_OFFSET + 018h
		bra		p____E

		ORG DATA_OFFSET + 0001Ah
		DATA "ACT ALERT"
		DATA "OBDII to RS232 Interpreter", 0
		DATA "BUFFER FULL"
		DATA "BUS BUSY", 0
		DATA "BUS ERROR"
		DATA "BUS INIT: ", 0
		DATA "CAN ERROR"
		DATA "<DATA ERROR"
		DATA "ELM327 v1.5"
		DATA "?"
		DATA "FB ERROR", 0
		DATA "UNABLE TO CONNECT"
		DATA "NO DATA"
		DATA "OK", 0
		DATA ">"
		DATA "SEARCHING...", 0
		DATA "STOPPED"
		DATA ">AT MA", 0
		DATA "<RX ERROR"
		DATA "LV RESET", 0

		ORG TABLE_OFFSET + 000F0h
		DATA "0123456789ABCDEF"
p__100	addwf	PCL						; entry from: 1AECh
		DB "Z", 000h
#if WDT_RESET
		goto	p_reset
#else
		clrf	0D1h,BANKED
		reset
#endif
		DB "I", 000h
		goto	p_182A
		DB "D", 000h
		goto	p__3B2
		DB 000h, 000h
		DB "A", "L"
		bsf		17h,4
		bra		p__302
		DB "A", "R"
		goto	p__CA0
		DB "B", "D"
		goto	p__CAA
		DB "B", "I"
		goto	p__CC4
		DB "C", "S"
		goto	p__E60
		DB "D", "0"
		bcf		18h,5
		bra		p__302
		DB "D", "1"
		bsf		18h,5
		bra		p__302
		DB "D", "P"
		goto	p__F40
		DB "E", "0"
		bcf		17h,2
		bra		p__302
		DB "E", "1"
		bsf		17h,2
		bra		p__302
		DB "F", "E"
		clrf	0D2h,BANKED
		bra		p__302
		DB "F", "I"
		goto	p_1104
		DB "H", "0"
		bcf		17h,1
		bra		p__302
		DB "H", "1"
		bsf		17h,1
		bra		p__302
		DB "J", "E"
		bcf		35h,2
		bra		p__302
		DB "J", "S"
		bsf		35h,2
		bra		p__302
		DB "K", "W"
		goto	p_11BC
		DB "L", "0"
		bcf		17h,7
		bra		p__302
		DB "L", "1"
		bsf		17h,7
		bra		p__302
		DB "L", "P"
		goto	p_11F8
		DB "M", "0"
		bcf		17h,5
		bra		p__302
		DB "M", "1"
		bsf		17h,5
		bra		p__302
		DB "M", "A"
		goto	p_129A
		DB "N", "L"
		bcf		17h,4
		bra		p__302
		DB "P", "C"
		goto	p_12E0
		DB "R", "0"
		bcf		17h,3
		bra		p__302
		DB "R", "1"
		bsf		17h,3
		bra		p__302
		DB "R", "D"
		goto	p_146E
		DB "R", "V"
		goto	p_148A
		DB "S", "0"
		bsf		18h,0
		bra		p__302
		DB "S", "1"
		bcf		18h,0
		bra		p__302
		DB "S", "I"
		goto	p_156E
		DB "S", "S"
		bsf		10h,5
		bra		p__302
		DB "V", "0"
		bcf		35h,5
		bra		p__302
		DB "V", "1"
		bsf		35h,5
		bra		p__302
		DB "W", "S"
		goto	p_1650
		DB "@", "1"
		goto	p__C3C
		DB "@", "2"
		goto	p__C42
		DB 000h, 000h

		ORG TABLE_OFFSET + 00200h
		addwf	PCL
		DB "A", "T"
		goto	p__C1E
		DB "C", "E"
		goto	p__D76
		DB "D", "M"
		goto	p__F22
		DB "D", "P"
		goto	p_101A
		DB "I", "G"
		goto	p_1184
		DB "K", "W"
		goto	p_11AA
		DB "P", "P"
		goto	p_13F4
		DB "R", "T"
		goto	p_147A
		DB "S", "P"
		goto	p_15AE
		DB "T", "P"
		goto	p_15AE
		DB 000h, 000h
		DB "C", "A"
		goto	p__D5C
		DB "C", "F"
		goto	p__DAC
		DB "C", "P"
		goto	p__DF2
		DB "I", "B"
		goto	p_110C
		DB "I", "F"
		goto	p_1148
		DB "M", "R"
		goto	p_12BA
		DB "M", "T"
		goto	p_12C2
		DB "R", "A"
		goto	p_157E
		DB "S", "P"
		goto	p_15DE
		DB "T", "A"
		goto	p_15A6
		DB "T", "P"
		goto	p_15DE
		DB "S", "D"
		goto	p_152E
		DB "S", "R"
		goto	p_157E
		DB "S", "T"
		goto	p_1586
		DB "S", "W"
		goto	p_1592
		DB 000h, 000h
		DB "B", "R"
		goto	p__CD8
		DB "C", "F"
		goto	p__D80
		DB "C", "M"
		goto	p__DC6
		DB "C", "E"
		goto	p_1536
		DB "I", "I"
		goto	p_112C
		DB "S", "H"
		goto	p_1558
		DB 000h, 000h
		DB "C", "R"
		goto	p__E02
		DB "C", "V"
		goto	p__EB2
		DB "M", "P"
		goto	p_12A2
		DB "P", "B"
		goto	p_12CE
		DB "P", "P"
		goto	p_12E6
		DB 000h, 000h
		DB "P", "P"
		goto	p_12FA
		DB 000h, 000h
		DB "M", "P"
		goto	p_12AC
		DB "P", "P"
		goto	p_1312
		DB "S", "H"
		goto	p_1546
		DB 000h, 000h

		ORG TABLE_OFFSET + 00300h
		addwf	PCL
p__302	goto	p__E9E					; entry from: 11Ah,138h,13Eh,14Ah,150h,156h,162h,168h,16Eh,174h,180h,186h,192h,198h,1A4h,1B0h,1B6h,1C8h,1CEh,1DAh,1E0h,1E6h,3BAh,3C4h
		DB "C", "F"
		goto	p__D92
		DB "C", "M"
		goto	p__DD8
		DB 000h, 000h
		DB "C", "R"
		goto	p__E24
		DB 000h, 000h
		DB "@", "3"
		goto	p__C72
		DB 000h, 000h
text_table2
		DATA "AUTO", 0
		DATA "SAE J1850 PWM"
		DATA "SAE J1850 VPW"
		DATA "ISO 9141-2", 0
		DATA "ISO 14230-4 (KWP 5BAUD)"
		DATA "ISO 14230-4 (KWP FAST)", 0
		DATA "ISO 15765-4"
		DATA "SAE J1939"
		DATA "USER1"
		DATA "USER2"
		DATA " (CAN ", 0
		DATA "ERR71"

p__3B2	btfss	17h,7					; entry from: 110h
		bra		p__3BC
		call	p__A1E
		bra		p__302
p__3BC	call	p__A1E					; entry from: 3B4h
		call	p__724
		bra		p__302

		ORG BASE_ADDR + 003C6h
p__3C6	clrf	2Fh						; entry from: 0FF2h,14EEh
		clrf	30h
		movlw	3
		movwf	7Ah,BANKED
		movlw	0E8h
		movwf	7Bh,BANKED
		call	p__AE2
		movff	7Dh,44h
		iorlw	0
		bz		p__3E0
		retlw	0FFh
p__3E0	movwf	7Ah,BANKED				; entry from: 3DCh
		movlw	64h
		movwf	7Bh,BANKED
		call	p__AE2
		movff	7Dh,30h
		movff	44h,2Fh
		clrf	7Dh,BANKED
		movlw	0Ah
p__3F6	incf	7Dh,f,BANKED			; entry from: 3FAh
		subwf	32h
		bc		p__3F6
		addwf	32h
		decf	7Dh,W,BANKED
		movwf	31h
		retlw	0

p__404	movwf	3Fh						; entry from: 1B42h,1B48h,1B5Eh,1DB2h
		tstfsz	3Fh
		bra		p__66A
		return	

p__40C	btfss	72h,1,BANKED			; entry from: 18ACh,18E8h,1E4Ch,1E5Ah,1EFAh,1F04h,2DA6h,2DC4h,2DC8h,2F82h,2F98h,2FA0h,2FB0h,2FFEh,3012h,302Ch,3038h,305Eh,3062h
		btfss	PIR1,5
		bra		p__476
		btfsc	72h,0,BANKED
		bra		p__478
		clrf	20h
		bcf		LATB,4
		movf	RCSTA1,W
		andlw	6
		bnz		p__47A
		movff	FSR0L,41h
		movff	74h,FSR0L
		movf	RCREG1,W
		movwf	INDF0
		btfss	17h,2
		bra		p__472
		movwf	POSTINC1
		bcf		FSR1H,0
		movf	FSR1L,W
		xorwf	FSR2L,W
		bz		p__470
p__43A	movf	8Bh,W,BANKED			; entry from: 474h
		xorwf	INDF0,W
		bz		p__484
		movlw	20h
		cpfsgt	INDF0
		bra		p__48A
		btfss	72h,7,BANKED
		bra		p__45A
		movlw	71h
		cpfslt	FSR0L
		bra		p__468
		incf	FSR0L,W
		movwf	74h,BANKED
		movff	41h,FSR0L
		retlw	0
p__45A	movlw	0B0h					; entry from: 448h
		movwf	72h,BANKED
		incf	FSR0L,W
		movwf	74h,BANKED
		movff	41h,FSR0L
		retlw	0
p__468	bsf		72h,6,BANKED			; entry from: 44Eh
		movff	41h,FSR0L
		retlw	0
p__470	bra		p__7FC					; entry from: 438h
p__472	bra		p__474					; entry from: 42Eh
p__474	bra		p__43A					; entry from: 472h
p__476	bra		p__478					; entry from: 410h

p__478	bra		p__652					; entry from: 414h,476h
p__47A	bcf		RCSTA1,4				; entry from: 41Eh
		movf	RCREG1,W
		bra		p__480
p__480	bsf		RCSTA1,4				; entry from: 47Eh
		bra		p__5D4
p__484	bsf		72h,0,BANKED			; entry from: 43Eh
		btfss	1Ch,7
		bsf		LATC,5
p__48A	movff	41h,FSR0L				; entry from: 444h
		goto	p__B46
p__492	call	p__B28					; entry from: 16FAh
		btfsc	PORTB,7
		return	
		movlw	68h
		movwf	TRISB
		movlw	0FCh
		movwf	LATB
		call	p__B3E
		btfsc	PORTB,7
		return	
		movlw	0E8h
		movwf	TRISB
		setf	0CDh,BANKED
		movlw	30h
		movwf	41h
		movlw	0Ch
		iorlw	1
		movwf	EEADR
		bsf		EECON1,2
p__4BC	clrf	42h						; entry from: 4E4h
		clrf	43h
		setf	EEDATA
		movlw	55h
		movwf	EECON2
		movlw	0AAh
		movwf	EECON2
		bsf		EECON1,1

p__4CC	decfsz	43h						; entry from: 4CEh,4DCh
		bra		p__4CC
		decfsz	42h
		bra		p__4DA
p__4D4	movlw	81h						; entry from: 0A14h
		movwf	0D1h,BANKED
#if WDT_RESET
		goto	p_reset
#else
		reset
#endif
p__4DA	btfsc	EECON1,1					; entry from: 4D2h
		bra		p__4CC
		incf	EEADR
		incf	EEADR
		decfsz	41h
		bra		p__4BC
		bcf		EECON1,2
		movlw	3Ch
		movwf	41h
p__4EC	movlw	0E8h					; entry from: 512h
		movwf	TRISB
		dcfsnz	41h
		bra		p__526
		movlw	0ECh
		movwf	LATB
		call	p__B2A
		movlw	0FCh
		movwf	LATB
		call	p__B26
		movlw	68h
		movwf	TRISB
		movlw	0FCh
		movwf	LATB
		call	p__B3E
		btfss	PORTB,7
		bra		p__4EC
		movlw	0E8h
		movwf	TRISB
		movlw	8
p__51A	movwf	41h						; entry from: 528h
p__51C	call	p__B2A					; entry from: 522h
		decfsz	41h
		bra		p__51C
		return	
p__526	movlw	64h						; entry from: 4F2h
		bra		p__51A

p__52A	movwf	42h						; entry from: 13E2h,19AEh
		movlw	47h
		cpfslt	42h
		retlw	0FFh
		movlw	40h
		cpfsgt	42h
		bra		p__53C
		movlw	37h
		bra		p__54A
p__53C	movlw	3Ah						; entry from: 536h
		cpfslt	42h
		retlw	0FFh
		movlw	2Fh
		cpfsgt	42h
		retlw	0FFh
		movlw	30h
p__54A	subwf	42h,W					; entry from: 53Ah
		return	

p__54E	nop								; entry from: 2522h,298Ch,2ECCh
		btfss	1Bh,7
		bra		p__5BA
		movlw	3
		cpfsgt	0
		bra		p__57E
		btfsc	11h,4
		bra		p__57A
		movf	15h,W
		cpfseq	2
		bra		p__56C
		movlw	80h
		btfsc	11h,6
		movlw	10h
		bra		p__5CC
p__56C	xorwf	3,W						; entry from: 562h
		movlw	10h
		btfsc	STATUS,2
		btfss	11h,5
		movlw	80h
		movwf	1Bh
		bra		p__5D2
p__57A	movlw	10h						; entry from: 55Ch
		bra		p__5C6
p__57E	btfss	17h,1					; entry from: 558h
		bra		p__5C2
		cpfslt	0
		bra		p__5A8
		btfss	0,1
		bra		p__59A
		movf	15h,W
		xorwf	2,W
		movlw	60h
		btfsc	STATUS,2
		btfss	11h,6
		movlw	80h
		movwf	1Bh
		return	
p__59A	decfsz	0,W						; entry from: 588h
		bra		p__5B2
		movlw	80h
		btfsc	11h,4
		movlw	10h
		movwf	1Bh
		return	
p__5A8	movf	15h,W					; entry from: 584h
		xorwf	3,W
		movlw	70h
		btfsc	STATUS,2
		btfss	11h,5
p__5B2	movlw	80h						; entry from: 59Ch
		movwf	1Bh
		nop
		return	
p__5BA	movf	1Bh,W					; entry from: 552h
		call	p__B48
		bra		p__5C4
p__5C2	movlw	80h						; entry from: 580h
p__5C4	nop								; entry from: 5C0h
p__5C6	nop								; entry from: 57Ch
		bra		p__5CA
p__5CA	nop								; entry from: 5C8h
p__5CC	nop								; entry from: 56Ah
		bra		p__5D0
p__5D0	movwf	1Bh						; entry from: 5CEh
p__5D2	return							; entry from: 578h

p__5D4	tstfsz	1Ah						; entry from: 482h,656h,760h,9AAh,0A10h,0B1Eh,0B4Ah,0B4Ch,0B4Eh,0B50h,0B52h,0B54h,0B56h,0B58h,0B6Eh,0B9Ch,0BE2h,0CBCh,0D14h,0D30h,0D34h,0E86h,1034h,1846h,1984h,1B50h,1B66h,1C96h,1D56h,1D82h,227Ah,22F6h,232Ah,2386h,23E2h,23F0h,23FEh,2414h,24D6h,24DAh,24FAh,251Ah,2556h,2566h,2576h,2586h,25D4h,25D8h,25F0h,25F4h,2716h,27ACh,27B8h,27C8h,2802h,2824h,2844h,28E4h,2914h,291Ch,2924h,2944h,2A94h,2AB8h,2ACAh,2C3Eh,2C66h,2C72h,2DE4h,2E04h,2E1Ah,2EACh,2EFCh,2F18h,2F34h,2F50h,2FBCh,303Ch,3120h,35ACh,3CFCh,3D1Eh,3E26h
		btfsc	TMR0L,7
		bra		p__61E
		btfsc	1Ah,7
		bra		p__5FE
		incf	1Dh
		btfsc	1Dh,3
		bsf		LATB,7
		incf	1Eh
		btfsc	1Eh,3
		bsf		LATB,6
		incf	1Fh
		btfsc	1Fh,3
		bsf		LATB,5
		incf	20h
		btfsc	20h,3
		bsf		LATB,4
		btfss	PORTC,4
		bsf		19h,7
		clrf	1Ah
		return	
p__5FE	decfsz	2Bh						; entry from: 5DCh
		bra		p__61C
		movlw	5
		movwf	2Bh
		incf	2Ah
p__608	movf	86h,W,BANKED			; entry from: 61Ch
		cpfslt	2Ah
		bsf		2Ch,6
		incf	21h
		movf	7Fh,W,BANKED
		cpfslt	21h
		bsf		0Fh,1
		bsf		19h,5
		bcf		1Ah,7
		return	
p__61C	bra		p__608					; entry from: 600h
p__61E	btfsc	PORTC,4					; entry from: 5D8h
		btfsc	PIR1,5
		bsf		19h,7
		btfsc	TMR0L,7
		tstfsz	1Ah
		bra		p__63E
		setf	1Ah
		tstfsz	3Ch
		decf	3Ch
		nop
		bra		p__634

p__634	nop								; entry from: 632h,644h
		btfsc	PORTC,4
		btfsc	PIR1,5
		bsf		19h,7
		return	

p__63E	movf	FSR1L,W					; entry from: 628h,1D8Ch,1F78h,1F88h,1FA6h,1FB6h,355Ch,357Ah,35DCh,363Eh,36B4h,3728h,3756h,37B4h,37C6h,3802h,3822h,386Ch,3888h,38AEh,38BCh,38D0h,3906h,392Ah,3942h,395Ah,3980h,3990h,399Eh,39B2h,39BCh,39EEh,3A6Ch,3AACh,3AB6h,3ADEh,3B5Eh
		cpfseq	FSR2L
		btfss	PIR1,4
		bra		p__634
		clrf	1Fh
		bcf		LATB,5
		movf	POSTINC2,W
		bcf		FSR2H,0
		movwf	TXREG1
		return	

p__652	call	p__B46					; entry from: 478h,2C34h,2C50h,31ACh
		bra		p__5D4

p__658	rcall	p__65A					; entry from: 0D0Ah,1230h,1762h,1822h,187Eh,198Eh

p__65A	movf	RCSTA1,W				; entry from: 658h,0D20h
		andlw	6
		btfss	STATUS,2
		bcf		RCSTA1,4
		btfss	STATUS,2
		bsf		RCSTA1,4
		movf	RCREG1,W
		return	

p__66A	clrf	STKPTR					; entry from: 408h,0CD4h,1C20h,1D14h,1D98h,1E72h
		movlw	1
		cpfseq	3Fh
		bra		p__676
		goto	p_1834
p__676	bcf		19h,4					; entry from: 670h
		movlw	2
		cpfseq	3Fh
		bra		p__682
		movlw	9Ah
		bra		p__6C2
p__682	movlw	3						; entry from: 67Ch
		cpfseq	3Fh
		bra		p__68C
		movlw	90h
		bra		p__6C2
p__68C	movlw	4						; entry from: 686h
		cpfseq	3Fh
		bra		p__696
		movlw	4Ch
		bra		p__6C2
p__696	movlw	5						; entry from: 690h
		cpfseq	3Fh
		bra		p__6A0
		movlw	56h
		bra		p__6C2
p__6A0	movlw	6						; entry from: 69Ah
		cpfseq	3Fh
		bra		p__6AA
		movlw	6Ch
		bra		p__6C2
p__6AA	movlw	0FFh					; entry from: 6A4h
		cpfseq	3Fh
		bra		p__6B4
p__6B0	movlw	0DCh					; entry from: 6CAh
		bra		p__6C2
p__6B4	movlw	8						; entry from: 6AEh
		cpfseq	3Fh
		bra		p__6C6
		btfsc	11h,7
		goto	p_1834
		movlw	0ACh

p__6C2	goto	p_182C					; entry from: 680h,68Ah,694h,69Eh,6A8h,6B2h
p__6C6	movlw	74h						; entry from: 6B8h
		cpfseq	3Fh
		bra		p__6B0

p__6CC	movwf	3Fh						; entry from: 10h,9BAh,1238h,17ECh
		clrf	STKPTR
		movff	FSR1L,FSR2L
		bcf		LATB,5
		rcall	p__706
		movf	8Bh,W,BANKED
		rcall	p__704
		movf	8Ah,W,BANKED
		btfsc	17h,7
		rcall	p__704
		movlw	45h
		rcall	p__704
		movlw	52h
		rcall	p__704
		movlw	52h
		rcall	p__704
#if DATA_OFFSET == 0
		clrf	TBLPTRH
#else
		movlw	high(DATA_OFFSET) + 0
		movwf	TBLPTRH
#endif
		clrf	TBLPTRU
		swapf	3Fh,W
		rcall	p__712
		rcall	p__704
		movf	3Fh,W
		rcall	p__712
		rcall	p__704
		bsf		LATB,5
		goto	p_1830

p__704	movwf	TXREG1					; entry from: 6DAh,6E0h,6E4h,6E8h,6ECh,6F6h,6FCh
p__706	clrf	41h						; entry from: 6D6h
p__708	call	p__B3E					; entry from: 70Eh
		decfsz	41h
		bra		p__708
		return	

p__712	iorlw	0F0h					; entry from: 6F4h,6FAh,71Ch,3894h
		movwf	TBLPTRL
		tblrd*
		movf	TABLAT,W
		return	

p__71C	rcall	p__712					; entry from: 1002h,1008h,100Eh,102Ah,1412h,1418h,14FAh,1500h,150Ch,38AAh,38DAh,3926h,3938h,393Eh,3948h,3956h,3960h,3974h,39A4h,3AA8h
		bra		p__7F2

p__720	movlw	3Ah						; entry from: 836h,141Ch,3964h
		bra		p__7F2

p__724	movf	8Bh,W,BANKED			; entry from: 3C0h,826h,848h,1030h,1206h,1450h,17F0h,17F4h,1810h,1814h,181Eh,1830h,1842h,1912h,191Ch,1920h,1E6Ah,1FBAh,24F0h,293Ah,2D2Eh,36A0h,38B8h,3ABAh
		rcall	p__7F2
		btfss	17h,7
		return	
		movf	8Ah,W,BANKED
		bra		p__7F2

p__730	movwf	TBLPTRL					; entry from: 846h,0D04h,0F4Eh,0F94h,0F9Eh,0FA4h,11FEh,1218h,180Ch,181Ah,182Ch,1888h,1918h,1FB2h,24ECh,2936h,2BCAh,2D2Ah,30ECh,369Ch

p__732	tblrd*+							; entry from: 73Eh,74Ah
		movf	TABLAT,W
		btfsc	STATUS,2
		return	
		rcall	p__7F2
		btfss	PIR1,4
		bra		p__732
		clrf	1Fh
		bcf		LATB,5
		movf	POSTINC2,W
		bcf		FSR2H,0
		movwf	TXREG1
		bra		p__732

p__74C	btfss	18h,0					; entry from: 0CB8h,0E82h,0E92h,11C8h,11D4h,1426h
		bra		p__7AA
		rcall	p__7AA
		bra		p__7F0
p__754	call	p__B44					; entry from: 7B0h

p__758	bra		p__75A					; entry from: 770h,7BCh

p__75A	nop								; entry from: 758h,790h
p__75C	call	p__B44					; entry from: 7C2h
		bra		p__5D4
p__762	movf	FSR1L,W					; entry from: 7EEh
		xorwf	FSR2L,W
		bz		p__7FC
		nop
		return	
p__76C	bcf		1Bh,6					; entry from: 7B4h
		btfsc	72h,3,BANKED
		bra		p__758
		swapf	1,W
		iorlw	0F0h
		movwf	TBLPTRL
		tblrd*
		movf	TABLAT,W
		movwf	POSTINC1
		bcf		FSR1H,0
		movf	FSR1L,W
		xorwf	FSR2L,W
		bz		p__7FC
		nop
		movf	1,W
		bra		p__7DA
p__78C	bcf		1Bh,5					; entry from: 7B8h
		btfsc	72h,3,BANKED
		bra		p__75A
		swapf	2,W
		iorlw	0F0h
		movwf	TBLPTRL
		tblrd*
		movf	TABLAT,W
		movwf	POSTINC1
		bcf		FSR1H,0
		movf	FSR1L,W
		xorwf	FSR2L,W
		bz		p__7FC
		movf	2,W
		bra		p__7DC

p__7AA	movwf	0Eh						; entry from: 74Eh,750h,1474h,382Eh,38B4h,397Ch,3986h,398Ch,3996h,39B8h,3AB2h
		bra		p__7BE

p__7AE	btfsc	1Bh,7					; entry from: 2532h,253Eh,254Ah,29AEh,29B2h,29D4h,2AF8h,2AFCh,2B02h,2F30h
		bra		p__754
		btfsc	1Bh,6
		bra		p__76C
		btfsc	1Bh,5
		bra		p__78C
		btfss	1Bh,4
		bra		p__758

p__7BE	bcf		1Bh,4					; entry from: 7ACh,1F94h
		btfsc	72h,3,BANKED
		bra		p__75C
		swapf	0Eh,W
		iorlw	0F0h
		movwf	TBLPTRL
		tblrd*
		movf	TABLAT,W
		movwf	POSTINC1
		bcf		FSR1H,0
		movf	FSR1L,W
		xorwf	FSR2L,W
		bz		p__7FC
		movf	0Eh,W
p__7DA	nop								; entry from: 78Ah
p__7DC	iorlw	0F0h					; entry from: 7A8h
		movwf	TBLPTRL
		tblrd*
		movf	TABLAT,W
		movwf	POSTINC1
		bcf		FSR1H,0
		movf	FSR1L,W
		cpfseq	FSR2L
		btfsc	18h,0
		bra		p__762

p__7F0	movlw	20h						; entry from: 752h,830h,0F58h,11E2h,1446h,144Ah

p__7F2	movwf	POSTINC1				; entry from: 71Eh,722h,726h,72Eh,73Ah,834h,0C4Ch,0E7Ch,0F54h,0FB4h,0FBEh,0FC4h,0FCAh,1014h,1024h,118Ch,1196h,119Eh,11A4h,120Ch,1212h,143Ah,1506h,1512h,1520h,152Ah,1926h,197Ch,2C0Ch,37FEh,3808h,380Eh,38C6h
		bcf		FSR1H,0
		movf	FSR1L,W
		cpfseq	FSR2L
		return	

p__7FC	clrf	STKPTR					; entry from: 470h,766h,784h,7A4h,7D6h
		movlw	0FCh
		andwf	LATB
		decf	FSR1L
		movlw	2
		movwf	FSR1H
		btfss	3Eh,0
		bra		p__818
		movf	CANSTAT,W
		andlw	0E0h
		xorlw	60h
		btfsc	STATUS,2
		call	p_3CCE
p__818	call	p_1034					; entry from: 80Ah
		movf	INDF1,W
		xorwf	8Bh,W,BANKED
		bz		p__826
		incf	FSR1L
		bcf		FSR1H,0
p__826	rcall	p__724					; entry from: 820h
		movlw	40h
		goto	p_182C

p__82E	btfss	18h,0					; entry from: 3812h,389Ch,38D4h,38DEh,392Eh,3968h,39A8h
		bra		p__7F0
		return	

p__834	rcall	p__7F2					; entry from: 0E70h,0E8Ch,11BEh,11CEh,11E8h,3898h,38CCh
		bra		p__720

; read eeprom
p__838	movwf	EEADR						; entry from: 98Eh,99Ah,0C4Ah,0C62h,1382h,13A4h,1422h,142Eh,1470h
		bcf		EECON1,7
		bcf		EECON1,6
		bsf		EECON1,0
		movf	EEDATA,W
		return	

p__844	movlw	0BAh					; entry from: 1C46h,1DBEh,2D02h,2D52h
		rcall	p__730
		bra		p__724

p__84A	rcall	p__8EA					; entry from: 1C4Ch,1D76h
		btfsc	STATUS,2
		addlw	1
		movwf	0C3h,BANKED
		movlw	0Ch
		cpfslt	0C3h,BANKED
		movwf	0C3h,BANKED
		btfsc	0D2h,7,BANKED
		btfss	33h,5
		bra		p__866
p__85E	movlw	5						; entry from: 86Ch
		cpfslt	0C3h,BANKED
		movwf	0C3h,BANKED
		return	
p__866	btfsc	0D2h,6,BANKED			; entry from: 85Ch
		btfss	33h,4
		return	
		bra		p__85E

p__86E	clrf	3Dh						; entry from: 9CCh,0AA2h,0AB2h
		clrf	EEADR
		bcf		EECON1,7
		bcf		EECON1,6
		movlw	8
		movwf	41h
p__87A	rrncf	3Dh						; entry from: 886h
		bsf		EECON1,0
		tstfsz	EEDATA
		bsf		3Dh,7
		incf	EEADR
		decfsz	41h
		bra		p__87A
		bcf		3Eh,7
		btfsc	3Dh,7
		bsf		3Eh,7
		bcf		3Dh,7
		bsf		EECON1,0
		movff	EEDATA,0C8h
		incf	EEADR
		nop
		bsf		EECON1,0
		movff	EEDATA,0C9h
		incf	EEADR
		nop
		bsf		EECON1,0
		movff	EEDATA,0CAh
		incf	EEADR
		nop
		bsf		EECON1,0
		movff	EEDATA,0CBh
		movlw	0Ch
		cpfsgt	3Dh
		return	
		clrf	3Dh
		bsf		3Eh,7
		return	
p__8C0	setf	0CDh,BANKED				; entry from: 1804h
		movlw	0Ch
		bra		p__98C
p__8C6	setf	0CDh,BANKED				; entry from: 0A32h
		movlw	0Eh
		bra		p__98C
p__8CC	setf	0CDh,BANKED				; entry from: 0A24h
		movlw	10h
		bra		p__98C
p__8D2	movlw	32h						; entry from: 0AC4h
		movwf	0CDh,BANKED
		movlw	12h
		bra		p__98C
p__8DA	movlw	1						; entry from: 0A62h
		movwf	0CDh,BANKED
		movlw	14h
		bra		p__98C
p__8E2	movlw	0F1h					; entry from: 1768h
		movwf	0CDh,BANKED
		movlw	18h
		bra		p__98C
p__8EA	movlw	9						; entry from: 84Ah
		movwf	0CDh,BANKED
		movlw	1Ah
		bra		p__98C
p__8F2	clrf	0CDh,BANKED				; entry from: 176Eh
		movlw	1Eh
		bra		p__98C
p__8F8	movlw	0Ah						; entry from: 1776h
		movwf	0CDh,BANKED
		movlw	20h
		bra		p__98C
p__900	movlw	DEFAULT_BAUD					; entry from: 1740h
		movwf	0CDh,BANKED
		movlw	24h
		bra		p__98C
p__908	movlw	0Dh						; entry from: 177Ch
		movwf	0CDh,BANKED
		movlw	26h
		bra		p__98C
p__910	clrf	0CDh,BANKED				; entry from: 0A4Ch
		movlw	2Eh
		bra		p__98C

p__916	movlw	32h						; entry from: 1C78h,1CECh
		movwf	0CDh,BANKED
		movlw	32h
		bra		p__98C
p__91E	movlw	0Ah						; entry from: 0ACCh
		movwf	0CDh,BANKED
		movlw	36h
		bra		p__98C
p__926	setf	0CDh,BANKED				; entry from: 1782h
		movlw	38h
		bra		p__98C
p__92C	movlw	92h						; entry from: 0AD2h
		movwf	0CDh,BANKED
		movlw	3Ah
		bra		p__98C

p__934	clrf	0CDh,BANKED				; entry from: 1C8Ah,1CFAh
		movlw	3Ch
		bra		p__98C
p__93A	movlw	28h						; entry from: 1D4Ah
		movwf	0CDh,BANKED
		movlw	3Eh
		bra		p__98C
p__942	clrf	0CDh,BANKED				; entry from: 0A3Ah
		movlw	54h
		bra		p__98C
p__948	clrf	0CDh,BANKED				; entry from: 0A44h
		movlw	56h
		bra		p__98C
p__94E	movlw	0						; entry from: 0A94h
		movwf	0CDh,BANKED
		movlw	58h
		bra		p__98C
p__956	setf	0CDh,BANKED				; entry from: 0A54h
		movlw	5Eh
		bra		p__98C
p__95C	movlw	38h						; entry from: 0A5Ch
		movwf	0CDh,BANKED
		movlw	60h
		bra		p__98C
p__964	movlw	2						; entry from: 178Ah
		movwf	0CDh,BANKED
		movlw	62h
		bra		p__98C
p__96C	movlw	0E0h					; entry from: 179Ah
		movwf	0CDh,BANKED
		movlw	64h
		bra		p__98C
p__974	movlw	4						; entry from: 17A0h
		movwf	0CDh,BANKED
		movlw	66h
		bra		p__98C
p__97C	movlw	80h						; entry from: 17ACh
		movwf	0CDh,BANKED
		movlw	68h
		bra		p__98C
p__984	movlw	0Ah						; entry from: 17B2h
		movwf	0CDh,BANKED
		movlw	6Ah
		bra		p__98C

p__98C	iorlw	1						; entry from: 8C4h,8CAh,8D0h,8D8h,8E0h,8E8h,8F0h,8F6h,8FEh,906h,90Eh,914h,91Ch,924h,92Ah,932h,938h,940h,946h,94Ch,954h,95Ah,962h,96Ah,972h,97Ah,982h,98Ah,1680h,16BEh,170Eh
		call	p__838
		bz		p__998
		movf	0CDh,W,BANKED
		return	
p__998	decf	EEADR,W					; entry from: 992h
		goto	p__838

p__99E	movlw	1						; entry from: 0ECCh,148Ah,4038h
		movwf	ADCON0
		call	p__B4A
		bsf		ADCON0,1
		clrf	41h
p__9AA	rcall	p__5D4					; entry from: 9B2h
		btfss	ADCON0,1
		bra		p__9BE
		decfsz	41h
		bra		p__9AA
		movlw	0
		movwf	ADCON0
		movlw	76h
		goto	p__6CC
p__9BE	goto	p_403E					; entry from: 9AEh
		nop
p__9C4	movff	3Dh,44h					; entry from: 184Ch
		btfsc	3Eh,7
		bsf		44h,7
		call	p__86E
		btfsc	3Eh,7
		bsf		3Dh,7
		movf	3Dh,W
		xorwf	44h,W
		bz		p__9FC
		bsf		EECON1,2
		clrf	EEADR
		movlw	8
		movwf	41h
		movlw	0FFh
p__9E4	btfss	44h,0					; entry from: 9EEh
		movlw	0
		rcall	p__A00
		rrncf	44h
		decfsz	41h
		bra		p__9E4
		bcf		EECON1,2
		bcf		3Eh,7
		btfsc	44h,7
		bsf		3Eh,7
		movff	44h,3Dh
p__9FC	bcf		3Dh,7					; entry from: 9D8h
		return	

; write eeprom
p__A00	movwf	EEDATA						; entry from: 9E8h,0C88h,0C94h,0C96h,0C98h,0C9Ah,0F08h,0F0Eh,0F14h,0F1Ah,1390h,13AEh
		movlw	55h
		movwf	EECON2
		movlw	0AAh
		movwf	EECON2
		bsf		EECON1,1
		movlw	0Ch
		rcall	p__B12
p__A10	rcall	p__5D4					; entry from: 0A18h
		btfsc	0Fh,1
		bra		p__4D4
		btfsc	EECON1,1
		bra		p__A10
		incf	EEADR
		retlw	0FFh

p__A1E	movf	8Ch,W,BANKED			; entry from: 3B6h,3BCh,17D2h
		andlw	0E0h
		movwf	17h
		call	p__8CC
		btfsc	STATUS,2
		bsf		17h,4
		bsf		17h,3
		btfsc	8Dh,6,BANKED
		bsf		17h,2
		call	p__8C6
		btfsc	STATUS,2
		bsf		17h,1
		call	p__942
		btfsc	STATUS,2
		bsf		17h,0
		clrf	18h
		call	p__948
		btfsc	STATUS,2
		bsf		18h,7
		call	p__910
		btfsc	STATUS,2
		bsf		18h,6
		call	p__956
		btfsc	STATUS,2
		bsf		18h,5
		call	p__95C
		movwf	33h
		call	p__8DA
		movwf	41h
		decf	41h
		bz		p__A72
		decfsz	41h
		bra		p__A74
		bsf		18h,3
p__A72	bsf		18h,4					; entry from: 0A6Ah
p__A74	clrf	3Fh						; entry from: 0A6Eh
		clrf	83h,BANKED
		movlw	0Fh
		movwf	0CEh,BANKED
		clrf	19h
		clrf	1Bh
		bsf		1Bh,7
		clrf	11h
		clrf	2Dh
		btfsc	8Dh,7,BANKED
		bsf		2Dh,1
		movlw	33h
		movwf	0BFh,BANKED
		clrf	34h
		clrf	35h
		clrf	0A6h,BANKED
		call	p__94E
		movwf	95h,BANKED
		btfss	3Eh,6
		bra		p__AB0
		movff	3Dh,44h
		call	p__86E
		movf	44h,W
		xorwf	3Dh,W
		bz		p__ABA
		call	p_1FEA
p__AB0	clrf	3Eh						; entry from: 0A9Ch
		call	p__86E
		call	p_26DE
p__ABA	clrf	0Fh						; entry from: 0AAAh
		clrf	10h
		bcf		2Ch,5
		call	p_1FFE
		call	p__8D2
		movwf	80h,BANKED
		movwf	7Eh,BANKED
		call	p__91E
		movwf	0C2h,BANKED
		call	p__92C
		movwf	86h,BANKED
		return	

p__ADA	movwf	3Fh						; entry from: 1F00h,1F84h,229Eh,22A6h,22BAh,273Ah,2742h,2756h,2BD6h,2C8Ah,2C9Ch,2CAEh,2CC8h,2CF6h,2D46h,2DACh,2DB8h,30FEh,3110h,3156h,3164h,32F0h,32FAh,3336h,333Ch,3350h,335Eh,349Eh,34ACh,3594h,3AC8h,3B22h,3D70h
		tstfsz	3Fh
		pop
		return	

p__AE2	clrf	7Ch,BANKED				; entry from: 3D2h,3E6h,0FE6h,14D4h
		clrf	7Dh,BANKED
p__AE6	movf	7Bh,W,BANKED			; entry from: 0B00h
		subwf	32h
		movf	7Ah,W,BANKED
		subwfb	31h
		movlw	0
		subwfb	30h
		subwfb	2Fh
		bnc		p__B02
		incf	7Dh,f,BANKED
		btfsc	STATUS,0
		incf	7Ch,f,BANKED
		btfsc	STATUS,0
		retlw	0FFh
		bra		p__AE6
p__B02	movf	7Bh,W,BANKED			; entry from: 0AF4h
		addwf	32h
		movf	7Ah,W,BANKED
		addwfc	31h
		movlw	0
		addwfc	30h
		addwfc	2Fh
		retlw	0

p__B12	movwf	7Fh,BANKED				; entry from: 0A0Eh,0B1Ch,18A2h,1C92h,230Eh,2792h,2F74h
		clrf	21h
		bcf		0Fh,1
		return	

p__B1A	movlw	0F6h					; entry from: 121Eh,1222h,1292h
		rcall	p__B12
p__B1E	rcall	p__5D4					; entry from: 0B22h
		btfss	0Fh,1
		bra		p__B1E
		return	

p__B26	rcall	p__B28					; entry from: 500h,1720h

p__B28	rcall	p__B2A					; entry from: 492h,0B26h

p__B2A	clrf	42h						; entry from: 4F8h,51Ch,0B28h,1732h
		clrf	43h

p__B2E	decfsz	42h						; entry from: 0B30h,0B34h
		bra		p__B2E
		decfsz	43h
		bra		p__B2E
		return	
p__B38	bra		p__B42					; entry from: 2F44h

p__B3A	rcall	p__B44					; entry from: 252Ch,2538h,2544h,2550h,2560h,2570h,2580h,2C1Eh,2C22h,2F10h,2F3Ch,3124h,3142h

p__B3C	bra		p__B40					; entry from: 28B6h,296Eh,2BF4h,2EC4h,2F68h

p__B3E	rcall	p__B40					; entry from: 4A2h,50Ch,708h,2516h,2526h,255Ah,256Ah,257Ah,2972h,2994h,29B6h,29F6h,2A14h,2A32h,2A50h

p__B40	bra		p__B46					; entry from: 0B3Ch,0B3Eh,237Eh,289Eh,29BAh

p__B42	rcall	p__B46					; entry from: 0B38h,238Eh,282Eh,2F06h

p__B44	bra		p__B48					; entry from: 754h,75Ch,0B3Ah,2402h,25BAh,2AD2h,3016h

p__B46	rcall	p__B48					; entry from: 48Eh,652h,0B40h,0B42h,238Ah,23F8h,2968h,3138h

p__B48	return							; entry from: 5BCh,0B44h,0B46h,240Ch,25B4h,2836h,28C8h,2ABCh,2AE8h,301Eh,3034h

p__B4A	rcall	p__5D4					; entry from: 9A2h,1956h
		rcall	p__5D4

p__B4E	rcall	p__5D4					; entry from: 23C8h,2866h

p__B50	rcall	p__5D4					; entry from: 2880h,2888h,2892h,289Ah,28AEh,28B2h,28C0h,28C4h,2AE0h,2AE4h,3146h

p__B52	rcall	p__5D4					; entry from: 27F2h,29F2h,2A10h,2A2Eh,2A4Ch,3134h

p__B54	rcall	p__5D4					; entry from: 2964h,2990h,29D8h
		rcall	p__5D4
		bra		p__5D4
p__B5A	nop								; entry from: 2374h

p__B5C	addlw	0FFh					; entry from: 0B60h,2364h
		btfss	STATUS,2
		bra		p__B5C
		return	

p__B64	clrf	90h,BANKED				; entry from: 1C54h,1DC6h
		clrf	8Fh,BANKED
		movlw	46h
		movwf	41h
		clrf	42h
p__B6E	rcall	p__5D4					; entry from: 0B86h
p__B70	movf	PORTB,W					; entry from: 0B82h
		andlw	8
		xorwf	8Fh,W,BANKED
		bz		p__B90
		xorwf	8Fh,f,BANKED
		infsnz	90h,f,BANKED
		retlw	6
p__B7E	nop								; entry from: 0B90h
		decfsz	42h
		bra		p__B70
		decfsz	41h
		bra		p__B6E
		movlw	20h
		cpfsgt	90h,BANKED
		bra		p__B92
		retlw	6
p__B90	bra		p__B7E					; entry from: 0B76h
p__B92	clrf	90h,BANKED				; entry from: 0B8Ch
		clrf	92h,BANKED
		movlw	67h
		movwf	41h
		clrf	42h
p__B9C	rcall	p__5D4					; entry from: 0BBEh
		setf	91h,BANKED
p__BA0	btfss	PORTC,0					; entry from: 0BBAh
		bra		p__BC8
		btfsc	92h,0,BANKED
		bra		p__BCC
		infsnz	90h,f,BANKED
		retlw	2
		movlw	6Ch
		btfsc	92h,3,BANKED
		cpfslt	91h,BANKED
		decf	90h,f,BANKED
		bsf		92h,0,BANKED
		clrf	91h,BANKED
p__BB8	decfsz	42h						; entry from: 0BD6h
		bra		p__BA0
		decfsz	41h
		bra		p__B9C
		movlw	0Ah
		cpfsgt	90h,BANKED
		bra		p__BD8
		retlw	2
p__BC8	bcf		92h,0,BANKED			; entry from: 0BA2h
		bcf		92h,3,BANKED
p__BCC	incfsz	91h,W,BANKED			; entry from: 0BA6h
		incf	91h,f,BANKED
		movlw	0Fh
		cpfslt	91h,BANKED
		bsf		92h,3,BANKED
		bra		p__BB8
p__BD8	clrf	90h,BANKED				; entry from: 0BC4h
		clrf	92h,BANKED
		movlw	67h
		movwf	41h
		clrf	42h
p__BE2	rcall	p__5D4					; entry from: 0C04h
		setf	91h,BANKED
p__BE6	btfsc	PORTC,2					; entry from: 0C00h
		bra		p__C0E
		btfss	92h,2,BANKED
		bra		p__C12
		infsnz	90h,f,BANKED
		retlw	1
		movlw	9
		btfsc	92h,4,BANKED
		cpfslt	91h,BANKED
		decf	90h,f,BANKED
		bcf		92h,2,BANKED
		clrf	91h,BANKED
p__BFE	decfsz	42h						; entry from: 0C1Ch
		bra		p__BE6
		decfsz	41h
		bra		p__BE2
		movlw	16h
		cpfsgt	90h,BANKED
		retlw	5
		retlw	1
p__C0E	bsf		92h,2,BANKED			; entry from: 0BE8h
		bcf		92h,4,BANKED
p__C12	incfsz	91h,W,BANKED			; entry from: 0BECh
		incf	91h,f,BANKED
		movlw	3
		cpfslt	91h,BANKED
		bsf		92h,4,BANKED
		bra		p__BFE
p__C1E	movlw	31h						; entry from: 204h
		cpfseq	65h,BANKED
		bra		p__C2A
		bcf		18h,3
p__C26	bsf		18h,4					; entry from: 0C32h
		bra		p__E9E
p__C2A	movlw	32h						; entry from: 0C22h
		cpfseq	65h,BANKED
		bra		p__C34
		bsf		18h,3
		bra		p__C26
p__C34	tstfsz	78h,BANKED				; entry from: 0C2Eh
		bra		p__EAC
		bcf		18h,4
		bra		p__E9E
p__C3C	movlw	24h						; entry from: 1F0h
		goto	p_182C
p__C42	rcall	p__C58					; entry from: 1F6h
		btfsc	STATUS,2
		bra		p__EAC
p__C48	movf	42h,W					; entry from: 0C54h
		rcall	p__838
		call	p__7F2
		incf	42h
		decfsz	41h
		bra		p__C48
		bra		p__E9A

p__C58	movlw	0Ch						; entry from: 0C42h,0C72h
		movwf	41h
		movlw	6Ch
		movwf	42h
p__C60	movf	42h,W					; entry from: 0C6Eh
		rcall	p__838
		btfsc	STATUS,2
		return	
		incf	42h
		movlw	70h
		cpfseq	42h
		bra		p__C60
		return	
#if SW_VERSION != 0
p__C72	movlw	0
		movwf	FSR0H
		movlw	65h
		movwf	FSR0L
		movf	POSTINC0,W
		xorlw	"E"
		bz		eep_chk
		xorlw	"E"
		xorlw	"B"
		bnz		cmd_err
		movf	POSTINC0,W
		xorlw	"L"
		bnz		cmd_err
		reset
eep_chk		movf	POSTINC0,W
		xorlw	"E"
		bnz		cmd_err
		call		eep_init
		bra		p__E9E	    ; print OK
cmd_err		bra		p__EAC	    ; print ?
#else
p__C72	rcall	p__C58					; entry from: 31Eh
		btfss	STATUS,2
		bra		p__EAC
		movlw	0
		movwf	FSR0H
		movlw	65h
		movwf	FSR0L
		movlw	70h
		movwf	EEADR
		bsf		EECON1,2
p__C86	movf	POSTINC0,W				; entry from: 0C8Ch
		rcall	p__A00
		decfsz	41h
		bra		p__C86
		movlw	6Ch
		movwf	EEADR
		movlw	0FFh
		rcall	p__A00
		rcall	p__A00
		rcall	p__A00
		rcall	p__A00
		bcf		EECON1,2
		bra		p__E9E
#endif
p__CA0	bcf		10h,4					; entry from: 11Eh
		bcf		34h,6
		bcf		34h,5
		bsf		34h,4
		bra		p__E9E
p__CAA	movlw	0						; entry from: 124h
		movwf	FSR0H
		movlw	0
		movwf	FSR0L
		movlw	0Dh
		movwf	41h
p__CB6	movf	POSTINC0,W				; entry from: 0CC0h
		call	p__74C
		rcall	p__5D4
		decfsz	41h
		bra		p__CB6
		bra		p__E9A
p__CC4	movf	3Dh						; entry from: 12Ah
		btfsc	STATUS,2
		bra		p__EAC
		bsf		19h,6
		call	p_1E76
		movwf	3Fh
		tstfsz	3Fh
		bra		p__66A
		bra		p__E9E
p__CD8	call	p_113A					; entry from: 29Eh
		movwf	41h
		movlw	54h
		cpfseq	65h,BANKED
		bra		p__CEA
		movff	41h,0CEh
		bra		p__E9E
p__CEA	movlw	44h						; entry from: 0CE2h
		btfsc	72h,4,BANKED
		cpfseq	65h,BANKED
		bra		p__EAC
		movlw	7
		cpfsgt	41h
		bra		p__EAC
		movff	0F7Dh,6Bh
		movff	SPBRG1,6Ch
		setf	6Dh,BANKED
		movlw	0B4h
p__D04	call	p__730					; entry from: 0D4Eh
		rcall	p_1030
		call	p__658
		movff	0CEh,43h
		clrf	42h

p__D14	call	p__5D4					; entry from: 0D3Ah,0D3Eh
		btfss	PIR1,5
		bra		p__D30
		clrf	20h
		bcf		LATB,4
		call	p__65A
		btfss	6Dh,0,BANKED
		cpfseq	8Bh,BANKED
		bra		p__D30
		movff	41h,0CFh
		bra		p__E9E

p__D30	call	p__5D4					; entry from: 0D1Ah,0D28h
		call	p__5D4
		decfsz	42h
		bra		p__D14
		decfsz	43h
		bra		p__D14
		btfss	6Dh,0,BANKED
		bra		p__D50
		clrf	SPBRGH1
		decf	41h,W
		movwf	SPBRG1
		movlw	82h
		clrf	6Dh,BANKED
		bra		p__D04
p__D50	movff	6Bh,0F7Dh				; entry from: 0D42h
		movff	6Ch,SPBRG1
		goto	p_1834
p__D5C	movlw	46h						; entry from: 242h
		cpfseq	65h,BANKED
		bra		p__D70
		movlw	30h
		cpfseq	66h,BANKED
		bra		p__D6C
		bcf		17h,0
		bra		p__E9E
p__D6C	movlw	31h						; entry from: 0D66h
		cpfseq	66h,BANKED
p__D70	bra		p__EAC					; entry from: 0D60h
		bsf		17h,0
		bra		p__E9E
p__D76	movlw	41h						; entry from: 20Ah
		cpfseq	65h,BANKED
		bra		p__EAC
		bcf		18h,1
		bra		p__E9E
p__D80	rcall	p__EA4					; entry from: 2A4h
		bcf		35h,4
		clrf	0A2h,BANKED
		clrf	0A3h,BANKED
		rcall	p__E48
		andlw	7
		movwf	0A4h,BANKED
		movf	79h,W,BANKED
		bra		p__DA4
p__D92	rcall	p__EA4					; entry from: 308h
		bsf		35h,4
		andlw	1Fh
		movwf	0A2h,BANKED
		movff	79h,0A3h
		movff	7Ah,0A4h
		movf	7Bh,W,BANKED

p__DA4	movwf	0A5h,BANKED				; entry from: 0D90h,0E22h
		bsf		34h,5
		bsf		34h,4
		bra		p__E9E
p__DAC	movlw	43h						; entry from: 248h
		cpfseq	65h,BANKED
		bra		p__DC0
		movlw	30h
		cpfseq	66h,BANKED
		bra		p__DBC
		bcf		18h,7
		bra		p__E9E
p__DBC	movlw	31h						; entry from: 0DB6h
		cpfseq	66h,BANKED
p__DC0	bra		p__EAC					; entry from: 0DB0h
		bsf		18h,7
		bra		p__E9E
p__DC6	rcall	p__EA4					; entry from: 2AAh
		bcf		35h,4
		clrf	9Eh,BANKED
		clrf	9Fh,BANKED
		rcall	p__E48
		andlw	7
		movwf	0A0h,BANKED
		movf	79h,W,BANKED
		bra		p__DEA
p__DD8	rcall	p__EA4					; entry from: 30Eh
		bsf		35h,4
		andlw	1Fh
		movwf	9Eh,BANKED
		movff	79h,9Fh
		movff	7Ah,0A0h
		movf	7Bh,W,BANKED
p__DEA	movwf	0A1h,BANKED				; entry from: 0DD6h
		bsf		34h,6
		bsf		34h,4
		bra		p__E9E
p__DF2	rcall	p__EA4					; entry from: 24Eh
		movlw	1Fh
		andwf	78h,f,BANKED
		movff	78h,2Eh
		bsf		34h,7
		bsf		34h,4
		bra		p__E9E
p__E02	rcall	p__EA4					; entry from: 2C4h
		andlw	0F0h
		xorlw	0A0h
		bnz		p__EAC
		bcf		35h,4
		clrf	9Eh,BANKED
		clrf	0A2h,BANKED
		clrf	9Fh,BANKED
		clrf	0A3h,BANKED
		movlw	7
		movwf	0A0h,BANKED
		andwf	78h,W,BANKED
		movwf	0A4h,BANKED
		setf	0A1h,BANKED
		movf	79h,W,BANKED
p__E20	bsf		34h,6					; entry from: 0E46h
		bra		p__DA4
p__E24	rcall	p__EA4					; entry from: 316h
		rcall	p__E48
		xorlw	0Ah
		bnz		p__EAC
		bsf		35h,4
		movlw	1Fh
		movwf	9Eh,BANKED
		setf	9Fh,BANKED
		setf	0A0h,BANKED
		setf	0A1h,BANKED
		andwf	79h,W,BANKED
		movwf	0A2h,BANKED
		movff	7Ah,0A3h
		movff	7Bh,0A4h
		movf	7Ch,W,BANKED
		bra		p__E20

p__E48	movlw	4						; entry from: 0D88h,0DCEh,0E26h,155Ch
		movwf	41h
p__E4C	bcf		STATUS,0				; entry from: 0E5Ah
		rrcf	78h,f,BANKED
		rrcf	79h,f,BANKED
		rrcf	7Ah,f,BANKED
		rrcf	7Bh,f,BANKED
		rrcf	7Ch,f,BANKED
		decfsz	41h
		bra		p__E4C
		movf	78h,W,BANKED
		return	
p__E60	movf	CANSTAT,W					; entry from: 130h
		andlw	0E0h
		bnz		p__E6E
		movff	TXERRCNT,0B1h
		movff	RXERRCNT,0B2h
p__E6E	movlw	54h						; entry from: 0E64h
		call	p__834
		movf	0B1h,W,BANKED
		btfss	COMSTAT,5
		bra		p__E82
		movlw	4Fh
		call	p__7F2
		movlw	0FFh
p__E82	call	p__74C					; entry from: 0E78h
		call	p__5D4
		movlw	52h
		call	p__834
		movf	0B2h,W,BANKED
		call	p__74C
		clrf	0B1h,BANKED
		clrf	0B2h,BANKED

p__E9A	goto	p_1830					; entry from: 0C56h,0CC2h,0F9Ah,1018h,102Eh

; print OK
p__E9E	movlw	0B4h					; entry from: 302h,0C28h,0C3Ah,0C9Eh,0CA8h,0CD6h,0CE8h,0D2Eh,0D6Ah,0D74h,0D7Eh,0DAAh,0DBAh,0DC4h,0DF0h,0E00h,0F20h,1076h,109Eh,10B8h,1102h,1462h
		goto	p_182C

p__EA4	movf	78h,W,BANKED			; entry from: 0D80h,0D92h,0DC6h,0DD8h,0DF2h,0E02h,0E24h,0EB2h,1466h
		btfsc	72h,4,BANKED
		return	
		pop

; print ?
p__EAC	movlw	8Eh						; entry from: 0C36h,0C46h,0C76h,0CC8h,0CF0h,0CF6h,0D70h,0D7Ah,0DC0h,0E08h,0E2Ah,0F26h,0F38h,146Ah,1AFAh
		goto	p_182C
p__EB2	rcall	p__EA4					; entry from: 2CAh
		bnz		p__ECC
		tstfsz	79h,BANKED
		bra		p__ECC
		movlw	6
		movwf	0C8h,BANKED
		movlw	0AEh
		movwf	0C9h,BANKED
		movlw	2
		movwf	0CAh,BANKED
		movlw	6Ah
		movwf	0CBh,BANKED
		bra		p__F00

p__ECC	call	p__99E					; entry from: 0EB4h,0EB8h
		movff	ADRESH,0CAh
		movff	ADRESL,0CBh
		swapf	79h,W,BANKED
		andlw	0Fh
		mullw	0Ah
		movlw	0Fh
		andwf	79h,W,BANKED
		addwf	PRODL,W
		movwf	0C9h,BANKED
		swapf	78h,W,BANKED
		andlw	0Fh
		mullw	0Ah
		movlw	0Fh
		andwf	78h,W,BANKED
		addwf	PRODL,W
		mullw	64h
		movf	PRODL,W
		addwf	0C9h,f,BANKED
		movf	PRODH,W
		btfsc	STATUS,0
		addlw	1
		movwf	0C8h,BANKED
p__F00	bsf		EECON1,2					; entry from: 0ECAh
		movlw	8
		movwf	EEADR
		movf	0C8h,W,BANKED
		call	p__A00
		movf	0C9h,W,BANKED
		call	p__A00
		movf	0CAh,W,BANKED
		call	p__A00
		movf	0CBh,W,BANKED
		call	p__A00
		bcf		EECON1,2
		bra		p__E9E
p__F22	movlw	31h						; entry from: 210h
		cpfseq	65h,BANKED
		bra		p__EAC
		movlw	0FEh
		movwf	39h
		movlw	0CAh
		movwf	3Ah
p__F30	clrf	38h						; entry from: 12AAh
p__F32	call	p_2220					; entry from: 12B8h
		btfss	97h,2,BANKED
		bra		p__EAC
		clrf	11h
		goto	p_1D68
p__F40	movlw	high(TABLE_OFFSET) + 3						; entry from: 142h
		movwf	TBLPTRH
		movlw	low(text_table2)
		movf	3Dh
		bz		p__F94
		btfss	3Eh,7
		bra		p__F5C
		call	p__730
		movlw	2Ch
		call	p__7F2
		call	p__7F0
p__F5C	movff	3Dh,41h					; entry from: 0F4Ch
		movlw	6
		cpfslt	3Dh
		bra		p__F7C
		dcfsnz	41h
		movlw	2Ah
		dcfsnz	41h
		movlw	38h
		dcfsnz	41h
		movlw	46h
		dcfsnz	41h
		movlw	52h
		dcfsnz	41h
		movlw	6Ah
		bra		p__F94
p__F7C	movlw	9						; entry from: 0F64h
		cpfsgt	3Dh
		bra		p__F9C
		subwf	41h
		movlw	0ACh
		dcfsnz	41h
		movlw	8Eh
		dcfsnz	41h
		movlw	98h
		dcfsnz	41h
		movlw	9Eh
		bra		p__F9E

p__F94	call	p__730					; entry from: 0F48h,0F7Ah
#if DATA_OFFSET == 0
		clrf	TBLPTRH
#else
		movlw	high(DATA_OFFSET) + 0
		movwf	TBLPTRH
#endif
		bra		p__E9A
p__F9C	movlw	82h						; entry from: 0F80h
p__F9E	call	p__730					; entry from: 0F92h
		movlw	0A4h
		call	p__730
#if DATA_OFFSET == 0
		clrf	TBLPTRH
#else
		movlw	high(DATA_OFFSET) + 0
		movwf	TBLPTRH
#endif
		call	p_2220
		btfss	37h,7
		bra		p__FBC
		movlw	31h
		call	p__7F2
		movlw	31h
		bra		p__FC4
p__FBC	movlw	32h						; entry from: 0FB0h
		call	p__7F2
		movlw	39h
p__FC4	call	p__7F2					; entry from: 0FBAh
		movlw	2Fh
		call	p__7F2
		clrf	2Fh
		clrf	30h
		bcf		STATUS,0
		rrcf	96h,W,BANKED
		addlw	0F4h
		movwf	32h
		clrf	31h
		movlw	1
		addwfc	31h
		clrf	7Ah,BANKED
		movff	96h,7Bh
		call	p__AE2
		movff	7Ch,31h
		movff	7Dh,32h
		call	p__3C6
		tstfsz	30h
		bra		p_1000
		tstfsz	31h
		bra		p_1006
		bra		p_100C
p_1000	movf	30h,W					; entry from: 0FF8h
		call	p__71C
p_1006	movf	31h,W					; entry from: 0FFCh
		call	p__71C
p_100C	movf	32h,W					; entry from: 0FFEh
		call	p__71C
		movlw	29h
		call	p__7F2
		bra		p__E9A
p_101A	movlw	4Eh						; entry from: 216h
		cpfseq	65h,BANKED
		bra		p_146A
		movlw	41h
		btfsc	3Eh,7
		call	p__7F2
		movf	3Dh,W
		call	p__71C
		bra		p__E9A

p_1030	call	p__724					; entry from: 0D08h,1202h,121Ch

p_1034	call	p__5D4					; entry from: 818h,103Ch,1400h,1A38h,1A3Eh
		movf	FSR1L,W
		cpfseq	FSR2L
		bra		p_1034
		return	
p_1040	btfss	73h,7,BANKED			; entry from: 1A76h
		bra		p_146A
		movlw	4Dh
		cpfseq	66h,BANKED
		bra		p_1078
		movlw	7
		cpfseq	60h,BANKED
		bra		p_146A
		swapf	79h,W,BANKED
		andlw	0Fh
		movwf	41h
		bz		p_1072
		movlw	1
		cpfseq	41h
		bra		p_1068
		btfss	35h,7
		bra		p_146A
		btfss	35h,6
		bra		p_146A
		bra		p_1072
p_1068	movlw	2						; entry from: 105Ch
		cpfseq	41h
		bra		p_146A
		btfss	35h,6
		bra		p_146A

p_1072	movff	41h,0A6h				; entry from: 1056h,1066h
		bra		p__E9E
p_1078	movlw	48h						; entry from: 1048h
		cpfseq	66h,BANKED
		bra		p_10BA
		movlw	9
		cpfseq	60h,BANKED
		bra		p_10A0
		clrf	0A7h,BANKED
		clrf	0A8h,BANKED
		swapf	79h,W,BANKED
		andlw	7
		movwf	0A9h,BANKED
		movlw	0F0h
		andwf	7Ah,f,BANKED
		movlw	0Fh
		andwf	79h,W,BANKED
		iorwf	7Ah,W,BANKED
		movwf	0AAh,BANKED
		swapf	0AAh,f,BANKED
		bsf		35h,7
		bra		p__E9E
p_10A0	movlw	0Eh						; entry from: 1082h
		cpfseq	60h,BANKED
		bra		p_146A
		movff	79h,0A7h
		movff	7Ah,0A8h
		movff	7Bh,0A9h
		movff	7Ch,0AAh
		bsf		35h,7
		bra		p__E9E
p_10BA	movlw	44h						; entry from: 107Ch
		cpfseq	66h,BANKED
		bra		p_146A
		btfsc	60h,0,BANKED
		bra		p_146A
		movlw	7
		cpfsgt	60h,BANKED
		bra		p_146A
		movf	95h,W,BANKED
		movwf	0ACh,BANKED
		movwf	0ADh,BANKED
		movwf	0AEh,BANKED
		movwf	0AFh,BANKED
		movlw	0Fh
		cpfslt	60h,BANKED
		movff	7Dh,0AFh
		movlw	0Dh
		cpfslt	60h,BANKED
		movff	7Ch,0AEh
		movlw	0Bh
		cpfslt	60h,BANKED
		movff	7Bh,0ADh
		movlw	9
		cpfslt	60h,BANKED
		movff	7Ah,0ACh
		movff	79h,0ABh
		movlw	6
		subwf	60h,W,BANKED
		movwf	0B0h,BANKED
		rrncf	0B0h,f,BANKED
		bsf		35h,6
		bra		p__E9E
p_1104	movlw	5						; entry from: 15Ah
		cpfseq	3Dh
		bra		p_146A
		bra		p_157A
p_110C	movlw	48h						; entry from: 254h
		cpfseq	78h,BANKED
		bra		p_1116
		bsf		2Dh,0
		bra		p_111E
p_1116	movlw	96h						; entry from: 1110h
		cpfseq	78h,BANKED
		bra		p_1122
		bcf		2Dh,0
p_111E	bsf		2Dh,1					; entry from: 1114h
		bra		p_1462
p_1122	movlw	10h						; entry from: 111Ah
		cpfseq	78h,BANKED
		bra		p_146A
		bcf		2Dh,1
		bra		p_1462
p_112C	movlw	41h						; entry from: 2B6h
		cpfseq	65h,BANKED
		bra		p_146A
		rcall	p_1466
		rcall	p_113A
		movwf	0BFh,BANKED
		bra		p_1462

p_113A	swapf	78h,W,BANKED			; entry from: 0CD8h,1134h,153Eh
		andlw	0F0h
		movwf	45h
		swapf	79h,W,BANKED
		andlw	0Fh
		iorwf	45h,W
		return	
p_1148	movlw	52h						; entry from: 25Ah
		cpfseq	65h,BANKED
		bra		p_146A
		movlw	31h
		cpfseq	66h,BANKED
		bra		p_1158
		bcf		10h,1
		bra		p_1462
p_1158	movlw	30h						; entry from: 1152h
		cpfseq	66h,BANKED
		bra		p_1164
		bsf		10h,1
		bcf		10h,0
		bra		p_1462
p_1164	movlw	32h						; entry from: 115Ch
		cpfseq	66h,BANKED
		bra		p_1170
		bsf		10h,1
		bsf		10h,0
		bra		p_1462
p_1170	movlw	48h						; entry from: 1168h
		cpfseq	66h,BANKED
		bra		p_117A
		bcf		10h,2
		bra		p_1462
p_117A	movlw	53h						; entry from: 1174h
		cpfseq	66h,BANKED
		bra		p_146A
		bsf		10h,2
		bra		p_1462
p_1184	movlw	4Eh						; entry from: 21Ch
		cpfseq	65h,BANKED
		bra		p_146A
		movlw	4Fh
		call	p__7F2
		btfss	PORTC,4
		bra		p_119C
		movlw	4Eh
		call	p__7F2
		bra		p_11F4
p_119C	movlw	46h						; entry from: 1192h
		call	p__7F2
		movlw	46h
		call	p__7F2
		bra		p_11F4
p_11AA	movlw	31h						; entry from: 222h
		cpfseq	65h,BANKED
		bra		p_11B4
		bcf		2Dh,6
		bra		p_1462
p_11B4	tstfsz	78h,BANKED				; entry from: 11AEh
		bra		p_146A
		bsf		2Dh,6
		bra		p_1462
p_11BC	movlw	31h						; entry from: 178h
		call	p__834
		btfss	8Dh,0,BANKED
		bra		p_11DA
		movf	0C0h,W,BANKED
		call	p__74C
		movlw	32h
		call	p__834
		movf	0C1h,W,BANKED
		call	p__74C
		bra		p_11F4
p_11DA	call	p_1528					; entry from: 11C4h
		call	p_1528
		call	p__7F0
		movlw	32h
		call	p__834
		call	p_1528
		call	p_1528

p_11F4	goto	p_1830					; entry from: 119Ah,11A8h,11D8h
p_11F8	btfss	1Ch,7					; entry from: 18Ah
		bra		p_146A
		movlw	0B4h
		call	p__730
		rcall	p_1030
		bra		p_1222

p_1206	call	p__724					; entry from: 18B8h,18F4h
		movlw	4Ch
		call	p__7F2
		movlw	50h
		call	p__7F2
		movlw	1Dh
		call	p__730
		rcall	p_1030
		call	p__B1A
p_1222	call	p__B1A					; entry from: 1204h
		call	p_1FEA
		bcf		LATA,1
		movlw	0F4h
		movwf	PORTB
		call	p__658
		movlw	82h
		btfsc	PIR1,5
		goto	p__6CC
		bsf		BAUDCON1,1
		bsf		PIE1,5
		bsf		INTCON,7
		movlw	2
		movwf	OSCCON
		bsf		LATC,5
		btfsc	1Ch,6
		bcf		LATC,5
		btfss	PORTC,4
		bra		p_1258
		btfsc	19h,3
		bra		p_126A
p_1254	btfsc	PORTC,4					; entry from: 1256h
		bra		p_1254
p_1258	clrf	41h						; entry from: 124Eh
p_125A	btfsc	PORTC,4					; entry from: 1264h
		clrf	41h
		incf	41h
		movlw	49h
		cpfsgt	41h
		bra		p_125A
p_1266	btfss	PORTC,4					; entry from: 1268h
		bra		p_1266

p_126A	clrf	41h						; entry from: 1252h,1276h
		movlw	16h
		btfss	1Ch,1
		movlw	5
		movwf	42h
p_1274	btfss	PORTC,4					; entry from: 127Eh
		bra		p_126A
		decfsz	41h
		bra		p_127E
		decfsz	42h
p_127E	bra		p_1274					; entry from: 127Ah
p_1280	bcf		INTCON,7				; entry from: 0Ah
		bcf		PIE1,5
		bcf		BAUDCON1,1
		clrf	OSCCON
p_1288	btfss	OSCCON,3				; entry from: 128Ah
		bra		p_1288
		bcf		LATC,5
		btfsc	1Ch,6
		bsf		LATC,5
		call	p__B1A
		goto	p_1650

p_129A	clrf	11h						; entry from: 19Ch,1826h
		bsf		11h,4
		goto	p_1D68
p_12A2	rcall	p_1466					; entry from: 2D0h
		movwf	39h
		movff	79h,3Ah
		bra		p__F30
p_12AC	rcall	p_1466					; entry from: 2ECh
		movwf	38h
		movff	79h,39h
		movff	7Ah,3Ah
		bra		p__F32
p_12BA	rcall	p_1466					; entry from: 260h
		movwf	15h
		movlw	40h
		bra		p_12C8
p_12C2	rcall	p_1466					; entry from: 266h
		movwf	15h
		movlw	20h
p_12C8	movwf	11h						; entry from: 12C0h
		goto	p_1D68
p_12CE	rcall	p_1466					; entry from: 2D6h
		movlw	41h
		cpfslt	79h,BANKED
		bra		p_146A
		movff	78h,9Ah
		movff	79h,9Bh
		bra		p_1462
p_12E0	call	p_1FEA					; entry from: 1A8h
		bra		p_1462
p_12E6	rcall	p_13C2					; entry from: 2DCh
		bsf		0CCh,0,BANKED
		movlw	4Fh
		cpfseq	67h,BANKED
		bra		p_13F2
		movlw	4Eh
		cpfseq	68h,BANKED
		bra		p_13F2
		clrf	0CDh,BANKED
		bra		p_1378
p_12FA	rcall	p_13C2					; entry from: 2E4h
		bsf		0CCh,0,BANKED
		movlw	4Fh
		cpfseq	67h,BANKED
		bra		p_13F2
		movlw	46h
		cpfseq	68h,BANKED
		bra		p_13F2
		cpfseq	69h,BANKED
		bra		p_13F2
		setf	0CDh,BANKED
		bra		p_1378
p_1312	rcall	p_13C2					; entry from: 2F2h
		infsnz	0CCh,W,BANKED
		bra		p_13F2
		movlw	53h
		cpfseq	67h,BANKED
		bra		p_13F2
		movlw	56h
		cpfseq	68h,BANKED
		bra		p_13F2
		movf	69h,W,BANKED
		call	p_13E2
		movwf	0CDh,BANKED
		swapf	0CDh,f,BANKED
		movf	6Ah,W,BANKED
		call	p_13E2
		iorwf	0CDh,f,BANKED
		rrncf	0CCh,W,BANKED
		xorlw	4
		bnz		p_1340
		movlw	3
		bra		p_1374
p_1340	rrncf	0CCh,W,BANKED			; entry from: 133Ah
		xorlw	0Ch
		bnz		p_134E
		movlw	7
		cpfsgt	0CDh,BANKED
		bra		p_13F2
		bra		p_1378
p_134E	rrncf	0CCh,W,BANKED			; entry from: 1344h
		xorlw	2Bh
		bz		p_1360
		rrncf	0CCh,W,BANKED
		xorlw	2Dh
		bz		p_1360
		rrncf	0CCh,W,BANKED
		xorlw	2Fh
		bnz		p_1368

p_1360	movf	0CDh,W,BANKED			; entry from: 1352h,1358h
		bz		p_13F2
		movlw	41h
		bra		p_1374
p_1368	rrncf	0CCh,W,BANKED			; entry from: 135Eh
		xorlw	7
		bnz		p_1378
		movf	0CDh,W,BANKED
		bz		p_13F2
		movlw	0Dh

p_1374	cpfslt	0CDh,BANKED				; entry from: 133Eh,1366h
		bra		p_13F2

p_1378	incf	0CCh,W,BANKED			; entry from: 12F8h,1310h,134Ch,136Ch
		bz		p_1398
		movlw	0Ch
		addwf	0CCh,W,BANKED
p_1380	movwf	0CCh,BANKED				; entry from: 1534h
		call	p__838
		xorwf	0CDh,W,BANKED
		btfsc	STATUS,2
		bra		p_1462
		bsf		EECON1,2
		movf	0CDh,W,BANKED
		call	p__A00
		bcf		EECON1,2
		bra		p_1462
p_1398	movlw	30h						; entry from: 137Ah
		movwf	41h
		movlw	0Ch
		iorlw	1
		movwf	EEADR
		bsf		EECON1,2
p_13A4	call	p__838					; entry from: 13BCh
		xorwf	0CDh,W,BANKED
		bz		p_13B4
		movf	0CDh,W,BANKED
		call	p__A00
		bra		p_13B6
p_13B4	incf	EEADR						; entry from: 13AAh
p_13B6	incf	EEADR,W					; entry from: 13B2h
		movwf	EEADR
		decfsz	41h
		bra		p_13A4
		bcf		EECON1,2
		bra		p_1462

p_13C2	movf	65h,W,BANKED			; entry from: 12E6h,12FAh,1312h
		call	p_13E2
		movwf	0CCh,BANKED
		swapf	0CCh,f,BANKED
		movf	66h,W,BANKED
		call	p_13E2
		iorwf	0CCh,f,BANKED
		infsnz	0CCh,W,BANKED
		return	
		movlw	30h
		cpfslt	0CCh,BANKED
		bra		p_13F0
		rlncf	0CCh,f,BANKED
		return	

p_13E2	call	p__52A					; entry from: 1326h,1330h,13C4h,13CEh
		movwf	42h
		infsnz	42h,W
		bra		p_13F0
		movf	42h,W
		return	

p_13F0	clrf	STKPTR					; entry from: 13DCh,13EAh

p_13F2	bra		p_146A					; entry from: 12EEh,12F4h,1302h,1308h,130Ch,1316h,131Ch,1322h,134Ah,1362h,1370h,1376h
p_13F4	movlw	53h						; entry from: 228h
		cpfseq	65h,BANKED
		bra		p_146A
		movlw	0Ch
		movwf	0CCh,BANKED
		clrf	41h
p_1400	rcall	p_1034					; entry from: 1460h
		movlw	4
		movwf	42h
p_1406	movlw	4						; entry from: 145Eh
		movwf	43h
p_140A	movlw	30h						; entry from: 144Eh
		cpfslt	41h
		bra		p_1450
		swapf	41h,W
		call	p__71C
		movf	41h,W
		call	p__71C
		call	p__720
		movf	0CCh,W,BANKED
		call	p__838
		call	p__74C
		incf	0CCh,f,BANKED
		movf	0CCh,W,BANKED
		call	p__838
		btfss	STATUS,2
		movlw	46h
		btfsc	STATUS,2
		movlw	4Eh
		call	p__7F2
		incf	0CCh,f,BANKED
		incf	41h
		decf	43h
		bz		p_1450
		call	p__7F0
		call	p__7F0
		bra		p_140A

p_1450	call	p__724					; entry from: 140Eh,1444h
		movlw	30h
		cpfslt	41h
		goto	p_1834
		decfsz	42h
		bra		p_1406
		bra		p_1400

p_1462	goto	p__E9E					; entry from: 1120h,112Ah,1138h,1156h,1162h,116Eh,1178h,1182h,11B2h,11BAh,12DEh,12E4h,138Ah,1396h,13C0h,1544h,1556h,156Ch,1584h,1590h,1598h,15A4h,15ACh,15CEh,15DCh,164Eh

p_1466	goto	p__EA4					; entry from: 1132h,12A2h,12ACh,12BAh,12C2h,12CEh,152Eh,1536h,1546h,1558h,157Eh,1586h,1592h,15A6h,15AEh,15DEh

p_146A	goto	p__EAC					; entry from: 101Eh,1042h,104Eh,1060h,1064h,106Ch,1070h,10A4h,10BEh,10C2h,10C8h,1108h,1126h,1130h,114Ch,117Eh,1188h,11B6h,11FAh,12D4h,13F2h,13F8h,147Eh,1484h,153Ch,1572h,1578h,15B6h,15F2h,15FEh,1610h
p_146E	movlw	7Ch						; entry from: 1BAh
		call	p__838
		call	p__7AA
		bra		p_1830
p_147A	movlw	52h						; entry from: 22Eh
		cpfseq	65h,BANKED
		bra		p_146A
		btfsc	3Eh,6
		btfss	3Eh,0
		bra		p_146A
		clrf	41h
		bra		p_1A02
p_148A	call	p__99E					; entry from: 1C0h
		bcf		STATUS,0
		rrcf	0CAh,W,BANKED
		movwf	31h
		rrcf	0CBh,W,BANKED
		movwf	32h
		clrf	2Fh
		clrf	30h
		movf	ADRESL,W
		mulwf	0C9h,BANKED
		movf	PRODL,W
		addwf	32h
		movf	PRODH,W
		addwfc	31h
		movf	ADRESH,W
		mulwf	0C9h,BANKED
		movf	PRODL,W
		addwf	31h
		movf	PRODH,W
		addwfc	30h
		movf	ADRESL,W
		mulwf	0C8h,BANKED
		movf	PRODL,W
		addwf	31h
		movf	PRODH,W
		addwfc	30h
		movf	ADRESH,W
		mulwf	0C8h,BANKED
		movf	PRODL,W
		addwf	30h
		movf	PRODH,W
		addwfc	2Fh
		movff	0CAh,7Ah
		movff	0CBh,7Bh
		call	p__AE2
		iorlw	0
		bnz		p_151A
		movlw	27h
		cpfslt	7Ch,BANKED
		bra		p_151A
		movlw	5
		addwf	7Dh,W,BANKED
		movwf	32h
		movlw	0
		addwfc	7Ch,W,BANKED
		movwf	31h
		call	p__3C6
		iorlw	0
		bnz		p_151A
		movf	2Fh,W
		tstfsz	2Fh
		call	p__71C
		movf	30h,W
		call	p__71C
		movlw	2Eh
		call	p__7F2
		movf	31h,W
		call	p__71C
p_1510	movlw	56h						; entry from: 1526h
		call	p__7F2
		goto	p_1830

p_151A	rcall	p_1528					; entry from: 14DAh,14E0h,14F4h
		rcall	p_1528
		movlw	2Eh
		call	p__7F2
		rcall	p_1528
		bra		p_1510

p_1528	movlw	2Dh						; entry from: 11DAh,11DEh,11ECh,11F0h,151Ah,151Ch,1524h
		goto	p__7F2
p_152E	rcall	p_1466					; entry from: 284h
		movwf	0CDh,BANKED
		movlw	7Ch
		bra		p_1380
p_1536	rcall	p_1466					; entry from: 2B0h
		movlw	41h
		cpfseq	65h,BANKED
		bra		p_146A
		rcall	p_113A
		movwf	16h
		bsf		18h,1
		bra		p_1462
p_1546	rcall	p_1466					; entry from: 2F8h
		movwf	12h
		movff	79h,13h
		movff	7Ah,14h
		bsf		0Fh,4
		bsf		34h,4
		bra		p_1462
p_1558	rcall	p_1466					; entry from: 2BCh
		clrf	12h
		call	p__E48
		andlw	7
		movwf	13h
		movff	79h,14h
		bsf		0Fh,4
		bsf		34h,4
		bra		p_1462
p_156E	movlw	5						; entry from: 1D2h
		cpfslt	3Dh
		bra		p_146A
		movlw	2
		cpfsgt	3Dh
		bra		p_146A
p_157A	bsf		2Dh,7					; entry from: 110Ah
		bra		p_1AFE

p_157E	rcall	p_1466					; entry from: 26Ch,28Ah
		movwf	93h,BANKED
		bsf		10h,4
		bra		p_1462
p_1586	rcall	p_1466					; entry from: 290h
		btfsc	STATUS,2
		movf	80h,W,BANKED
		movwf	7Eh,BANKED
		bsf		0Fh,6
		bra		p_1462
p_1592	rcall	p_1466					; entry from: 296h
		bnz		p_159A
		bsf		2Ch,4
		bra		p_1462
p_159A	movwf	86h,BANKED				; entry from: 1594h
		movlw	0F5h
		cpfslt	86h,BANKED
		movwf	86h,BANKED
		bcf		2Ch,4
		bra		p_1462
p_15A6	rcall	p_1466					; entry from: 278h
		movwf	94h,BANKED
		movwf	0BEh,BANKED
		bra		p_1462

p_15AE	rcall	p_1466					; entry from: 234h,23Ah
		swapf	78h,W,BANKED
		sublw	0Ch
		btfss	STATUS,0
		bra		p_146A
		bsf		3Eh,7
		movf	78h,f,BANKED
		bz		p_15C8
		bcf		3Eh,7

p_15C0	movlw	53h						; entry from: 1604h,160Ah
		xorwf	63h,W,BANKED
		btfsc	STATUS,2
		bsf		3Eh,2

p_15C8	swapf	78h,W,BANKED			; entry from: 15BCh,1606h
		xorwf	3Dh,W
		btfsc	STATUS,2
		bra		p_1462
		call	p_1FEA
		swapf	78h,W,BANKED
		movwf	3Dh
		call	p_26DE
		bra		p_1462

p_15DE	rcall	p_1466					; entry from: 272h,27Eh
		bz		p_1608
		andlw	0Fh
		xorlw	0Ah
		bz		p_15F4
		swapf	78h,W,BANKED
		movwf	78h,BANKED
		andlw	0Fh
		xorlw	0Ah
		bz		p_15F4
		bra		p_146A

p_15F4	movlw	0F0h					; entry from: 15E6h,15F0h
		andwf	78h,f,BANKED
		swapf	78h,W,BANKED
		sublw	0Ch
		btfss	STATUS,0
		bra		p_146A
		bsf		3Eh,7
		tstfsz	78h,BANKED
		bra		p_15C0
		bra		p_15C8
p_1608	bsf		3Eh,7					; entry from: 15E0h
		bra		p_15C0
p_160C	btfsc	72h,4,BANKED			; entry from: 1A66h
		btfsc	60h,0,BANKED
		bra		p_146A
		bsf		2Ch,5
		movlw	4
		subwf	60h,W,BANKED
		movwf	22h
		bcf		STATUS,0
		rrcf	22h
		movff	78h,23h
		movff	79h,24h
		movff	7Ah,25h
		movff	7Bh,26h
		movff	7Ch,27h
		movff	7Dh,28h
		movlw	0
		movwf	FSR0H
		movlw	23h
		movwf	FSR0L
		movlw	0
		movff	22h,41h
p_1644	addwf	POSTINC0,W				; entry from: 1648h
		decfsz	41h
		bra		p_1644
		movwf	INDF0
		incf	22h
		bra		p_1462

p_1650	movlw	20h						; entry from: 1EAh,1296h
		bra		p_1666
p_1654	clrf	OSCCON					; entry from: 2
		comf	RCON,W
		setf	RCON
		clrwdt
		andlw	1Bh
		btfsc	STKPTR,7
		iorlw	0A0h
		btfsc	STKPTR,6
		iorlw	60h
#if EEPROM_PAGE != 0
		movlw	EEPROM_PAGE
		movwf	EEADRH
#endif
#if SW_VERSION != 0
		call	eep_copy
#endif
p_1666	movlb	0						; entry from: 1652h
		movwf	0D0h,BANKED
		clrf	STKPTR
		btfsc	0D0h,1,BANKED
		bcf		0D0h,0,BANKED
		btfss	0D0h,4,BANKED
		bra		p_1678
		tstfsz	0D1h,BANKED
		bsf		0D0h,5,BANKED
p_1678	clrf	8Eh,BANKED				; entry from: 1672h
		movlw	0FFh
		movwf	0CDh,BANKED
		movlw	30h
		call	p__98C
		addlw	1
		bz		p_168A
		bsf		8Eh,1,BANKED
p_168A	movlw	0F9h					; entry from: 1686h
		xorwf	8Eh,W,BANKED
		movwf	PORTA
		movlw	0F9h
		movwf	TRISA
		call	p_4028
		movlw	0
		movwf	ADCON1
		movlw	86h
		movwf	ADCON2
		movlw	0F4h
		movwf	PORTB
		btfss	0D0h,1,BANKED
		bra		p_16B0
		movlw	7Fh
		movwf	INTCON2
		movlw	0E8h
		bra		p_16B2
p_16B0	movlw	8						; entry from: 16A6h
p_16B2	movwf	TRISB					; entry from: 16AEh
		movlw	0
		movwf	CCP1CON
		movlw	9Ah
		movwf	0CDh,BANKED
		movlw	28h
		call	p__98C
		movwf	1Ch
		movlw	0F0h
		btfss	1Ch,7
		bra		p_16CE
		btfss	1Ch,6
		andlw	0DFh
p_16CE	movwf	PORTC					; entry from: 16C8h
		movlw	97h
		movwf	TRISC
		btfsc	0D0h,5,BANKED
		bra		p_16DE
		rlncf	PORTA,W
		movwf	8Ch,BANKED
		rlncf	8Ch,f,BANKED
p_16DE	lfsr	1,200h					; entry from: 16D6h
		lfsr	2,200h
		lfsr	0,0
#if DATA_OFFSET == 0
		clrf	TBLPTRH
#else
		movlw	high(DATA_OFFSET) + 0
		movwf	TBLPTRH
#endif
		movlw	80h
		movwf	EECON1
		bsf		CANCON,7
		clrf	97h,BANKED
		btfss	0D0h,1,BANKED
		bra		p_1706
		clrf	0D2h,BANKED
		call	p__492
		movlw	0FFh
		movwf	INTCON2
		movlw	8
		movwf	TRISB
p_1706	clrf	3Ch						; entry from: 16F6h
		movlw	0Dh
		movwf	0CDh,BANKED
		movlw	2Ch
		call	p__98C
		movwf	3Bh
		btfss	0D0h,5,BANKED
		bra		p_171C
		movwf	3Ch
		bra		p_1730
p_171C	movlw	7Ch						; entry from: 1716h
p_171E	movwf	LATB					; entry from: 172Ch
		call	p__B26
		bsf		STATUS,0
		rrcf	WREG,W
		andlw	0FCh
		btfsc	WREG,3
		bra		p_171E
		movwf	LATB
p_1730	btfss	TXSTA1,1				; entry from: 171Ah
		call	p__B2A
		clrf	SPBRGH1
		nop
		nop
		movf	0CFh,W,BANKED
		btfss	0D0h,5,BANKED
		call	p__900
		movwf	0CFh,BANKED
		movlw	8
		cpfsgt	0CFh,BANKED
		movwf	0CFh,BANKED
		decf	0CFh,W,BANKED
		bra		p_1754
		incf	SPBRGH1
		movlw	0A0h
p_1754	movwf	SPBRG1					; entry from: 174Eh
		movlw	8
		movwf	BAUDCON1
		movlw	25h
		movwf	TXSTA1
		movlw	90h
		movwf	RCSTA1
		call	p__658
		clrf	8Dh,BANKED
		call	p__8E2
		movwf	94h,BANKED
		call	p__8F2
		btfsc	STATUS,2
		bsf		8Dh,6,BANKED
		call	p__8F8
		movwf	8Ah,BANKED
		call	p__908
		movwf	8Bh,BANKED
		call	p__926
		btfsc	STATUS,2
		bsf		8Dh,7,BANKED
		call	p__964
		movwf	99h,BANKED
		movlw	40h
		cpfslt	99h,BANKED
		movwf	99h,BANKED
		movlw	0F9h
		movwf	0BEh,BANKED
		call	p__96C
		movwf	9Ah,BANKED
		call	p__974
		movwf	9Bh,BANKED
		movlw	40h
		cpfslt	9Bh,BANKED
		movwf	9Bh,BANKED
		call	p__97C
		movwf	9Ch,BANKED
		call	p__984
		movwf	9Dh,BANKED
		movlw	40h
		cpfslt	9Dh,BANKED
		movwf	9Dh,BANKED
		movlw	0C5h
		movwf	T0CON
		clrf	TMR0L
		clrf	2Ch
		clrf	1Ah
		clrf	3Eh
		clrf	60h,BANKED
		clrf	72h,BANKED
		clrf	0B1h,BANKED
		clrf	0B2h,BANKED
		call	p__A1E
		movlw	0
		btfsc	0D0h,3,BANKED
		movlw	91h
		btfsc	0D0h,6,BANKED
		movlw	92h
		btfsc	0D0h,7,BANKED
		movlw	93h
		btfsc	0D0h,4,BANKED
		movf	0D1h,W,BANKED
		iorlw	0
		btfss	STATUS,2
		goto	p__6CC
		call	p__724
		call	p__724
		btfss	0D0h,0,BANKED
		bra		p_1802
		bsf		0D2h,6,BANKED
		movlw	0E2h
		bra		p_182C
p_1802	bcf		0D2h,6,BANKED			; entry from: 17FAh
		call	p__8C0
		bnz		p_182A
		movlw	82h
		call	p__730
		call	p__724
		call	p__724
		movlw	0D0h
		call	p__730
		call	p__724
		call	p__658
		goto	p_129A

p_182A	movlw	82h						; entry from: 10Ah,1808h

p_182C	call	p__730					; entry from: 6C2h,82Ah,0C3Eh,0EA0h,0EAEh,1800h,1840h,1D38h

p_1830	call	p__724					; entry from: 700h,0E9Ah,11F4h,1478h,1516h

p_1834	btfss	19h,4					; entry from: 672h,6BCh,0D58h,1458h,1B58h,1BC8h,1C36h,1CACh,1D2Eh,1D88h
		bra		p_1842
		bcf		19h,4
		btfss	19h,7
		bra		p_1842
		movlw	0C8h
		bra		p_182C

p_1842	call	p__724					; entry from: 1836h,183Ch
		call	p__5D4
		btfsc	3Eh,2
		call	p__9C4
		bcf		3Eh,2
		bcf		19h,6
		bcf		2Dh,7
		btfss	PIR1,5
		bra		p_185E
		clrf	20h
		bcf		LATB,4
p_185E	bcf		34h,3					; entry from: 1858h
		clrf	0B3h,BANKED
		btfsc	3Eh,0
		btfsc	CANSTAT,7
		bra		p_187E
		movf	CANSTAT,W
		andlw	0E0h
		bnz		p_1876
		btfsc	COMSTAT,5
		bra		p_1876
		btfss	COMSTAT,0
		bra		p_187E

p_1876	call	p_3CCE					; entry from: 186Ch,1870h
		call	p_3B7C

p_187E	call	p__658					; entry from: 1866h,1874h
		btfss	1Ch,7
		bcf		LATC,5
		movlw	0B8h
		call	p__730
		movlw	70h
		andwf	72h,f,BANKED
		movlw	61h
		movwf	74h,BANKED
		movff	61h,71h
		bcf		1Ch,0
		bcf		19h,3
		clrf	88h,BANKED
		clrf	89h,BANKED
		movlw	10h
		call	p__B12
p_18A6	btfsc	1Ch,2					; entry from: 192Ch
		btfsc	PORTC,4
		clrf	21h
		call	p__40C
		btfsc	1Ch,7
		btfss	0Fh,1
		bra		p_18BA
		bsf		19h,3
		bra		p_1206
p_18BA	btfsc	2Ch,7					; entry from: 18B4h
		btfss	2Ch,6
		bra		p_18C4
		call	p_1E2A
p_18C4	btfsc	LATB,4					; entry from: 18BEh
		bra		p_18D0
		bcf		72h,2,BANKED
		bcf		1Ch,0
		clrf	88h,BANKED
		clrf	89h,BANKED
p_18D0	btfsc	20h,7					; entry from: 18C6h
		bsf		72h,2,BANKED
		btfss	20h,7
		btfss	72h,2,BANKED
		bra		p_192A
		bcf		72h,2,BANKED
		incf	88h,f,BANKED
		movlw	13h
		cpfsgt	88h,BANKED
		bra		p_18E8
		btfsc	72h,7,BANKED
		bra		p_1AFA
p_18E8	call	p__40C					; entry from: 18E2h
		movlw	39h
		cpfsgt	88h,BANKED
		bra		p_192A
		btfsc	1Ch,0
		bra		p_1206
		incf	89h,f,BANKED
		clrf	88h,BANKED
		btfsc	1Ch,7
		btfss	1Ch,5
		bra		p_192A
		movlw	4
		btfsc	1Ch,4
		movlw	13h
		btfsc	LATB,4
		cpfseq	89h,BANKED
		bra		p_192A
		bsf		1Ch,0
		btfss	1Ch,3
		bra		p_192A
		call	p__724
		movlw	1Ah
		call	p__730
		call	p__724
		call	p__724
		movlw	3Eh
		call	p__7F2

p_192A	btfss	72h,0,BANKED			; entry from: 18D8h,18F0h,18FEh,190Ah,1910h
		bra		p_18A6
		bsf		72h,1,BANKED
		movlw	61h
		movwf	FSR0L
		subwf	74h,W,BANKED
		bnz		p_193E
		movff	71h,61h
		bra		p_194E
p_193E	movwf	60h,BANKED				; entry from: 1936h
		movwf	41h
p_1942	bcf		INDF0,7					; entry from: 194Ch
		btfsc	INDF0,6
		bcf		INDF0,5
		incf	FSR0L
		decfsz	41h
		bra		p_1942
p_194E	incf	SPBRG1,W				; entry from: 193Ch
		movwf	41h
		rrcf	41h
		bcf		41h,7
p_1956	call	p__B4A					; entry from: 1972h
		btfss	PIR1,5
		bra		p_1964
		movf	RCREG1,W
		xorwf	8Ah,W,BANKED
		bz		p_1974
p_1964	movf	RCSTA1,W				; entry from: 195Ch
		andlw	6
		btfss	STATUS,2
		bcf		RCSTA1,4
		btfss	STATUS,2
		bsf		RCSTA1,4
		decfsz	41h
		bra		p_1956
p_1974	btfsc	17h,2					; entry from: 1962h
		btfss	17h,7
		bra		p_1980
		movf	8Ah,W,BANKED
		call	p__7F2
p_1980	incf	SPBRG1,W				; entry from: 1978h
		movwf	41h
p_1984	call	p__5D4					; entry from: 198Ah
		decfsz	41h
		bra		p_1984
		bcf		19h,7
		call	p__658
		bsf		73h,7,BANKED
		movlw	0
		movwf	FSR0H
		movlw	60h
		movwf	FSR0L
		movf	60h,W,BANKED
		btfss	STATUS,2
		btfsc	72h,6,BANKED
		bra		p_1AFA
		movwf	41h
		movlw	76h
		movwf	43h
p_19AA	incf	FSR0L					; entry from: 19F6h
		movf	INDF0,W
		call	p__52A
		movwf	42h
		incfsz	42h,W
		bra		p_19C8
		bcf		72h,5,BANKED
		movlw	65h
		cpfslt	FSR0L
		bcf		72h,4,BANKED
		movlw	67h
		cpfslt	FSR0L
		bcf		73h,7,BANKED
		clrf	42h
p_19C8	movff	FSR0L,44h				; entry from: 19B6h
		movff	43h,FSR0L
		movlw	61h
		andlw	1
		bnz		p_19DC
		btfss	44h,0
		bra		p_19E0
		bra		p_19E6
p_19DC	btfss	44h,0					; entry from: 19D4h
		bra		p_19E6
p_19E0	swapf	42h,W					; entry from: 19D8h
		movwf	INDF0
		bra		p_19EC

p_19E6	movf	42h,W					; entry from: 19DAh,19DEh
		iorwf	INDF0
		incf	FSR0L
p_19EC	movff	FSR0L,43h				; entry from: 19E4h
		movff	44h,FSR0L
		decfsz	41h
		bra		p_19AA
		btfsc	72h,5,BANKED
		dcfsnz	60h,W,BANKED
		bra		p_1A3E
		movff	60h,41h
p_1A02	setf	81h,BANKED				; entry from: 1488h
		btfss	41h,0
		bra		p_1A0E
		movf	42h,W
		movwf	81h,BANKED
		decf	41h
p_1A0E	movlw	0Fh						; entry from: 1A06h
		btfss	3Eh,0
		bra		p_1A2A
		btfsc	97h,2,BANKED
		bra		p_1A32
		btfsc	97h,1,BANKED
		btfss	17h,0
		bra		p_1A24
		btfsc	18h,1
		movlw	0Dh
		bra		p_1A2E
p_1A24	btfss	18h,1					; entry from: 1A1Ch
		bra		p_1A32
		bra		p_1A2E
p_1A2A	btfsc	17h,4					; entry from: 1A12h
		bra		p_1A32

p_1A2E	cpfslt	41h						; entry from: 1A22h,1A28h
		bra		p_1AFA

p_1A32	rrncf	41h,W					; entry from: 1A16h,1A26h,1A2Ch
		movwf	75h,BANKED
		btfsc	18h,0
		call	p_1034
		bra		p_1AFE
p_1A3E	call	p_1034					; entry from: 19FCh
		movlw	2
		cpfsgt	60h,BANKED
		bra		p_1AFA
		movlw	41h
		cpfseq	61h,BANKED
		bra		p_1AFA
		movlw	54h
		cpfseq	62h,BANKED
		bra		p_1AFA
		movlw	5
		cpfsgt	60h,BANKED
		bra		p_1A6A
		movlw	57h
		cpfseq	63h,BANKED
		bra		p_1A6A
		movf	64h,W,BANKED
		xorlw	4Dh
		btfsc	STATUS,2
		goto	p_160C

p_1A6A	movlw	0FCh					; entry from: 1A58h,1A5Eh
		cpfseq	77h,BANKED
		bra		p_1A7A
		movf	65h,W,BANKED
		xorlw	53h
		btfsc	STATUS,2
		goto	p_1040
p_1A7A	movlw	high(TABLE_OFFSET) + 1						; entry from: 1A6Eh
		movwf	TBLPTRH
		movlw	3
		subwf	60h,W,BANKED
		movwf	41h
		btfsc	STATUS,2
		movlw	2
		dcfsnz	41h
		movlw	16h
		tstfsz	41h
		btfsc	41h,7
		bra		p_1ACC
		incf	TBLPTRH
		dcfsnz	41h
		movlw	2
		dcfsnz	41h
		movlw	40h
		dcfsnz	41h
		movlw	9Ch
		dcfsnz	41h
		movlw	0C2h
		dcfsnz	41h
		movlw	0E2h
		dcfsnz	41h
		movlw	0EAh
		tstfsz	41h
		btfsc	41h,7
		bra		p_1ACC
		incf	TBLPTRH
		dcfsnz	41h
		movlw	22h
		dcfsnz	41h
		movlw	6
		dcfsnz	41h
		movlw	14h
		dcfsnz	41h
		movlw	22h
		dcfsnz	41h
		movlw	22h
		dcfsnz	41h
		movlw	1Ch

p_1ACC	movwf	TBLPTRL					; entry from: 1A90h,1AB0h
p_1ACE	tblrd*+							; entry from: 1AF6h
		movf	TABLAT,W
		bz		p_1AF8
		cpfseq	63h,BANKED
		bra		p_1AF0
		tblrd*+
		movf	TABLAT,W
		bz		p_1AE2
		cpfseq	64h,BANKED
		bra		p_1AF2
p_1AE2	movff	TBLPTRH,PCLATH			; entry from: 1ADCh
#if DATA_OFFSET == 0
		clrf	TBLPTRH
#else
		movlw	high(DATA_OFFSET) + 0
		movwf	TBLPTRH
#endif
		movlw	2
		subwf	TBLPTRL,W
		goto	p__100
p_1AF0	incf	TBLPTRL					; entry from: 1AD6h
p_1AF2	movlw	4						; entry from: 1AE0h
		addwf	TBLPTRL
		bra		p_1ACE
#if DATA_OFFSET == 0
p_1AF8	clrf	TBLPTRH					; entry from: 1AD2h
#else
p_1AF8	movlw	high(DATA_OFFSET) + 0			; entry from: 1AD2h
		movwf	TBLPTRH
#endif

p_1AFA	goto	p__EAC					; entry from: 18E6h,19A2h,1A30h,1A46h,1A4Ch,1A52h

p_1AFE	bcf		3Eh,4					; entry from: 157Ch,1A3Ch,1C34h,1CB4h,1D28h,1D32h
		bsf		19h,4
		movff	75h,0
		movff	76h,4
		movff	77h,5
		movff	78h,6
		movff	79h,7
		movff	7Ah,8
		movff	7Bh,9
		movff	7Ch,0Ah
		movff	7Dh,0Bh
		bcf		0Fh,5
		movlw	2
		cpfseq	0
		bra		p_1B3A
		tstfsz	5
		bra		p_1B3A
		dcfsnz	4,W
		bsf		0Fh,5
		btfsc	0Fh,4
		bcf		0Fh,5

p_1B3A	btfss	2Dh,7					; entry from: 1B2Ch,1B30h
		btfss	3Eh,6
		bra		p_1B9A
		rcall	p_1EC4
		call	p__404
		rcall	p_1EDC
		call	p__404
		clrf	11h
		bsf		11h,6
p_1B50	call	p__5D4					; entry from: 1B98h
		tstfsz	81h,BANKED
		btfss	17h,3
		goto	p_1834
		rcall	p_1F12
		call	p__404
p_1B62	btfss	81h,7,BANKED			; entry from: 1BEAh
		decf	81h,f,BANKED
		call	p__5D4
		tstfsz	83h,BANKED
		bra		p_1B76
		movlw	5
		movwf	83h,BANKED
		clrf	84h,BANKED
		clrf	85h,BANKED
p_1B76	btfss	84h,5,BANKED			; entry from: 1B6Ch
		incf	84h,f,BANKED
		incf	85h,f,BANKED
		movlw	0FFh
		btfsc	18h,3
		movlw	3Fh
		andwf	85h,W,BANKED
		bnz		p_1B8E
		decf	83h,f,BANKED
		movlw	5
		cpfsgt	83h,BANKED
		movwf	83h,BANKED
p_1B8E	movf	82h,W,BANKED			; entry from: 1B84h
		btfsc	STATUS,2
		movlw	0FFh
		cpfsgt	83h,BANKED
		movwf	83h,BANKED
		bra		p_1B50
p_1B9A	movff	3Dh,0C4h				; entry from: 1B3Eh
		bcf		2Dh,5
		setf	0C6h,BANKED
		movf	3Dh
		bz		p_1C44
		movlw	2
		cpfsgt	3Dh
		bra		p_1BB2
		movlw	5
		cpfsgt	3Dh
		bra		p_1C26
p_1BB2	bsf		19h,6					; entry from: 1BAAh
		rcall	p_1E76
		bcf		19h,6
		bcf		3Eh,6
		rcall	p_1BEC
		rcall	p_1EC4
		rcall	p_1BEC
		rcall	p_1EDC
		rcall	p_1BEC
		tstfsz	81h,BANKED
		btfss	17h,3
		goto	p_1834
		clrf	98h,BANKED
		movlw	19h
		movff	3Dh,41h
		dcfsnz	41h
		movlw	19h
		dcfsnz	41h
		movlw	19h
		btfss	0Fh,6
		bra		p_1BE4
		cpfslt	7Eh,BANKED
		movf	7Eh,W,BANKED
p_1BE4	rcall	p_1F5A					; entry from: 1BDEh
		rcall	p_1BEC
		bsf		3Eh,6
		bra		p_1B62

p_1BEC	movwf	3Fh						; entry from: 1BBAh,1BBEh,1BC2h,1BE6h
		movf	3Fh
		btfsc	STATUS,2
		return	
		pop
p_1BF6	bcf		3Eh,2					; entry from: 1C3Ch
		rcall	p_1FEA
		btfss	2Dh,7
		btfss	3Eh,7
		bra		p_1C06
		btfsc	19h,7
		bra		p_1D34
		bra		p_1C44
p_1C06	movlw	8						; entry from: 1BFEh
		cpfseq	3Fh
		bra		p_1C1E
		movlw	2
		cpfsgt	3Dh
		bra		p_1C20
		movlw	6
		cpfslt	3Dh
		bra		p_1C20
		movlw	0FFh
		movwf	3Fh
		bra		p_1C20
p_1C1E	btfss	19h,7					; entry from: 1C0Ah

p_1C20	goto	p__66A					; entry from: 1C10h,1C16h,1C1Ch
		bra		p_1D34
p_1C26	btfsc	3Eh,6					; entry from: 1BB0h
		rcall	p_1FEA
		rcall	p_1E76
		movwf	3Fh
		xorlw	0
		bnz		p_1C3A
		btfss	2Dh,7
		bra		p_1AFE
		goto	p_1834
p_1C3A	btfss	19h,7					; entry from: 1C30h
		bra		p_1BF6
		call	p_1FEA
		bra		p_1D34

p_1C44	bsf		3Eh,4					; entry from: 1BA4h,1C04h
		call	p__844
		rcall	p_1D3C
		call	p__84A
		movlw	1
		btfss	10h,5
		call	p__B64
		movwf	3Dh
		cpfslt	0C3h,BANKED
		bra		p_1C64
		movlw	1
		movwf	3Dh
		bra		p_1C6A
p_1C64	decf	3Dh,W					; entry from: 1C5Ch
		movwf	0C5h,BANKED
		bnz		p_1C6E
p_1C6A	movff	0C3h,0C5h				; entry from: 1C62h
p_1C6E	movlw	2						; entry from: 1C68h
		cpfseq	3Dh
		bra		p_1C82
		decf	0C4h,W,BANKED
		bnz		p_1C9E
		call	p__916
		addlw	0DBh
		bc		p_1C92
		bra		p_1C9E
p_1C82	movlw	5						; entry from: 1C72h
		btfsc	2Dh,5
		cpfseq	3Dh
		bra		p_1C9E
		call	p__934
		addlw	0C3h
		bnc		p_1C9E

p_1C92	call	p__B12					; entry from: 1C7Eh,1CF2h,1D00h
p_1C96	call	p__5D4					; entry from: 1C9Ch
		btfss	0Fh,1
		bra		p_1C96

p_1C9E	clrf	98h,BANKED				; entry from: 1C76h,1C80h,1C88h,1C90h,1CF0h,1CF8h,1CFEh
		rcall	p_1E76
		movwf	3Fh
		tstfsz	3Fh
		bra		p_1CB6
		bcf		3Eh,4
		btfss	11h,3
		goto	p_1834
		btfsc	19h,7
		bra		p_1D34
		bra		p_1AFE
p_1CB6	rcall	p_1FEA					; entry from: 1CA6h
		btfss	19h,7
		bra		p_1CC2
		movff	0C4h,3Dh
		bra		p_1D34

p_1CC2	movf	3Dh,W					; entry from: 1CBAh,1CDEh,1CE4h
		xorwf	0C5h,W,BANKED
		bz		p_1D02
		rcall	p_1D3C
		incf	3Dh
		movf	0C3h,W,BANKED
		cpfsgt	3Dh
		bra		p_1CD6
		movlw	1
		movwf	3Dh
p_1CD6	btfss	2Dh,5					; entry from: 1CD0h
		bra		p_1CE6
		movlw	3
		xorwf	3Dh,W
		bz		p_1CC2
		movlw	4
		xorwf	3Dh,W
		bz		p_1CC2
p_1CE6	movlw	2						; entry from: 1CD8h
		cpfseq	3Dh
		bra		p_1CF4
		call	p__916
		bz		p_1C9E
		bra		p_1C92
p_1CF4	movlw	5						; entry from: 1CEAh
		cpfseq	3Dh
		bra		p_1C9E
		call	p__934
		bz		p_1C9E
		bra		p_1C92
p_1D02	bcf		3Eh,4					; entry from: 1CC6h
		incfsz	0C6h,W,BANKED
		bra		p_1D18
p_1D08	movff	0C4h,3Dh				; entry from: 1D24h
		call	p_26DE
		movlw	2
		movwf	3Fh
		goto	p__66A
p_1D18	movf	0C6h,W,BANKED			; entry from: 1D06h
		movwf	3Dh
		bsf		19h,6
		rcall	p_1E76
		bcf		19h,6
		btfss	3Eh,6
		bra		p_1D08
		btfss	0Fh,5
		bra		p_1AFE
		btfsc	97h,1,BANKED
		btfss	17h,0
		goto	p_1834
		bra		p_1AFE

p_1D34	bcf		19h,4					; entry from: 1C02h,1C24h,1C42h,1CB2h,1CC0h,1D5Ch,1E28h
		movlw	0C8h
		goto	p_182C

p_1D3C	movlw	5						; entry from: 1C4Ah,1CC8h
		xorwf	3Dh,W
		btfsc	STATUS,2
		btfsc	2Dh,5
p_1D44	return							; entry from: 1D4Eh
		movlw	5
		movwf	45h
		call	p__93A
		bz		p_1D44
		movwf	7Fh,BANKED
p_1D52	clrf	21h						; entry from: 1D64h
		bcf		0Fh,1
p_1D56	call	p__5D4					; entry from: 1D60h
		btfsc	19h,7
		bra		p_1D34
		btfss	0Fh,1
		bra		p_1D56
		decfsz	45h
		bra		p_1D52
		return	

p_1D68	bsf		11h,2					; entry from: 0F3Ch,129Eh,12CAh
		bcf		3Eh,4
		bsf		34h,3
		clrf	98h,BANKED
		bcf		35h,0
		bcf		2Dh,4
		bsf		19h,4
		call	p__84A
		btfss	3Eh,3
		bra		p_1DA2

p_1D7E	rcall	p_1F12					; entry from: 1D92h,1DA0h
		movwf	3Fh
p_1D82	call	p__5D4					; entry from: 1E04h
		btfsc	19h,7
		goto	p_1834
		call	p__63E
		movf	3Fh,W
		bz		p_1D7E
		xorlw	8
		bz		p_1D9C
		goto	p__66A
p_1D9C	clrf	0B3h,BANKED				; entry from: 1D96h
		bsf		0B3h,1,BANKED
		bra		p_1D7E
p_1DA2	movf	3Dh,W					; entry from: 1D7Ch
		movwf	0C4h,BANKED
		btfsc	STATUS,2
		incf	3Dh
		btfss	3Eh,6
		bra		p_1DB8
		rcall	p_1FEA
p_1DB0	rcall	p_2096					; entry from: 1DBAh
		call	p__404
		bra		p_1E00
p_1DB8	btfss	3Eh,7					; entry from: 1DACh
		bra		p_1DB0
		bsf		3Eh,4
		call	p__844
		tstfsz	0C4h,BANKED
		bra		p_1DD4
		call	p__B64
		movwf	3Dh
		xorlw	5
		movlw	3
		btfsc	STATUS,2
		movwf	3Dh
p_1DD4	movf	3Dh,W					; entry from: 1DC4h
		cpfslt	0C3h,BANKED
		bra		p_1DDE
		movlw	1
		movwf	3Dh

p_1DDE	rcall	p_2096					; entry from: 1DD8h,1E22h
		iorlw	0
		bnz		p_1DEA
		clrf	98h,BANKED
		movlw	32h
		rcall	p_1F5A
p_1DEA	movwf	3Fh						; entry from: 1DE2h
		bcf		72h,3,BANKED
		xorlw	0
		bnz		p_1E06
		btfss	3Eh,0
		bra		p_1DFA
		btfsc	11h,1
		bra		p_1E06
p_1DFA	bcf		3Eh,4					; entry from: 1DF4h
		btfsc	17h,5
		bsf		3Eh,2
p_1E00	bsf		3Eh,3					; entry from: 1DB6h
		clrf	3Fh
		bra		p_1D82

p_1E06	rcall	p_1FEA					; entry from: 1DF0h,1DF8h
		movf	3Dh,W
		xorlw	3
		btfsc	STATUS,2
		incf	3Dh
		movf	3Dh,W
		xorlw	4
		btfsc	STATUS,2
		incf	3Dh
		movf	0C3h,W,BANKED
		cpfslt	3Dh
		clrf	3Dh
		incf	3Dh
		btfss	19h,7
		bra		p_1DDE
		movff	0C4h,3Dh
		bra		p_1D34
p_1E2A	btfss	2Ch,4					; entry from: 18C0h
		bra		p_1E34
		bcf		2Ch,7
		bcf		2Ch,4
		retlw	0
p_1E34	movff	22h,0					; entry from: 1E2Ch
		movff	23h,1
		movff	24h,2
		movff	25h,3
		movff	26h,4
		movff	27h,5
		call	p__40C
		movff	28h,6
		movff	29h,7
		rcall	p_1EDC
		call	p__40C
		btfss	2Ch,6
		retlw	0
		movf	86h,W,BANKED
		cpfslt	2Ah
		retlw	0
		rcall	p_1FEA
		call	p__724
		movlw	5
		movwf	3Fh
		goto	p__66A

p_1E76	bcf		3Eh,3					; entry from: 0CCCh,1BB4h,1C2Ah,1CA0h,1D1Eh
		bcf		11h,2
		bcf		2Ch,7
		bcf		11h,7
		bcf		11h,0
		clrf	0C7h,BANKED
		rcall	p_204A
		btfss	3Eh,6
		return	
		btfsc	17h,5
		bsf		3Eh,2
		retlw	0

p_1E8E	cpfslt	7Eh,BANKED				; entry from: 22C0h,275Ch,3356h
		movf	7Eh,W,BANKED
		movwf	8Fh,BANKED
p_1E94	btfsc	11h,0					; entry from: 1EB8h
		bra		p_1EAC
		btfsc	0Fh,0
		bra		p_1EA2
		bsf		11h,0
		bsf		3Eh,6
		bra		p_1EAC
p_1EA2	movf	3Dh,W					; entry from: 1E9Ah
		movwf	0C6h,BANKED
		incf	0C7h,f,BANKED
		btfsc	0C7h,3,BANKED
		retlw	8

p_1EAC	movf	8Fh,W,BANKED			; entry from: 1E96h,1EA0h
		call	p_1FE2
		bcf		72h,3,BANKED
		movwf	3Fh
		movf	3Fh
		bz		p_1E94
		btfss	3Eh,6
		return	
		btfss	0Fh,5
		bsf		11h,3
		retlw	0

p_1EC4	movlw	0						; entry from: 1B40h,1BBCh,229Ah,2736h,30FAh
		movwf	FSR0H
		movlw	0
		movwf	FSR0L
		movff	POSTINC0,42h
		movlw	0Ch
		addlw	0FDh
		cpfslt	42h
		retlw	75h
		rcall	p_20E4
		return	

p_1EDC	movlw	0						; entry from: 1B46h,1BC0h,1E58h,22A2h,273Eh
		movwf	FSR0H
		movlw	1
		movwf	FSR0L
		clrf	11h
		bsf		11h,6
		movf	93h,W,BANKED
		btfsc	10h,4
		bra		p_1EF8
		movf	3,W
		btfsc	3Eh,1
		bra		p_1EF8
		btfss	1,2
		incf	2,W

p_1EF8	movwf	15h						; entry from: 1EECh,1EF2h
		call	p__40C
		rcall	p_2130
		call	p__ADA
		call	p__40C
		clrf	2Ah
		bcf		2Ch,6
		movlw	5
		movwf	2Bh
		retlw	0

p_1F12	btfsc	11h,7					; entry from: 1B5Ch,1D7Eh
		btfsc	3Eh,3
		bra		p_1F58
		btfsc	18h,4
		btfss	3Eh,6
		bra		p_1F58
		movf	83h,W,BANKED
		bz		p_1F58
		movlw	4
		cpfsgt	84h,BANKED
		bra		p_1F58
		movf	83h,W,BANKED
		movwf	7Fh,BANKED
		bcf		STATUS,0
		btfsc	84h,5,BANKED
		bra		p_1F40
		movlw	10h
		cpfslt	84h,BANKED
		bra		p_1F42
		btfss	18h,3
		rlcf	7Fh,f,BANKED
		bnc		p_1F48
		bra		p_1F58
p_1F40	rrcf	7Fh,f,BANKED			; entry from: 1F30h
p_1F42	bcf		STATUS,0				; entry from: 1F36h
		btfsc	18h,3
		rrcf	7Fh,f,BANKED
p_1F48	movf	83h,W,BANKED			; entry from: 1F3Ch
		addwf	7Fh,f,BANKED
		bc		p_1F58
		movlw	0Fh
		cpfsgt	83h,BANKED
		incf	7Fh,f,BANKED
		movf	7Fh,W,BANKED
		cpfsgt	7Eh,BANKED

p_1F58	movf	7Eh,W,BANKED			; entry from: 1F16h,1F1Ch,1F20h,1F26h,1F3Eh,1F4Ch

p_1F5A	btfss	97h,2,BANKED			; entry from: 1BE4h,1DE8h,1FE8h,315Eh
		bra		p_1F76
		movf	7Eh,W,BANKED
		btfss	3Eh,6
		movlw	3Eh
		cpfslt	7Eh,BANKED
		movf	7Eh,W,BANKED
		movwf	41h
		movlw	0FFh
		btfsc	0B3h,3,BANKED
		btfsc	0B3h,4,BANKED
		movf	41h,W
		btfsc	0B3h,1,BANKED
		movf	41h,W
p_1F76	movwf	7Fh,BANKED				; entry from: 1F5Ch
		call	p__63E
		clrf	21h
		bcf		0Fh,1
		bcf		10h,7
		rcall	p_2186
		call	p__ADA
		call	p__63E
		bsf		11h,7
		btfss	1Bh,4
		bra		p_1F98
		btfsc	17h,1
		call	p__7BE
p_1F98	movlw	3						; entry from: 1F90h
		cpfsgt	0
		bsf		0Fh,0
		btfsc	72h,3,BANKED
		bra		p_1FBE
		btfss	0Fh,0
		bra		p_1FB6
		call	p__63E
		movlw	0D8h
		btfsc	3Eh,0
		btfss	11h,1
		movlw	76h
		call	p__730
p_1FB6	call	p__63E					; entry from: 1FA4h
		call	p__724
p_1FBE	btfsc	0Fh,0					; entry from: 1FA0h
		bra		p_1FCA
		clrf	2Ah
		bcf		2Ch,6
		movlw	5
		movwf	2Bh
p_1FCA	btfss	10h,7					; entry from: 1FC0h
		bra		p_1FDC
		call	p_3CC4
		btfsc	RXB0CON,3
		call	p_3E1E
		call	p_3CB0
p_1FDC	btfss	19h,7					; entry from: 1FCCh
		retlw	0
		retlw	1

p_1FE2	btfsc	17h,3					; entry from: 1EAEh,22B4h,2750h,334Ah
		btfss	0Fh,5
		bsf		72h,3,BANKED
		bra		p_1F5A

p_1FEA	tstfsz	3Dh						; entry from: 0AACh,1226h,12E0h,15D0h,1BF8h,1C28h,1C3Eh,1CB6h,1DAEh,1E06h,1E68h
		call	p_21D2
p_1FF0	movlw	0B5h					; entry from: 3D40h
		andwf	3Eh
		bcf		2Ch,7
		bcf		2Ch,4
		clrf	97h,BANKED
		clrf	83h,BANKED
		retlw	0
p_1FFE	movff	3Dh,41h					; entry from: 0AC0h
		dcfsnz	41h
		bra		p_2266
		dcfsnz	41h
		goto	p_2702
		dcfsnz	41h
		goto	p_2B54
		dcfsnz	41h
		goto	p_306E
		dcfsnz	41h
		goto	p_306E
		dcfsnz	41h
		goto	p_320C
		dcfsnz	41h
		goto	p_320C
		dcfsnz	41h
		goto	p_320C
		dcfsnz	41h
		goto	p_320C
		dcfsnz	41h
		goto	p_320C
		dcfsnz	41h
		goto	p_320C
		dcfsnz	41h
		goto	p_320C
		retlw	74h
p_204A	movff	3Dh,41h					; entry from: 1E82h
		dcfsnz	41h
		bra		p_2274
		dcfsnz	41h
		goto	p_2710
		dcfsnz	41h
		goto	p_2B4E
		dcfsnz	41h
		goto	p_3068
		dcfsnz	41h
		goto	p_30DE
		dcfsnz	41h
		goto	p_31F8
		dcfsnz	41h
		goto	p_3EAC
		dcfsnz	41h
		goto	p_3EC2
		dcfsnz	41h
		goto	p_3ED8
		dcfsnz	41h
		goto	p_3EEE
		dcfsnz	41h
		goto	p_3F04
		dcfsnz	41h
		goto	p_3F1A
		retlw	74h

p_2096	bcf		2Dh,4					; entry from: 1DB0h,1DDEh
		movff	3Dh,41h
		dcfsnz	41h
		bra		p_22C2
		dcfsnz	41h
		goto	p_2760
		dcfsnz	41h
		goto	p_2E98
		dcfsnz	41h
		goto	p_2E98
		dcfsnz	41h
		goto	p_2E98
		dcfsnz	41h
		goto	p_31FC
		dcfsnz	41h
		goto	p_3EB2
		dcfsnz	41h
		goto	p_3EC8
		dcfsnz	41h
		goto	p_3EDE
		dcfsnz	41h
		goto	p_3EF4
		dcfsnz	41h
		goto	p_3F0A
		dcfsnz	41h
		goto	p_3F20
		retlw	74h
p_20E4	movff	3Dh,41h					; entry from: 1ED8h
		dcfsnz	41h
		bra		p_22C8
		dcfsnz	41h
		goto	p_2764
		dcfsnz	41h
		goto	p_2D7A
		dcfsnz	41h
		goto	p_31BA
		dcfsnz	41h
		goto	p_31BA
		dcfsnz	41h
		goto	p_3368
		dcfsnz	41h
		goto	p_3368
		dcfsnz	41h
		goto	p_3368
		dcfsnz	41h
		goto	p_3368
		dcfsnz	41h
		goto	p_3368
		dcfsnz	41h
		goto	p_3368
		dcfsnz	41h
		goto	p_3368
		retlw	74h
p_2130	movff	3Dh,41h					; entry from: 1EFEh
		movlw	7
		cpfsgt	41h
		bra		p_215C
		subwf	41h
		dcfsnz	41h
		goto	p_3474
		dcfsnz	41h
		goto	p_3474
		dcfsnz	41h
		goto	p_3474
		dcfsnz	41h
		goto	p_3474
		dcfsnz	41h
		goto	p_3474
		retlw	74h
p_215C	dcfsnz	41h						; entry from: 2138h
		bra		p_230C
		dcfsnz	41h
		goto	p_2790
		dcfsnz	41h
		goto	p_2DA6
		dcfsnz	41h
		goto	p_2DA6
		dcfsnz	41h
		goto	p_2DA6
		dcfsnz	41h
		goto	p_3474
		dcfsnz	41h
		goto	p_3474
		retlw	74h
p_2186	movff	3Dh,41h					; entry from: 1F82h
		dcfsnz	41h
		bra		p_2420
		dcfsnz	41h
		goto	p_28D4
		dcfsnz	41h
		goto	p_2DD2
		dcfsnz	41h
		goto	p_2DD2
		dcfsnz	41h
		goto	p_2DD2
		dcfsnz	41h
		goto	p_3544
		dcfsnz	41h
		goto	p_3544
		dcfsnz	41h
		goto	p_3544
		dcfsnz	41h
		goto	p_3544
		dcfsnz	41h
		goto	p_3544
		dcfsnz	41h
		goto	p_3544
		dcfsnz	41h
		goto	p_3544
		retlw	74h
p_21D2	movff	3Dh,41h					; entry from: 1FECh
		dcfsnz	41h
		goto	p_260A
		dcfsnz	41h
		goto	p_2B18
		dcfsnz	41h
		goto	p_2E98
		dcfsnz	41h
		goto	p_2E98
		dcfsnz	41h
		goto	p_2E98
		dcfsnz	41h
		goto	p_3B64
		dcfsnz	41h
		goto	p_3B64
		dcfsnz	41h
		goto	p_3B64
		dcfsnz	41h
		goto	p_3B64
		dcfsnz	41h
		goto	p_3B64
		dcfsnz	41h
		goto	p_3B64
		dcfsnz	41h
		goto	p_3B64
		retlw	74h

p_2220	movff	3Dh,41h					; entry from: 0F32h,0FAAh
		tstfsz	41h
		dcfsnz	41h
		return	
		dcfsnz	41h
		return	
		dcfsnz	41h
		return	
		dcfsnz	41h
		return	
		dcfsnz	41h
		return	
		dcfsnz	41h
		goto	p_3202
		dcfsnz	41h
		goto	p_3EB8
		dcfsnz	41h
		goto	p_3ECE
		dcfsnz	41h
		goto	p_3EE4
		dcfsnz	41h
		goto	p_3EFA
		dcfsnz	41h
		goto	p_3F10
		dcfsnz	41h
		goto	p_3F26
		retlw	74h

p_2266	movlw	61h						; entry from: 2004h,2284h
		movwf	12h
		movlw	6Ah
		movwf	13h
		movf	94h,W,BANKED
		movwf	14h
		return	
p_2274	rcall	p_22C2					; entry from: 2050h
p_2276	btfsc	19h,7					; entry from: 2280h
		retlw	1
		call	p__5D4
		tstfsz	3Ch
		bra		p_2276
		btfss	0Fh,4
		call	p_2266
		btfss	19h,6
		bra		p_2290
		bsf		3Eh,6
		retlw	0
p_2290	movlw	1						; entry from: 228Ah
		movwf	4
		clrf	5
		movlw	2
		movwf	0
		call	p_1EC4
		call	p__ADA
		call	p_1EDC
		call	p__ADA
		movlw	19h
		cpfslt	7Eh,BANKED
		movf	7Eh,W,BANKED
		btfss	0Fh,6
		movlw	19h
		call	p_1FE2
		bcf		72h,3,BANKED
		call	p__ADA
		movlw	19h
		bra		p_1E8E

p_22C2	bcf		LATA,2					; entry from: 209Eh,2274h
		bcf		LATC,3
		bra		p_26E8
p_22C8	movlw	0FFh					; entry from: 20EAh
		movwf	40h
		movlw	61h
		btfss	3Eh,4
		movf	12h,W
		movwf	POSTINC0
		call	p_264E
		movlw	6Ah
		btfss	3Eh,4
		movf	13h,W
		movwf	POSTINC0
		call	p_264E
		movf	94h,W,BANKED
		btfss	3Eh,4
		movf	14h,W
		movwf	POSTINC0
		call	p_264E

p_22F0	movf	POSTINC0,W				; entry from: 22FCh,278Ch
		call	p_264E
		call	p__5D4
		decfsz	42h
		bra		p_22F0
		comf	40h,W
		movwf	INDF0
		movlw	4
		addwf	0
		btfsc	19h,7
		retlw	1
		retlw	0
p_230C	movlw	7Ah						; entry from: 215Eh
		call	p__B12
		movlw	4
		movwf	92h,BANKED
p_2316	btfsc	0Fh,1					; entry from: 23D4h
		retlw	4
		movlw	0
		movwf	FSR0H
		movlw	1
		movwf	FSR0L
		btfsc	PORTC,2
		bra		p_233E
p_2326	movlw	9						; entry from: 2344h
		movwf	41h
p_232A	call	p__5D4					; entry from: 233Ch
		btfsc	0Fh,1
		retlw	4
		btfss	18h,6
		clrf	41h
		dcfsnz	41h
		retlw	5
		btfss	PORTC,2
		bra		p_232A
p_233E	movlw	3Ah						; entry from: 2324h
		movwf	41h
p_2342	btfss	PORTC,2					; entry from: 2348h
		bra		p_2326
		decfsz	41h
		bra		p_2342
		btfsc	19h,7
		retlw	1
		movlw	10h
		movwf	41h
p_2352	dcfsnz	41h						; entry from: 2358h
		bra		p_235A
		btfsc	PORTC,2
		bra		p_2352
p_235A	bsf		LATA,2					; entry from: 2354h
		bsf		LATC,3
		bcf		LATB,7
		clrf	1Dh
		movlw	8
		call	p__B5C
		btfss	PORTC,2
		bra		p_2372
		bcf		LATA,2
		bcf		LATC,3
		retlw	3
p_2372	movlw	14h						; entry from: 236Ah
		call	p__B5A
		bcf		LATA,2
		bcf		LATC,3
		nop
		call	p__B40
		movf	0,W
		movwf	42h
		call	p__5D4
		call	p__B46
p_238E	call	p__B42					; entry from: 23A0h
		movf	POSTINC0,W
		call	p_23D8
		movwf	3Fh
		tstfsz	3Fh
		bra		p_23A4
		decfsz	42h
		bra		p_238E
		retlw	0
p_23A4	clrf	8Fh,BANKED				; entry from: 239Ch
		clrf	90h,BANKED
		clrf	44h
p_23AA	movf	PORTC,W					; entry from: 23BAh
		andlw	4
		xorwf	8Fh,W,BANKED
		bz		p_23D6
		xorwf	8Fh,f,BANKED
		incfsz	90h,W,BANKED
		incf	90h,f,BANKED
p_23B8	decfsz	44h						; entry from: 23D6h
		bra		p_23AA
		movlw	5
		cpfslt	90h,BANKED
		bra		p_23C6
		dcfsnz	92h,f,BANKED
		retlw	5
p_23C6	clrf	44h						; entry from: 23C0h
p_23C8	call	p__B4E					; entry from: 23D2h
		btfsc	19h,7
		retlw	1
		decfsz	44h
		bra		p_23C8
		bra		p_2316
p_23D6	bra		p_23B8					; entry from: 23B0h

p_23D8	bsf		LATA,2					; entry from: 2394h,25FEh
		bsf		LATC,3
		movwf	43h
		movlw	8
		movwf	44h
p_23E2	call	p__5D4					; entry from: 241Eh
		rlcf	43h
		btfss	STATUS,0
		bra		p_23FE
		bcf		LATA,2
		bcf		LATC,3
		call	p__5D4
		btfss	PORTC,2
		retlw	9
		call	p__B46
		bra		p_2410
p_23FE	call	p__5D4					; entry from: 23EAh
		call	p__B44
		nop
		bcf		LATA,2
		bcf		LATC,3
		call	p__B48
p_2410	dcfsnz	44h						; entry from: 23FCh
		retlw	0
		call	p__5D4
		bsf		LATA,2
		bsf		LATC,3
		nop
		bra		p_23E2

p_2420	movlw	80h						; entry from: 218Ch,2510h,25DEh,264Ah
		movwf	1Bh
		movlw	0FFh
		movwf	40h
		movlw	0
		movwf	FSR0H
		movlw	1
		movwf	FSR0L
		bcf		0Fh,2

p_2432	btfss	PORTC,2					; entry from: 24A0h,24B0h,24C4h,24E0h,24F6h
		bra		p_24B2
		btfsc	PORTC,4
		btfsc	PIR1,5
		bsf		19h,7
		btfsc	19h,7
		retlw	1
		btfsc	0Fh,1
		bra		p_2508
		btfss	PORTC,2
		bra		p_24B2
		btfsc	TMR0L,7
		setf	1Ah
		tstfsz	1Ah
		btfsc	TMR0L,7
		bra		p_2496
		btfss	PORTC,2
		bra		p_24B2
		decfsz	2Bh
		bra		p_2460
		movlw	5
		movwf	2Bh
		incf	2Ah
p_2460	movf	86h,W,BANKED			; entry from: 2458h
		btfss	PORTC,2
		bra		p_24B2
		cpfslt	2Ah
		bsf		2Ch,6
		incf	21h
		movf	7Fh,W,BANKED
		cpfslt	21h
		bsf		0Fh,1
		bcf		1Ah,7
		btfss	PORTC,2
		bra		p_24B2
		incf	1Dh
		btfsc	1Dh,3
		bsf		LATB,7
		incf	1Eh
		btfsc	1Eh,3
		bsf		LATB,6
		btfss	PORTC,2
		bra		p_24B2
		incf	1Fh
		btfsc	1Fh,3
		bsf		LATB,5
		incf	20h
		btfsc	20h,3
		bsf		LATB,4
		clrf	1Ah
p_2496	btfss	PORTC,2					; entry from: 2450h
		bra		p_24B2
		movf	FSR1L,W
		cpfseq	FSR2L
		btfss	PIR1,4
		bra		p_2432
		btfss	PORTC,2
		bra		p_24B2
		clrf	1Fh
		bcf		LATB,5
		movf	POSTINC2,W
		bcf		FSR2H,0
		movwf	TXREG1
		bra		p_2432

p_24B2	movf	86h,W,BANKED			; entry from: 2434h,2446h,2454h,2464h,2476h,2486h,2498h,24A4h
		cpfslt	2Ah
		bsf		2Ch,6
		clrf	1Eh
		bcf		LATB,6
		bra		p_24BE
p_24BE	movlw	11h						; entry from: 24BCh
		movwf	41h
p_24C2	btfsc	PORTC,2					; entry from: 24C8h
		bra		p_2432
		decfsz	41h
		bra		p_24C2
		movlw	0Bh
		movwf	41h
p_24CE	btfsc	PORTC,2					; entry from: 24D4h
		bra		p_2512
		decfsz	41h
		bra		p_24CE
		call	p__5D4
		call	p__5D4
		btfsc	PORTC,2
		bra		p_2432
		btfss	18h,6
		bra		p_24F4
		btfss	3Eh,3
		retlw	5
		movlw	56h
		call	p__730
		call	p__724

p_24F4	btfsc	PORTC,2					; entry from: 24E4h,2506h
		bra		p_2432
		clrf	1Eh
		call	p__5D4
		btfsc	19h,7
		retlw	1
		btfss	3Eh,3
		btfss	0Fh,1
		bra		p_24F4
p_2508	btfss	3Eh,3					; entry from: 2442h
		retlw	8
		clrf	21h
		bcf		0Fh,1
		bra		p_2420
p_2512	incf	21h,W					; entry from: 24D0h
		movwf	82h,BANKED
		call	p__B3E
		call	p__5D4
		clrf	0
p_2520	rcall	p_262E					; entry from: 25D2h
		call	p__54E
		call	p__B3E
		rcall	p_2610
		call	p__B3A
		rcall	p_262E
		call	p__7AE
		rcall	p_2610
		call	p__B3A
		rcall	p_262E
		call	p__7AE
		rcall	p_2610
		call	p__B3A
		rcall	p_262E
		call	p__7AE
		rcall	p_2610
		call	p__B3A
		rcall	p_262E
		call	p__5D4
		call	p__B3E
		rcall	p_2610
		call	p__B3A
		rcall	p_262E
		call	p__5D4
		call	p__B3E
		rcall	p_2610
		call	p__B3A
		rcall	p_262E
		call	p__5D4
		call	p__B3E
		rcall	p_2610
		call	p__B3A
		rcall	p_262E
		call	p__5D4
		incf	0
		bsf		1Bh,4
		bcf		0Fh,2
		movlw	0Dh
		cpfslt	FSR0L
		bsf		0Fh,2
		bsf		0Fh,3
		btfsc	17h,4
		bra		p_25A8
		movlw	0Bh
		btfsc	11h,2
		movlw	0Ch
		cpfseq	0
		bcf		0Fh,3
		bra		p_25B4
p_25A8	btfss	19h,7					; entry from: 259Ah
		bcf		0Fh,3
		movf	0
		btfss	STATUS,2
		bcf		0Fh,3
		nop
p_25B4	call	p__B48					; entry from: 25A6h
		rcall	p_2610
		call	p__B44
		nop
		bcf		0Fh,0
		movlw	0C4h
		cpfseq	40h
		bsf		0Fh,0
		movf	71h,W,BANKED
		btfss	0Fh,2
		movwf	POSTINC0
		movwf	0Eh
		btfss	0Fh,3
		bra		p_2520
		call	p__5D4
		call	p__5D4
p_25DC	btfsc	1Bh,7					; entry from: 2646h
		bra		p_2420
		btfsc	11h,2
		retlw	0
		btfsc	10h,1
		bra		p_2604
		btfsc	0Fh,0
		retlw	0
		btfsc	1,3
		retlw	0
p_25F0	call	p__5D4					; entry from: 2606h
		call	p__5D4
		movf	94h,W,BANKED
		btfss	10h,2
		movf	14h,W
		call	p_23D8
		retlw	0
p_2604	btfsc	10h,0					; entry from: 25E6h
		bra		p_25F0
		retlw	0

p_260A	bcf		LATA,2					; entry from: 21D8h,2B18h
		bcf		LATC,3
		bra		p_26E8

p_2610	bsf		71h,7,BANKED			; entry from: 252Ah,2536h,2542h,254Eh,255Eh,256Eh,257Eh,25B8h
		rlncf	71h,f,BANKED
		btfss	PORTC,2
		bcf		71h,0,BANKED
		movlw	1Dh
		bcf		STATUS,0
		rlcf	40h
		bc		p_2628
		btfsc	71h,0,BANKED
		xorwf	40h
		nop
		retlw	0
p_2628	btfss	71h,0,BANKED			; entry from: 261Eh
		xorwf	40h
		retlw	0

p_262E	movlw	5						; entry from: 2520h,2530h,253Ch,2548h,2554h,2564h,2574h,2584h
		movwf	41h
p_2632	btfss	PORTC,2					; entry from: 263Eh
		retlw	0
		dcfsnz	41h
		bra		p_2640
		btfss	PORTC,2
		retlw	0
		bra		p_2632
p_2640	pop								; entry from: 2638h
		bra		p_2644
p_2644	tstfsz	0						; entry from: 2642h
		goto	p_25DC
		goto	p_2420

p_264E	movwf	44h						; entry from: 22D4h,22E0h,22ECh,22F2h,2770h,277Ch,2788h,2B48h
		movlw	1Dh
		bcf		STATUS,0
		rlcf	40h
		bc		p_265E
		btfsc	44h,7
		xorwf	40h
		bra		p_2664
p_265E	btfss	44h,7					; entry from: 2656h
		xorwf	40h
		bcf		STATUS,0
p_2664	rlcf	40h						; entry from: 265Ch
		bc		p_266E
		btfsc	44h,6
		xorwf	40h
		bra		p_2674
p_266E	btfss	44h,6					; entry from: 2666h
		xorwf	40h
		bcf		STATUS,0
p_2674	rlcf	40h						; entry from: 266Ch
		bc		p_267E
		btfsc	44h,5
		xorwf	40h
		bra		p_2684
p_267E	btfss	44h,5					; entry from: 2676h
		xorwf	40h
		bcf		STATUS,0
p_2684	rlcf	40h						; entry from: 267Ch
		bc		p_268E
		btfsc	44h,4
		xorwf	40h
		bra		p_2694
p_268E	btfss	44h,4					; entry from: 2686h
		xorwf	40h
		bcf		STATUS,0
p_2694	rlcf	40h						; entry from: 268Ch
		bc		p_269E
		btfsc	44h,3
		xorwf	40h
		bra		p_26A4
p_269E	btfss	44h,3					; entry from: 2696h
		xorwf	40h
		bcf		STATUS,0
p_26A4	rlcf	40h						; entry from: 269Ch
		bc		p_26AE
		btfsc	44h,2
		xorwf	40h
		bra		p_26B4
p_26AE	btfss	44h,2					; entry from: 26A6h
		xorwf	40h
		bcf		STATUS,0
p_26B4	rlcf	40h						; entry from: 26ACh
		bc		p_26BE
		btfsc	44h,1
		xorwf	40h
		bra		p_26C4
p_26BE	btfss	44h,1					; entry from: 26B6h
		xorwf	40h
		bcf		STATUS,0
p_26C4	rlcf	40h						; entry from: 26BCh
		bc		p_26CE
		btfsc	44h,0
		xorwf	40h
		bra		p_26D4
p_26CE	btfss	44h,0					; entry from: 26C6h
		xorwf	40h
		nop
p_26D4	bcf		0Fh,0					; entry from: 26CCh
		movlw	0C4h
		cpfseq	40h
		bsf		0Fh,0
		return	

p_26DE	movlw	2						; entry from: 0AB6h,15D8h,1D0Ch
		cpfseq	3Dh
		bra		p_26E8
p_26E4	movlw	2						; entry from: 2762h
		bra		p_26EA

p_26E8	movlw	0						; entry from: 22C6h,260Eh,26E2h
p_26EA	xorwf	8Eh,W,BANKED			; entry from: 26E6h
		bnz		p_26F6
		btfss	LATA,1
		retlw	0
		bcf		LATA,1
		bra		p_26FC
p_26F6	btfsc	LATA,1					; entry from: 26ECh
		retlw	0
		bsf		LATA,1
p_26FC	movf	3Bh,W					; entry from: 26F4h
		movwf	3Ch
		retlw	0

p_2702	movlw	68h						; entry from: 2008h,2720h
		movwf	12h
		movlw	6Ah
		movwf	13h
		movf	94h,W,BANKED
		movwf	14h
		return	
p_2710	rcall	p_2760					; entry from: 2054h
p_2712	btfsc	19h,7					; entry from: 271Ch
		retlw	1
		call	p__5D4
		tstfsz	3Ch
		bra		p_2712
		btfss	0Fh,4
		call	p_2702
		btfss	19h,6
		bra		p_272C
		bsf		3Eh,6
		retlw	0
p_272C	movlw	1						; entry from: 2726h
		movwf	4
		clrf	5
		movlw	2
		movwf	0
		call	p_1EC4
		call	p__ADA
		call	p_1EDC
		call	p__ADA
		movlw	19h
		cpfslt	7Eh,BANKED
		movf	7Eh,W,BANKED
		btfss	0Fh,6
		movlw	19h
		call	p_1FE2
		bcf		72h,3,BANKED
		call	p__ADA
		movlw	19h
		goto	p_1E8E

p_2760	bcf		LATA,2					; entry from: 20A2h,2710h
		bra		p_26E4
p_2764	movlw	0FFh					; entry from: 20EEh
		movwf	40h
		movlw	68h
		btfss	3Eh,4
		movf	12h,W
		movwf	POSTINC0
		call	p_264E
		movlw	6Ah
		btfss	3Eh,4
		movf	13h,W
		movwf	POSTINC0
		call	p_264E
		movf	94h,W,BANKED
		btfss	3Eh,4
		movf	14h,W
		movwf	POSTINC0
		call	p_264E
		goto	p_22F0
p_2790	movlw	7Ah						; entry from: 2162h
		call	p__B12
		movlw	4
		movwf	92h,BANKED
p_279A	btfsc	0Fh,1					; entry from: 2872h
		retlw	4
		movlw	0
		movwf	FSR0H
		movlw	1
		movwf	FSR0L
		btfss	PORTC,0
		bra		p_27D0
p_27AA	clrf	41h						; entry from: 27D6h
p_27AC	call	p__5D4					; entry from: 27CEh
		btfsc	0Fh,1
		retlw	4
		btfss	PORTC,0
		bra		p_27D0
		call	p__5D4
		btfss	18h,6
		clrf	41h
		dcfsnz	41h
		retlw	5
		btfss	PORTC,0
		bra		p_27D0
		call	p__5D4
		btfsc	PORTC,0
		bra		p_27AC

p_27D0	movlw	0DFh					; entry from: 27A8h,27B6h,27C6h
		movwf	41h
p_27D4	btfsc	PORTC,0					; entry from: 27DAh
		bra		p_27AA
		decfsz	41h
		bra		p_27D4
		btfsc	19h,7
		retlw	1
		movlw	10h
		movwf	41h
p_27E4	dcfsnz	41h						; entry from: 27EAh
		bra		p_27EC
		btfss	PORTC,0
		bra		p_27E4
p_27EC	bsf		LATA,2					; entry from: 27E6h
		bcf		LATB,7
		clrf	1Dh
		call	p__B52
		btfsc	PORTC,0
		bra		p_27FE
		bcf		LATA,2
		retlw	3
p_27FE	movlw	17h						; entry from: 27F8h
		movwf	41h
p_2802	call	p__5D4					; entry from: 280Eh
		nop
		nop
		nop
		decfsz	41h
		bra		p_2802
		movf	0,W
		movwf	42h
p_2814	movf	POSTINC0,W				; entry from: 2834h
		call	p_2876
		movwf	3Fh
		tstfsz	3Fh
		bra		p_283E
		movlw	8
		movwf	41h
p_2824	call	p__5D4					; entry from: 282Ch
		nop
		decfsz	41h
		bra		p_2824
		call	p__B42
		decfsz	42h
		bra		p_2814
		call	p__B48
		bcf		LATA,2
		retlw	0
p_283E	setf	8Fh,BANKED				; entry from: 281Eh
		clrf	91h,BANKED
		clrf	44h
p_2844	call	p__5D4					; entry from: 2858h
		movf	PORTC,W
		andlw	1
		xorwf	8Fh,W,BANKED
		bz		p_2874
		xorwf	8Fh,f,BANKED
		incfsz	91h,W,BANKED
		incf	91h,f,BANKED
p_2856	decfsz	44h						; entry from: 2874h
		bra		p_2844
		movlw	5
		cpfslt	91h,BANKED
		bra		p_2864
		dcfsnz	92h,f,BANKED
		retlw	5
p_2864	clrf	44h						; entry from: 285Eh
p_2866	call	p__B4E					; entry from: 2870h
		btfsc	19h,7
		retlw	1
		decfsz	44h
		bra		p_2866
		bra		p_279A
p_2874	bra		p_2856					; entry from: 284Eh

p_2876	bcf		LATA,2					; entry from: 2816h,2ADCh
		movwf	43h
		movlw	4
		movwf	44h
p_287E	nop								; entry from: 28D2h
		call	p__B50
		btfsc	PORTC,0
		retlw	9
		call	p__B50
		rlcf	43h
		btfss	STATUS,0
		bra		p_28A4
		call	p__B50
		btfsc	PORTC,0
		retlw	9
		call	p__B50
		call	p__B40
		nop
p_28A4	nop								; entry from: 2890h
		bsf		LATA,2
		rlcf	43h
		btfsc	STATUS,0
		bra		p_28BC
		call	p__B50
		call	p__B50
		call	p__B3C
		nop
p_28BC	dcfsnz	44h						; entry from: 28ACh
		retlw	0
		call	p__B50
		call	p__B50
		call	p__B48
		nop
		bcf		LATA,2
		nop
		bra		p_287E

p_28D4	movlw	80h						; entry from: 2190h,295Ah,2AA0h
		movwf	1Bh
		movlw	0FFh
		movwf	40h
		movlw	0
		movwf	FSR0H
		movlw	1
		movwf	FSR0L

p_28E4	call	p__5D4					; entry from: 28F2h,28FEh,2912h,291Ah,2922h,2940h
		btfsc	0Fh,1
		bra		p_2952
		btfsc	19h,7
		retlw	1
		btfss	PORTC,0
		bra		p_28E4
		movlw	82h
		movwf	41h
		bcf		LATB,6
		clrf	1Eh
p_28FC	btfss	PORTC,0					; entry from: 2902h
		bra		p_28E4
		decfsz	41h
		bra		p_28FC
		movlw	3Dh
		call	p_2B2C
		iorlw	0
		bz		p_295C
		clrf	41h
p_2910	btfss	PORTC,0					; entry from: 292Ah
		bra		p_28E4
		call	p__5D4
		btfss	PORTC,0
		bra		p_28E4
		call	p__5D4
		btfss	PORTC,0
		bra		p_28E4
		call	p__5D4
		decfsz	41h
		bra		p_2910
		btfss	18h,6
		bra		p_293E
		btfss	3Eh,3
		retlw	5
		movlw	56h
		call	p__730
		call	p__724

p_293E	btfss	PORTC,0					; entry from: 292Eh,2950h
		bra		p_28E4
		clrf	1Eh
		call	p__5D4
		btfsc	19h,7
		retlw	1
		btfss	3Eh,3
		btfss	0Fh,1
		bra		p_293E
p_2952	btfss	3Eh,3					; entry from: 28EAh
		retlw	8
		clrf	21h
		bcf		0Fh,1
		bra		p_28D4
p_295C	incf	21h,W					; entry from: 290Ch
		movwf	82h,BANKED
		clrf	0
		clrf	71h,BANKED
		call	p__B54
		call	p__B46
p_296C	bcf		71h,7,BANKED			; entry from: 2A8Eh
		call	p__B3C
		call	p__B3E
		call	p_2B1C
		iorlw	0
		bz		p_298A
		call	p_2B1C
		iorlw	0
		btfss	STATUS,2
		bra		p_2A9E
		bsf		71h,7,BANKED
p_298A	bsf		71h,6,BANKED			; entry from: 297Ch
		call	p__54E
		call	p__B54
		call	p__B3E
		call	p_2B2A
		iorlw	0
		bz		p_29AC
		call	p_2B2A
		iorlw	0
		btfss	STATUS,2
		bra		p_2AF6
		bcf		71h,6,BANKED
p_29AC	bcf		71h,5,BANKED			; entry from: 299Eh
		call	p__7AE
		call	p__7AE
		call	p__B3E
		call	p__B40
		call	p_2B1C
		iorlw	0
		bz		p_29D2
		call	p_2B1C
		iorlw	0
		btfss	STATUS,2
		bra		p_2B00
		bsf		71h,5,BANKED
p_29D2	bsf		71h,4,BANKED			; entry from: 29C4h
		call	p__7AE
		call	p__B54
		call	p_2B2A
		iorlw	0
		bz		p_29F0
		call	p_2B2A
		iorlw	0
		btfss	STATUS,2
		bra		p_2B06
		bcf		71h,4,BANKED
p_29F0	bcf		71h,3,BANKED			; entry from: 29E2h
		call	p__B52
		call	p__B3E
		call	p_2B1C
		iorlw	0
		bz		p_2A0E
		call	p_2B1C
		iorlw	0
		btfss	STATUS,2
		bra		p_2B08
		bsf		71h,3,BANKED
p_2A0E	bsf		71h,2,BANKED			; entry from: 2A00h
		call	p__B52
		call	p__B3E
		call	p_2B2A
		iorlw	0
		bz		p_2A2C
		call	p_2B2A
		iorlw	0
		btfss	STATUS,2
		bra		p_2B0A
		bcf		71h,2,BANKED
p_2A2C	bcf		71h,1,BANKED			; entry from: 2A1Eh
		call	p__B52
		call	p__B3E
		call	p_2B1C
		iorlw	0
		bz		p_2A4A
		call	p_2B1C
		iorlw	0
		btfss	STATUS,2
		bra		p_2B0C
		bsf		71h,1,BANKED
p_2A4A	bsf		71h,0,BANKED			; entry from: 2A3Ch
		call	p__B52
		call	p__B3E
		call	p_2B2A
		iorlw	0
		bz		p_2A68
		call	p_2B2A
		iorlw	0
		btfss	STATUS,2
		bra		p_2B0E
		bcf		71h,0,BANKED
p_2A68	call	p_2B38					; entry from: 2A5Ah
		bsf		0Fh,3
		btfsc	17h,4
		bra		p_2A7E
		movlw	0Bh
		btfsc	11h,2
		movlw	0Ch
		cpfseq	0
		bcf		0Fh,3
		bra		p_2A8A
p_2A7E	btfss	19h,7					; entry from: 2A70h
		bcf		0Fh,3
		movf	0
		btfss	STATUS,2
		bcf		0Fh,3
		nop
p_2A8A	bra		p_2A8C					; entry from: 2A7Ch
p_2A8C	btfss	0Fh,3					; entry from: 2A8Ah
		bra		p_296C
		movlw	15h
		movwf	41h
p_2A94	call	p__5D4					; entry from: 2A9Ah
		decfsz	41h
		bra		p_2A94
		nop

p_2A9E	btfsc	1Bh,7					; entry from: 2986h,2B16h
		bra		p_28D4
		btfsc	11h,2
		retlw	0
		btfsc	10h,1
		bra		p_2AF0
		btfsc	0Fh,0
		retlw	0
		btfsc	1,3
		retlw	0
p_2AB2	movlw	4						; entry from: 2AF2h
		movwf	41h
		bra		p_2AB8

p_2AB8	call	p__5D4					; entry from: 2AB6h,2AC2h
		call	p__B48
		decfsz	41h
		bra		p_2AB8
		bsf		LATA,2
		movlw	9
		movwf	41h
p_2ACA	call	p__5D4					; entry from: 2AD0h
		decfsz	41h
		bra		p_2ACA
		call	p__B44
		movf	94h,W,BANKED
		btfss	10h,2
		movf	14h,W
		call	p_2876
		call	p__B50
		call	p__B50
		call	p__B48
		bcf		LATA,2
		retlw	0
p_2AF0	btfsc	10h,0					; entry from: 2AA8h
		bra		p_2AB2
		retlw	0
p_2AF6	bcf		71h,6,BANKED			; entry from: 29A8h
		call	p__7AE
		call	p__7AE
p_2B00	bcf		71h,5,BANKED			; entry from: 29CEh
		call	p__7AE
p_2B06	bcf		71h,4,BANKED			; entry from: 29ECh
p_2B08	bcf		71h,3,BANKED			; entry from: 2A0Ah
p_2B0A	bcf		71h,2,BANKED			; entry from: 2A28h
p_2B0C	bcf		71h,1,BANKED			; entry from: 2A46h
p_2B0E	bcf		71h,0,BANKED			; entry from: 2A64h
		call	p_2B38
		bsf		0Fh,0
		bra		p_2A9E
p_2B18	goto	p_260A					; entry from: 21DEh

p_2B1C	movlw	34h						; entry from: 2976h,297Eh,29BEh,29C6h,29FAh,2A02h,2A36h,2A3Eh
		movwf	41h
p_2B20	btfsc	PORTC,0					; entry from: 2B26h
		retlw	0
		decfsz	41h
		bra		p_2B20
		retlw	0FFh

p_2B2A	movlw	34h						; entry from: 2998h,29A0h,29DCh,29E4h,2A18h,2A20h,2A54h,2A5Ch
p_2B2C	movwf	41h						; entry from: 2906h
p_2B2E	btfss	PORTC,0					; entry from: 2B34h
		retlw	0
		decfsz	41h
		bra		p_2B2E
		retlw	0FFh

p_2B38	incf	0						; entry from: 2A68h,2B10h
		bsf		1Bh,4
		movlw	0Dh
		subwf	FSR0L,W
		movf	71h,W,BANKED
		btfss	STATUS,0
		movwf	POSTINC0
		movwf	0Eh
		call	p_264E
		return	
p_2B4E	btfsc	19h,6					; entry from: 205Ah
		bra		p_2D0A
		bra		p_2BC4

p_2B54	btfsc	0Fh,4					; entry from: 200Eh,2D0Ah
		bra		p_2B64
		movlw	68h
		movwf	12h
		movlw	6Ah
		movwf	13h
		movf	94h,W,BANKED
		movwf	14h
p_2B64	btfsc	2Ch,5					; entry from: 2B56h
		return	
		movlw	6
		movwf	22h
		movlw	68h
		movwf	23h
		movwf	24h
		movlw	2
		cpfsgt	22h
		return	
		movff	24h,25h
		movlw	6Ah
		movwf	24h
		addwf	25h
		movlw	3
		cpfsgt	22h
		return	
		movff	25h,26h
		movf	94h,W,BANKED
		movwf	25h
		addwf	26h
		movlw	4
		cpfsgt	22h
		return	
		movff	26h,27h
		movlw	1
		movwf	26h
		addwf	27h
		movlw	5
		cpfsgt	22h
		return	
		movff	27h,28h
		movlw	0
		movwf	27h
		addwf	28h
		movlw	6
		cpfsgt	22h
		return	
		movff	28h,29h
		movlw	0
		movwf	28h
		addwf	29h
		return	

p_2BC4	movlw	60h						; entry from: 2B52h,306Ch
		btfss	2Dh,7
		btfss	3Eh,7
		call	p__730
		bcf		8Dh,0,BANKED
		movlw	4Bh
		call	p_2F70
		call	p__ADA
		btfsc	19h,7
		retlw	1
		movf	0BFh,W,BANKED
		movwf	0Eh
		movwf	1
		clrf	0
		incf	0
		movlw	9
		movwf	41h
		bra		p_2C16
p_2BEE	btfss	2Dh,7					; entry from: 2C64h
		btfss	3Eh,7
		bra		p_2BFA
		call	p__B3C
		bra		p_2C10
p_2BFA	dcfsnz	41h,W					; entry from: 2BF2h
		bra		p_2C0A
		movlw	4
		xorwf	41h,W
		bz		p_2C0A
		movlw	7
		xorwf	41h,W
		bnz		p_2C10

p_2C0A	movlw	2Eh						; entry from: 2BFCh,2C02h
		call	p__7F2

p_2C10	rrcf	0Eh						; entry from: 2BF8h,2C08h
		btfsc	STATUS,0
		bra		p_2C30
p_2C16	bcf		LATB,7					; entry from: 2BECh
		movlw	3
		iorwf	LATB
		clrf	1Dh
		call	p__B3A
		call	p__B3A
		btfss	PORTC,1
		bra		p_2C38
		movlw	0FCh
		andwf	LATB
		retlw	3
p_2C30	movlw	0FCh					; entry from: 2C14h
		andwf	LATB
		call	p__652
p_2C38	movlw	64h						; entry from: 2C28h
		movwf	43h
		clrf	42h
p_2C3E	call	p__5D4					; entry from: 2C4Ah
		bra		p_2C44
p_2C44	decfsz	42h						; entry from: 2C42h
		bra		p_2C4A
		decfsz	43h
p_2C4A	bra		p_2C3E					; entry from: 2C46h
		movlw	0ABh
		movwf	42h
p_2C50	call	p__652					; entry from: 2C56h
		decfsz	42h
		bra		p_2C50
		btfss	19h,7
		bra		p_2C62
		movlw	0FCh
		andwf	LATB
		retlw	1
p_2C62	decfsz	41h						; entry from: 2C5Ah
		bra		p_2BEE
		call	p__5D4
		movlw	0FCh
		andwf	LATB
		movlw	64h
		movwf	42h
p_2C72	call	p__5D4					; entry from: 2C7Ch
		decfsz	41h
		bra		p_2C7C
		decfsz	42h
p_2C7C	bra		p_2C72					; entry from: 2C78h
		bsf		2Dh,5
		bsf		72h,3,BANKED
		movlw	0E6h
		call	p_2EA0
		bcf		72h,3,BANKED
		call	p__ADA
		movf	71h,W,BANKED
		movwf	2
		incf	0
		movlw	55h
		xorwf	2,W
		bz		p_2CA0
		movlw	0FFh
		call	p__ADA
p_2CA0	bsf		72h,3,BANKED			; entry from: 2C98h
		movlw	2Dh
		btfsc	2Dh,1
		movlw	87h
		call	p_2EA0
		bcf		72h,3,BANKED
		call	p__ADA
		movf	71h,W,BANKED
		movwf	3
		movwf	0C0h,BANKED
		incf	0
		bsf		72h,3,BANKED
		movlw	2Dh
		btfsc	2Dh,1
		movlw	87h
		call	p_2EA0
		bcf		72h,3,BANKED
		call	p__ADA
		movf	71h,W,BANKED
		movwf	4
		movwf	0C1h,BANKED
		incf	0
		bsf		8Dh,0,BANKED
		movlw	3
		cpfseq	3Dh
		bra		p_2D38
		btfss	2Dh,7
		btfsc	2Dh,6
		bra		p_2CF4
		movf	3,W
		cpfseq	4
		bra		p_2D34
		movlw	8
		xorwf	3,W
		bz		p_2CF4
		movlw	94h
		cpfseq	3
		bra		p_2D34

p_2CF4	rcall	p_2FB6					; entry from: 2CE0h,2CECh,2D70h,2D78h
		call	p__ADA
		movlw	4
		cpfseq	3Dh
		bra		p_2D0A
		btfss	3Eh,4
		call	p__844
		movlw	3
		movwf	3Dh

p_2D0A	call	p_2B54					; entry from: 2B50h,2CFEh
p_2D0E	clrf	2Ah						; entry from: 2D60h
		bcf		2Ch,6
		movlw	5
		movwf	2Bh
		bsf		3Eh,6
		bsf		2Ch,7
		btfsc	19h,6
		retlw	0
		bsf		11h,3
		btfsc	2Dh,7
		bra		p_2D28
		btfsc	3Eh,7
		retlw	0
p_2D28	movlw	0B4h					; entry from: 2D22h
		call	p__730
		call	p__724
		retlw	0

p_2D34	btfss	3Eh,7					; entry from: 2CE6h,2CF2h
		retlw	0FFh
p_2D38	btfss	2Dh,7					; entry from: 2CDAh
		btfsc	2Dh,6
		bra		p_2D44
		movlw	8Fh
		cpfseq	4
		bra		p_2D62
p_2D44	rcall	p_2FB6					; entry from: 2D3Ch
		call	p__ADA
		movlw	3
		cpfseq	3Dh
		bra		p_2D5A
		btfss	3Eh,4
		call	p__844
		movlw	4
		movwf	3Dh

p_2D5A	call	p_306E					; entry from: 2D4Eh,306Ah,319Ah
		bsf		3Eh,1
		bra		p_2D0E
p_2D62	btfss	3Eh,7					; entry from: 2D42h
		retlw	0FFh
		movf	3,W
		cpfseq	4
		retlw	0FFh
		movlw	8
		xorwf	3,W
		bz		p_2CF4
		movlw	94h
		cpfseq	3
		retlw	0FFh
		bra		p_2CF4
p_2D7A	movlw	68h						; entry from: 20F4h
		btfss	3Eh,4
		movf	12h,W
		movwf	1
		movlw	6Ah
		btfss	3Eh,4
		movf	13h,W
		movwf	2
		movf	94h,W,BANKED
		btfss	3Eh,4
		movf	14h,W
		movwf	3
p_2D92	movlw	3						; entry from: 31D6h
		addwf	42h
		movlw	0
p_2D98	addwf	POSTINC0,W				; entry from: 2D9Ch
		decfsz	42h
		bra		p_2D98
		movwf	INDF0
		movlw	4
		addwf	0
		retlw	0

p_2DA6	call	p__40C					; entry from: 2168h,216Eh,2174h
		rcall	p_2F6E
		call	p__ADA
p_2DB0	movff	0,44h					; entry from: 3152h
p_2DB4	movf	POSTINC0,W				; entry from: 2DD0h
		rcall	p_2FF6
		call	p__ADA
		dcfsnz	44h
		retlw	0
		movlw	0F2h
		movwf	43h
p_2DC4	call	p__40C					; entry from: 2DCEh
		call	p__40C
		decfsz	43h
		bra		p_2DC4
		bra		p_2DB4

p_2DD2	movlw	80h						; entry from: 2196h,219Ch,21A2h,2E94h
		movwf	1Bh
		clrf	40h
		movlw	0
		movwf	FSR0H
		movlw	1
		movwf	FSR0L
		btfsc	PORTC,1
		bra		p_2DF8

p_2DE4	call	p__5D4					; entry from: 2DF6h,2E0Eh
		btfsc	3Eh,3
		bra		p_2DF0
		btfsc	0Fh,1
		retlw	8
p_2DF0	btfsc	19h,7					; entry from: 2DEAh
		retlw	1
		btfss	PORTC,1
		bra		p_2DE4
p_2DF8	btfsc	11h,2					; entry from: 2DE2h
		btfsc	2Dh,4
		bra		p_2E1A
		movf	0C2h,W,BANKED
		movwf	44h
		clrf	43h
p_2E04	call	p__5D4					; entry from: 2E16h
		btfsc	19h,7
		retlw	1
		btfss	PORTC,1
		bra		p_2DE4
		decfsz	43h
		bra		p_2E16
		decfsz	44h
p_2E16	bra		p_2E04					; entry from: 2E12h
		bsf		2Dh,4

p_2E1A	call	p__5D4					; entry from: 2DFCh,2E2Ch
		btfsc	3Eh,3
		bra		p_2E26
		btfsc	0Fh,1
		retlw	8
p_2E26	btfsc	19h,7					; entry from: 2E20h
		retlw	1
		btfsc	PORTC,1
		bra		p_2E1A
		clrf	0
		incf	21h,W
		movwf	82h,BANKED
p_2E34	rcall	p_2E9E					; entry from: 2E8Eh
		movwf	3Fh
		xorlw	8
		bz		p_2E92
		incf	0
		bsf		1Bh,4
		bcf		0Fh,0
		movf	71h,W,BANKED
		cpfseq	40h
		bsf		0Fh,0
		addwf	40h
		movlw	0Dh
		subwf	FSR0L,W
		movf	71h,W,BANKED
		btfss	STATUS,0
		movwf	POSTINC0
		movwf	0Eh
		movlw	4
		cpfsgt	0
		bra		p_2E82
		movlw	3
		cpfseq	3Dh
		bra		p_2E74
		movlw	0Bh
		btfsc	11h,2
		movlw	0Ch
		btfss	17h,4
		bra		p_2E86
		btfsc	19h,7
		tstfsz	0
		bra		p_2E8A
		bra		p_2E92
p_2E74	movlw	3Fh						; entry from: 2E60h
		andwf	1,W
		bnz		p_2E7C
		incf	4,W
p_2E7C	addlw	4						; entry from: 2E78h
		xorwf	0,W
		bz		p_2E92
p_2E82	bsf		0Fh,0					; entry from: 2E5Ah
		bra		p_2E8A
p_2E86	xorwf	0,W						; entry from: 2E6Ah
		bz		p_2E92

p_2E8A	movf	3Fh,W					; entry from: 2E70h,2E84h
		xorlw	0FFh
		bnz		p_2E34
		bsf		0Fh,0

p_2E92	btfsc	1Bh,7					; entry from: 2E3Ah,2E72h,2E80h,2E88h
		bra		p_2DD2
		retlw	0

p_2E98	bcf		LATB,0					; entry from: 20A8h,20AEh,20B4h,21E4h,21EAh,21F0h
		bcf		LATB,1
		retlw	0
p_2E9E	decf	0C2h,W,BANKED			; entry from: 2E34h

p_2EA0	movwf	44h						; entry from: 2C84h,2CA8h,2CC2h,2FD6h
		btfss	PORTC,1
		bra		p_2EC8
		clrf	43h
p_2EA8	btfss	PORTC,1					; entry from: 2EBEh
		bra		p_2EC4
		call	p__5D4
		btfss	PORTC,1
		bra		p_2EC4
		btfss	PORTC,1
		bra		p_2EC4
		decfsz	43h
		bra		p_2EBE
		decfsz	44h
p_2EBE	bra		p_2EA8					; entry from: 2EBAh
		bsf		2Dh,4
		retlw	8

p_2EC4	call	p__B3C					; entry from: 2EAAh,2EB2h,2EB6h
p_2EC8	bcf		LATB,6					; entry from: 2EA4h
		clrf	1Eh
		call	p__54E
		movlw	3
		cpfsgt	3Dh
		bra		p_2EEC
		btfsc	17h,1
		bra		p_2EEE
		movlw	4
		cpfseq	0
		bra		p_2EF2
		movlw	3Fh
		andwf	1,W
		bnz		p_2EF6
		movlw	80h
		movwf	1Bh
		bra		p_2EFA
p_2EEC	bra		p_2EEE					; entry from: 2ED4h

p_2EEE	nop								; entry from: 2ED8h,2EECh
		bra		p_2EF2

p_2EF2	nop								; entry from: 2EDEh,2EF0h
		bra		p_2EF6

p_2EF6	nop								; entry from: 2EE4h,2EF4h
		bra		p_2EFA

p_2EFA	nop								; entry from: 2EEAh,2EF8h
		call	p__5D4
		movlw	1
		btfss	2Dh,1
		bra		p_2F16
		call	p__B42
		btfss	2Dh,0
		bra		p_2F16
		nop
		call	p__B3A
		movlw	8

p_2F16	movwf	41h						; entry from: 2F04h,2F0Ch
p_2F18	call	p__5D4					; entry from: 2F1Eh
		decfsz	41h
		bra		p_2F18
		movlw	9
		movwf	41h
		movlw	6
		movwf	42h
		bra		p_2F30
p_2F2A	rrcf	71h,f,BANKED			; entry from: 2F60h
		movlw	5
		movwf	42h

p_2F30	call	p__7AE					; entry from: 2F28h,2F3Ah
		call	p__5D4
		decfsz	42h
		bra		p_2F30
		call	p__B3A
		btfss	2Dh,1
		bra		p_2F58
		call	p__B38
		btfss	2Dh,0
		bra		p_2F68
		movlw	10h
		movwf	45h
p_2F50	call	p__5D4					; entry from: 2F56h
		decfsz	45h
		bra		p_2F50

p_2F58	bsf		STATUS,0				; entry from: 2F42h,2F6Ch
		btfss	PORTC,1
		bcf		STATUS,0
		decfsz	41h
		bra		p_2F2A
		btfsc	STATUS,0
		retlw	0
		retlw	0FFh
p_2F68	call	p__B3C					; entry from: 2F4Ah
		bra		p_2F58
p_2F6E	movlw	0Fh						; entry from: 2DAAh

p_2F70	movwf	43h						; entry from: 2BD2h,310Ch
		movlw	0FFh
		call	p__B12
		bcf		19h,5
		btfss	PORTC,1
		bra		p_2F9E
p_2F7E	movff	43h,44h					; entry from: 2FAAh

p_2F82	call	p__40C					; entry from: 2F90h,2F96h
		btfsc	0Fh,1
		retlw	4
		btfss	PORTC,1
		bra		p_2F9E
		btfss	19h,5
		bra		p_2F82
		bcf		19h,5
		decfsz	44h
		bra		p_2F82
		call	p__40C
		retlw	0

p_2F9E	clrf	44h						; entry from: 2F7Ch,2F8Ch
p_2FA0	call	p__40C					; entry from: 2FAEh
		btfsc	0Fh,1
		retlw	4
		btfsc	PORTC,1
		bra		p_2F7E
		decfsz	44h
		bra		p_2FA0
		call	p__40C
		retlw	5

p_2FB6	movlw	8						; entry from: 2CF4h,2D44h
		movwf	41h
		bcf		19h,5

p_2FBC	call	p__5D4					; entry from: 2FC2h,2FC8h
		btfss	19h,5
		bra		p_2FBC
		bcf		19h,5
		decfsz	41h
		bra		p_2FBC
		comf	4,W
		movwf	5
		incf	0
		rcall	p_2FF6
		bsf		72h,3,BANKED
		movlw	19h
		rcall	p_2EA0
		bcf		72h,3,BANKED
		movwf	3Fh
		iorlw	0
		bz		p_2FE6
		btfsc	2Dh,6
		retlw	0
		return	
p_2FE6	movf	71h,W,BANKED			; entry from: 2FDEh
		movwf	6
		incf	0
		comf	71h,W,BANKED
		xorwf	0BFh,W,BANKED
		btfss	STATUS,2
		retlw	0FFh
		retlw	0

p_2FF6	movwf	0Eh						; entry from: 2DB6h,2FD0h
		bsf		LATB,0
		bcf		LATB,7
		clrf	1Dh
		call	p__40C
		btfss	PORTC,1
		bra		p_300A
		bcf		LATB,0
		retlw	3
p_300A	movlw	9						; entry from: 3004h
		movwf	43h
		bra		p_301A

p_3010	nop								; entry from: 3052h,3056h
		call	p__40C
		call	p__B44
p_301A	btfss	2Dh,1					; entry from: 300Eh
		bra		p_302C
		call	p__B48
		movlw	5
		btfss	2Dh,0
		bra		p_3032
		movlw	0Bh
		bra		p_3032
p_302C	call	p__40C					; entry from: 301Ch
		movlw	4

p_3032	movwf	45h						; entry from: 3026h,302Ah
		call	p__B48
p_3038	call	p__40C					; entry from: 3042h
		call	p__5D4
		decfsz	45h
		bra		p_3038
		dcfsnz	43h
		bra		p_3058
		rrcf	0Eh
		btfsc	STATUS,0
		bra		p_3054
		nop
		bsf		LATB,0
		bra		p_3010
p_3054	bcf		LATB,0					; entry from: 304Ch
		bra		p_3010
p_3058	nop								; entry from: 3046h
		bra		p_305C
p_305C	bcf		LATB,0					; entry from: 305Ah
		call	p__40C
		call	p__40C
		retlw	0
p_3068	btfsc	19h,6					; entry from: 2060h
		bra		p_2D5A
		bra		p_2BC4

p_306E	btfsc	0Fh,4					; entry from: 2014h,201Ah,2D5Ah,30DEh
		bra		p_307E
		movlw	0CFh
		movwf	12h
		movlw	33h
		movwf	13h
		movf	94h,W,BANKED
		movwf	14h
p_307E	btfsc	2Ch,5					; entry from: 3070h
		return	
		movlw	5
		movwf	22h
		movlw	0C1h
		movwf	23h
		movwf	24h
		movlw	2
		cpfsgt	22h
		return	
		movff	24h,25h
		movlw	33h
		movwf	24h
		addwf	25h
		movlw	3
		cpfsgt	22h
		return	
		movff	25h,26h
		movf	94h,W,BANKED
		movwf	25h
		addwf	26h
		movlw	4
		cpfsgt	22h
		return	
		movff	26h,27h
		movlw	3Eh
		movwf	26h
		addwf	27h
		movlw	5
		cpfsgt	22h
		return	
		movff	27h,28h
		movlw	0
		movwf	27h
		addwf	28h
		movlw	6
		cpfsgt	22h
		return	
		movff	28h,29h
		movlw	0
		movwf	28h
		addwf	29h
		return	
p_30DE	call	p_306E					; entry from: 2066h
		btfsc	19h,6
		bra		p_319A
		movlw	60h
		btfss	2Dh,7
		btfss	3Eh,7
		call	p__730
		bcf		8Dh,0,BANKED
		movlw	81h
		movwf	4
		movlw	1
		movwf	0
		call	p_1EC4
		call	p__ADA
		movlw	0
		movwf	FSR0H
		movlw	1
		movwf	FSR0L
		movlw	4Bh
		call	p_2F70
		call	p__ADA
		btfsc	19h,7
		retlw	1
		movlw	3
		iorwf	LATB
		bcf		LATB,7
		clrf	1Dh
		call	p__5D4
		call	p__B3A
		btfss	PORTC,1
		bra		p_3132
		movlw	0FCh
		andwf	LATB
		retlw	3
p_3132	rcall	p_31A6					; entry from: 312Ah
		call	p__B52
		call	p__B46
		movlw	0FCh
		andwf	LATB
		rcall	p_31A6
		call	p__B3A
		call	p__B50
		clrf	11h
		bsf		11h,6
		movff	3,15h
		call	p_2DB0
		call	p__ADA
p_315A	movlw	7Ah						; entry from: 31A2h
		bsf		72h,3,BANKED
		call	p_1F5A
		bcf		72h,3,BANKED
		call	p__ADA
		movlw	7
		xorwf	0,W
		bnz		p_317C
		movff	5,0C0h
		movff	6,0C1h
		bsf		8Dh,0,BANKED
		movf	4,W
		bra		p_3192
p_317C	movlw	8						; entry from: 316Ch
		xorwf	0,W
		bz		p_3186
		btfss	2Dh,6
		bra		p_319E
p_3186	movff	6,0C0h					; entry from: 3180h
		movff	7,0C1h
		bsf		8Dh,0,BANKED
		movf	5,W
p_3192	xorlw	0C1h					; entry from: 317Ah
		bz		p_319A
		btfss	2Dh,6
		bra		p_319E

p_319A	goto	p_2D5A					; entry from: 30E4h,3194h

p_319E	incf	0C7h,f,BANKED			; entry from: 3184h,3198h
		btfss	0C7h,4,BANKED
		bra		p_315A
		retlw	0FFh

p_31A6	movlw	0Ah						; entry from: 3132h,3140h
		movwf	42h
		clrf	41h
p_31AC	call	p__652					; entry from: 31B6h
		decfsz	41h
		bra		p_31B6
		decfsz	42h
p_31B6	bra		p_31AC					; entry from: 31B2h
		return	

p_31BA	btfss	3Eh,4					; entry from: 20FAh,2100h
		bra		p_31DA
		movlw	0CFh
p_31C0	andlw	0C0h					; entry from: 31E2h
		iorwf	42h,W
p_31C4	movwf	1						; entry from: 31F6h
		movlw	33h
		btfss	3Eh,4
		movf	13h,W
		movwf	2
		movf	94h,W,BANKED
		btfss	3Eh,4
		movf	14h,W
		movwf	3
		goto	p_2D92
p_31DA	movf	12h,W					; entry from: 31BCh
		andlw	3Fh
		bz		p_31E4
		movf	12h,W
		bra		p_31C0
p_31E4	rcall	p_344E					; entry from: 31DEh
		movlw	1
		movwf	FSR0L
		movff	0,4
		incf	0
		movff	0,42h
		movf	12h,W
		bra		p_31C4
p_31F8	rcall	p_3202					; entry from: 206Ch
		bra		p_32EC
p_31FC	rcall	p_3202					; entry from: 20BAh
		goto	p_335A

p_3202	movlw	1						; entry from: 223Ch,31F8h,31FCh
		movwf	96h,BANKED
		movlw	81h
		goto	p_3D4A

p_320C	clrf	0B3h,BANKED				; entry from: 2020h,2026h,202Ch,2032h,2038h,203Eh,2044h,32F4h,3362h

p_320E	bcf		34h,4					; entry from: 3476h,3590h
		bsf		34h,2
		btfsc	0Fh,4
		bra		p_3244
		btfss	97h,2,BANKED
		bra		p_3228
		movlw	0EAh
		movwf	12h
		movlw	0FFh
		movwf	13h
		movf	0BEh,W,BANKED
		movwf	14h
		bra		p_3244
p_3228	btfss	37h,7					; entry from: 3218h
		bra		p_3238
		clrf	12h
		movlw	7
		movwf	13h
		movlw	0DFh
		movwf	14h
		bra		p_3244
p_3238	movlw	0DBh					; entry from: 322Ah
		movwf	12h
		movlw	33h
		movwf	13h
		movf	94h,W,BANKED
		movwf	14h

p_3244	btfsc	34h,7					; entry from: 3214h,3226h,3236h
		bra		p_3254
		movlw	18h
		btfsc	37h,7
		movlw	0
		btfsc	97h,2,BANKED
		movlw	18h
		movwf	2Eh
p_3254	btfsc	34h,6					; entry from: 3246h
		bra		p_329E
		btfss	37h,7
		bra		p_3294
		clrf	9Eh,BANKED
		clrf	9Fh,BANKED
		movlw	7
		andwf	13h,W
		xorlw	7
		bnz		p_328A
		movlw	0DFh
		xorwf	14h,W
		bz		p_3280
		movlw	0F0h
		andwf	14h,W
		xorlw	0E0h
		bnz		p_328A
		movlw	7
		movwf	0A0h,BANKED
		movlw	0FFh
		movwf	0A1h,BANKED
		bra		p_329E
p_3280	movlw	7						; entry from: 326Ch
		movwf	0A0h,BANKED
		movlw	0F8h
		movwf	0A1h,BANKED
		bra		p_329E

p_328A	movlw	7						; entry from: 3266h,3274h
		movwf	0A0h,BANKED
		movlw	0C0h
		movwf	0A1h,BANKED
		bra		p_329E
p_3294	clrf	9Eh,BANKED				; entry from: 325Ah
		clrf	9Fh,BANKED
		movlw	0FFh
		movwf	0A0h,BANKED
		clrf	0A1h,BANKED

p_329E	btfsc	34h,5					; entry from: 3256h,327Eh,3288h,3292h
		retlw	0
		btfss	37h,7
		bra		p_32E0
		clrf	0A2h,BANKED
		clrf	0A3h,BANKED
		movlw	7
		andwf	13h,W
		xorlw	7
		bnz		p_32D6
		movlw	0DFh
		xorwf	14h,W
		bz		p_32CC
		movlw	0F0h
		andwf	14h,W
		xorlw	0E0h
		bnz		p_32D6
		movf	13h,W
		movwf	0A4h,BANKED
		movf	14h,W
		movwf	0A5h,BANKED
		bsf		0A5h,3,BANKED
		retlw	0
p_32CC	movlw	7						; entry from: 32B6h
		movwf	0A4h,BANKED
		movlw	0E8h
		movwf	0A5h,BANKED
		retlw	0

p_32D6	movf	13h,W					; entry from: 32B0h,32BEh
		movwf	0A4h,BANKED
		movf	14h,W
		movwf	0A5h,BANKED
		retlw	0
p_32E0	clrf	0A2h,BANKED				; entry from: 32A4h
		clrf	0A3h,BANKED
		movf	14h,W
		movwf	0A4h,BANKED
		clrf	0A5h,BANKED
		retlw	0

p_32EC	call	p_3B8A					; entry from: 31FAh,3EAEh,3EC4h,3EDAh,3EF0h,3F06h,3F1Ch
		call	p__ADA
		rcall	p_320C
		call	p_3C82
		call	p__ADA
		btfss	19h,6
		bra		p_3306
		bsf		3Eh,6
		retlw	0
p_3306	btfss	97h,2,BANKED			; entry from: 3300h
		bra		p_3318
		movlw	0EEh
		movwf	5
		movlw	0FEh
		movwf	6
		clrf	7
		bcf		0Fh,5
		bra		p_332E
p_3318	movlw	2						; entry from: 3308h
		movwf	5
		movlw	1
		movwf	6
		clrf	7
		movf	95h,W,BANKED
		movwf	8
		movwf	9
		movwf	0Ah
		movwf	0Bh
		movwf	0Ch
p_332E	movlw	3						; entry from: 3316h
		movwf	0
		movwf	36h
		rcall	p_33A0
		call	p__ADA
		rcall	p_34B0
		call	p__ADA
		movlw	19h
		cpfslt	7Eh,BANKED
		movf	7Eh,W,BANKED
		btfss	0Fh,6
		movlw	19h
		call	p_1FE2
		bcf		72h,3,BANKED
		call	p__ADA
		movlw	19h
		goto	p_1E8E

p_335A	call	p_3B8A					; entry from: 31FEh,3EB4h,3ECAh,3EE0h,3EF6h,3F0Ch,3F22h
		call	p__ADA
		rcall	p_320C
		bsf		34h,3
		retlw	0

p_3368	movf	42h,W					; entry from: 2106h,210Ch,2112h,2118h,211Eh,2124h,212Ah
		movwf	36h
		bnz		p_3372
		bsf		36h,6
		bra		p_33A0
p_3372	rcall	p_344E					; entry from: 336Ch
		movlw	5
		addwf	0,W
		movwf	FSR0L
		movlw	0Dh
p_337C	cpfslt	FSR0L					; entry from: 3384h
		bra		p_3386
		movff	95h,POSTINC0
		bra		p_337C
p_3386	btfsc	97h,2,BANKED			; entry from: 337Eh
		bra		p_33A0
		btfsc	97h,1,BANKED
		btfss	17h,0
		bra		p_3396
		rcall	p_344E
		movf	0,W
		rcall	p_3466
p_3396	btfss	18h,1					; entry from: 338Eh
		bra		p_33A0
		rcall	p_344E
		movf	16h,W
		rcall	p_3466

p_33A0	movlw	4						; entry from: 3334h,3370h,3388h,3398h
		addwf	0
		btfsc	3Eh,4
		bra		p_33BA
		movff	2Eh,1
		movff	12h,2
		movff	13h,3
		movff	14h,4
		retlw	0
p_33BA	call	p_3CCE					; entry from: 33A6h
		btfsc	97h,2,BANKED
		bra		p_33F2
		btfss	37h,7
		bra		p_3410
		clrf	1
		clrf	2
		movlw	7
		movwf	3
		movlw	0DFh
		movwf	4
		clrf	2Fh
		clrf	30h
		movlw	7
		movwf	31h
		movlw	0F8h
		movwf	32h
		rcall	p_3BDC
		call	p_3C64
		clrf	2Fh
		clrf	30h
		movlw	7
		movwf	31h
		movlw	0E8h
		movwf	32h
		bra		p_3446
p_33F2	movlw	18h						; entry from: 33C0h
		movwf	1
		movlw	0EAh
		movwf	2
		movlw	0FFh
		movwf	3
		movf	0BEh,W,BANKED
		movwf	4
		clrf	38h
		movlw	0FEh
		movwf	39h
		movlw	0EEh
		movwf	3Ah
		goto	p_3E44
p_3410	movlw	18h						; entry from: 33C4h
		movwf	1
		movlw	0DBh
		movwf	2
		movlw	33h
		movwf	3
		movf	94h,W,BANKED
		movwf	4
		movlw	0
		movwf	2Fh
		movlw	0
		movwf	30h
		movlw	0FFh
		movwf	31h
		movlw	0
		movwf	32h
		rcall	p_3BDC
		call	p_3C64
		movlw	0
		movwf	2Fh
		movlw	0
		movwf	30h
		movf	94h,W,BANKED
		movwf	31h
		movlw	0
		movwf	32h
p_3446	rcall	p_3BDC					; entry from: 33F0h
		rcall	p_3C1A
		bsf		34h,2
		retlw	0

p_344E	movlw	4						; entry from: 31E4h,3372h,3390h,339Ah
		movwf	FSR0L
		movlw	8
		movwf	42h
		movf	POSTINC0,W
p_3458	movff	INDF0,41h				; entry from: 3462h
		movwf	POSTINC0
		movf	41h,W
		decfsz	42h
		bra		p_3458
		return	

p_3466	movwf	5						; entry from: 3394h,339Eh
		movlw	8
		cpfslt	0
		return	
		incf	0
		incf	36h
		return	

p_3474	btfsc	34h,4					; entry from: 213Eh,2144h,214Ah,2150h,2156h,217Ah,2180h
		rcall	p_320E
		movlw	7
		btfsc	97h,2,BANKED
		cpfseq	0
		bra		p_34A4
		btfsc	35h,2
		bra		p_348C
		movf	7,W
		movff	5,7
		movwf	5
p_348C	movff	5,3Ah					; entry from: 3482h
		movff	6,39h
		movff	7,38h
		bcf		35h,0
		call	p_3E44
		call	p__ADA
		bra		p_34B0
p_34A4	bsf		35h,0					; entry from: 347Eh
		btfss	34h,2
		bra		p_34B0
		rcall	p_3C82
		call	p__ADA

p_34B0	movff	1,2Fh					; entry from: 333Ah,34A2h,34A8h
		movff	2,30h
		movff	3,31h
		movff	4,32h
		rcall	p_3BDC
		btfss	97h,2,BANKED
		btfss	37h,7
		bsf		30h,3
		movf	CANSTAT,W
		andlw	0E0h
		bnz		p_34D8
		btfsc	COMSTAT,5
		bra		p_34D6
		btfss	COMSTAT,0
		bra		p_34DC
p_34D6	rcall	p_3CCE					; entry from: 34D0h
p_34D8	movlw	0						; entry from: 34CCh
		rcall	p_3CD0
p_34DC	call	p_3CC4					; entry from: 34D4h
		btfsc	RXB0CON,3
		call	p_3E1E
		btfsc	36h,6
		bra		p_34F0
		movlw	8
		btfss	35h,5
		btfsc	37h,6
p_34F0	movf	36h,W					; entry from: 34E8h
		movwf	RXB0DLC
		addlw	4
		movwf	0
		bcf		0,6
		movff	2Fh,0F61h
		movff	30h,0F62h
		movff	31h,0F63h
		movff	32h,0F64h
		movff	5,0F66h
		movff	6,0F67h
		movff	7,0F68h
		movff	8,0F69h
		movff	9,0F6Ah
		movff	0Ah,0F6Bh
		movff	0Bh,0F6Ch
		movff	0Ch,0F6Dh
		call	p_3B7C
		clrf	PIR3
p_3530	bcf		LATB,7					; entry from: 3B62h
		clrf	1Dh
		call	p_3CC4
		movlw	8
		movwf	RXB0CON
		call	p_3E1E
		goto	p_3CB0

p_3544	bsf		0B3h,5,BANKED			; entry from: 21A8h,21AEh,21B4h,21BAh,21C0h,21C6h,21CCh
		movf	CANSTAT,W
		andlw	0E0h
		bnz		p_3552
		bcf		0B3h,5,BANKED
		btfss	35h,0
		bcf		11h,6
p_3552	btfss	0B3h,1,BANKED			; entry from: 354Ah
		bra		p_3574
		movlw	70h
		andwf	11h,W
		bnz		p_3572
		call	p__63E
		call	p_3CCE
		movlb	0Eh
		call	p_3E7C
		btfsc	0B3h,5,BANKED
		bra		p_3572
		movlw	0
		rcall	p_3CD0

p_3572	clrf	0B3h,BANKED				; entry from: 355Ah,356Ch
p_3574	bcf		1Bh,4					; entry from: 3554h
		bcf		34h,1
		bcf		PIR5,5
		call	p__63E
		movf	98h,f,BANKED
		btfsc	STATUS,2
		bcf		35h,1
		movf	CANSTAT,W
		andlw	0E0h
		bz		p_35AA
		btfss	34h,3
		bra		p_359A
		bcf		34h,3
		rcall	p_320E
		rcall	p_3D5C
		call	p__ADA
		bra		p_35A8
p_359A	movlw	60h						; entry from: 358Ch
		xorwf	CANSTAT,W
		andlw	0E0h
		bz		p_35AA
p_35A2	movlw	60h						; entry from: 35F0h
		rcall	p_3CD0
		rcall	p_3B7C
p_35A8	clrf	PIR3					; entry from: 3598h

p_35AA	rcall	p_3CB0					; entry from: 3588h,35A0h,35D4h,35E8h,35FCh,3676h,3692h,36A4h,36C2h,36D0h,37E6h,38F2h,39ECh,39FCh,3A02h,3A08h,3A16h,3A1Ch,3A22h,3A32h,3AC2h,3ACCh,3AD2h
		call	p__5D4
		btfsc	0Fh,1
		bra		p_35F2
		btfsc	19h,7
		retlw	1
		btfsc	COMSTAT,0
		bcf		PIR5,5
		btfsc	34h,1
		bra		p_35C8
		btfss	RXB0CON,7
		bra		p_35C8
		bsf		34h,1
		bra		p_35FE

p_35C8	bcf		34h,1					; entry from: 35BEh,35C2h
		rcall	p_3CBA
		btfsc	RXB0CON,7
		bra		p_35FE
		btfsc	PIR5,7
		btfsc	3Eh,6
		bra		p_35AA
		incfsz	98h,W,BANKED
		incf	98h,f,BANKED
		bcf		PIR5,7
		call	p__63E
		btfss	3Eh,3
		bra		p_3672
		movlw	40h
		cpfsgt	98h,BANKED
		bra		p_35AA
		rcall	p_3CCE
		clrf	98h,BANKED
		incf	98h,f,BANKED
		bra		p_35A2

p_35F2	btfss	0B3h,0,BANKED			; entry from: 35B2h,3678h
		btfss	3Eh,3
		retlw	8
		clrf	21h
		bcf		0Fh,1
		bra		p_35AA

p_35FE	movff	RXB0SIDH,1					; entry from: 35C6h,35CEh
		movff	RXB0SIDL,2
		movff	RXB0EIDH,3
		movff	RXB0EIDL,4
		movff	RXB0D0,5
		movff	RXB0D1,6
		movff	RXB0D2,7
		movff	RXB0D3,8
		movff	RXB0D4,9
		movff	RXB0D5,0Ah
		movff	RXB0D6,0Bh
		movff	RXB0D7,0Ch
		movff	RXB0DLC,36h
		movff	PIR3,44h
		bcf		RXB0CON,7
		clrf	PIR3
		bcf		LATB,6
		clrf	1Eh
		call	p__63E
		rcall	p_3CB0
		incf	21h,W
		movwf	82h,BANKED
		movlw	8
		btfsc	36h,3
		movwf	36h
		bcf		0Fh,0
		bcf		11h,1
		movf	COMSTAT,W
		andlw	7Fh
		bnz		p_3660
		btfsc	44h,7
		bra		p_3660
		clrf	98h,BANKED
		bra		p_36A6

p_3660	clrf	COMSTAT						; entry from: 3656h,365Ah
		bsf		0Fh,0
		bsf		11h,1
		incfsz	98h,W,BANKED
		incf	98h,f,BANKED
		btfsc	3Eh,6
		bra		p_36A6
		btfsc	3Eh,3
		bra		p_367A
p_3672	movlw	5						; entry from: 35E2h
		cpfsgt	98h,BANKED
		bra		p_35AA
		bra		p_35F2
p_367A	btfsc	COMSTAT,0					; entry from: 3670h
		bra		p_3684
		movlw	40h
		cpfsgt	98h,BANKED
		bra		p_3690
p_3684	rcall	p_3CCE					; entry from: 367Ch
		clrf	98h,BANKED
		incf	98h,f,BANKED
		movlw	60h
		rcall	p_3CD0
		rcall	p_3B7C
p_3690	btfsc	35h,1					; entry from: 3682h
		bra		p_35AA
		bsf		35h,1
		btfsc	44h,7
		bra		p_36A6
		movlw	6Ch
		call	p__730
		call	p__724
		bra		p_35AA

p_36A6	bcf		34h,0					; entry from: 365Eh,366Ch,3698h
		btfsc	36h,6
		bsf		34h,0
		movlw	0Fh
		andwf	36h
		btfsc	STATUS,2
		bsf		34h,0
		call	p__63E
		btfss	34h,0
		bra		p_36C4
		btfss	97h,2,BANKED
		btfss	18h,1
		bra		p_37C4
		bra		p_35AA
p_36C4	btfsc	97h,2,BANKED			; entry from: 36BAh
		bra		p_39BC
		btfss	18h,1
		bra		p_36D2
		movf	94h,W,BANKED
		cpfseq	5
		bra		p_35AA
p_36D2	movf	5,W						; entry from: 36CAh
		btfsc	18h,1
		movf	6,W
		movwf	45h
		btfss	97h,1,BANKED
		bra		p_37C4
		btfsc	18h,7
		btfsc	11h,2
		bra		p_37C4
		movf	45h,W
		andlw	0F0h
		xorlw	10h
		bnz		p_37C4
		movlw	8
		cpfslt	36h
		bra		p_3704
		btfsc	35h,5
		bra		p_36FA
		btfsc	33h,7
		bra		p_37C4
p_36FA	movlw	1						; entry from: 36F4h
		btfsc	18h,1
		movlw	2
		cpfsgt	36h
		bra		p_37C4
p_3704	movf	45h,W					; entry from: 36F0h
		xorlw	10h
		bnz		p_3714
		movf	6,W
		btfsc	18h,1
		movf	7,W
		sublw	6
		bc		p_37C4
p_3714	decfsz	0A6h,W,BANKED			; entry from: 3708h
		bra		p_3730
		movff	0A7h,2Fh
		movff	0A8h,30h
		movff	0A9h,31h
		movff	0AAh,32h
		call	p__63E
		rcall	p_3BDC
		bra		p_3756
p_3730	movff	1,2Fh					; entry from: 3716h
		movff	2,30h
		movff	3,31h
		movff	4,32h
		bcf		30h,4
		tstfsz	0A6h,BANKED
		bra		p_3756
		btfss	37h,7
		bra		p_374E
		bcf		2Fh,0
		bra		p_3756
p_374E	movff	3,32h					; entry from: 3748h
		movff	4,31h

p_3756	call	p__63E					; entry from: 372Eh,3744h,374Ch
		bcf		30h,3
		btfss	37h,7
		bsf		30h,3
		rcall	p_3CC4
		btfsc	RXB0CON,3
		rcall	p_3E1E
		movlw	8
		btfss	35h,5
		btfsc	37h,6
		movlw	3
		movwf	RXB0DLC
		movff	2Fh,0F61h
		movff	30h,0F62h
		movff	31h,0F63h
		movff	32h,0F64h
		movlw	30h
		movwf	RXB0D0
		clrf	RXB0D1
		clrf	RXB0D2
		movf	95h,W,BANKED
		movwf	RXB0D3
		movwf	RXB0D4
		movwf	RXB0D5
		movwf	RXB0D6
		movwf	RXB0D7
		movf	0A6h,f,BANKED
		bz		p_37B8
		movf	0B0h,W,BANKED
		btfss	35h,5
		btfsc	37h,6
		movwf	RXB0DLC
		movff	0ABh,0F66h
		movff	0ACh,0F67h
		movff	0ADh,0F68h
		movff	0AEh,0F69h
		movff	0AFh,0F6Ah
		call	p__63E
p_37B8	movlw	8						; entry from: 3796h
		movwf	RXB0CON
		bsf		10h,7
		rcall	p_3CB0
		bra		p_37C4

p_37C2	bsf		0B3h,1,BANKED			; entry from: 39DAh,39DEh,39E6h,3A0Ah

p_37C4	rcall	p_3DDA					; entry from: 36C0h,36DCh,36E2h,36EAh,36F8h,3702h,3712h,37C0h,3AECh,3AF2h,3B16h,3B26h
		call	p__63E
		movlw	4
		addwf	36h,W
		movwf	0
		movlw	0
		movwf	FSR0H
		movlw	6
		btfss	97h,2,BANKED
		btfss	18h,1
		movlw	5
		movwf	FSR0L
		btfss	97h,0,BANKED
		btfss	17h,0
		bra		p_37F0
		btfsc	34h,0
		bra		p_35AA
		btfsc	97h,1,BANKED
		bra		p_3834
		btfsc	97h,2,BANKED
		bra		p_390C
p_37F0	btfsc	72h,3,BANKED			; entry from: 37E2h
		retlw	0
		btfsc	17h,1
		rcall	p_396E
		btfss	34h,0
		bra		p_3818
		movlw	52h
		call	p__7F2
		call	p__63E
		movlw	54h
		call	p__7F2
		movlw	52h
		call	p__7F2
		call	p__82E
		retlw	0

p_3818	movlw	8						; entry from: 37FAh,387Ah,38A0h,390Ah,391Ah,394Eh,3952h,396Ch
p_381A	cpfsgt	36h						; entry from: 38E8h
		movf	36h,W
		addlw	5
		movwf	41h
p_3822	call	p__63E					; entry from: 3832h
		movf	41h,W
		cpfslt	FSR0L
		retlw	0
		movf	POSTINC0,W
		call	p__7AA
		bra		p_3822
p_3834	movf	45h,W					; entry from: 37EAh
		bz		p_38FA
		andlw	0F0h
		movwf	42h
		bnz		p_3842
		btfsc	45h,3
		bra		p_38EA
p_3842	sublw	3Fh						; entry from: 383Ch
		bnc		p_38EA
		movlw	10h
		cpfseq	42h
		bra		p_3856
		movlw	2
		btfsc	18h,1
		movlw	3
		cpfsgt	36h
		bra		p_38EA
p_3856	btfss	35h,5					; entry from: 384Ah
		btfss	33h,7
		bra		p_3862
		movlw	8
		cpfseq	36h
		bra		p_38EA
p_3862	btfsc	72h,3,BANKED			; entry from: 385Ah
		retlw	0
		btfss	17h,1
		bra		p_387E
		rcall	p_396E
		call	p__63E
		incf	45h,W
		movf	42h
		bz		p_38E4
		movlw	30h
		cpfseq	42h
		bra		p_3818
		bra		p_38E2
p_387E	tstfsz	42h						; entry from: 3868h
		bra		p_3888
		movf	POSTINC0,W
		incf	45h,W
		bra		p_38E4
p_3888	call	p__63E					; entry from: 3880h
		movlw	20h
		cpfseq	42h
		bra		p_38A2
		movf	POSTINC0,W
		call	p__712
p_3898	call	p__834					; entry from: 38C2h
		call	p__82E
		bra		p_3818
p_38A2	movlw	10h						; entry from: 3890h
		cpfseq	42h
		bra		p_38C4
		movf	POSTINC0,W
		call	p__71C
		call	p__63E
		movf	POSTINC0,W
		call	p__7AA
		call	p__724
		call	p__63E
		movlw	30h
		bra		p_3898
p_38C4	movlw	46h						; entry from: 38A6h
		call	p__7F2
		movlw	43h
		call	p__834
		call	p__63E
		call	p__82E
		movf	POSTINC0,W
		call	p__71C
		call	p__82E
p_38E2	movlw	3						; entry from: 387Ch

p_38E4	btfsc	18h,1					; entry from: 3874h,3886h
		addlw	1
		bra		p_381A

p_38EA	btfsc	3Eh,3					; entry from: 3840h,3844h,3854h,3860h
		bra		p_3900
p_38EE	btfss	3Eh,6					; entry from: 38FCh
		btfss	3Eh,4
		bra		p_35AA
		bsf		0Fh,0
		bsf		72h,3,BANKED
		retlw	0
p_38FA	btfss	3Eh,3					; entry from: 3836h
		bra		p_38EE
		btfsc	33h,6
p_3900	bsf		0Fh,0					; entry from: 38ECh
		btfsc	17h,1
		rcall	p_396E
		call	p__63E
		bra		p_3818
p_390C	btfsc	72h,3,BANKED			; entry from: 37EEh
		retlw	0
		btfss	17h,1
		bra		p_3950
		btfsc	43h,3
		bra		p_391C
		rcall	p_3972
		bra		p_3818
p_391C	rrcf	1,W						; entry from: 3916h
		movwf	42h
		rrcf	42h
		bcf		42h,3
		movf	42h,W
		call	p__71C
		call	p__63E
		call	p__82E
		movlw	0
		btfsc	1,0
		movlw	1
		call	p__71C
		swapf	2,W
		call	p__71C
		call	p__63E
		movf	2,W
		call	p__71C
		rcall	p_398A
		bra		p_3818
p_3950	btfss	0B3h,3,BANKED			; entry from: 3912h
		bra		p_3818
		swapf	5,W
		call	p__71C
		call	p__63E
		movf	POSTINC0,W
		call	p__71C
		call	p__720
		call	p__82E
		bra		p_3818

p_396E	btfsc	43h,3					; entry from: 37F6h,386Ah,3904h
		bra		p_397A
p_3972	movf	3,W						; entry from: 3918h
		call	p__71C
		bra		p_3990
p_397A	movf	1,W						; entry from: 3970h
		call	p__7AA
		call	p__63E
		movf	2,W
		call	p__7AA
p_398A	movf	3,W						; entry from: 394Ch
		call	p__7AA
p_3990	call	p__63E					; entry from: 3978h
		movf	4,W
		call	p__7AA
		btfss	18h,5
		bra		p_39AC
		call	p__63E
		movf	36h,W
		call	p__71C
		call	p__82E
p_39AC	btfss	97h,2,BANKED			; entry from: 399Ch
		btfss	18h,1
		return	
		call	p__63E
		movf	94h,W,BANKED
		goto	p__7AA
p_39BC	call	p__63E					; entry from: 36C6h
		swapf	2,W
		andlw	30h
		movwf	0B4h,BANKED
		rlncf	2,W
		andlw	0C1h
		iorwf	0B4h,f,BANKED
		rlncf	1,W
		andlw	0Eh
		iorwf	0B4h,f,BANKED
		swapf	0B4h,f,BANKED
		movlw	70h
		andwf	11h,W
		btfss	STATUS,2
		bra		p_37C2
		btfsc	35h,0
		bra		p_37C2
		movf	39h,W
		xorwf	0B4h,W,BANKED
		btfsc	STATUS,2
		bra		p_37C2
		movlw	8
		cpfseq	36h
		bra		p_35AA
		call	p__63E
		movlw	0E8h
		cpfseq	0B4h,BANKED
		bra		p_3A0C
		movf	3Ah,W
		cpfseq	0Ah
		bra		p_35AA
		movf	39h,W
		cpfseq	0Bh
		bra		p_35AA
		movf	38h,W
		cpfseq	0Ch
		bra		p_35AA
		bra		p_37C2
p_3A0C	movlw	0ECh					; entry from: 39F6h
		cpfseq	0B4h,BANKED
		bra		p_3ACE
		movf	3Ah,W
		cpfseq	0Ah
		bra		p_35AA
		movf	39h,W
		cpfseq	0Bh
		bra		p_35AA
		movf	38h,W
		cpfseq	0Ch
		bra		p_35AA
		movf	9,W
		movwf	0BBh,BANKED
		movlw	10h
		xorwf	5,W
		bz		p_3A3A
		movlw	20h
		cpfseq	5
		bra		p_35AA
		bsf		0B3h,4,BANKED
		movlw	0FFh
		movwf	0BBh,BANKED
p_3A3A	bsf		0B3h,3,BANKED			; entry from: 3A2Ch
		movff	4,0B5h
		movff	6,0B6h
		movff	7,0B7h
		movf	8,W
		movwf	0B8h,BANKED
		movwf	0BAh,BANKED
		clrf	0B9h,BANKED
		incf	0B9h,f,BANKED
		clrf	0BCh,BANKED
		clrf	0BDh,BANKED
		movlw	10h
		cpfslt	0BBh,BANKED
		movwf	0BBh,BANKED
		movf	8,W
		cpfslt	0BBh,BANKED
		movwf	0BBh,BANKED
		bsf		0B3h,5,BANKED
		movf	CANSTAT,W
		andlw	0E0h
		btfsc	STATUS,2
		bcf		0B3h,5,BANKED
		call	p__63E
		rcall	p_3CCE
		movlb	0Eh
		setf	0FEh,BANKED
		setf	0FFh,BANKED
		movlw	4Bh
		movwf	0E9h,BANKED
		movwf	0EDh,BANKED
		movwf	0F1h,BANKED
		movwf	0F5h,BANKED
		movf	3,W
		movwf	0EAh,BANKED
		movwf	0EEh,BANKED
		movwf	0F2h,BANKED
		movwf	0F6h,BANKED
		movf	4,W
		movwf	0EBh,BANKED
		movwf	0EFh,BANKED
		movwf	0F3h,BANKED
		movwf	0F7h,BANKED
		movlb	0
		bsf		0B3h,0,BANKED
		movlw	60h
		btfss	0B3h,5,BANKED
		movlw	0
		rcall	p_3CD0
		btfss	17h,0
		bra		p_3ABE
		movf	0B7h,W,BANKED
		call	p__71C
		call	p__63E
		movf	0B6h,W,BANKED
		call	p__7AA
		call	p__63E
		call	p__724
p_3ABE	btfss	0B3h,4,BANKED			; entry from: 3AA4h
		btfsc	11h,2
		bra		p_35AA
		call	p_3B28
		call	p__ADA
		bra		p_35AA
p_3ACE	movlw	0EBh					; entry from: 3A10h
		cpfseq	0B4h,BANKED
		bra		p_35AA
		btfss	0B3h,4,BANKED
		btfsc	11h,2
		bsf		0B3h,2,BANKED
		incf	0BCh,f,BANKED
		incf	0BDh,f,BANKED
		call	p__63E
		btfss	0B3h,2,BANKED
		bra		p_3AEE
		movf	0B8h,W,BANKED
		cpfslt	0BCh,BANKED
		bsf		0B3h,1,BANKED
		bra		p_37C4
p_3AEE	movf	0BDh,W,BANKED			; entry from: 3AE4h
		cpfseq	0BBh,BANKED
		bra		p_37C4
		addwf	0B9h,f,BANKED
		subwf	0BAh,f,BANKED
		tstfsz	0BAh,BANKED
		bra		p_3B18
		bsf		0B3h,1,BANKED
		rcall	p_3CC4
		btfsc	RXB0CON,3
		rcall	p_3E1E
		movlw	13h
		movwf	RXB0D0
		movf	0B6h,W,BANKED
		movwf	RXB0D1
		movf	0B7h,W,BANKED
		movwf	RXB0D2
		movf	0B8h,W,BANKED
		movwf	RXB0D3
		rcall	p_3B3C
		bra		p_37C4
p_3B18	clrf	0BDh,BANKED				; entry from: 3AFAh
		movf	0BAh,W,BANKED
		cpfslt	0BBh,BANKED
		movwf	0BBh,BANKED
		rcall	p_3B28
		call	p__ADA
		bra		p_37C4

p_3B28	rcall	p_3CC4					; entry from: 3AC4h,3B20h
		btfsc	RXB0CON,3
		rcall	p_3E1E
		movlw	11h
		movwf	RXB0D0
		movff	0BBh,0F67h
		movff	0B9h,0F68h
		setf	RXB0D3
p_3B3C	setf	RXB0D4						; entry from: 3B14h
		movff	3Ah,RXB0D5
		movff	39h,RXB0D6
		movff	38h,RXB0D7
		movlw	0E7h
		movwf	RXB0SIDH
		movlw	68h
		movwf	RXB0SIDL
		movff	0B5h,RXB0EIDH
		movff	14h,RXB0EIDL
		movlw	8
		movwf	RXB0DLC
		call	p__63E
		bra		p_3530

p_3B64	bsf		CANCON,4					; entry from: 21F6h,21FCh,2202h,2208h,220Eh,2214h,221Ah
		movlw	30h
		xorwf	CANSTAT,W
		andlw	0E0h
		btfss	STATUS,2
		rcall	p_3CCE
		bsf		LATB,2
		bcf		3Eh,0
		bcf		34h,3
		clrf	0B1h,BANKED
		clrf	0B2h,BANKED
		retlw	0

p_3B7C	rcall	p_3CBA					; entry from: 187Ah,352Ah,35A6h,368Eh,3DD8h
		bcf		RXB0CON,7
		call	p_3CB0
		bcf		RXB0CON,7
		clrf	COMSTAT
		retlw	0

p_3B8A	movf	96h,W,BANKED			; entry from: 32ECh,335Ah
		movwf	42h
		clrf	41h
		btfsc	33h,3
p_3B92	btfsc	PORTB,3					; entry from: 3B9Ah
		bra		p_3B9E
		dcfsnz	41h
		decfsz	42h
		bra		p_3B92
		retlw	6
p_3B9E	rcall	p_3CCE					; entry from: 3B94h
		clrf	PIE3
		movlw	20h
		movwf	CIOCON
		goto	p_4000
		nop

		ORG BASE_ADDR + 03BC2h
p_3BC2	bsf		3Eh,0					; entry from: 4024h
		rcall	p_3CBA
		movlw	0
		movwf	RXB0CON
		rcall	p_3CB0
		movlw	4
		movwf	RXB0CON
		retlw	0

p_3BD2	btfss	37h,5					; entry from: 3C94h,3CA8h,3D88h,3DB0h,3DCEh
		bra		p_3BDC
		btfss	34h,6
		btfsc	34h,5
		bra		p_3C14

p_3BDC	btfss	37h,7					; entry from: 33DEh,3430h,3446h,34C0h,372Ch,3BD4h
		bra		p_3BF8
p_3BE0	rlcf	32h						; entry from: 3C18h
		rlcf	31h
		rlcf	32h
		rlcf	31h
		movlw	1Fh
		andwf	31h,W
		movwf	2Fh
		movlw	0FCh
		andwf	32h,W
		movwf	30h
		clrf	31h
		clrf	32h

p_3BF8	movlw	3						; entry from: 3BDEh,3C16h,3E52h
		andwf	30h,W
		movwf	41h
		rlcf	30h
		rlcf	2Fh
		rlcf	30h
		rlcf	2Fh
		rlcf	30h
		rlcf	2Fh
		movlw	0E0h
		andwf	30h,W
		iorwf	41h,W
		movwf	30h
		retlw	0
p_3C14	btfsc	35h,4					; entry from: 3BDAh
		bra		p_3BF8
		bra		p_3BE0

p_3C1A	movlb	0Eh						; entry from: 3448h,3CAAh,3DD0h
		movf	2Fh,W
		movwf	0E0h,BANKED
		movwf	0E4h,BANKED
		movwf	0E8h,BANKED
		movwf	0ECh,BANKED
		movwf	0F0h,BANKED
		movwf	0F4h,BANKED
		bsf		30h,3
		btfss	37h,7
		btfsc	37h,5
		bcf		30h,3
		movf	30h,W
		movwf	0E5h,BANKED
		movwf	0EDh,BANKED
		movwf	0F5h,BANKED
		btfsc	37h,5
		iorlw	8
		movwf	0E1h,BANKED
		movwf	0E9h,BANKED
		movwf	0F1h,BANKED
		movf	31h,W
		movwf	0E2h,BANKED
		movwf	0E6h,BANKED
		movwf	0EAh,BANKED
		movwf	0EEh,BANKED
		movwf	0F2h,BANKED
		movwf	0F6h,BANKED
		movf	32h,W
		movwf	0E3h,BANKED
		movwf	0E7h,BANKED
		movwf	0EBh,BANKED
		movwf	0EFh,BANKED
		movwf	0F3h,BANKED
		movwf	0F7h,BANKED
		movlb	0
		retlw	0

p_3C64	movlb	0Eh						; entry from: 33E0h,3432h,3C96h,3D8Ah,3DB2h
		movf	2Fh,W
		movwf	0F8h,BANKED
		movwf	0FCh,BANKED
		movf	30h,W
		movwf	0F9h,BANKED
		movwf	0FDh,BANKED
		movf	31h,W
		movwf	0FAh,BANKED
		movwf	0FEh,BANKED
		movf	32h,W
		movwf	0FBh,BANKED
		movwf	0FFh,BANKED
		movlb	0
		retlw	0

p_3C82	rcall	p_3CCE					; entry from: 32F6h,34AAh
		movff	9Eh,2Fh
		movff	9Fh,30h
		movff	0A0h,31h
		movff	0A1h,32h
		rcall	p_3BD2
		rcall	p_3C64
		movff	0A2h,2Fh
		movff	0A3h,30h
		movff	0A4h,31h
		movff	0A5h,32h
		rcall	p_3BD2
		rcall	p_3C1A
		bcf		34h,2
		retlw	0

p_3CB0	movf	CANCON,W					; entry from: 1FD8h,3540h,35AAh,3642h,37BEh,3B80h,3BCAh,3E3Ch
		andlw	0E1h
		iorlw	0
		movwf	CANCON
		retlw	0

p_3CBA	movf	CANCON,W					; entry from: 35CAh,3B7Ch,3BC4h
		andlw	0E1h
		iorlw	0Ah
		movwf	CANCON
		retlw	0

p_3CC4	movf	CANCON,W					; entry from: 1FCEh,34DCh,3534h,3760h,3AFEh,3B28h
		andlw	0E1h
		iorlw	8
		movwf	CANCON
		retlw	0

p_3CCE	movlw	80h						; entry from: 814h,1876h,33BAh,34D6h,3560h,35EAh,3684h,3A70h,3B6Eh,3B9Eh,3C82h,3D5Ch,3E44h

p_3CD0	movwf	43h						; entry from: 34DAh,3570h,35A4h,368Ch,3AA0h,3DD6h
		xorwf	CANSTAT,W
		andlw	0E0h
		btfsc	STATUS,2
		retlw	0
		movff	TXERRCNT,0B1h
		movff	RXERRCNT,0B2h
		movf	CANSTAT,W
		andlw	0E0h
		xorlw	60h
		bnz		p_3CEE
		movlw	0
		rcall	p_3CF4
p_3CEE	movf	43h,W					; entry from: 3CE8h
		rcall	p_3CF4
		retlw	0

p_3CF4	movwf	CANCON						; entry from: 3CECh,3CF0h
		rlncf	96h,W,BANKED
		movwf	42h
		clrf	41h
p_3CFC	call	p__5D4					; entry from: 3D0Eh
		movf	CANSTAT,W
		xorwf	CANCON,W
		andlw	0E0h
		btfsc	STATUS,2
		retlw	0
		dcfsnz	41h
		decfsz	42h
		bra		p_3CFC
		pop
		bsf		LATB,2
		movlw	30h
		movwf	CANCON
		rlncf	96h,W,BANKED
		addlw	60h
		movwf	42h
p_3D1E	call	p__5D4					; entry from: 3D2Eh
		movlw	30h
		xorwf	CANSTAT,W
		andlw	0E0h
		bz		p_3D38
		dcfsnz	41h
		decfsz	42h
		bra		p_3D1E
p_3D30	bsf		0D2h,7,BANKED			; entry from: 3D3Ah
		movlw	94h
		movwf	0D1h,BANKED
		reset
p_3D38	btfss	PORTB,2					; entry from: 3D28h
		bra		p_3D30
		bcf		3Eh,0
		bcf		34h,3
		call	p_1FF0
		tstfsz	STKPTR
		pop
		retlw	6

p_3D4A	movwf	37h						; entry from: 3208h,3EBEh,3ED4h,3EEAh,3F00h,3F16h,3F2Ch
		andlw	7
		addlw	1
		clrf	97h,BANKED
		bsf		97h,7,BANKED
p_3D54	rlncf	97h,f,BANKED			; entry from: 3D58h
		addlw	0FFh
		bnz		p_3D54
		return	
p_3D5C	rcall	p_3CCE					; entry from: 3592h
		btfss	34h,6
		btfsc	34h,5
		bra		p_3D96
		btfss	97h,2,BANKED
		bra		p_3D76
		movlw	70h
		andwf	11h,W
		bnz		p_3D76
		rcall	p_3E44
		call	p__ADA
		bra		p_3DD4

p_3D76	clrf	2Fh						; entry from: 3D66h,3D6Ch
		clrf	30h
		clrf	31h
		clrf	32h
		movlw	0FFh
		btfsc	11h,6
		movwf	31h
		btfsc	11h,5
		movwf	32h
		rcall	p_3BD2
		rcall	p_3C64
		clrf	2Fh
		clrf	30h
		clrf	31h
		clrf	32h
		bra		p_3DC4
p_3D96	movff	9Eh,2Fh					; entry from: 3D62h
		movff	9Fh,30h
		movff	0A0h,31h
		movff	0A1h,32h
		movlw	0FFh
		btfsc	11h,6
		movwf	31h
		btfsc	11h,5
		movwf	32h
		rcall	p_3BD2
		rcall	p_3C64
		movff	0A2h,2Fh
		movff	0A3h,30h
		movff	0A4h,31h
		movff	0A5h,32h
p_3DC4	movf	15h,W					; entry from: 3D94h
		btfsc	11h,6
		movwf	31h
		btfsc	11h,5
		movwf	32h
		rcall	p_3BD2
		rcall	p_3C1A
		bsf		34h,2
p_3DD4	movlw	60h						; entry from: 3D74h
		rcall	p_3CD0
		bra		p_3B7C
p_3DDA	clrf	43h						; entry from: 37C4h
		movlw	0Bh
		andwf	2,W
		movwf	41h
		rrcf	1
		rrcf	2
		swapf	1
		swapf	2
		movlw	0Fh
		andwf	2
		movlw	0F0h
		andwf	1,W
		iorwf	2
		movlw	7
		andwf	1
		btfsc	41h,3
		bra		p_3E0A
		movff	1,3
		movff	2,4
		clrf	1
		clrf	2
		retlw	0
p_3E0A	bcf		STATUS,0				; entry from: 3DFAh
		rlcf	2
		rlcf	1
		rlcf	2
		rlcf	1
		movf	41h,W
		andlw	3
		iorwf	2
		setf	43h
		retlw	0

p_3E1E	rlncf	96h,W,BANKED			; entry from: 1FD4h,34E2h,353Ch,3764h,3B02h,3B2Ch
		addwf	96h,W,BANKED
		movwf	41h
		clrf	42h
p_3E26	call	p__5D4					; entry from: 3E36h
		btfss	RXB0CON,3
		retlw	0
		btfsc	COMSTAT,0
		bra		p_3E38
		dcfsnz	42h
		decfsz	41h
		bra		p_3E26
p_3E38	bcf		RXB0CON,3					; entry from: 3E30h
		bcf		PIR5,5
		call	p_3CB0
		pop
		retlw	6

p_3E44	rcall	p_3CCE					; entry from: 340Ch,349Ah,3D6Eh
		clrf	0B3h,BANKED
		bsf		34h,2
		movff	38h,2Fh
		movff	39h,30h
		call	p_3BF8
		movlb	0Eh
		movf	2Fh,W
		movwf	0E0h,BANKED
		movwf	0E4h,BANKED
		movf	30h,W
		iorlw	8
		movwf	0E1h,BANKED
		movwf	0E5h,BANKED
		movlw	0F0h
		cpfslt	39h
		bra		p_3E76
		movlw	0FFh
		movwf	0E2h,BANKED
		movf	14h,W
		movwf	0E6h,BANKED
		bra		p_3E7C
p_3E76	movf	3Ah,W					; entry from: 3E6Ah
		movwf	0E2h,BANKED
		movwf	0E6h,BANKED

p_3E7C	movlw	0Fh						; entry from: 3566h,3E74h
		movwf	0F8h,BANKED
		movwf	0FCh,BANKED
		movlw	0E3h
		movwf	0F9h,BANKED
		movwf	0FDh,BANKED
		setf	0FAh,BANKED
		clrf	0FEh,BANKED
		clrf	0FBh,BANKED
		clrf	0FFh,BANKED
		movlw	7
		movwf	0E8h,BANKED
		movwf	0ECh,BANKED
		movwf	0F0h,BANKED
		movwf	0F4h,BANKED
		movlw	68h
		movwf	0E9h,BANKED
		movwf	0EDh,BANKED
		btfss	11h,2
		movlw	48h
		movwf	0F1h,BANKED
		movwf	0F5h,BANKED
		movlb	0
		retlw	0
p_3EAC	rcall	p_3EB8					; entry from: 2072h
		goto	p_32EC
p_3EB2	rcall	p_3EB8					; entry from: 20C0h
		goto	p_335A

p_3EB8	movlw	1						; entry from: 2242h,3EACh,3EB2h
		movwf	96h,BANKED
		movlw	1
		goto	p_3D4A
p_3EC2	rcall	p_3ECE					; entry from: 2078h
		goto	p_32EC
p_3EC8	rcall	p_3ECE					; entry from: 20C6h
		goto	p_335A

p_3ECE	movlw	2						; entry from: 2248h,3EC2h,3EC8h
		movwf	96h,BANKED
		movlw	81h
		goto	p_3D4A
p_3ED8	rcall	p_3EE4					; entry from: 207Eh
		goto	p_32EC
p_3EDE	rcall	p_3EE4					; entry from: 20CCh
		goto	p_335A

p_3EE4	movlw	2						; entry from: 224Eh,3ED8h,3EDEh
		movwf	96h,BANKED
		movlw	1
		goto	p_3D4A
p_3EEE	rcall	p_3EFA					; entry from: 2084h
		goto	p_32EC
p_3EF4	rcall	p_3EFA					; entry from: 20D2h
		goto	p_335A

p_3EFA	movff	99h,96h					; entry from: 2254h,3EEEh,3EF4h
		movlw	42h
		goto	p_3D4A
p_3F04	rcall	p_3F10					; entry from: 208Ah
		goto	p_32EC
p_3F0A	rcall	p_3F10					; entry from: 20D8h
		goto	p_335A

p_3F10	movff	9Bh,96h					; entry from: 225Ah,3F04h,3F0Ah
		movf	9Ah,W,BANKED
		goto	p_3D4A
p_3F1A	rcall	p_3F26					; entry from: 2090h
		goto	p_32EC
p_3F20	rcall	p_3F26					; entry from: 20DEh
		goto	p_335A

p_3F26	movff	9Dh,96h					; entry from: 2260h,3F1Ah,3F20h
		movf	9Ch,W,BANKED
		goto	p_3D4A
		nop

#if WDT_RESET
p_reset		bsf     WDTCON, SWDTEN
reset_loop	bra	reset_loop
#endif

		ORG BASE_ADDR + 04000h
p_4000	decf	96h,W,BANKED			; entry from: 3BA6h
		btfss	97h,2,BANKED
		iorlw	80h
		movff	WREG,0E43h
		movlw	0BCh
		btfss	97h,2,BANKED
		movlw	0BBh
		movlb	0Eh
		movwf	44h,BANKED
		btfsc	37h,4
		bcf		44h,4,BANKED
		movlb	0
		movlw	1
		btfss	97h,2,BANKED
		movlw	2
		movff	WREG,0E45h
		goto	p_3BC2
p_4028	movlw	1						; entry from: 1694h
		movff	WREG,0F5Dh
		movlw	0
		movff	WREG,0F5Ch
		movlw	0
		movwf	ADCON0
		call	p__99E
		return	
p_403E	btfss	ADRESH,7				; entry from: 9BEh
		bra		p_4046
		clrf	ADRESH
		clrf	ADRESL
p_4046	rrcf	ADRESH					; entry from: 4040h
		rrcf	ADRESL
		rrcf	ADRESH
		rrcf	ADRESL
		movlw	3
		andwf	ADRESH
		retlw	0
		movf	SPBRGH1,W
		rcall	p_405E
		movf	SPBRG1,W
		rcall	p_405E
p_405C	bra		p_405C					; entry from: 405Ch

p_405E	btfss	PIR1,4					; entry from: 4056h,405Ah,4060h
		bra		p_405E
		movwf	TXREG1
		return	
	END