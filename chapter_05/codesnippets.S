//
// This file contains the various code
// snippets from Chapter 5. This ensures
// they compile and gives you a chance
// to single step through them.
// They are labeled, so you can set a
// breakpoint at the one you are interested in.

.global _start

.data
l1:
    .byte   74,0112,0b00101010,0x4A,0X4a,'J','H' + 2
    .word   0x1234ABCD,-1434
    .quad   0x123456789ABCDEF0
    .ascii  "Hello World\n"

l2:
    .byte   -0x45,-33,~0b00111001

l3:
    .fill   10,4,0

l4:
    .rept   3
    .byte   0,1,2
    .endr

    .byte   0,1,2
    .byte   0,1,2
    .byte   0,1,2

l5:
    .byte   0x3F
    .align  4
    .word   0x12345678

.text

_start:
l6:
    ldr     x1,=helloworld
    adr     x1,helloworld2

l7:
    ldr     x1,=0x1234ABCD1234ABCD

l8:
// load the address of mynumber into x1
    ldr     x1,=mynumber
// load the word stored at mynumber into x2
    ldr     x2,[x1]

l9:
    ldr     x1,=arr1

l10:
                                // Load the first element
    ldr     w2,[x1]
                                // Load element 3
                                // The elements count from 0, so 2 is
                                // the third one. Each word is 4 bytes,
                                // so we need to multiply by 4
    ldr     w2,[x1,#(2 * 4)]

l11:
                                // The 3rd element is still number 2
    mov     x3,#(2 * 4)
                                // Add the offset in x3 to x1 to get our element.
    ldr     w2,[x1,x3]

l12:
    ldr     w2,[x1,#-(2 * 4)]
    mov     x3,#(-2 * 4)
    ldr     w2,[x1,x3]

l13:
                                // Our array is of WORDs. 2 is the index
    mov     x3,#2
                                // Shift x3 left by 2 positions to multiply
                                // by 4 to get the correct address.
    ldr     w2,[x1,x3,lsl #2]

l14:
    ldr     w2,[x1,#(2 * 4)]!

    ldr     x2,=arr1
l15:
                                // Load x1 with the memory pointed to by x2
                                // Then do x2 = x2 + 2
    ldr     x1,[x2],#2

l16:
    ldr     x1,=myoctaword
    ldp     x2,x3,[x1]
    stp     x2,x3,[x1]

// Setup the parameters to exit the program
// and then call Linux to do it.
    mov     x0,#0               // Use 0 return code
    mov     x8,#93              // Service command code 93 terminates this program
    svc     0                   // Call linux to terminate the program
helloworld2:
    .ascii  "Hello World!"

.data
helloworld:
    .ascii  "Hello World!"
    .align  4
mynumber:
    .QUAD   0x123456789ABCDEF0
arr1:
    .FILL   10,4,0
myoctaword:
    .OCTA   0x12345678876543211234567887654321
