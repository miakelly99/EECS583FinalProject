#include <stdio.h>
#include <stdlib.h>

int main()
{
    int i;
    int j;
    int sum = 0;
    for (i = 1; i <= 3; i++)
    {
        for (j = 1; j <= i; j++)
        {
            sum += i * j;
        }
    }

    printf("Sum is %d\n", sum);
    return 0;
}