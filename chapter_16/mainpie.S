//
// Assembler program to demonstate a buffer
// overrun hacking attack.
//
// x0-x2 - parameters to linux function services
// x1 - address of output string
// x0 - address of input string
// x8 - linux function number
//

.global _start                  // Provide program starting address to linker

DownloadCreditCardNumbers:
// Setup the parameters to print hello world
// and then call Linux to do it.
    mov     x0,#1               // 1 = StdOut
    ldr     x1,=getcreditcards  // string to print
    mov     x2,#30              // length of our string
    mov     x8,#64              // linux write system call
    svc     0                   // Call linux to output the string
    ret

calltoupper:
    str     lr,[sp,#-16]!       // Put lr on the stack
    sub     sp,sp,#16           // 16 bytes for outstr
    ldr     x0,=instr           // start of input string
    mov     x1,sp               // address of output string

    bl      toupper

aftertoupper:
    add     sp,sp,#16           // Free outstr
    ldr     lr,[sp],#16
    ret

_start:
    bl      calltoupper

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     x0,#0               // Use 0 return code
    mov     x8,#93              // Service command code 93 terminates
    svc     0                   // Call linux to terminate the program

.data
instr:
    .ascii  "This is our Test"  // Correct length string
    .dword  0x00000000004000b0  // overwrite for lr
getcreditcards:
    .asciz  "Downloading Credit Card Data!\n"
    .align  4
