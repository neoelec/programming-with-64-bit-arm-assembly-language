//
// Main program to test our distance function
//
// w19 - loop counter
// x20 - address to current set of points

.global main                    // Provide program starting address

    .equ    N,100               // Number of additions.

main:
    stp     x19,x20,[sp,#-16]!
    str     lr,[sp,#-16]!

// Add up one hundred cents and test if they equal $1.00

    mov     w19,#N              // number of loop iterations

// load cents, running sum and real sum to FPU
    ldr     x0,=cent
    ldp     s0,s1,[x0],#8
    ldr     s2,[x0]
loop:
                                // add cent to running sum
    fadd    s1,s1,s0
    subs    w19,w19,#1          // decrement loop counter
    b.ne    loop                // loop if more points

                                // compare running sum to real sum
    fcmp    s1,s2
                                // print if the numbers are equal or not
    b.eq    equal
    ldr     x0,=notequalstr
    bl      printf
    b       next
equal:
    ldr     x0,=equalstr
    bl      printf

next:
// load pointer to running sum, real sum and epsilon
    ldr     x0,=runsum

// call comparison function
    bl      fpcomp              // call comparison function
// compare return code to 1 and print if the numbers
// are equal or not (within epsilon).
    cmp     x0,#1
    b.eq    equal2
    ldr     x0,=notequalstr
    bl      printf
    b       done
equal2:
    ldr     x0,=equalstr
    bl      printf

done:
    mov     x0,#0               // return code
    ldr     lr,[sp],#16
    ldp     x19,x20,[sp],#16
    ret

.data
cent:
    .single 0.01
runsum:
    .single 0.0
sum:
    .single 1.00
epsilon:
    .single 0.00001
equalstr:
    .asciz  "equal\n"
notequalstr:
    .asciz  "not equal\n"
