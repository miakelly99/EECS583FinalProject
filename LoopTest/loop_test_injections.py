MAX_INJECTIONS = 1000
MIN_INJECTIONS = 1
TOTAL_INJECTION_TESTS = 50
TESTS_PER_INJECTION_NUM = 100
ITERATIONS = 100

TOTAL_ITERATIONS = (ITERATIONS * (ITERATIONS + 1)) // 2

INJECT_LINE = 101

from sys import argv
import time
import os
import random

PATH_TO_CHECKSUM_PASS = "../ChecksumPass/checksumpass/ChecksumPass.so"
CHECKSUM_PASS = "checksum"

PATH_TO_INJECTION_PASS = "../InjectionPass/injectionpass/InjectionPass.so"
INJECTION_PASS = "inject"

def main():
    os.system("mkdir -p tmp")

    os.system("cp loop.c tmp/loop_copy.c")
    with open("tmp/loop_copy.c", "a") as loop_file:
        loop_file.write(f"\nconst unsigned int I_MAX = {ITERATIONS};\n")

    os.system("clang -emit-llvm -c tmp/loop_copy.c -Xclang -disable-O0-optnone -o tmp/loop.bc")
    os.system(f"opt -load-pass-plugin=\"{PATH_TO_CHECKSUM_PASS}\" -passes=\"{CHECKSUM_PASS}\" tmp/loop.bc -o tmp/loop_checksum.bc > /dev/null")
    os.system("clang tmp/loop.bc -o tmp/loop.out")

    with open("loop_inject.txt", "r") as injection_base:
        injection_map_contents = injection_base.read()
    
    with open(argv[1], 'w') as data_file:
        data_file.write("Total Injections, Same Output % (No Checksums), Injection Detected % (Checksums) \n")
        for i in range(0, TOTAL_INJECTION_TESTS):
            injection_num = int(MIN_INJECTIONS + i * (MAX_INJECTIONS - MIN_INJECTIONS) / (TOTAL_INJECTION_TESTS - 1))
            same_output = 0
            checksum_finds = 0
            for j in range(0, TESTS_PER_INJECTION_NUM):
                os.system("cp loop_inject.txt tmp/loop_inject_copy.txt")
                injection_text = ""
                iterations = random.sample(range(1, TOTAL_ITERATIONS + 1), injection_num)
                for iteration in iterations:
                   bit = random.randrange(1, 32 + 1)
                   injection_text = injection_text +  f"({INJECT_LINE} {iteration} {bit}) "
                
                inserted_injection_map_contents = injection_map_contents.replace("INSERT", injection_text)

                with open("tmp/loop_inject.txt", "w") as new_inject:
                    new_inject.write(inserted_injection_map_contents)

                os.system(f"opt -load-pass-plugin=\"{PATH_TO_INJECTION_PASS}\" -passes=\"{INJECTION_PASS}\" tmp/loop_checksum.bc -o tmp/loop_checksum_injected.bc")
                os.system("clang tmp/loop_checksum_injected.bc -o tmp/loop_checksum_injected.out")
                
                checksum_res = os.system(f"./tmp/loop_checksum_injected.out > tmp/loop_checksum_injected_output.txt")
                if checksum_res != 0:
                    checksum_finds += 1

                os.system(f"./tmp/loop.out > tmp/loop_output.txt")

                with open("tmp/loop_output.txt", "r") as no_inject_res_file:
                    with open("tmp/loop_checksum_injected_output.txt", "r") as checksum_inject_res_file:
                        no_inject_res = no_inject_res_file.read()
                        checksum_inject_res = checksum_inject_res_file.read()
                        if (no_inject_res == checksum_inject_res):
                            same_output += 1
                
            prct_same_output = 100 * same_output / TESTS_PER_INJECTION_NUM
            prct_caught_error = 100 * checksum_finds / TESTS_PER_INJECTION_NUM

            data_file.write(f"{injection_num}, {prct_same_output:.2f}, {prct_caught_error:.2f}\n")
            if (i == 1 * TOTAL_INJECTION_TESTS // 10): print("10% of tests complete")
            if (i == 2 * TOTAL_INJECTION_TESTS // 10): print("20% of tests complete")
            if (i == 3 * TOTAL_INJECTION_TESTS // 10): print("30% of tests complete")
            if (i == 4 * TOTAL_INJECTION_TESTS // 10): print("40% of tests complete")
            if (i == 5 * TOTAL_INJECTION_TESTS // 10): print("50% of tests complete")
            if (i == 6 * TOTAL_INJECTION_TESTS // 10): print("60% of tests complete")
            if (i == 7 * TOTAL_INJECTION_TESTS // 10): print("70% of tests complete")
            if (i == 8 * TOTAL_INJECTION_TESTS // 10): print("80% of tests complete")
            if (i == 9 * TOTAL_INJECTION_TESTS // 10): print("90% of tests complete")

    #os.system("rm tmp/*")

if __name__ == "__main__":
    main()