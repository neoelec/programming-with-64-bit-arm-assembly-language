//
// Examples of the MOV instruction.
//
.global _start                  // Provide program starting address to linker

// Load x2 with 0x1234FEDC4F5D6E3A first using MOV and MOVK
_start:
    mov     x2,#0x6e3a
    movk    x2,#0x4f5d,lsl #16
    movk    x2,#0xfedc,lsl #32
    movk    x2,#0x1234,lsl #48

// Just move w2 into w1
    mov     w1,w2

// Now lets see all the shift versions of MOV
    mov     x1,x2,lsl #1        // Logical shift left
    mov     x1,x2,lsr #1        // Logical shift right
    mov     x1,x2,asr #1        // Arithmetic shift right
    mov     x1,x2,ror #1        // Rotate right

// Repeat the above shifts using the Assembler mnemonics.

    lsl     x1,x2,#1            // Logical shift left
    lsr     x1,x2,#1            // Logical shift right
    asr     x1,x2,#1            // Arithmetic shift right
    ror     x1,x2,#1            // Rotate right

// Example that works with 8 bit immediate and shift
    mov     x1,#0xab000000      // Too big for #imm16

// Example that can't be represented and results in an error
// Uncomment the instruction if you want to see the error
    // mov     x1,#0xabcdef11      // Too big for #imm16 and can’t be represented.

// Example of MVN
    movn    w1,#45

// Example of a MOV that the Assembler will change to MVN
    mov     w1,#0xfffffffe      // (-2)

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     x0,#0               // Use 0 return code
    mov     x8,#93              // Service command code 93 terminates this program
    svc     0                   // Call linux to terminate the program
