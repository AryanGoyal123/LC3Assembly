; ECE109 Program 2
; Aryan Goyal, April 1st 2024
; Description: This program outputs a '+' symbol on a GUI. The program allows the User to use the 'WASD' keys to move the '+' around the given GUI. Moreover, the User can
; change the color of the '+' symbol and clear the background to restart drawing.

    .ORIG   x3000
    JSR DRAWPLUS ; DRAW Initial '+' Symbol
    BRnzp PROGRAM ; Go to PROGRAM

NEGQ    .FILL	#-113
NEGW    .FILL	#-119
NEGA    .FILL	#-97
NEGS    .FILL	#-115
NEGD    .FILL	#-100
COLORP  .FILL   x7FFF
COORX  .FILL	#64
COORY  .FILL	#62
COORPLUS    .FILL	xDF40
COLORBLACK   .FILL	x0000
INTADDRESS  .FILL	xC000
REDCOLOR    .FILL	x7C00
GREENCOLOR  .FILL	x03E0 
BLUECOLOR   .FILL	x001F 
YELLOWCOLOR .FILL	x7FED
WHITECOLOR  .FILL	x7FFF
RETURN  .FILL	#-10
SPACE   .FILL	#-32
YUP .FILL	#-896
YDOWN   .FILL	#896
NEGVERT  .FILL	#-128
POSVERT .FILL	#128
TOTALADDRESS    .FILL	#15871
NEGR .FILL	#-114
NEGG .FILL	#-103
NEGB .FILL	#-98
NEGY .FILL	#-121
RIGHTCHECK  .FILL	#-120
LEFTCHECK   .FILL	#-8
UPCHECK .FILL	#-6
DOWNCHECK   .FILL	#-118

