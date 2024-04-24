#include <stdio.h>

int main()
{
    int x = 5;
    int y = 7;
    int z = 10;
    x = y + x; // x = 12
    y = z * x; // y = 120
    z = y - x; // z = 108 
    y = y / x; // y = 10 
    x = x * x; // x = 144
    // Should print [144, 10, 108]
    printf("%d\n%d\n%d\n", x, y, z);
}