; Add_Even.asm
; Author(s): Joshua Hidocos, Rian Olson, Even Green
; Student Number(s): 040878695, 041073915, 040998760
; Date:  Augest 11, 2023

Add_Even:
    LDAB    #NUMDIGITS  ; Load the length of the card number into register B

    PSHB               ; Push the original value of B onto the stack
    LDAA   #0          ; Initialize B to hold the sum of even digits
    dex
    dex
    dex
    dex
skip:
    LDAB    1,x                ; Load a digit from the sequence into register A
    inx
    inx
    ABA                 ; Add it to the running sum in register A
    PULB                ; Restore the original value of B from the stack
    DECB                ; Decrement B (remaining digits to process)
    DECB                ; Decrement B again (skipping odd digits)
    PSHB                ; Push the updated value of B onto the stack
    TFR     a,b         ; Transfer the sum in A to B
    CLRA
    PULA
    CMPA    #0
    PSHA
    TFR     b,a
    BGT      skip
    PULA

    CLRA                ; Clear A (cleanup)

    RTS                 ; Return from the subroutine

    end