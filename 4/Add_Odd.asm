; Add_Odd.asm

; Author(s): Joshua Hidocos, Rian Olson, Even Green
; Student Number(s): 040878695, 041073915, 040998760
; Date:  Augest 11, 2023

MAX             equ        9                ; Maximum value for loop iteration
Extract_MSB     equ        $2144            ; Memory address for MSB extraction
Extract_LSB     equ        $2149            ; Memory address for LSB extraction
sum             db         1

Add_odd
        ldaa    #NUMDIGITS                 ; Load NUMDIGITS value into A register
Start
        ldab    #$2                        ; Load constant value 2 into B register
        sba                                ; Subtract B from A, useful for loop counter
        psha                               ; Push A register onto the stack
        ldaa    0,x                        ; Load value at address pointed by X + 0 into B register
        cmpa    #8
        beq     eight
        cmpa    #9
        beq     nine
        clc
        asla
        ldab    #MAX                        ; Load maximum value (9) into B register
        cba                                 ; Compare B with A
        bls     Loop                        ; Branch to Loop if B <= A
        daa
	psha                                ; Push A onto the stack
        jsr     Extract_MSB                 ; Call subroutine at Extract_Msb address
        pulb                                ; Pull value from stack into B register
        exg     a,b                         ; Exchange A and B registers
        jsr     Extract_LSB                 ; Call subroutine at Extract_Lsb address
        aba                                 ; Add B to A, result in A
Loop
        inx
        inx
	pulb                                ; Pull value from stack into B register
        psha                                ; Push B onto the stack
        tfr     b,a                         ; Transfer data from B to A register
        cmpa    #$0                        ; Compare A with 0
        bhi     Start                       ; Branch to Start if A > 0
        pula                                ; Pull value from stack into A register
        pulb                                ; Pull value from stack into B register
        aba                                 ; Add A and B, result in A
        daa
        tfr     a,y                         ; Transfer A to Y register
        clra                                ; Clear A register
        clrb                                ; Clear B register
        rts                                 ; Return from subroutine

        end                                 ; End of the program

eight
        ldaa    #7
        bra     loop
nine
        ldaa    #9
        bra     loop

        
