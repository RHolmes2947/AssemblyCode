; Config_HEX_Displays.asm
; David Haley, Professor, 18 Mar 2013
;--------------------------------------
; Config_HEX_Displays                 -
;    Purpose:                         -
;       - To configure the ports the  -
;         Dragon12-Plus HCS12 Trainer -
;         Rev F. Board Ports to use   -
;         the four HEX displays       -
;         on Port B and P             -
;                                     -
;   Precondition:                     -
;       - A library file that defines -
;         the register mapping must   -
;         be included in the source   -
;         code using this subroutine  -
;         because this subroutine     -
;         is dependent upon the       -
;         register mapping            -
;                                     -
;    Use:                             -
; - Place Config_HEX_Displays.asm in  -
;         your Source Code folder     -
;                                     -
;       - insert the following after  -
;         your last line of source    -
;         and before "end"            -
;                                     -
;    #include Config_HEX_Displays.asm -
;                                     -
;     Use:                            -
;       - jsr Config_HEX_Displays     -
;                                     -
;    Postcondition:                   -
;        - A is destroyed             -
;--------------------------------------
Config_HEX_Displays
        ldaa    #$FF    ; port configuration value
        staa    DDRB    ; Make PORTB output - for Hex Displays' values
        staa    DDRP    ; Make PTP as output - to select correct Hex Display
        rts
;- --------------------------------
;     End Config_HEX_Displays     -
;----------------------------------