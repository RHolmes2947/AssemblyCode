; CC_Validation.asm
;
#include C:\68HCS12\registers.inc
;
; Author(s): Joshua Hidocos, Rian Olson, Even Green
; Student Number(s): 040878695, 041073915, 040998760
; Date:  Augest 11, 2023
;
; Purpose:      Credit Card Number Validation

; Address Constants - Do NOT change
STORAGE1        equ     $1000                   ; Storage starts here for original cards
FINALRESULTS    equ     $1030                   ; Final number of valid and invalid cards
PROGRAMSTART    equ     $2000                   ; Executable code starts here

; Hardware Configuration - Complete the Constant values
DIGIT3_PP0      equ    %1110                ; HEX Display MSB (left most digit)
DIGIT0_PP3      equ    %0111                ; Display LSB (right most digit)


; Program Constants - Do not change these values
NUMBERSOFCARDS  equ     6                       ; Six Cards to process
NUMDIGITS       equ     4                       ; Each Card has 4 digits

; You may add other Constant here if needed



; DO NOT CHANGE THE DELAY_VALUE; OTHERWISE THE VALUES WILL INCORRECTLY BE DISPLAYED
; IN THE SIMULATOR
DELAY_VALUE     equ     64                      ; HEX Display Multiplexing Delay

                org STORAGE1                    ; Note: a Label cannot be placed
Cards                                           ; on same line as org statement
#include        Sec_302_CC_Numbers.txt                  ; substitute the appropriate file name here.
EndCards


; Do not change this code.
; Place your results here as you loop through your solution
                org  FINALRESULTS
InvalidResult   ds      1                       ; Count of Invalid CARDs processed
ValidResult     ds      1                       ; Count of Valid CARDs processed
Count           ds      1
; end of do not change

                org     ProgramStart
                lds     #ProgramStart           ; Stack used to protect values
; --- Your code starts here

MainLoop
    clr     Count
    clr     ValidResult        ; Clear the valid count
    clr     InvalidResult      ; Clear the invalid count
    ldx     #Cards             ; Load the array of card numbers

LoopCard
    jsr     Add_Odd            ; Calculate sum of odd digits


    jsr     Add_Even           ; Calculate sum of even digits
    jsr     Validate_CC        ; Validate the credit card number

    cmpb    #$0

    bhi     ValidCard
    ldaa    InvalidResult
    inca
    staa    InvalidResult        ; Branch if invalid
    bra     NextCard

ValidCard
    ldaa   ValidResult
    inca
    staa   ValidResult

NextCard
    ldaa    Count
    inca
    staa    Count
    cmpa    #NUMBERSOFCARDS
    beq     Finished
    clra
    bra     LoopCard





; Do not change and code below here
Finished        jsr     Config_HEX_Displays
Display         ldaa    ValidResult
                ldab    #DIGIT3_PP0             ; Select MSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; Delay for DELAY_VALUE milliseconds
                ldaa    InValidResult
                ldab    #DIGIT0_PP3             ; Select LSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; Eelay for DELAY_VALUE milliseconds
                bra     Display                 ; Endless loop


; Filenames without a "C:\68HCS12\Lib\" path MUST be placed in the SOURCE FOLDER
#include Add_Odd.asm                            ; you write this one
#include Add_Even.asm                           ; you write this one
#include Validate_CC.asm                        ; you write this one
#include Config_HEX_Displays.asm                ; provided to you - no changes permitted
#include Hex_Display.asm                        ; provided to you - no changes permitted
#include C:\68HCS12\Lib\Delay_ms.asm            ; Library File    - no changes permitted

                end

************************* No Code Past Here ****************************