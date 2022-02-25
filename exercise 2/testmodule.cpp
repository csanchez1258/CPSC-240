#include <iostream>
extern "C" long int testmodule();
int main(int argc, char* argv[])
{
        printf("\nWelcome to Gravitational Attraction maintained by Christian Sanchez.\n");
        printf("This program was last updated on February 24, 2022");
        long int code = -99;
        code = testmodule();
        printf("\nThe driver module recieved this integer: %ld\n", code);
        printf("End of demonstration test.\n");
        return 0;
}
