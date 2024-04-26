#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
    const int I_MAX = stoi(argv[1]);
    int i;
    int j;
    int sum = 0;
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