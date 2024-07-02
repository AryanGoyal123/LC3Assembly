; ECE109 Program 3
; Aryan Goyal, April 10th 2024
; Description: This program takes input from the user about the location, size, and color for upto five squares and displey them on a graphical user interface. 
;              The program can also redraw the squares from memory based on user input. 

    .ORIG   x3000
    BRnzp PROGRAM ; Go to PROGRAM

PROGRAM AND R0, R0, #0
        BRnzp PROMTX1 
        PROMTX1 LEA R0, XPROMPT
                PUTS
                LOOPX1  AND R0, R0, #0
                        GETC ; Ask for X coordinate for first square
                        OUT
                        LD R1, ENTER
                        ADD R2, R0, R1
                        BRz PROMPTY1

                        LD R1, ASCIIOFFSET
                        ADD R0, R0, R1
                        BRn LOOPX1
                        ADD R3,	R0, #-9
                        BRp LOOPX1

                        LD R1, BOX1x
                        AND R2,	R2,	#0
                        JSR MULT10 ; Multiply R1 * 10 to R2
                        ADD R2,	R2,	R0
                        ST  R2,	BOX1x
                        BRnzp LOOPX1
            
        PROMPTY1    LEA R0, YPROMPT
                    PUTS
                    LOOPY1  AND R0, R0, #0
                            GETC ; Ask for Y coordinate for first square
                            OUT
                            LD R1, ENTER
                            ADD R2, R0, R1
                            BRz PROMPTP1

                            LD R1, ASCIIOFFSET
                            ADD R0, R0, R1
                            BRn LOOPY1
                            ADD	R3,	R0,	#-9
                            BRp LOOPY1

                            LD R1, BOX1y
                            AND	R2,	R2,	#0
                            JSR	MULT10 ; Multiply R1 * 10 to R2
                            ADD	R2,	R2,	R0
                            ST	R2,	BOX1y
                            BRnzp LOOPY1

        PROMPTP1    LEA R0, PIXALPROMPT
                    PUTS
                    LOOPP1  AND R0, R0, #0
                            GETC ; Ask for dimension for first square
                            OUT
                            LD R1, ENTER
                            ADD R2, R0, R1
                            BRz PROMPTC1

                            LD R1, ASCIIOFFSET
                            ADD R0, R0, R1
                            BRn LOOPP1
                            ADD	R3,	R0,	#-9
                            BRp LOOPP1

                            LD R1, BOX1p
                            AND	R2,	R2,	#0
                            JSR	MULT10 ; Multiply R1 * 10 to R2
                            ADD	R2,	R2,	R0
                            ST	R2,	BOX1p
                            BRnzp LOOPP1
        
        ENTER .FILL #-10
        POSVERT .FILL	#128

        PROMPTC1    LEA R0, COLORPROMPT
                    PUTS
                    AND R0, R0, #0
                    LOOPC1  GETC ; Ask and get the colorfor of first square
                            OUT

                            LD R1, ENTER
                            ADD R2, R0, R1
                            BRz PROMPTX2

                            LD R1, NEGR ; Load Negitive 'r' ASCII value into R1
                            ADD R2, R0, R1  
                            BRz REDCLR
                            LD R1, NEGG ; Load Negitive 'g' ASCII value into R1
                            ADD R2, R0, R1
                            BRz GRENCLR
                            LD R1, NEGB ; Load Negitive 'b' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz BLUECLR
                            LD R1, NEGY ; Load Negitive 'y' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz YELLOWCLR
                            LD R1, NEGW ; Load Negitive 'y' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz WHITECLR

                            BRnzp LOOPC1

                            REDCLR  LD R1, REDCOLOR ; Change color to 'Red'
                                    ST R1, BOX1c
                                    JSR DRAWBOX1
                                    BRnzp PROMPTX2

                            GRENCLR LD R1, GREENCOLOR ; Change color to 'Green'
                                    ST R1, BOX1c
                                    JSR DRAWBOX1
                                    BRnzp PROMPTX2
                            
                            BLUECLR LD R1, BLUECOLOR ; Change color to 'Blue'
                                    ST R1, BOX1c
                                    JSR DRAWBOX1
                                    BRnzp PROMPTX2

                            YELLOWCLR   LD R1, YELLOWCOLOR ; Change color to 'Yellow'
                                        ST R1, BOX1c
                                        JSR DRAWBOX1
                                        BRnzp PROMPTX2

                            WHITECLR    LD R1, WHITECOLOR ; Change color to 'White'
                                        ST R1, BOX1c
                                        JSR DRAWBOX1
                                        BRnzp PROMPTX2
