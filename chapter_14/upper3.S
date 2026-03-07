//
// Assembler program to convert a string to
// all upper case. Assumes only alphabetic
// characters. Uses bit clear blindly without
// checking if character is alphabetic or not.
//
// x0 - address of input string
// x1 - address of output string
// x2 - original output string for length calc.
// w3 - current character being processed
//

.global _start                  // Provide program starting address

.macro toupper inputstr, outputstr
    ldr     x0,=\inputstr       // start of input string
    ldr     x1,=\outputstr      // address of output string
    mov     x2,x1
// The loop is until byte pointed to by R1 is non-zero
loop:
    ldrb    w3,[x0],#1          // load character and increment pointer
    bic     w3,w3,#0x20         // kill the bit that makes it lower case
    strb    w3,[x1],#1          // store character to output str
    cmp     w3,#0               // stop on hitting a null charactser
    b.ne    loop                // loop if character isn't null
    sub     x0,x1,x2            // get the length by subtracting the pointers
.endm

_start:
    toupper instr,outstr

// Setup the parameters to print our hex number
// and then call Linux to do it.
    mov     x2,x0               // return code is the length of the string

    mov     x0,#1               // 1 = StdOut
    ldr     x1,=outstr          // string to print
    mov     x8,#64              // linux write system call
    svc     0                   // Call linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     x0,#0               // Use 0 return code
    mov     x8,#93              // Service command code 96 terminates
    svc     0                   // Call linux to terminate the program

.data
instr:
    .asciz  "ThisIsRatherALargeVariableNameAaZz //[`{\n"
    .align  4
outstr:
    .fill   255,1,0
