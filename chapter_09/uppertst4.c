/*
 * C program to embed our Assembly
 * toupper routine inline.
 */

#include <stdio.h>

int mytoupper(char *str, char *outBuf)
{
    int len;

    __asm__ volatile("mov     x4,%2\n"
                     "loop:\n"
                     "ldrb    w5,[%1],#1\n"
                     "cmp     w5,#'z'\n"
                     "b.gt    cont\n"
                     "cmp     w5,#'a'\n"
                     "b.lt    cont\n"
                     "sub     w5,w5,#('a'-'A')\n"
                     "cont:\n"
                     "strb    w5,[%2],#1\n"
                     "cmp     w5,#0\n"
                     "b.ne    loop\n"
                     "sub     %0,%2,x4\n"
                     : "=r"(len)
                     : "r"(str), "r"(outBuf)
                     : "x4", "x5");

    return len;
}

#define MAX_BUFFSIZE 255

int main(void)
{
    char *str = "This is a test.";
    char outBuf[MAX_BUFFSIZE];
    int len;

    len = mytoupper(str, outBuf);
    printf("Before str: %s\n", str);
    printf("After str: %s\n", outBuf);
    printf("Str len = %d\n", len);

    return 0;
}
