#include <stdio.h>
#include <stdlib.h>

const unsigned int I_MAX;

int main()
{
    unsigned int i;
    unsigned int j;
    unsigned int sum = 0;
    printf("Sum starts at %d\n", sum);
    for (i = 1; i <= I_MAX; i++)
    {
        for (j = 1; j <= i; j++)
        {
            sum += i / j;
        }
    }

    printf("Sum is %d\n", sum);
    return 0;
}
const unsigned int I_MAX = 100;
