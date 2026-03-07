//
// Multiply 2 3x3 integer matrices
// Uses the NEON Coprocessor to do
// some operations in parallel.
//
// Registers:
//      d0 - first column of matrix A
//      d1 - second column of matrix A
//      d2 - third column of matrix A
//      d3 - first column of matrix B
//      d4 - second column of matrix B
//      d5 - third column of matrix B
//      d6 - first column of matrix C
//      d7 - second column of matrix C
//      d8 - third column of matrix C

.global main                    // Provide program starting address to linker

main:
    stp     x19,x20,[sp,#-16]!
    str     lr,[sp,#-16]!

// load matrix A into Neon registers d0, d1, d2
    ldr     x0,=A               // Address of A
    ldp     d0,d1,[x0],#16
    ldr     d2,[x0]

// load matrix B into Neon registers d3, d4, d5
    ldr     x0,=B               // Address of B
    ldp     d3,d4,[x0],#16
    ldr     d5,[x0]

.macro mulcol ccol bcol
    mul     \ccol\().4H,V0.4H,\bcol\().4H[0]
    mla     \ccol\().4H,V1.4H,\bcol\().4H[1]
    mla     \ccol\().4H,V2.4H,\bcol\().4H[2]
.endm

    mulcol  V6,V3               // process first column
    mulcol  V7,V4               // process second column
    mulcol  V8,V5               // process third column

    ldr     x1,=C               // Address of C
    stp     d6,d7,[x1],#16
    str     d8,[x1]

// Print out matrix C
// Loop through 3 rows printing 3 cols each time.
    mov     w19,#3              // Print 3 rows
    ldr     x20,=C              // Addr of results matrix
printloop:

    ldr     x0,=prtstr          // printf format string
// print transpose so matrix is in usual row column order.
// first ldrh post-indexes by 2 for next row
// so second ldrh adds 6, so is ahead by 2+6=8=row size
// simlarly for third ldh ahead by 2+14=16 = 2 x row size
    ldrh    w1,[x20],#2         // first element in current row
    ldrh    w2,[x20,#6]         // second element in current row
    ldrh    w3,[x20,#14]        // third element in curent row
    bl      printf              // Call printf
    subs    w19,w19,#1          // Dec loop counter
    b.ne    printloop           // If not zero loop

    mov     x0,#0               // return code
    ldr     lr,[sp],#16
    ldp     x19,x20,[sp],#16
    ret

.data
// First matrix in column major order
A:
    .short  1,4,7,0
    .short  2,5,8,0
    .short  3,6,9,0
// Second matrix in column major order
B:
    .short  9,6,3,0
    .short  8,5,2,0
    .short  7,4,1,0
// Result matix in column major order
C:
    .fill   12,2,0

prtstr:
    .asciz  "%3d  %3d  %3d\n"