DRAWBOX1    LD R1, BOX1x
            LD R2, BOX1y
            LD R3, INTADDRESS

            ADD	R1,	R1,	R3
            ADD	R2,	R2,	R2 ; Y is x2
            ADD	R2,	R2,	R2 ; Y is x4
            ADD	R2,	R2,	R2 ; Y is x8
            ADD	R2,	R2,	R2 ; Y is x16
            ADD	R2,	R2,	R2 ; Y is x32
            ADD	R2,	R2,	R2 ; Y is x64
            ADD	R2,	R2,	R2 ; Y is x128
            ADD R0, R1, R2 ; Get the starting pixel address at R0

            ; CLEAR R1, R2, R3
            AND	R1, R1,	#0
            AND	R2, R2,	#0
            AND	R3, R3,	#0

                LD R1, BOX1p ; pixels
                LD R2, BOX1c ; color
                ADD R3, R1, R1 ; this is x2 pixels
                ADD R3, R3, R3 ; this is x4 pixels
                ADD R3, R3, R3 ; this is x8 pixels
                ADD R3, R3, R3 ; this is x16 pixels
                ADD R3, R3, R3 ; this is x32 pixels
                ADD R3, R3, R3 ; this is x64 pixels
                ADD R3, R3, R3 ; this is x128 pixels

                ADD R3,	R3, R0 ; Get the bottom left address
                AND R5,	R5, #0
                ADD R5,	R1, #0 ; copy pixels in R1 to R5
                ADD R4, R3, #0 ; copy R3 (bottom left) to R4
                ADD R6, R1, #0 ; copy pixels in R1 to R6

            LOOPC1Y     ADD R5,	R1, #0 ; copy pixels in R1 to R5
                        ADD R4, R3, #0 ; copy R3 (bottom left) to R4
                        BRnzp LOOPC1X

                        LOOPC1X STR R2,	R4, #0
                                ADD R4,	R4, #1
                                ADD R5,	R5, #-1
                                BRp LOOPC1X
                                ST R7, STORER7
                                LD R7, YOFFSET
                                ADD R3,	R3, R7
                                LD R7, STORER7
                                ADD R6, R6, #-1
                                BRp LOOPC1Y
            RET  

