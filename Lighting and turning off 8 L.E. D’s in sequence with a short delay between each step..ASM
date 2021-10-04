;About-Lighting and turning off the 8 L.E. D’s in sequence with a short delay between each step.



;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
; Configuration data 
; PICmicro MCU type: 16F88 
; Oscillator: RC mode, slow, VR1 fully anticlockwise (min.rate) 
; LCD display: off 
; 7-segment display: off 
; Version 3 board settings: J14 links: Digital 
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
;
; The following lines embed configuration data into the PICmicro
	LIST P=16F88
	__CONFIG H'2007', H'3F7A'       ; RC mode
	__CONFIG H'2008', H'3FFC'       ; Clock Fail-Safe disabled
	
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
				
; setting Port B to output mode and turn on each led
				
	ORG	0		; Reset vector
	GOTO	5		; Goto start of program
	ORG	4		; Interrupt vector
	GOTO	5		; Goto start of program
	ORG	5		; Start of program memory
STATUS  EQU    H'03'           ;we will use EQU to make the program easier to read,
                    ;by setting hex 03 equivalent to STATUS, so we can replace H'03' with STATUS

Z       EQU     2
ANSEL   EQU     H'9B'         ;set hex 9B equivalent to ANSEL register 
PORTB   EQU     H'06'
DIRB    EQU     H'86'
PAGE    EQU     5
LEDZERO EQU     0              ;make the word “LEDONE” equivalent to 0
LEDONE  EQU     1
LEWTWO  EQU     2
LEDTHEEE EQU    3
LEDFOUR  EQU    4              ;make LEDFOUR equivalent to 4
LEDFIVE  EQU    5
LEDSIX   EQU    6
LEDSEVEN EQU    7
MINUSONE EQU    H'FF'         ;make MINUSONE equivalent to H'FF'
FIVE     EQU    5
delayval EQU    H'1'            ;assign hex 1 to delayval 


START	CLRF	PORTB		; set all Port B pins to logic 0
	BSF	STATUS,5		; instruct program that Page 1 commands come next
	CLRF	ANSEL		; clear ANSEL register to make port pins digital
	CLRF	H'86'		; set all Port B pins as outputs from within Page 1
	BCF	H'03',5		; instruct program that Page 0 commands come next	


	BSF	PORTB,0		; set Port B pin 0 to logic 1, light up led 1
        CALL     DELAY             ;call subroutine (will return with RETURN or RETLW)
        BSF	PORTB,1          ; set Port B pin 1 to logic 1, light up led 2

        CALL     DELAY
        BSF	PORTB,2        ;set port B pin 2 to logic 1, light up led 3
        CALL     DELAY     ;go to the delay loop so that the LED stays on for a few milliseconds
        BSF	PORTB,3
        CALL     DELAY
        BSF	PORTB,4
        CALL     DELAY          ;call subroutine (will return with RETURN or RETLW)

        BSF	PORTB,5      ;set port B pin 5 to logic 1, LIGHT UP led 6
        CALL     DELAY     ;go to the delay loop so that the LED stays on for a few milliseconds
        BSF	PORTB,6
        CALL     DELAY
        BSF	PORTB,7      ;set port B pin 7 to logic 1, LIGHT UP led 8
        CALL     DELAY   ;go to the delay loop so that the LED stays on for a few milliseconds


        BCF	PORTB,7   ;set port B pin 7 to logic 0, TURN OFF led 8
        CALL     DELAY    ;go to the delay loop so that the LED stays on for a few milliseconds
        BCF	PORTB,6
        CALL     DELAY
        BCF	PORTB,5
        CALL     DELAY
        BCF	PORTB,4    ;set port B pin 4 to logic 0, TURN OFF led 5
        CALL     DELAY     ;go to the delay loop so that the LED stays on for a few milliseconds
        BCF	PORTB,3
        CALL     DELAY
        BCF	PORTB,2
        CALL     DELAY
        BCF	PORTB,1
        CALL     DELAY
        BSF	PORTB,0   ;set port B pin 0 to logic 0, TURN OFF led 1
        CALL     DELAY    ;go to the delay loop so that the LED stays on for a few milliseconds



        GOTO     START 
DELAY   MOVLW      H'1' ;start of delay subroutine which loads the working register W with a                             
                        ; number and counts it down to zero thus creating a delay, move literal    
                        ; value hex 1 to working register
LOOP    ADDLW      H'ff'        ;subtracts 1 from working register W using two’s complement   
                                ;notation to represent -1   
        BTFSS      STATUS,Z     ;bit test file in status file check is count is equal to zero,                                                                                    
                                 ;if zero set z to satus register.

        GOTO       LOOP      ;it has not passed the test, go to LOOP and start again
        RETURN                  ;go back to the next line from where the delay was called
	END			; final statement, required to end the program

