//
// This file contains the various code
// snippets from Chapter 4. This ensures
// they compile and gives you a chance
// to single step through them.
// They are labeled, so you can set a
// breakpoint at the one you are interested in.

.global _start

_start:
// uncomment the next 2 lines if you want to see
// an infinite loop
l1:
                                // mov x1, #1
                                // B _start

l2:
    cmp     x4,#45
    b.eq    _start

    cmp     w4,#45
    b.eq    _start

    mov     w2,#1               // w2 holds I
loop:
                                // body of the loop goes here.

                                // Most of the logic is at the end
    add     w2,w2,#1            // I = I + 1
    cmp     w2,#10
    b.le    loop                // IF I <= 10 goto loop

l4:
    mov     w2,#10              // R2 holds I
loop2:
                                // body of the loop goes here.

                                // The CMP is redundant since we
                                // are doing SUBS.
    subs    w2,w2,#1            // I = I - 1
    b.ne    loop2               // branch until I = 0

l5:
                                // w4 is X and has been initialized
loop3:
    cmp     w4,#5
    b.ge    loopdone
                                // … other statements in the loop body …
    b       loop3
loopdone:
                                // program continues

l6:
    cmp     w5,#10
    b.ge    elseclause

                                // … if statements …

    b       endif
elseclause:

                                // … else statements …

endif:
                                // continue on after the /then/else …

                                // mask off the high order byte
    and     w6,w6,#0xff000000

// shift the byte down to the
// low order position.
    lsr     w6,w6,#24

l8:
    orr     x6,x6,#0xff

l9:
    bic     x6,x6,#0xff

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     w0,#0               // Use 0 return code
    mov     x8,#93              // Service command code 93 terminates this program
    svc     0                   // Call linux to terminate the program

.data
helloworld:
    .ascii  "Hello World!"
