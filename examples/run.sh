# ACTION REQUIRED: Ensure that the path to the library and pass name are correct.
PATH2LIB="../injectionpass/InjectionPass.so"
PASS=inject

BENCH=src/${1}.c

clang -emit-llvm -c ${BENCH} -Xclang -disable-O0-optnone -o ${1}.bc

opt -load-pass-plugin="${PATH2LIB}" -passes="${PASS}" ${1}.bc -o ${1}_injected.bc > /dev/null

clang ${1}.bc -o ${1}_no_inject
clang ${1}_injected.bc -o ${1}_inject

echo "Output of original program\n"
./${1}_no_inject

echo "Output of fault-injected program\n"
./${1}_inject

rm ${1}.bc ${1}_injected.bc ${1}_no_inject ${1}_inject