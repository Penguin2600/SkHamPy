@ DEVICE PIC16F88,HS_OSC,MCLR_ON,LVP_OFF,WDT_OFF,PROTECT_OFF

INCLUDE "modedefs.bas"

DEFINE OSC 20 ' use precision OSC for reliable RS232

CMCON = 0 ' no analog needed... for now.
ADCON0 = 0
ANSEL = 0

RXBUFF var byte

RX var PORTB.1
TX var PORTB.0
PTT var PORTB.3 
CUP var PORTB.2
CIN var PORTB.4 
DIN var PORTB.5

HIGH ptt 
high CUP

pause 50 'relax while everything setles down
SEROUT TX, N9600, ["READY",13] 'Reply without doing anything 
SEROUT RX, N9600, ["READY",13] 'Reply without doing anything 
high PORTB.6
LOW PORTB.7
loop:
SERin RX, N9600, RXBUFF

if RXBUFF == "!" THEN
SEROUT TX, N9600, ["COMOK",13] 'Reply without doing anything  
goto loop  
endif

if RXBUFF == "Q" THEN
toggle ptt ' toggle the push to talk
SEROUT TX, N9600, ["PTTOK",13]
goto loop  
endif

if RXBUFF == "W" THEN
LOW CUP
pause 50 ' pulse the channel up line
high CUP
SEROUT TX, N9600, ["CUPOK",13]
goto loop  
endif

if RXBUFF == "S" THEN
LOW CUP
pause 1500 ' hold the channel up line low for scan
high CUP
SEROUT TX, N9600, ["SCNOK",13]
goto loop  
endif

SEROUT TX, N9600, ["ERROR",13]
goto loop

     
