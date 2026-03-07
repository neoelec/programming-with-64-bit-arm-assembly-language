//
// Example of 128-Bit addition with the ADD/ADC instructions.
//
.global _start                  // Provide program starting address to linker

// Load the registers with some data
// First 64-bit number is 0x0000000000000003FFFFFFFFFFFFFFFF
_start:
    mov     x2,#0x0000000000000003
    mov     x3,#0xffffffffffffffff //Assembler will change to MOVN
// Second 64-bit number is 0x00000000000000050000000000000001
    mov     x4,#0x0000000000000005
    mov     x5,#0x0000000000000001

    adds    x1,x3,x5            // Lower order word
    adc     x0,x2,x4            // Higher order word

// Setup the parameters to exit the programc
// and then call Linux to do it.
// R0 is the return code and will be what we
// calculated above.
    mov     x8,#93              // Service command code 93 terminates this program
    svc     0                   // Call linux to terminate the program
