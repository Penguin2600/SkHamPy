
; PICBASIC PRO(TM) Compiler 2.47, (c) 1998, 2006 microEngineering Labs, Inc. All Rights Reserved.  
PM_USED			EQU	1

	INCLUDE	"16F88.INC"


; Define statements.
#define		CODE_SIZE		 4
#define		OSC		 20 

RAM_START       		EQU	00020h
RAM_END         		EQU	001EFh
RAM_BANKS       		EQU	00004h
BANK0_START     		EQU	00020h
BANK0_END       		EQU	0007Fh
BANK1_START     		EQU	000A0h
BANK1_END       		EQU	000EFh
BANK2_START     		EQU	00110h
BANK2_END       		EQU	0016Fh
BANK3_START     		EQU	00190h
BANK3_END       		EQU	001EFh
EEPROM_START    		EQU	02100h
EEPROM_END      		EQU	021FFh

R0              		EQU	RAM_START + 000h
R1              		EQU	RAM_START + 002h
R2              		EQU	RAM_START + 004h
R3              		EQU	RAM_START + 006h
R4              		EQU	RAM_START + 008h
R5              		EQU	RAM_START + 00Ah
R6              		EQU	RAM_START + 00Ch
R7              		EQU	RAM_START + 00Eh
R8              		EQU	RAM_START + 010h
FLAGS           		EQU	RAM_START + 012h
GOP             		EQU	RAM_START + 013h
RM1             		EQU	RAM_START + 014h
RM2             		EQU	RAM_START + 015h
RR1             		EQU	RAM_START + 016h
RR2             		EQU	RAM_START + 017h
_RXBUFF          		EQU	RAM_START + 018h
_PORTL           		EQU	 PORTB
_PORTH           		EQU	 PORTA
_TRISL           		EQU	 TRISB
_TRISH           		EQU	 TRISA
#define _RX              	_PORTB??1
#define _TX              	_PORTB??0
#define _PTT             	_PORTB??3
#define _CUP             	_PORTB??2
#define _CIN             	_PORTB??4
#define _DIN             	_PORTB??5
#define _PORTB??1        	 PORTB, 001h
#define _PORTB??0        	 PORTB, 000h
#define _PORTB??3        	 PORTB, 003h
#define _PORTB??2        	 PORTB, 002h
#define _PORTB??4        	 PORTB, 004h
#define _PORTB??5        	 PORTB, 005h
#define _PORTB??6        	 PORTB, 006h
#define _PORTB??7        	 PORTB, 007h

; Constants.
_T2400           		EQU	00000h
_T1200           		EQU	00001h
_T9600           		EQU	00002h
_T300            		EQU	00003h
_N2400           		EQU	00004h
_N1200           		EQU	00005h
_N9600           		EQU	00006h
_N300            		EQU	00007h
_OT2400          		EQU	00008h
_OT1200          		EQU	00009h
_OT9600          		EQU	0000Ah
_OT300           		EQU	0000Bh
_ON2400          		EQU	0000Ch
_ON1200          		EQU	0000Dh
_ON9600          		EQU	0000Eh
_ON300           		EQU	0000Fh
_MSBPRE          		EQU	00000h
_LSBPRE          		EQU	00001h
_MSBPOST         		EQU	00002h
_LSBPOST         		EQU	00003h
_LSBFIRST        		EQU	00000h
_MSBFIRST        		EQU	00001h
_CLS             		EQU	00000h
_HOME            		EQU	00001h
_BELL            		EQU	00007h
_BKSP            		EQU	00008h
_TAB             		EQU	00009h
_CR              		EQU	0000Dh
_UnitOn          		EQU	00012h
_UnitOff         		EQU	0001Ah
_UnitsOff        		EQU	0001Ch
_LightsOn        		EQU	00014h
_LightsOff       		EQU	00010h
_Dim             		EQU	0001Eh
_Bright          		EQU	00016h
	INCLUDE	"RCLINK~1.MAC"
	INCLUDE	"PBPPIC14.LIB"


	ASM?
 DEVICE PIC16F88,HS_OSC,MCLR_ON,LVP_OFF,WDT_OFF,PROTECT_OFF

	ENDASM?

	MOVE?CB	000h, CMCON
	MOVE?CB	000h, ADCON0
	MOVE?CB	000h, ANSEL
	HIGH?T	_PTT
	HIGH?T	_CUP
	PAUSE?C	032h
	SERPIN?T	_TX
	SERMODE?C	_N9600
	SEROUT?C	052h
	SEROUT?C	045h
	SEROUT?C	041h
	SEROUT?C	044h
	SEROUT?C	059h
	SEROUT?C	00Dh
	SERPIN?T	_RX
	SERMODE?C	_N9600
	SEROUT?C	052h
	SEROUT?C	045h
	SEROUT?C	041h
	SEROUT?C	044h
	SEROUT?C	059h
	SEROUT?C	00Dh
	HIGH?T	_PORTB??6
	LOW?T	_PORTB??7

	LABEL?L	_loop	
	SERPIN?T	_RX
	SERMODE?C	_N9600
	SERIN?B	_RXBUFF
	CMPNE?BCL	_RXBUFF, 021h, L00001
	SERPIN?T	_TX
	SERMODE?C	_N9600
	SEROUT?C	043h
	SEROUT?C	04Fh
	SEROUT?C	04Dh
	SEROUT?C	04Fh
	SEROUT?C	04Bh
	SEROUT?C	00Dh
	GOTO?L	_loop
	LABEL?L	L00001	
	CMPNE?BCL	_RXBUFF, 051h, L00003
	TOGGLE?T	_PTT
	SERPIN?T	_TX
	SERMODE?C	_N9600
	SEROUT?C	050h
	SEROUT?C	054h
	SEROUT?C	054h
	SEROUT?C	04Fh
	SEROUT?C	04Bh
	SEROUT?C	00Dh
	GOTO?L	_loop
	LABEL?L	L00003	
	CMPNE?BCL	_RXBUFF, 057h, L00005
	LOW?T	_CUP
	PAUSE?C	032h
	HIGH?T	_CUP
	SERPIN?T	_TX
	SERMODE?C	_N9600
	SEROUT?C	043h
	SEROUT?C	055h
	SEROUT?C	050h
	SEROUT?C	04Fh
	SEROUT?C	04Bh
	SEROUT?C	00Dh
	GOTO?L	_loop
	LABEL?L	L00005	
	CMPNE?BCL	_RXBUFF, 053h, L00007
	LOW?T	_CUP
	PAUSE?C	005DCh
	HIGH?T	_CUP
	SERPIN?T	_TX
	SERMODE?C	_N9600
	SEROUT?C	053h
	SEROUT?C	043h
	SEROUT?C	04Eh
	SEROUT?C	04Fh
	SEROUT?C	04Bh
	SEROUT?C	00Dh
	GOTO?L	_loop
	LABEL?L	L00007	
	SERPIN?T	_TX
	SERMODE?C	_N9600
	SEROUT?C	045h
	SEROUT?C	052h
	SEROUT?C	052h
	SEROUT?C	04Fh
	SEROUT?C	052h
	SEROUT?C	00Dh
	GOTO?L	_loop

	END