ASCIIOFFSET .FILL #-48
NEGR .FILL #-114
NEGG .FILL #-103
NEGB .FILL #-98
NEGY .FILL #-121
NEGN .FILL #-110
NEGW .FILL  #-119
INTADDRESS  .FILL xC000
XPROMPT .STRINGZ "\nEnter X coordinate: "
YPROMPT .STRINGZ "Enter Y coordinate: "
PIXALPROMPT .STRINGZ "Enter Number of Pixals: "
COLORPROMPT .STRINGZ "Enter color: "
YOFFSET .FILL	#-128
STORER7 .FILL	#0    
REDCOLOR    .FILL x7C00
GREENCOLOR  .FILL x03E0 
BLUECOLOR   .FILL x001F 
YELLOWCOLOR .FILL x7FED
WHITECOLOR  .FILL x7FFF
BOX1x   .FILL	#0
BOX1y   .FILL	#0
BOX1c   .FILL	#0
BOX1p   .FILL	#0
BOX1INTCOOR     .FILL	#0

        PROMPTX2 AND R0, R0, #0    
                LEA R0, XPROMPT ; Ask for X coordinate for the second square
                PUTS
                LOOPX2  AND R0, R0, #0
                        GETC ; get the character
                        OUT
                        LD R1, ENTER
                        ADD R2, R0, R1
                        BRz PROMPTY2

                        LD R1, ASCIIOFFSET
                        ADD R0, R0, R1
                        BRn LOOPX2
                        ADD R3,	R0, #-9
                        BRp LOOPX2

                        LD R1, BOX2x
                        AND R2,	R2, #0
                        JSR MULT10 ; Multiply R1 * 10 to R2
                        ADD R2,	R2, R0
                        ST R2, BOX2x
                        BRnzp LOOPX2
            
        PROMPTY2    LEA R0, YPROMPT
                    PUTS ; Ask for Y coordinate for second square
                    LOOPY2  AND R0, R0, #0
                            GETC ; get the character
                            OUT
                            LD R1, ENTER
                            ADD R2, R0, R1
                            BRz PROMPTP2

                            LD R1, ASCIIOFFSET
                            ADD R0, R0, R1
                            BRn LOOPY2
                            ADD	R3, R0,	#-9
                            BRp LOOPY2

                            LD R1, BOX2y
                            AND	R2, R2,	#0
                            JSR	MULT10 ; Multiply R1 * 10 to R2
                            ADD	R2, R2,	R0
                            ST	R2, BOX2y
                            BRnzp LOOPY2

        PROMPTP2    LEA R0, PIXALPROMPT
                    PUTS ; Ask for pixel dimensions for second square
                    LOOPP2  AND R0, R0, #0
                            GETC ; get the character
                            OUT
                            LD R1, ENTER
                            ADD R2, R0, R1
                            BRz PROMPTC2

                            LD R1, ASCIIOFFSET
                            ADD R0, R0, R1
                            BRn LOOPP2
                            ADD	R3, R0,	#-9
                            BRp LOOPP2

                            LD R1, BOX2p
                            AND	R2, R2,	#0
                            JSR	MULT10 ; Multiply R1 * 10 to R2
                            ADD	R2, R2,	R0
                            ST	R2, BOX2p
                            BRnzp LOOPP2
        
        PROMPTC2    LEA R0, COLORPROMPT
                    PUTS ; Ask for color of second square
                    AND R0, R0, #0
                    LOOPC2  GETC ; get the character
                            OUT

                            LD R1, ENTER
                            ADD R2, R0, R1
                            BRz PROMPTX3

                            LD R1, NEGR ; Load Negitive 'r' ASCII value into R1
                            ADD R2, R0, R1  
                            BRz REDCLR2
                            LD R1, NEGG ; Load Negitive 'g' ASCII value into R1
                            ADD R2, R0, R1
                            BRz GRENCLR2
                            LD R1, NEGB ; Load Negitive 'b' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz BLUECLR2
                            LD R1, NEGY ; Load Negitive 'y' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz YELLOWCLR2
                            LD R1, NEGW ; Load Negitive 'y' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz WHITECLR2

                            BRnzp LOOPC2

                            REDCLR2 LD R1, REDCOLOR ; Change color to 'Red'
                                    ST R1, BOX2c
                                    JSR DRAWBOX2
                                    BRnzp PROMPTX3
                            GRENCLR2 LD R1, GREENCOLOR ; Change color to 'Green'
                                    ST R1, BOX2c
                                    JSR DRAWBOX2
                                    BRnzp PROMPTX3                      
                            BLUECLR2 LD R1, BLUECOLOR ; Change color to 'Blue'
                                    ST R1, BOX2c
                                    JSR DRAWBOX2
                                    BRnzp PROMPTX3
                            YELLOWCLR2  LD R1, YELLOWCOLOR ; Change color to 'Yellow'
                                        ST R1, BOX2c
                                        JSR DRAWBOX2
                                        BRnzp PROMPTX3
                            WHITECLR2   LD R1, WHITECOLOR ; Change color to 'White'
                                        ST R1, BOX2c
                                        JSR DRAWBOX2
                                        BRnzp PROMPTX3
        BOX2x   .FILL	#0
        BOX2y   .FILL	#0
        BOX2c   .FILL	#0
        BOX2p   .FILL	#0
        BOX2INTCOOR     .FILL	#0

