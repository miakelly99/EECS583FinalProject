# ACTION REQUIRED: Ensure that the path to the library and pass name are correct.
PATH2LIB="../build/hw1pass/HW1Pass.so"
PASS=hw1

BENCH=src/${1}.c

clang -S -emit-llvm ${BENCH} -o ${1}.ll

opt --disable-output -load-pass-plugin="${PATH2LIB}" -passes="${PASS}" ${1}.ll

rm ${1}.ll