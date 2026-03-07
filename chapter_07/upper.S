//
// Assembler program to convert a string to
// all upper case.
//
// x1 - address of output string
// x0 - address of input string
// x4 - original output string for length calc.
// w5 - current character being processed
//

.global toupper                 // Allow other files to call this routine

toupper:
    mov     x4,x1
// The loop is until byte pointed to by x1 is non-zero
loop:
    ldrb    w5,[x0],#1          // load character and increment pointer
// If w5 > 'z' then goto cont
    cmp     w5,#'z'             // is letter > 'z'?
    b.gt    cont
// Else if w5 < 'a' then goto end if
    cmp     w5,#'a'
    b.lt    cont                // goto to end if
// if we got here then the letter is lower case, so convert it.
    sub     w5,w5,#('a'-'A')
cont:
                                // end if
    strb    w5,[x1],#1          // store character to output str
    cmp     w5,#0               // stop on hitting a null character
    b.ne    loop                // loop if character isn't null
    sub     x0,x1,x4            // get the length by subtracting the pointers
    ret                         // Return to caller