DRAWBOX2    LD R1, BOX2x
        LD R2, BOX2y
        LD R3, INTADDRESS

        ADD	R1,	R1,	R3
        ADD	R2,	R2,	R2 ; Y is x2
        ADD	R2,	R2,	R2 ; Y is x4
        ADD	R2,	R2,	R2 ; Y is x8
        ADD	R2,	R2,	R2 ; Y is x16
        ADD	R2,	R2,	R2 ; Y is x32
        ADD	R2,	R2,	R2 ; Y is x64
        ADD	R2,	R2,	R2 ; Y is x128
        ADD R0, R1, R2 ; Get the starting pixel address at R0

        ; CLEAR R1, R2, R3
        AND	R1, R1,	#0
        AND	R2, R2,	#0
        AND	R3, R3,	#0

        LD R1, BOX2p ; pixels
        LD R2, BOX2c ; color
        ADD R3, R1, R1 ; this is x2 pixels
        ADD R3, R3, R3 ; this is x4 pixels
        ADD R3, R3, R3 ; this is x8 pixels
        ADD R3, R3, R3 ; this is x16 pixels
        ADD R3, R3, R3 ; this is x32 pixels
        ADD R3, R3, R3 ; this is x64 pixels
        ADD R3, R3, R3 ; this is x128 pixels

        ADD R3,	R3, R0 ; Get the bottom left address
        AND R5,	R5, #0
        ADD R5,	R1, #0 ; copy pixels in R1 to R5
        ADD R4, R3, #0 ; copy R3 (bottom left) to R4
        ADD R6, R1, #0 ; copy pixels in R1 to R6

        LOOPC2Y     ADD R5,	R1, #0 ; copy pixels in R1 to R5
                ADD R4, R3, #0 ; copy R3 (bottom left) to R4
                BRnzp LOOPC2X

                LOOPC2X STR R2,	R4, #0
                        ADD R4,	R4, #1
                        ADD R5,	R5, #-1
                        BRp LOOPC2X
                        ST R7, STORER7
                        LD R7, YOFFSET
                        ADD R3,	R3, R7
                        LD R7, STORER7
                        ADD R6, R6, #-1
                        BRp LOOPC2Y
        RET

        PROMPTX3 AND R0, R0, #0    
                LEA R0, XPROMPT ; Ask for X coordinate for third square
                PUTS
                LOOPX3  AND R0, R0, #0
                        GETC ; get the character
                        OUT
                        LD R1, ENTER1
                        ADD R2, R0, R1
                        BRz PROMPTY3

                        LD R1, ASCIIOFFSET1
                        ADD R0, R0, R1
                        BRn LOOPX3
                        ADD R3,	R0, #-9
                        BRp LOOPX3

                        LD R1, BOX3x
                        AND R2,	R2, #0
                        JSR MULT10 ; Multiply R1 * 10 to R2
                        ADD R2,	R2, R0
                        ST R2, BOX3x
                        BRnzp LOOPX3
            
        PROMPTY3    LEA R0, YPROMPT ; Ask for Y coordinate for third square
                    PUTS
                    LOOPY3  AND R0, R0, #0
                            GETC ; get the character
                            OUT
                            LD R1, ENTER1
                            ADD R2, R0, R1
                            BRz PROMPTP3

                            LD R1, ASCIIOFFSET1
                            ADD R0, R0, R1
                            BRn LOOPY3
                            ADD	R3, R0,	#-9
                            BRp LOOPY3

                            LD R1, BOX3y
                            AND	R2, R2,	#0
                            JSR	MULT10 ; Multiply R1 * 10 to R2
                            ADD	R2, R2,	R0
                            ST	R2, BOX3y
                            BRnzp LOOPY3

        PROMPTP3    LEA R0, PIXALPROMPT
                    PUTS
                    LOOPP3  AND R0, R0, #0
                            GETC ; get the character
                            OUT
                            LD R1, ENTER1
                            ADD R2, R0, R1
                            BRz PROMPTC3

                            LD R1, ASCIIOFFSET1
                            ADD R0, R0, R1
                            BRn LOOPP3
                            ADD	R3, R0,	#-9
                            BRp LOOPP3

                            LD R1, BOX3p
                            AND	R2, R2,	#0
                            JSR	MULT10 ; Multiply R1 * 10 to R2
                            ADD	R2, R2,	R0
                            ST	R2, BOX3p
                            BRnzp LOOPP3
        
        BOX3x   .FILL	#0
        BOX3y   .FILL	#0
        BOX3c   .FILL	#0
        BOX3p   .FILL	#0
        BOX3INTCOOR     .FILL	#0
        ENTER1 .FILL #-10
        ASCIIOFFSET1 .FILL #-48

        PROMPTC3    LEA R0, COLORPROMPT
                    PUTS
                    AND R0, R0, #0
                    LOOPC3  GETC ; get the character
                            OUT

                            LD R1, ENTER1
                            ADD R2, R0, R1
                            BRz PROMPTX4

                            LD R1, NEGR1 ; Load Negitive 'r' ASCII value into R1
                            ADD R2, R0, R1  
                            BRz REDCLR3
                            LD R1, NEGG1 ; Load Negitive 'g' ASCII value into R1
                            ADD R2, R0, R1
                            BRz GRENCLR3
                            LD R1, NEGB1 ; Load Negitive 'b' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz BLUECLR3
                            LD R1, NEGY1 ; Load Negitive 'y' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz YELLOWCLR3
                            LD R1, NEGW1 ; Load Negitive 'w' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz WHITECLR3

                            BRnzp LOOPC3

                            REDCLR3 LD R1, REDCOLOR1 ; Change color to 'Red'
                                    ST R1, BOX3c
                                    JSR DRAWBOX3
                                    BRnzp PROMPTX4
                            GRENCLR3 LD R1, GREENCOLOR1 ; Change color to 'Green'
                                    ST R1, BOX3c
                                    JSR DRAWBOX3
                                    BRnzp PROMPTX4                      
                            BLUECLR3 LD R1, BLUECOLOR1 ; Change color to 'Blue'
                                    ST R1, BOX3c
                                    JSR DRAWBOX3
                                    BRnzp PROMPTX4
                            YELLOWCLR3  LD R1, YELLOWCOLOR1 ; Change color to 'Yellow'
                                        ST R1, BOX3c
                                        JSR DRAWBOX3
                                        BRnzp PROMPTX4
                            WHITECLR3   LD R1, WHITECOLOR1 ; Change color to 'White'
                                        ST R1, BOX3c
                                        JSR DRAWBOX3
                                        BRnzp PROMPTX4
        
        XPROMPT1 .STRINGZ "\nEnter X coordinate: "
        YPROMPT1 .STRINGZ "Enter Y coordinate: "
        PIXALPROMPT1 .STRINGZ "Enter Number of Pixals: "
        COLORPROMPT1 .STRINGZ "Enter color: "
        REDCOLOR1    .FILL x7C00
        GREENCOLOR1  .FILL x03E0 
        BLUECOLOR1   .FILL x001F 
        YELLOWCOLOR1 .FILL x7FED
        WHITECOLOR1  .FILL x7FFF

