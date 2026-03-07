//
// Assembler program to convert a string to
// all upper case by calling a function.
//
// x0-R2 - parameters to linux function services
// x1 - address of output string
// x0 - address of input string
// x8 - linux function number
//

.global _start                  // Provide program starting address to linker

_start:
    ldr     x0,=instr           // start of input string
    ldr     x1,=outstr          // address of output string

    bl      toupper

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
    mov     x8,#93              // Service command code 93 terminates
    svc     0                   // Call linux to terminate the program

.data
instr:
    .asciz  "This is our Test String that we will convert. AaZz@[`{\n"
    .align  4
outstr:
    .fill   255,1,0