PROGRAM     GETC           ; Reads input character from user
            
            LD R1, NEGQ ; Load Negitive 'q' ASCII value into R1
            ADD R2, R0, R1 ; ADD Negitive ASCII value of Q, place it in R6
            BRz STOPGAME   ; If zero, then input is 'q', go to STOPGAME

            LD R1, NEGD ; Load Negitive 'd' ASCII value into R1
            ADD R2, R0, R1 ; ADD Negitive ASCII value of 'd', place it in R2
            BRz MOVERIGHT   ; If zero, then input is 'd', go to MOVERIGHT

            LD R1, NEGA ; Load Negitive 'a' ASCII value into R1
            ADD R2, R0, R1 ; ADD Negitive ASCII value of 'a', place it in R2
            BRz MOVELEFT   ; If zero, then input is 'a', go to MOVELEFT

            LD R1, NEGW ; Load Negitive 'w' ASCII value into R1
            ADD R2, R0, R1 ; ADD Negitive ASCII value of 'w', place it in R2
            BRz MOVEUP   

            LD R1, NEGS ; Load Negitive 's' ASCII value into R1
            ADD R2, R0, R1 ; ADD Negitive ASCII value of 's', place it in R2
            BRz MOVEDOWN   

            LD R1, NEGR ; Load Negitive 'r' ASCII value into R1
            ADD R2, R0, R1 ; 
            BRz REDCLR

            LD R1, NEGG ; Load Negitive 'g' ASCII value into R1
            ADD R2, R0, R1
            BRz GREENCLR

            LD R1, NEGB ; Load Negitive 'b' ASCII value into R1
            ADD R2, R0, R1 
            BRz BLUECLR

            LD R1, NEGY ; Load Negitive 'y' ASCII value into R1
            ADD R2, R0, R1 
            BRz YELLOWCLR

            LD R1, RETURN ; Load Negitive 'Return' ASCII value into R1
            ADD R2, R0, R1 
            BRz CLRSCREEN

            LD R1, SPACE ; Load Negitive 'Space' ASCII value into R1
            ADD R2, R0, R1 
            BRz WHITECLR

            BRnzp PROGRAM

        MOVEUP      LD R1, COORY
                    LD R2, UPCHECK ; Check if '+' can move up
                    ADD R3, R1, R2
                    BRz PROGRAM
                    ADD R1, R1, #-7
                    ST R1, COORY
                    LD R1, COORPLUS
                    LD R2, YUP
                    ADD R1, R1, R2
                    ST R1, COORPLUS
                    JSR DRAWPLUS
                    BRnzp PROGRAM

        MOVEDOWN    LD R1, COORY
                    LD R2, DOWNCHECK ; Check if '+' can move down
                    ADD R3, R1, R2
                    BRz PROGRAM
                    ADD R1, R1, #7
                    ST R1, COORY
                    LD R1, COORPLUS
                    LD R2, YDOWN
                    ADD R1, R1, R2
                    ST R1, COORPLUS
                    JSR DRAWPLUS
                    BRnzp PROGRAM

        MOVERIGHT   LD R1, COORX
                    LD R2, RIGHTCHECK ; Check if '+' can move right
                    ADD	R3,	R1,	R2
                    BRz PROGRAM
                    ADD R1, R1, #7
                    ST R1, COORX
                    LD R1, COORPLUS
                    ADD R1, R1, #7
                    ST R1, COORPLUS
                    JSR DRAWPLUS
                    BRnzp PROGRAM
        
        MOVELEFT    LD R1, COORX 
                    LD R2, LEFTCHECK ; Check if '+' can move left
                    ADD	R3,	R1,	R2
                    BRz PROGRAM
                    ADD R1, R1, #-7
                    ST R1, COORX
                    LD R1, COORPLUS
                    ADD R1, R1, #-7 ; Actually move left
                    ST R1, COORPLUS
                    JSR DRAWPLUS
                    BRnzp PROGRAM
        
        REDCLR      LD R1, REDCOLOR ; Change color to 'Red'
                    ST R1, COLORP
                    JSR DRAWPLUS
                    BRnzp PROGRAM
        
        BLUECLR     LD R1, BLUECOLOR ; Change color to 'Blue'
                    ST R1, COLORP
                    JSR DRAWPLUS
                    BRnzp PROGRAM
        
        GREENCLR    LD R1, GREENCOLOR ; Change color to 'Green'
                    ST R1, COLORP
                    JSR DRAWPLUS
                    BRnzp PROGRAM
        
        YELLOWCLR   LD R1, YELLOWCOLOR ; Change color to 'Yellow'
                    ST R1, COLORP
                    JSR DRAWPLUS
                    BRnzp PROGRAM
        
        WHITECLR    LD R1, WHITECOLOR ; Change color to 'White'
                    ST R1, COLORP
                    JSR DRAWPLUS
                    BRnzp PROGRAM
        
        CLRSCREEN   LD  R1, INTADDRESS ; We need to clear screen with BLACK color
                    LD  R2, COLORBLACK
                    LD  R3, TOTALADDRESS
                    JSR	CLEARSCREEN
                    JSR DRAWPLUS
                    BRnzp PROGRAM

        STOPGAME    HALT

CLEARSCREEN STR R2,	R1,	#0 ; Clear all the pixels and set them equal to black
            ADD R1, R1, #1
            ADD R3, R3, #-1
            BRzp CLEARSCREEN
            RET

DRAWPLUS    LD R0, COORPLUS
            LD R1, COLORP
            STR	R1,	R0,	#0 ; Draw the horizontal axis of the '+'
            ADD R2, R0, #-3
            STR	R1,	R2,	#0
            ADD R2, R0, #-2
            STR	R1,	R2,	#0
            ADD R2, R0, #-1
            STR	R1,	R2,	#0
            ADD R2, R0, #3
            STR	R1,	R2,	#0
            ADD R2, R0, #2
            STR	R1,	R2,	#0
            ADD R2, R0, #1
            STR	R1,	R2,	#0
                            
            LD R2, NEGVERT ; Draw the vertical axis of the '+'
            ADD	R3,	R2,	R0
            STR	R1,	R3,	#0
            ADD	R3,	R2,	R3
            STR	R1,	R3,	#0
            ADD	R3,	R2,	R3
            STR	R1,	R3,	#0

            LD R2, POSVERT
            ADD	R3,	R2,	R0
            STR	R1,	R3,	#0
            ADD	R3,	R2,	R3
            STR	R1,	R3,	#0
            ADD	R3,	R2,	R3
            STR	R1,	R3,	#0
            RET
    .END
