//
// Function to compare to floating point numbers
// the parameters are a pointer to the two numbers
// and an error epsilon.
//
// Inputs:
//      x0 - pointer to the 3 fp numbers
//           they are x1, x2, e
// Outputs:
//      x0 - 1 if they are equal, else 0

.global fpcomp                  // Allow function to be called by others

//
fpcomp:
                                // load the 3 numbers
    ldp     s0,s1,[x0],#8
    ldr     s2,[x0]

                                // calc s3 = x2 - x1
    fsub    s3,s1,s0
    fabs    s3,s3
    fcmp    s3,s2
    b.le    notequal
    mov     x0,#1
    b       done

notequal:
    mov     x0,#0

done:
    ret
