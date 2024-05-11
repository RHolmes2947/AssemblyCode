; HEX_Display.asm
; Author:               D. Haley
; Student Number:       Faculty
; Date:                 28 Nov 2020
;
; Purpose:              Subroutine to display a value on a Hex Display
;
; Preconditions:        HEX Displays configured for Output
;                       Value to Display is in Accumulator A
;                       Hex Display to use is in Accumulator B
;
; Notes:                Select the Hex Display and then display the value;
;                       otherwise, excessive flicker will occur if this order
;                       of operations is not followed
;
; Postcondition:        X is destroyed
;                       A is destroyed
; Use:                             -
;                       Place Hex_Display.asm in  your Source Code folder
;                                     -
;                       insert the following after your last line of source
;                       and before "end"
;
;                       #include Config_HEX_Displays.asm
;
; Use:
;                       jsr Config_HEX_Displays
;                        observing Preconditions
;
;                 Partial Lookup table for LED segments
LEDSEG  db        $3F,$06,$5B,$4F,$66,$6D,$7D
;                 0,  1,  2,  3,  4,  5,  6
;
Hex_Display
        ldx     #LEDSEG         ; Point to start of lookup table
        ldaa    a,x             ; Effective address is sum of contents of registers A and X
        stab    PTP             ; Selected Hex Display (if this code is after staa PORTB
                                ; then ALL Hex Dislays will momentarily flicker the value)
        staa    PORTB           ; Display value
        rts
; -----------------------------
;        END Hex_Display      -
;------------------------------