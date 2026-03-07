//
// This file contains the various code
// snippets from Chapter 2. This ensures
// they compile and gives you a chance
// to single step through them.
// They are labeled, so you can set a
// breakpoint at the one you are interested in.

.global _start

_start:
l1:
    add     x0,XZR,x1
    mov     x0,x1
    orr     x0,XZR,x1
// Load x2 with 0x1234FEDC4F5D6E3A first using MOV and MOVK
l2:
    mov     x2,#0x6e3a
    movk    x2,#0x4f5d,lsl #16
    movk    x2,#0xfedc,lsl #32
    movk    x2,#0x1234,lsl #48
l3:
    mov     x1,x2,lsl #1        // Logical shift left
    mov     x1,x2,lsr #1        // Logical shift right
    mov     x1,x2,asr #1        // Arithmetic shift right
    mov     x1,x2,ror #1        // Rotate right

l4:
    lsl     x1,x2,#1            // Logical shift left
    lsr     x1,x2,#1            // Logical shift right
    asr     x1,x2,#1            // Arithmetic shift right
    ror     x1,x2,#1            // Rotate right

l5:
                                // Too big for #imm16
    mov     x1,#0xab000000

// Uncomment the next line if you want to see the
// Assembler error for a constant that can't be
// represented.
// mov	x1,#0xabcdef11           // Too big for #imm16 and can’t be represented.

l6:
                                // the immediate value can be 12-bits, so 0-4095
                                // x2 = x1 + 4000
    add     x2,x1,#4000
                                // the shift on an immediate can be 0 or 12
                                // x2 = x1 + 0x20000
    add     x2,x1,#0x20,lsl #12
                                // simple addition of two registers
                                // x2 = x1 + x0
    add     x2,x1,x0
                                // addition of a register with a shifted register
                                // x2 = x1 + (x0 * 4)
    add     x2,x1,x0,lsl #2
                                // With register extension options
                                // x2 = x1 + signed extended byte(x0)
    add     x2,x1,x0,sxtb
                                // x2 = x1 + zero extended halfword(x0) * 4
    add     x2,x1,x0,uxth #2

l8:
    adds    x0,x0,#1

l9:
    adds    x1,x3,x5            // Lower order 64-bits
    adc     x0,x2,x4            // Higher order 64-bits

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     x0,#0               // Use 0 return code
    mov     x8,#93              // Service command code 93 terminates this program
    svc     0                   // Call linux to terminate the program

.data
helloworld:
    .ascii  "Hello World!"
