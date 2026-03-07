//
// Assembler program to print "Hello World!"
// to stdout.
//
// x0-x2 - parameters to linux function services
// x8 - linux function number
//

.global _start                  // Provide program starting address to linker

// Setup the parameters to print hello world
// and then call Linux to do it.
_start:
    mov     x0,#1               // 1 = StdOut
    ldr     x1,=helloworld      // string to print
    mov     x2,#13              // length of our string
    mov     x8,#64              // linux write system call
    svc     0                   // Call linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     x0,#0               // Use 0 return code
    mov     x8,#93              // Service command code 93 terminates this program
    svc     0                   // Call linux to terminate the program

.data
helloworld:
    .ascii  "Hello World!\n"
