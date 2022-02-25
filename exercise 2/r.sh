#!/bin/bash

#Program to find drop of an object in seconds
#Author: Christian Sanchez

#Delete some uneeded files
rm *.o
rm *.out

echo "Bash: The script file for drop seconds has begun"

echo "Bash: Assemble drop.asm"
nasm -f elf64 -o drop.o drop2.asm

echo "Bash: Compile testmodule.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o drive.o testmodule.cpp -std=c++17

echo "Bash: Compile verifyFloat.cpp using g++ 2017"
g++ -c -Wall -m64 -no-pie -fno-pie -o verifyFloat.o verifyFloat.cpp

echo "Bash: Link the object files"
g++ -m64 -fno-pie -no-pie -o code.out -std=c++17 drop.o drive.o verifyFloat.o -std=c++17

echo "Bash: Run the program Drop in Seconds and tee it into output.txt"
./code.out > output.txt | tee

echo "Bash: The script file will now terminate"



