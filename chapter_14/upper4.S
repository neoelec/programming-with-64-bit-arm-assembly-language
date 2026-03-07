//
// Assembler program to convert a string to
// all upper case.
//
// x0 - address of input string
// x1 - address of output string
// x2 - use as indirection to load data
// q0 - 8 characters to be processed
// V1 - contains all a's for comparison
// V2 - result of comparison with 'a's
// q3 - all 25's for comp
// q8 - spaces for bic operation

.global toupper                 // Allow other files to call this routine

    .equ    N,4
toupper:
    ldr     x2,=aaas
    ldr     q1,[x2]             // Load q1 with all as
    ldr     x2,=endch
    ldr     q3,[x2]             // Load q3 with all 25's
    ldr     x2,=spaces
    ldr     q8,[x2]             // Load q8 with all spaces
    mov     w3,#N
// The loop is until byte pointed to by R1 is non-zero
loop:
    ldr     q0,[x0],#16         // load 16 characters and increment pointer
    sub     v2.16b,v0.16b,v1.16b // Subtract 'a's
    cmhi    v2.16b,v2.16b,v3.16b // compare chars to 25's
    not     v2.16b,v2.16b       // no cmlo so need to not
    and     v2.16b,v2.16b,v8.16b // and result with spaces
    bic     v0.16b,v0.16b,v2.16b // kill the bit that makes it lowercase
    str     q0,[x1],#16         // store character to output str
    subs    w3,w3,#1            // decrement loop counter and set flags
    b.ne    loop                // loop if character isn't null
    mov     x0,#(N*16)          // get the length by subtracting the pointers
    ret                         // Return to caller

.data
aaas:
    .fill   16,1,'a'            // 16 a's
endch:
    .fill   16,1,25             // after shift, chars are 0-25
spaces:
    .fill   16,1,0x20           // spaces for bic
