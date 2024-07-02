; ECE109 Program 1
; Aryan Goyal, March 18th 2024
; This programs takes in an input of two 4-bit binary numbers and performs a bitwise OR operation on the two numbers. It then outputs the new 4-bit number to the console and continues the program unless 'q' character is inputted by the user. 

    .ORIG	x3000
    BRnzp PRG ; Go to the start of program

NEGZERO .FILL	#-48
NEGONE  .FILL	#-49
NEGQ    .FILL	#-113
NEGASCII .FILL	#-48
ASCIIOFF .FILL	#48

Char1 .BLKW     #1
Char2 .BLKW	#1
Char3 .BLKW	#1
Char4 .BLKW	#1
Char5 .BLKW	#1
Char6 .BLKW	#1
Char7 .BLKW	#1
Char8 .BLKW	#1

PRG     LD R2, NEGQ     ; Load Negitive 'q' ASCII value into R2
        LD R3, NEGZERO
        LD R4, NEGONE
        LD R5, NEGASCII

        LEA R0, Input1  ; Load address from Input1 into R0
        PUTS            ; write Input1 on screen
        BRnzp BIT1

        BIT1    GETC           ; Reads input character from user
                OUT            ; Display input character to user
                ADD R6, R0, R2 ; ADD Negitive ASCII value of Q, place it in R6
                BRz STOPGAME   ; If zero, then input is 'q', go to STOPGAME
                ADD R6, R0, R3 ; ADD Negitive ASCII valie for '0', place it in R6
                BRz BITNUM1    ; If zero, then input is '0', go to BITNUM1
                ADD R6, R0, R4 ; ADD Negitive ASCII valie for '1', place it in R6
                BRz BITNUM1    ; If zero, then input is '1', go to BITNUM1
                BRnzp BIT1

        BITNUM1 ADD R0, R0, R5	; Convert to Binary
                ST R0, Char1    ; Store R0 value in Char1 Block
                BRnzp BIT2

        BIT2    GETC           ; Reads input character from user
                OUT            ; Display input character to user
                ADD R6, R0, R2 ; ADD Negitive ASCII value of Q, place it in R6
                BRz STOPGAME   ; If zero, then input is 'q', go to STOPGAME
                ADD R6, R0, R3 ; ADD Negitive ASCII valie for '0', place it in R6
                BRz BITNUM2    ; If zero, then input is '0', go to BITNUM2
                ADD R6, R0, R4 ; ADD Negitive ASCII valie for '1', place it in R6
                BRz BITNUM2    ; If zero, then input is '1', go to BITNUM1
                BRnzp BIT2

        BITNUM2 ADD R0, R0, R5	; Convert to Binary
                ST R0, Char2        ; Store R0 value in Char2 Block
                BRnzp BIT3

        BIT3    GETC           ; Reads input character from user
                OUT            ; Display input character to user
                ADD R6, R0, R2 ; ADD Negitive ASCII value of Q, place it in R6
                BRz STOPGAME   
                ADD R6, R0, R3
                BRz BITNUM3
                ADD R6, R0, R4
                BRz BITNUM3
                BRnzp BIT3

        BITNUM3 ADD R0, R0, R5	; Convert to Binary
                ST R0, Char3
                BRnzp BIT4

        BIT4    GETC           ; Reads input character from user
                OUT            ; Display input character to user
                ADD R6, R0, R2 ; ADD Negitive ASCII value of Q, place it in R6
                BRz STOPGAME
                ADD R6, R0, R3
                BRz BITNUM4
                ADD R6, R0, R4
                BRz BITNUM4
                BRnzp BIT4

        BITNUM4 ADD R0, R0, R5	; Convert to Binary
                ST R0, Char4
                BRnzp STRING2

        STRING2 LEA R0,	Input2  ; Load address from Input2 into R0
                PUTS            ; write Input1 on screen
                BRnzp BIT5

        BIT5    GETC           ; Reads input character from user
                OUT            ; Display input character to user
                ADD R6, R0, R2 ; ADD Negitive ASCII value of Q, place it in R6
                BRz STOPGAME
                ADD R6, R0, R3
                BRz BITNUM5
                ADD R6, R0, R4
                BRz BITNUM5
                BRnzp BIT5

        BITNUM5 ADD R0, R0, R5	; Convert to Binary
                ST R0, Char5
                BRnzp BIT6

        BIT6    GETC           ; Reads input character from user
                OUT            ; Display input character to user
                ADD R6, R0, R2 ; ADD Negitive ASCII value of Q, place it in R6
                BRz STOPGAME
                ADD R6, R0, R3
                BRz BITNUM6
                ADD R6, R0, R4
                BRz BITNUM6
                BRnzp BIT6

        BITNUM6 ADD R0, R0, R5	; Convert to Binary
                ST R0, Char6
                BRnzp BIT7

        BIT7    GETC           ; Reads input character from user
                OUT            ; Display input character to user
                ADD R6, R0, R2 ; ADD Negitive ASCII value of Q, place it in R6
                BRz STOPGAME
                ADD R6, R0, R3
                BRz BITNUM7
                ADD R6, R0, R4
                BRz BITNUM7
                BRnzp BIT7

        BITNUM7 ADD R0, R0, R5	; Convert to Binary
                ST R0, Char7
                BRnzp BIT8

        BIT8    GETC           ; Reads input character from user
                OUT            ; Display input character to user
                ADD R6, R0, R2 ; ADD Negitive ASCII value of Q, place it in R6
                BRz STOPGAME
                ADD R6, R0, R3
                BRz BITNUM8
                ADD R6, R0, R4
                BRz BITNUM8
                BRnzp BIT5

        BITNUM8 ADD R0, R0, R5	; Convert to Binary
                ST R0, Char8
                BRnzp ORSTING

        ORSTING LEA R0,	ORSTR  ; Load address from ORSTR into R0
                PUTS            ; write ORSTR on screen

        OROPRATN        LD, R5, ASCIIOFF
                        LD R2, Char1 ; Load Char1 into R2
                        LD R3, Char5 ; Load Char5 into R3
                        NOT R2, R2 ; OR Function in DeMorgans
                        NOT R3, R3
                        AND R0, R3, R2
                        NOT R0, R0
                        ADD R0, R0, R5 ; Binary to ASCII
                        OUT

                        LD R2, Char2 ; Load Char2 into R2
                        LD R3, Char6 ; Load Char6 into R3
                        NOT R2, R2 ; OR Function in DeMorgans
                        NOT R3, R3
                        AND R0, R3, R2
                        NOT R0, R0
                        ADD R0, R0, R5 ; Binary to ASCII
                        OUT

                        LD R2, Char3 ; Load Char3 into R2
                        LD R3, Char7 ; Load Char7 into R3
                        NOT R2, R2 ; OR Function in DeMorgans
                        NOT R3, R3
                        AND R0, R3, R2
                        NOT R0, R0
                        ADD R0, R0, R5 ; Binary to ASCII
                        OUT

                        ; Get Char4 and Char8, OR them and then OUTPUT
                        LD R2, Char4 ; Load Char4 into R2
                        LD R3, Char8 ; Load Char8 into R3
                        NOT R2, R2 ; OR Function in DeMorgans
                        NOT R3, R3
                        AND R0, R3, R2
                        NOT R0, R0
                        ADD R0, R0, R5 ; Binary to ASCII
                        OUT
                        BRnzp PRG

        STOPGAME LEA R0, Quit
                 PUTS
                 HALT
        
Input1 .STRINGZ	"\nEnter First Number (4 binary digits): "
Input2 .STRINGZ	"\nEnter Second Number (4 binary digits): "
ORSTR  .STRINGZ "\nThe OR function of the two numbers is: "
Quit   .STRINGZ	"\nThank you for playing!"

    .END
