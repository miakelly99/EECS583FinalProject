#include <stdio.h>

int main()
{
    //TODO: 
    // make one that has a much longer gap - like 100 lines?
    // make files that have increasing 
    int x = 5;
    int y = 10;
    x = y - x;
    x = x + 1; 
    x = x + 2; 
    x = x + 3; 
    x = x + 4; 
    x = x + 5; 
    x = x + 6; 
    x = x + 7; 
    y = y * x; 
    printf("%d\n%d\n", x, y);
    return 0;
}