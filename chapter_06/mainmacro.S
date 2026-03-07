//
// Assembler program to convert a string to
// all upper case by calling a function.
//
// x0-x2 - parameters to linux function services
// x1 - address of output string
// x0 - address of input string
// x2 - original address of input string
// x8 - linux function number
//

#include "uppermacro.inc"

.global _start                  // Provide program starting address to linker

_start:
                                // Convert tststr to uppercase
    toupper tststr,buffer

// Setup the parameters to print
// and then call Linux to do it.
    mov     x2,x0               // return code is the length of the string

    mov     x0,#1               // 1 = StdOut
    ldr     x1,=buffer          // string to print
    mov     x8,#64              // linux write system call
    svc     0                   // Call linux to output the string

                                // Convert tststr2 to uppercase
    toupper tststr2,buffer

// Setup the parameters to print
// and then call Linux to do it.
    mov     x2,x0               // return code is the length of the string

    mov     x0,#1               // 1 = StdOut
    ldr     x1,=buffer          // string to print
    mov     x8,#64              // linux write system call
    svc     0                   // Call linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     x0,#0               // Use 0 return code
    mov     x8,#93              // Service command code 93 terminates
    svc     0                   // Call linux to terminate the program

.data
tststr:
    .asciz  "This is our Test String that we will convert.\n"
tststr2:
    .asciz  "A second string to upper case!!\n"
buffer:
    .fill   255,1,0
