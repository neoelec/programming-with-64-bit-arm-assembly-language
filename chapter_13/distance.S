//
// Example function to calculate the distance
// between 4D two points in single precision
// floating point using the NEON Processor
//
// Inputs:
//      x0 - pointer to the 8 fp numbers
//           they are (x1, x2, x3, x4),
//                    (y1, y2, y3, y4)
// Outputs:
//      w0 - the length (as single precision fp)

.global distance                // Allow function to be called by others

//
distance:
                                // load all 4 numbers at once
    ldp     q2,q3,[x0]

                                // calc V1 = V2 - V3
    fsub    v1.4s,v2.4s,v3.4s
                                // calc V1 = V1 * V1 = (xi-yi)^2
    fmul    v1.4s,v1.4s,v1.4s
                                // calc s0 = s0 + s1 + s2 + s3
    faddp   v0.4s,v1.4s,v1.4s
    faddp   v0.4s,v0.4s,v0.4s
                                // calc sqrt(s0)
    fsqrt   s4,s0
                                // move result to w0 to be returned
    fmov    w0,s4

    ret
