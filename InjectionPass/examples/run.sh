# ACTION REQUIRED: Ensure that the path to the library and pass name are correct.
PATH2LIB="../injectionpass/InjectionPass.so"
PASS=inject

BENCH=src/${1}.c

clang -emit-llvm -c ${BENCH} -Xclang -disable-O0-optnone -o ${1}.bc

opt -load-pass-plugin="${PATH2LIB}" -passes="${PASS}" ${1}.bc -o ${1}_injected.bc > /dev/null

clang ${1}.bc -o ${1}_no_inject
clang ${1}_injected.bc -o ${1}_inject

echo "Output of original program\n"
if ./${1}_no_inject; then
    echo "-------------------------"
    echo "No transient faults detected :)"
else
    echo "-------------------------"
    echo "Error! Transient faults detected"
fi

echo "Output of fault-injected program\n"
if ./${1}_inject; then
    echo "-------------------------"
    echo "No transient faults detected :)"
else
    echo "-------------------------"
    echo "Error! Transient faults detected"
fi

rm ${1}.bc ${1}_injected.bc ${1}_no_inject ${1}_inject