DRAWBOX3    LD R1, BOX3x
            LD R2, BOX3y
            LD R3, INTADDRESS1

            ADD	R1, R1,	R3
            ADD	R2, R2,	R2 ; Y is x2
            ADD	R2, R2,	R2 ; Y is x4
            ADD	R2, R2,	R2 ; Y is x8
            ADD	R2, R2,	R2 ; Y is x16
            ADD	R2, R2,	R2 ; Y is x32
            ADD	R2, R2,	R2 ; Y is x64
            ADD	R2, R2,	R2 ; Y is x128
            ADD R0, R1, R2 ; Get the starting pixel address at R0

            ; CLEAR R1, R2, R3
            AND	R1, R1,	#0
            AND	R2, R2,	#0
            AND	R3, R3,	#0

                LD R1, BOX3p ; pixels
                LD R2, BOX3c ; color
                ADD R3, R1, R1 ; this is x2 pixels
                ADD R3, R3, R3 ; this is x4 pixels
                ADD R3, R3, R3 ; this is x8 pixels
                ADD R3, R3, R3 ; this is x16 pixels
                ADD R3, R3, R3 ; this is x32 pixels
                ADD R3, R3, R3 ; this is x64 pixels
                ADD R3, R3, R3 ; this is x128 pixels

                ADD R3,	R3, R0 ; Get the bottom left address
                AND R5,	R5, #0
                ADD R5,	R1, #0 ; copy pixels in R1 to R5
                ADD R4, R3, #0 ; copy R3 (bottom left) to R4
                ADD R6, R1, #0 ; copy pixels in R1 to R6

            LOOPC3Y     ADD R5,	R1, #0 ; copy pixels in R1 to R5
                        ADD R4, R3, #0 ; copy R3 (bottom left) to R4
                        BRnzp LOOPC3X

                        LOOPC3X STR R2,	R4, #0
                                ADD R4,	R4, #1
                                ADD R5,	R5, #-1
                                BRp LOOPC3X
                                ST R7, STORER72
                                LD R7, YOFFSET1
                                ADD R3,	R3, R7
                                LD R7, STORER72
                                ADD R6, R6, #-1
                                BRp LOOPC3Y
                RET       
        
        NEGR1 .FILL #-114
        NEGG1 .FILL #-103
        NEGB1 .FILL #-98
        NEGY1 .FILL #-121
        NEGN1 .FILL #-110
        NEGW1 .FILL  #-119
        
        PROMPTX4 AND R0, R0, #0    
                LEA R0, XPROMPT1 ; Ask for X coordinate for forth square
                PUTS
                LOOPX4  AND R0, R0, #0
                        GETC ; get the character
                        OUT
                        LD R1, ENTER1
                        ADD R2, R0, R1
                        BRz PROMPTY4

                        LD R1, ASCIIOFFSET1
                        ADD R0, R0, R1
                        BRn LOOPX4
                        ADD R3,	R0, #-9
                        BRp LOOPX4

                        LD R1, BOX4x
                        AND R2,	R2, #0
                        JSR MULT10 ; Multiply R1 * 10 to R2
                        ADD R2,	R2, R0
                        ST R2, BOX4x
                        BRnzp LOOPX4

        PROMPTY4    LEA R0, YPROMPT1 ; Ask for Y coordinate for forth square
                    PUTS
                    LOOPY4  AND R0, R0, #0
                            GETC ; get the character
                            OUT
                            LD R1, ENTER1
                            ADD R2, R0, R1
                            BRz PROMPTP4

                            LD R1, ASCIIOFFSET1
                            ADD R0, R0, R1
                            BRn LOOPY4
                            ADD	R3, R0,	#-9
                            BRp LOOPY4

                            LD R1, BOX4y
                            AND	R2, R2,	#0
                            JSR	MULT10 ; Multiply R1 * 10 to R2
                            ADD	R2, R2,	R0
                            ST	R2, BOX4y
                            BRnzp LOOPY4

        BOX4x   .FILL	#0
        BOX4y   .FILL	#0
        BOX4c   .FILL	#0
        BOX4p   .FILL	#0

        PROMPTP4    LEA R0, PIXALPROMPT1
                    PUTS
                    LOOPP4  AND R0, R0, #0
                            GETC ; get the character
                            OUT
                            LD R1, ENTER1
                            ADD R2, R0, R1
                            BRz PROMPTC4

                            LD R1, ASCIIOFFSET1
                            ADD R0, R0, R1
                            BRn LOOPP4
                            ADD	R3, R0,	#-9
                            BRp LOOPP4

                            LD R1, BOX4p
                            AND	R2, R2,	#0
                            JSR	MULT10 ; Multiply R1 * 10 to R2
                            ADD	R2, R2,	R0
                            ST	R2, BOX4p
                            BRnzp LOOPP4

        PROMPTC4    LEA R0, COLORPROMPT1
                    PUTS
                    AND R0, R0, #0
                    LOOPC4  GETC ; get the character
                            OUT

                            LD R1, ENTER1
                            ADD R2, R0, R1
                            BRz PROMPTX5

                            LD R1, NEGR1 ; Load Negitive 'r' ASCII value into R1
                            ADD R2, R0, R1  
                            BRz REDCLR4
                            LD R1, NEGG1 ; Load Negitive 'g' ASCII value into R1
                            ADD R2, R0, R1
                            BRz GRENCLR4
                            LD R1, NEGB1 ; Load Negitive 'b' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz BLUECLR4
                            LD R1, NEGY1 ; Load Negitive 'y' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz YELLOWCLR4
                            LD R1, NEGW1 ; Load Negitive 'w' ASCII value into R1
                            ADD R2, R0, R1 
                            BRz WHITECLR4

                            BRnzp LOOPC4

                            REDCLR4 LD R1, REDCOLOR1 ; Change color to 'Red'
                                    ST R1, BOX4c
                                    JSR DRAWBOX4
                                    BRnzp PROMPTX5
                            GRENCLR4 LD R1, GREENCOLOR1 ; Change color to 'Green'
                                    ST R1, BOX4c
                                    JSR DRAWBOX4
                                    BRnzp PROMPTX5                      
                            BLUECLR4 LD R1, BLUECOLOR1 ; Change color to 'Blue'
                                    ST R1, BOX4c
                                    JSR DRAWBOX4
                                    BRnzp PROMPTX5
                            YELLOWCLR4  LD R1, YELLOWCOLOR1 ; Change color to 'Yellow'
                                        ST R1, BOX4c
                                        JSR DRAWBOX4
                                        BRnzp PROMPTX5
                            WHITECLR4   LD R1, WHITECOLOR1 ; Change color to 'Whilte'
                                        ST R1, BOX4c
                                        JSR DRAWBOX4
                                        BRnzp PROMPTX5
        
        PROMPTX5 AND R0, R0, #0    
                LEA R0, XPROMPT1
                PUTS
                BRnzp REDISPLAY
        
        NEWLINE .STRINGZ "\n"
        NEGC .FILL #-99
        NEGQ .FILL #-113
        NEGASCI .FILL	#-48
        INTADDRESS1  .FILL xC000
        COLORBLACK  .FILL x0000
        TOTALADRS1 .FILL #15871
        Quit    .STRINGZ "\nThank you for playing!"
        
        REDISPLAY       LEA R0, NEWLINE
                        PUTS 

                        GETC
                        LD R1, NEGQ ; Load Negitive 'q' ASCII value into R1
                        ADD R2, R0, R1 ; ADD Negitive ASCII value of Q, place it in R6
                        BRz STOPGAME   ; If zero, then input is 'q', go to STOPGAME

                        LD R1, NEGC ; Load Negitive 'c' ASCII value into R1
                        ADD R2, R0, R1 
                        BRz CLRSCREEN

                        ; ASCII to Binary
                        LD R1, NEGASCI
                        ADD R0, R0, R1
                        ADD R2, R0, #-1
                        BRz DRAWSQUARE1
                        ADD R2, R0, #-2
                        BRz DRAWSQUARE2
                        ADD R2, R0, #-3
                        BRz DRAWSQUARE3
                        ADD R2, R0, #-4
                        BRz DRAWSQUARE4

                        BRnzp REDISPLAY

                        DRAWSQUARE1     JSR DRAWBOX1
                                        BRnzp REDISPLAY
                        DRAWSQUARE2     JSR DRAWBOX2
                                        BRnzp REDISPLAY
                        DRAWSQUARE3     JSR DRAWBOX3
                                        BRnzp REDISPLAY
                        DRAWSQUARE4     JSR DRAWBOX4
                                        BRnzp REDISPLAY
                        
        CLRSCREEN   LD  R1, INTADDRESS1 ; We need to clear screen with BLACK color
                    LD  R2, COLORBLACK
                    LD  R3, TOTALADRS1
                    JSR	CLEARSCREEN
                    ;BRnzp PROGRAM

        STOPGAME    LEA R0, Quit
                    PUTS
                    HALT

