; BCD_Counter.asm
; Author:               D. Haley, Faculty
; Modified by:          Rian Olson
; Student Number(s):    041073915
; Course:               CST8216
; Date:                 07/30/23
;
; Purpose       BCD Counter $00 - $15 (BCD) using Hex Displays
;               and a single register, Accumulator A, for the count
;               The range of counting can be altered by changing the
;               FIRST_BCD and END_BCD constants
;
; ***** DO NOT CHANGE ANY CODE BETWEEN THESE MARKERS *****
; Library Routines  - to be used in your solution
;

Config_Hex_Displays         equ        $2117
Delay_Ms                    equ        $211F
Hex_Display                 equ        $2139
Extract_Msb                 equ        $2144
Extract_Lsb                 equ        $2149

; Program Constants - to be used in your solution
STACK           equ     $2000
                                ; Port P (PPT) Display Selection Values
DIGIT3_PP0      equ     %1110   ; Left-most display MSB
DIGIT2_PP1      equ     %1101   ; 2nd from left-most display LSB

; Delay Subroutine Value  - to be used in your solution
DVALUE  equ     #250            ; Delay value (base 10) 0 - 255 ms
                                ; 125 = 1/8 second <- good for Dragon12 Board

; ***** END OF DO NOT CHANGE ANY CODE BETWEEN THESE MARKERS *****

; BCD Count constants  - to be used in your solution
; Changing these values will change the Starting and End BCD counts

FIRST_BCD        equ     $00     ; Starting BCD count
END_BCD          equ     $15     ; Ending BCD count0

        org     $2000
Start   lds     #STACK          ; Initialize the Stack

        jsr     Config_HEX_Displays ; Use the Hex Displays to display the count
; Continually Count FIRST_BCD ... END_BCD ... FIRST_BCD ... END_BCD


First   ldaa    #First_BCD       ; Load the value from memory location First_BCD into Accumulator A
Return  cmpa    #END_BCD        ; Compare the value in Accumulator A with the constant value END_BCD
        bhi     First           ; Branch to the label First if Accumulator A is higher (greater)

        psha                    ; Push the value in Accumulator A onto the stack

        jsr     Extract_Msb     ; Call the subroutine Extract_Msb to extract the most significant digit
        ldab    #DIGIT3_PP0     ; Load the constant value DIGIT3_PP0 into Register B
        jsr     Hex_Display     ; Call the subroutine Hex_Display to display the extracted digit on a display

        ldaa    #DVALUE         ; Load the constant value DVALUE into Accumulator A
        jsr     Delay_ms        ; Call the subroutine Delay_ms to introduce a delay in milliseconds
        pula                    ; Pull the value from the stack into Accumulator A
        psha                    ; Push the value in Accumulator A onto the stack

        jsr     Extract_Lsb     ; Call the subroutine Extract_Lsb to extract the least significant digit
        ldab    #DIGIT2_PP1     ; Load the constant value DIGIT2_PP1 into Register B
        jsr     Hex_Display     ; Call the subroutine Hex_Display to display the extracted digit on a display

        ldaa    #DVALUE         ; Load the constant value DVALUE into Accumulator A
        jsr     Delay_ms        ; Call the subroutine Delay_ms to introduce a delay in milliseconds
        pula                    ; Pull the value from the stack into Accumulator A

        adca    #1              ; Add 1 to the value in Accumulator A with carry
        daa                     ; Decimal adjust the result in Accumulator A after addition

        bra     Return          ; Branch (jump) back to the label Return to continue the loop

        end                     ; The end of the code
