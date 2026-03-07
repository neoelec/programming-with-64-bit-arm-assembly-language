//
// This file contains the various code
// snippets from Chapter 6. This ensures
// they compile and gives you a chance
// to single step through them.
// They are labeled, so you can set a
// breakpoint at the one you are interested in.

.global _start

_start:
l1:
    str     x0,[sp,#-16]!
    ldr     x0,[sp],#16
    stp     x0,x1,[sp,#-16]!
    ldp     x0,x1,[sp],#16

l2:
                                // … other code ...
    bl      myfunc
    mov     x1,#4
                                // … more code …

    b       l3

myfunc:
                                // do some work
    ret

l3:
                                // … other code ...
    bl      myfuncb
    mov     x1,#4
                                // … more code …

    b       l4

myfuncb:
    str     lr,[sp,#-16]!       // PUSH lr
                                // do some work …
    bl      myfuncb2
                                // do some more work...
    ldr     lr,[sp],#16         // POP lr
    ret
myfuncb2:
                                // do some work ....
    ret

l4:
    sub     sp,sp,#16

l5:
    str     w0,[sp]             // Store a
    str     w1,[sp,#4]          // Store b
    str     w2,[sp,#8]          // Store c

l6:
    add     sp,sp,#16

l7:
    SUB     fp,sp,#16
    sub     sp,sp,#16

l8:
    str     w0,[fp]             // Store a
    str     w1,[fp,#-4]         // Store b
    str     w2,[fp,#-8]         // Store c

    add     sp,sp,#16

l9:
    bl      SUMFN
    b       l10

// Simple function that takes 2 parameters
// VAR1 and VAR2. The function adds them,
// storing the result in a variable SUM.
// The function returns the sum.
// It is assumed this function does other work,
// including other functions.

// Define our variables
    .equ    VAR1,0
    .equ    VAR2,4
    .equ    SUM,8

SUMFN:
    stp     lr,fp,[sp,#-16]!
    sub     fp,sp,#16
    sub     sp,sp,#16           // room for 3 32-bit values
    str     w0,[fp,#VAR1]       // save first param.
    str     w1,[fp,#VAR2]       // save second param.

// Do a bunch of other work, but don’t change sp.

    ldr     w4,[fp,#VAR1]
    ldr     w5,[fp,#VAR2]
    add     w6,w4,w5
    str     w6,[fp,#SUM]

// Do other work

// Function Epilog
    ldr     w0,[fp,#SUM]        // load sum to return
    add     sp,sp,#16           // Release local vars
    ldp     lr,fp,[sp],#16      // Restore lr, fp
    ret

.macro PUSH1 register
    str     \register,[sp,#-16]!
.endm

.macro POP1 register
    ldr     \register,[sp],#16
.endm

.macro PUSH2 register1, register2
    stp     \register1,\register2,[sp,#-16]!
.endm

.macro POP2 register1, register2
    ldp     \register1,\register2,[sp],#16
.endm

Myfunction:
    PUSH1   lr
    PUSH2   x20,x23
// function body …
    POP2    x20,x23
    POP1    lr
    ret

l10:

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     x0,#0               // Use 0 return code
    mov     x8,#93              // Service command code 93 terminates
    svc     0                   // Call linux to terminate the program