MULT10  ADD R2, R1, R1
        ADD R2, R2, R2
        ADD R2, R2, R2 ; Now its eight times
        ADD R2, R2, R1
        ADD R2, R2, R1 ; Now its ten times
        RET

CLEARSCREEN STR R2, R1,	#0 ; Clear all the pixels and set them equal to black
            ADD R1, R1, #1
            ADD R3, R3, #-1
            BRzp CLEARSCREEN
            RET

STORER72 .FILL	#0
YOFFSET1 .FILL	#-128

DRAWBOX4    LD R1, BOX4x
            LD R2, BOX4y
            LD R3, INTADDRESS1

            ADD	R1, R1,	R3
            ADD	R2, R2,	R2 ; Y is x2
            ADD	R2, R2,	R2 ; Y is x4
            ADD	R2, R2,	R2 ; Y is x8
            ADD	R2, R2,	R2 ; Y is x16
            ADD	R2, R2,	R2 ; Y is x32
            ADD	R2, R2,	R2 ; Y is x64
            ADD	R2, R2,	R2 ; Y is x128
            ADD R0, R1, R2 ; Get the starting pixel address at R0

            ; CLEAR R1, R2, R3
            AND	R1, R1,	#0
            AND	R2, R2,	#0
            AND	R3, R3,	#0

                LD R1, BOX4p ; pixels
                LD R2, BOX4c ; color
                ADD R3, R1, R1 ; this is x2 pixels
                ADD R3, R3, R3 ; this is x4 pixels
                ADD R3, R3, R3 ; this is x8 pixels
                ADD R3, R3, R3 ; this is x16 pixels
                ADD R3, R3, R3 ; this is x32 pixels
                ADD R3, R3, R3 ; this is x64 pixels
                ADD R3, R3, R3 ; this is x128 pixels

                ADD R3,	R3, R0 ; Get the bottom left address
                AND R5,	R5, #0
                ADD R5,	R1, #0 ; copy pixels in R1 to R5
                ADD R4, R3, #0 ; copy R3 (bottom left) to R4
                ADD R6, R1, #0 ; copy pixels in R1 to R6

            LOOPC4Y     ADD R5,	R1, #0 ; copy pixels in R1 to R5
                        ADD R4, R3, #0 ; copy R3 (bottom left) to R4
                        BRnzp LOOPC4X

                        LOOPC4X STR R2,	R4, #0
                                ADD R4,	R4, #1
                                ADD R5,	R5, #-1
                                BRp LOOPC4X
                                ST R7, STORER72
                                LD R7, YOFFSET1
                                ADD R3,	R3, R7
                                LD R7, STORER72
                                ADD R6, R6, #-1
                                BRp LOOPC4Y
                RET
    .END
