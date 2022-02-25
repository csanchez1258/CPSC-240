#!/bin/bash

#Program to find drop of an object in seconds
#Author: Christian Sanchez

#Delete some uneeded files
rm *.o
rm *.out

echo "Bash: The script file for drop seconds has begun"

echo "Bash: Assemble drop.asm"
nasm -f elf64 -o drop.o drop1.asm

echo "Bash: Compile testmodule.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o drive.o testmodule.cpp -std=c++17

echo "Bash: Link the object files"
g++ -m64 -fno-pie -no-pie -o code.out -std=c++17 drop.o drive.o

echo "Bash: Run the program Drop in Seconds"
./code.out

echo "The script file will now terminate"
