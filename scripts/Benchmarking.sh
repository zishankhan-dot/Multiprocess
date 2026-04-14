#!/bin/bash 
mkdir -p ./results
/usr/bin/time -v javac ./codes/Multiprocessing.java 2>&1 | tee ./results/compilation_java.txt
g++  ./codes/Multiprocessing.cpp -o ./codes/Multiprocessing_c++ 
/usr/bin/time -v ./codes/Multiprocessing_c++ 2>&1 | tee ./results/execution_cpp.txt
gcc  ./codes/Multiprocessing.c  -o ./codes/Multiprocessing_c 
/usr/bin/time -v ./codes/Multiprocessing_c 2>&1 | tee ./results/execution_c.txt
/usr/bin/time -v python3 ./codes/Multiprocessing.py 2>&1 | tee ./results/execution_python.txt
