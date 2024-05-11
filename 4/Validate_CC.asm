; Validate_CC.asm

; Author(s): Joshua Hidocos, Rian Olson, Even Green
; Student Number(s): 040878695, 041073915, 040998760
; Date:  Augest 11, 2023

Validate_CC:    tfr     y,a
                daa
                aba              ; Add B to A and store in A (B + A -> A)
                daa
                tfr     a,b      ; Transfer A to B and clear A
                clra             ; Clear register A
                pshx
                ldx     #10       ; Load the value 10 into index register X

                idiv              ; Divide B by X

                cmpb    #0        ; Compare the result in B with 0
                beq     TrueOp    ; Branch if equal to 0, indicating a true result
                clrb              ; Clear register B to indicate false result

Return:         pulx
                rts               ; Return from the subroutine

TrueOp:         ldab    #1        ; Load 1 into register B (true result)
                clra              ; Clear register A
                bra     Return    ; Unconditional branch to the 'Return' label

                end
