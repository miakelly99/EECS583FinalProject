#!/bin/bash
# Run script for Homework 1 EECS 583 Winter 2024
# Place this script inside the benchmark directory. e.g. benchmark1/run.sh
# Usage: sh run.sh <benchmark_name>
# where <benchmark_name> = simple OR anagram OR compress

# ACTION REQUIRED: Ensure that the path to the library and pass name are correct.
PATH2LIB="../checksumpass/ChecksumPass.so"
PASS=checksum

BENCH=src/${1}.c

clang -emit-llvm -c ${BENCH} -Xclang -disable-O0-optnone -o ${1}.bc

opt -load-pass-plugin="${PATH2LIB}" -passes="${PASS}" ${1}.bc -o ${1}_checksum.bc > /dev/null

clang ${1}.bc -o ${1}_no_checksum
clang ${1}_checksum.bc -o ${1}_checksum

echo "Output of original program\n"
./${1}_no_checksum

echo "Output of checksummed program\n"
if ./${1}_checksum; then
    echo "-------------------------"
    echo "No transient faults detected :)"
else
    echo "-------------------------"
    echo "Error! Transient faults detected"
fi

rm ${1}.bc ${1}_checksum ${1}_no_checksum