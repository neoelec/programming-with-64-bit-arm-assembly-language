//
// Assembler program to convert a string to
// all upper case.
//
// x1 - address of output string
// x0 - address of input string
// x4 - original output string for length calc.
// w5 - current character being processed
// w6 - minus 'a' to compare < 26.
// w6 - char minus 0x20, potentiall upper cased
//

.global toupper                 // Allow other files to call this routine

toupper:
    mov     x4,x1
// The loop is until byte pointed to by R1 is non-zero
loop:
    ldrb    w5,[x0],#1          // load character and increment pointer
// Want to know if 'a' <= w5 <= 'z'
// First subtract 'a'
    sub     w6,w5,#'a'
// Now want to know if w6 <= 25
    cmp     w6,#25              // chars are 0-25 after shift
// perform lower case conversion to w6
    sub     w6,w5,#('a'-'A')
// Use w6 if lower case, other wise use orginal character in w5
    csel    w5,w6,w5,ls
    strb    w5,[x1],#1          // store character to output str
    cmp     w5,#0               // stop on hitting a null character
    b.ne    loop                // loop if character isn't null
    sub     x0,x1,x4            // get the length by subtracting the pointers
    ret                         // Return to caller
