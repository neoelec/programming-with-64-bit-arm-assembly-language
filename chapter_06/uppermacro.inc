//
// Assembler program to convert a string to
// all upper case.
//
// x1 - address of output string
// x0 - address of input string
// x2 - original output string for length calc.
// w3 - current character being processed
//

// label 1 = loop
// label 2 = cont

.macro toupper	instr, outstr
    ldr     x0,=\instr
    ldr     x1,=\outstr
    mov     x2,x1
// The loop is until byte pointed to by x1 is non-zero
1:
    ldrb    w3,[x0],#1          // load character and increment pointer
// If R5 > 'z' then goto cont
    cmp     w3,#'z'             // is letter > 'z'?
    b.gt    2f
// Else if R5 < 'a' then goto end if
    cmp     w3,#'a'
    b.lt    2f                  // goto to end if
// if we got here then the letter is lower case, so convert it.
    sub     w3,w3,#('a'-'A')
2:
                                // end if
    strb    w3,[x1],#1          // store character to output str
    cmp     w3,#0               // stop on hitting a null character
    b.ne    1b                  // loop if character isn't null
    sub     x0,x1,x2            // get the length by subtracting the pointers
.endm
