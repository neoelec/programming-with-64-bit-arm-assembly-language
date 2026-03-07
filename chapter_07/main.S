//
// Assembler program to convert a string to
// all upper case by calling a function.
//
// x0-x2, x8 - used by macros to call linux
// x11 - input file descriptor
// x9 - output file descriptor
// x10 - number of characters read
//

#include <asm/unistd.h>

#include "fileio.inc"

    .equ    BUFFERLEN,250

.global _start                  // Provide program starting address to linker

_start:
    openFile inFile,O_RDONLY
    adds    x11,XZR,x0          // save file descriptor
    b.pl    nxtfil              // pos number file opened ok
    mov     x1,#1               // stdout
    ldr     x2,=inpErrsz        // Error msg
    ldr     w2,[x2]
    writeFile x1,inpErr,x2      // print the error
    b       exit

nxtfil:
    openFile outFile,O_CREAT+O_WRONLY
    adds    x9,XZR,x0           // save file descriptor
    b.pl    loop                // pos number file opened ok
    mov     x1,#1
    ldr     x2,=outErrsz
    ldr     w2,[x2]
    writeFile x1,outErr,x2
    b       exit

// loop through file until done.
loop:
    readFile x11,buffer,BUFFERLEN
    mov     x10,x0              // Keep the length read
    mov     x1,#0               // Null terminator for string

                                // setup call to toupper and call function
    ldr     x0,=buffer          // first param for toupper
    strb    w1,[x0,x10]         // put null at end of string.
    ldr     x1,=outBuf
    bl      toupper

    writeFile x9,outBuf,x10

    cmp     x10,#BUFFERLEN
    b.eq    loop

    flushClose x11
    flushClose x9

// Setup the parameters to exit the program
// and then call Linux to do it.
exit:
    mov     x0,#0               // Use 0 return code
    mov     x8,#__NR_exit
    svc     0                   // Call Linux to terminate the program

.data
inFile:
    .asciz  "../main.S"
outFile:
    .asciz  "upper.txt"
buffer:
    .fill   BUFFERLEN + 1,1,0
outBuf:
    .fill   BUFFERLEN + 1,1,0
inpErr:
    .asciz  "Failed to open input file.\n"
inpErrsz:
    .word   .-inpErr
outErr:
    .asciz  "Failed to open output file.\n"
outErrsz:
    .word   .-outErr
