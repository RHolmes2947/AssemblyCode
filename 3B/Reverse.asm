VALUE1  equ $3289

org $1000

Source  db %00100010, $54, $98, $55, $66, $32
Source2 dw $5677

; All Values must be in Hexadecimal as per the example for lds

org $2000
lds #$2000

ldd #VALUE1

Aba

ldaa Source+4
ldab $1000
ldx Source2
ldx #Source2

ldaa Source+7
ldaa Source2

end
