#include  <stdio.h>
#include  <add.h>
#include  <stdlib.h>

int main(int argc, char** argv)
{
    int a = 0, b = 0, sum = 0;
    a = atoi(argv[1]);
    b = atoi(argv[2]);

    sum = addNumbers(a,b);

    printf("Sum of %d and %d is %d\n",a,b,sum);
    return 0;
}