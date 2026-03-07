//
// This file contains the various code
// snippets from Chapter 11. This ensures
// they compile and gives you a chance
// to single step through them.
// They are labeled, so you can set a
// breakpoint at the one you are interested in.

.global _start

_start:
l1:
    stp     q8,q9,[sp,#-32]!
    str     q10,[sp,#-16]!
    ldp     q8,q9,[sp],#32
    ldr     q10,[sp],#16

l2:
    ldr     x1,=fp1
    ldr     s4,[x1]
    ldr     d5,[x1,#4]
    str     s4,[x1]
    str     d5,[x1,#4]

l3:
    fmov    h1,w2
    fmov    w2,h1
    fmov    s1,w2
    fmov    x1,d2
    fmov    d2,d3

l4:
    fadd    h1,h2,h3            // h1 = h2 + h3
    fadd    s1,s2,s3            // s1 = s2 + s3
    fadd    d1,d2,d3            // d1 = d2 + d3
    fsub    d1,d2,d3            // d1 = d2 - d3
    fmul    d1,d2,d3            // d1 = d2 * d3
    fdiv    d1,d2,d3            // d1 = d2 / d3
    fmadd   d1,d2,d3,d4         // d1 = d4 + d2 * d3
    fmsub   d1,d2,d3,d4         // d1 = d4 * d2 *d3
    fneg    d1,d2               // d1 = - d2
    fabs    d1,d2               // d1 = Absolute Value( d2 )
    fmax    d1,d2,d3            // d1 = Max( d2, d3 )
    fmin    d1,d2,d3            // d1 = Min( d2, d3 )
    fsqrt   d1,d2               // d1 = Square Root( d2 )

l5:
    fcvt    d1,s2
    fcvt    s1,d2
    fcvt    s1,h2
    fcvt    h1,s2

l6:
    scvtf   d1,x2               // d1 = signed integer from x2
    ucvtf   s1,w2               // s1 = unsigned integer from w2

l7:
    fcvtas  w1,h2               // signed, round to nearest
    fcvtau  w1,s2               // unsigned, round to nearest
    fcvtms  x1,d2               // signed, round towards minus infinity
    fcvtmu  x1,d2               // unsigned, round towards minus infinity
    fcvtps  x1,d2               // signed, round towards positive infinity
    fcvtpu  x1,d2               // unsigned, round towards positive infinity
    fcvtzs  x1,d2               // signed, round towards zero
    fcvtzu  x1,d2               // unsigned, round towards zero

l8:
    fcmp    h1,h2
    fcmp    h1,#0.0
    fcmp    s1,s2
    fcmp    s1,#0.0
    fcmp    d1,d2
    fcmp    d1,#0.0

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     x0,#0               // Use 0 return code
    mov     x8,#93              // Service command code 93 terminates
    svc     0                   // Call linux to terminate the program

.data
    .single 1.343,4.343e20,-0.4343,-0.4444e-10
    .double -4.24322322332e-10,3.141592653589793
fp1:
    .single 3.14159
fp2:
    .double 4.3341
fp3:
    .single 0.0
fp4:
    .double 0.0
