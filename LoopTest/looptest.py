MAX_ITERS = 100000
MIN_ITERS = 1000
TOTAL_TESTS = 100

from sys import argv
import time
import os

PATH_TO_CHECKSUM_PASS = "../ChecksumPass/checksumpass/ChecksumPass.so"
CHECKSUM_PASS = "checksum"

PATH_TO_INJECTION_PASS = "../InjectionPass/injectionpass/InjectionPass.so"
INJECTION_PASS = "inject"

def main():
    os.system("mkdir -p tmp")
    
    with open(argv[1], 'w') as data_file:
        data_file.write("Iteration number, No Checksum Time (s), Checksum Time (s)\n")
        for i in range(0, TOTAL_TESTS):
            iteration_num = int(MIN_ITERS + i * (MAX_ITERS - MIN_ITERS) / (TOTAL_TESTS - 1))

            os.system("cp loop.c tmp/loop_copy.c")
            with open("tmp/loop_copy.c", "a") as loop_file:
                loop_file.write(f"\nconst unsigned int I_MAX = {iteration_num};\n")
            
            os.system("clang -emit-llvm -c tmp/loop_copy.c -Xclang -disable-O0-optnone -o tmp/loop.bc")
            os.system(f"opt -load-pass-plugin=\"{PATH_TO_CHECKSUM_PASS}\" -passes=\"{CHECKSUM_PASS}\" tmp/loop.bc -o tmp/loop_checksum.bc > /dev/null")
            os.system("clang tmp/loop.bc -o tmp/loop.out")
            os.system("clang tmp/loop_checksum.bc -o tmp/loop_checksum.out")
            
            base_start_time = time.time()
            os.system(f"./tmp/loop.out {iteration_num} > /dev/null")
            base_end_time = time.time()
            base_duration = base_end_time - base_start_time

            checksum_start_time = time.time()
            os.system(f"./tmp/loop_checksum.out {iteration_num} > /dev/null")
            checksum_end_time = time.time()
            checksum_duration = checksum_end_time - checksum_start_time

            data_file.write(f"{iteration_num}, {base_duration:.3f}, {checksum_duration:.3f}\n")
            if (i == 1 * TOTAL_TESTS // 10): print("10% of tests complete")
            if (i == 2 * TOTAL_TESTS // 10): print("20% of tests complete")
            if (i == 3 * TOTAL_TESTS // 10): print("30% of tests complete")
            if (i == 4 * TOTAL_TESTS // 10): print("40% of tests complete")
            if (i == 5 * TOTAL_TESTS // 10): print("50% of tests complete")
            if (i == 6 * TOTAL_TESTS // 10): print("60% of tests complete")
            if (i == 7 * TOTAL_TESTS // 10): print("70% of tests complete")
            if (i == 8 * TOTAL_TESTS // 10): print("80% of tests complete")
            if (i == 9 * TOTAL_TESTS // 10): print("90% of tests complete")

            os.system("rm tmp/*")
    
    


if __name__ == "__main__":
    main()