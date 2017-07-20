#include <stdio.h>

int main()
{
 __builtin_set_texasr(0xAAAAAAAAAAAAAAA);
 __builtin_set_tfhar(0xFFFFFFFFFFFFFFFF);
 __builtin_set_tfiar(0xCCCCCCCCCCCCCCCC);

 asm volatile (".long 0x0");
}
