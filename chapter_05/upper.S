//
// Assembler program to convert a string to
// all upper case.
//
// x0-x2 - parameters to linux function services
// x3 - address of output string
// x4 - address of input string
// w5 - current character being processed
// x8 - linux function number
//

.global _start                  // Provide program starting address to linker

_start:
    ldr     x4,=instr           // start of input string
    ldr     x3,=outstr          // address of output string
// The loop is until byte pointed to by x1 is non-zero
loop:
    ldrb    w5,[x4],#1          // load character and increment pointer
// If w5 > 'z' then goto cont
    cmp     w5,#'z'             // is letter > 'z'?
    b.gt    cont
// Else if w5 < 'a' then goto end if
    cmp     w5,#'a'
    b.lt    cont                // goto to end if, if < 'a'
// if we got here then the letter is lower case, so convert it.
    sub     w5,w5,#('a'-'A')
cont:
                                // end if
    strb    w5,[x3],#1          // store character to output str
    cmp     w5,#0               // stop on hitting a null character
    b.ne    loop                // loop if character isn't null

// Setup the parameters to print our hex number
// and then call Linux to do it.
    mov     x0,#1               // 1 = StdOut
    ldr     x1,=outstr          // string to print
    sub     x2,x3,x1            // get the length by subtracting the pointers
    mov     x8,#64              // linux write system call
    svc     0                   // Call Linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     x0,#0               // Use 0 return code
    mov     x8,#93              // Service code 93 terminates
    svc     0                   // Call Linux to terminate the program

.data
instr:
    .asciz  "This is our Test String that we will convert.\n"
outstr:
    .fill   255,1,0
