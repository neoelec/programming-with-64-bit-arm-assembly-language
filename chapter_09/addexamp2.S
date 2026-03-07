//
// Example of 128-Bit addition with the ADD/ADC instructions.
//

#include "debug.inc"

.global main                    // Provide program starting address

// Load the registers with some data
// First 64-bit number is 0x0000000000000003FFFFFFFFFFFFFFFF
main:
    str     lr,[sp,#-16]!
    mov     x2,#0x0000000000000003
    mov     x3,#0xffffffffffffffff //Assembler will change to MOVN
// Second 64-bit number is 0x00000000000000050000000000000001
    mov     x4,#0x0000000000000005
    mov     x5,#0x0000000000000001

    printStr "Inputs:"
    printReg 2
    printReg 3
    printReg 4
    printReg 5
    adds    x1,x3,x5            // Lower order word
    adc     x0,x2,x4            // Higher order word

    printStr "Outputs:"
    printReg 1
    printReg 0
    mov     x0,#0               // return code
    ldr     lr,[sp],#16
    ret
