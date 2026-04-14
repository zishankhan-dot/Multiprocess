#!/bin/bash 
mkdir -p ./results

TARGET="${1:-}"
case "$TARGET" in 
    java)
        /usr/bin/time -v javac ./codes/Multiprocessing.java 2>&1 | tee ./results/compilation_java.txt
        ;;
    java-virtual)
        /usr/bin/time -v javac ./codes/Multiprocessing_Virtual.java 2>&1 | tee ./results/execution_java_virtual.txt
        ;;
    cpp)
        g++  ./codes/Multiprocessing.cpp -o ./codes/Multiprocessing_c++ 
        /usr/bin/time -v ./codes/Multiprocessing_c++ 2>&1 | tee ./results/execution_cpp.txt
        ;;
    c)
        gcc  ./codes/Multiprocessing.c  -o ./codes/Multiprocessing_c 
        /usr/bin/time -v ./codes/Multiprocessing_c 2>&1 | tee ./results/execution_c.txt
        ;;
    python)
        /usr/bin/time -v python3 ./codes/Multiprocessing.py 2>&1 | tee ./results/execution_python.txt
        ;;
    *)
        echo "Unknown benchmark target: $TARGET"
        exit 1
        ;;
esac
