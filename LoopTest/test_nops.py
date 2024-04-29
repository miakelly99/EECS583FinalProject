MAX_GAP = 100
MIN_GAP = 5
TOTAL_GAP_TESTS = 20
TESTS_PER_GAP_NUM = 500

from sys import argv
import time
import os
import random
import re

PATH_TO_CHECKSUM_PASS = "../ChecksumPass/checksumpass/ChecksumPass.so"
CHECKSUM_PASS = "checksum"

PATH_TO_INJECTION_PASS = "../InjectionPass/injectionpass/InjectionPass.so"
INJECTION_PASS = "inject"

FIRST_LINE_NO_NOP = 55
LAST_LINE_NO_NOP = 380

def main():
    os.system("mkdir -p tmp")

    os.system("cp gap.c tmp/gap_copy.c")

    os.system("clang -emit-llvm -c tmp/gap_copy.c -Xclang -disable-O0-optnone -o tmp/gap.bc")
    
    with open("checksum_env.txt", "w") as env_file:
        env_file.write("0\n0\n")
 
    os.system(f"opt -load-pass-plugin=\"{PATH_TO_CHECKSUM_PASS}\" -passes=\"{CHECKSUM_PASS}\" tmp/gap.bc -o tmp/gaps_no_nops.bc > /dev/null")

    with open("gaps_no_nops_template.txt", "r") as fp:
        injection_map_contents = fp.read()
        a_injection_map_contents_split = injection_map_contents.split("\n")
    
    with open(argv[1], 'w') as data_file:
        data_file.write("Minimum Gap, Injections Caught % (No NOPs), Injections Caught % (NOPs), Instruction Count (No NOPs), Instruction Count (NOPs)\n")
        for i in range(0, TOTAL_GAP_TESTS):
            gap_num = int(MIN_GAP + i * (MAX_GAP - MIN_GAP) / (TOTAL_GAP_TESTS - 1))

            no_nop_detections = 0
            nop_detections = 0

            no_nop_time = 0
            nop_time = 0
            
            with open("checksum_env.txt", "w") as env_file:
                env_file.write(f"1\n{gap_num}\n")
            
            os.system(f"opt -load-pass-plugin=\"{PATH_TO_CHECKSUM_PASS}\" -passes=\"{CHECKSUM_PASS}\" tmp/gap.bc -o tmp/gaps_nops.bc > /dev/null")

            with open("inject_env.txt", "w") as inject_env:
                inject_env.write("1\ntmp/gaps_nops_template.txt\n0\ntmp/gaps_nops_injected.txt\n")
                
            os.system(f"opt -load-pass-plugin=\"{PATH_TO_INJECTION_PASS}\" -passes=\"{INJECTION_PASS}\" tmp/gaps_nops.bc -o tmp/gaps_nops_injected.bc")

            for j in range(0, TESTS_PER_GAP_NUM):
                injection_text = ""

                first_loc = random.randrange(FIRST_LINE_NO_NOP, LAST_LINE_NO_NOP)
                second_loc = random.randrange(first_loc + 1, LAST_LINE_NO_NOP + 1)
                #first_loc = 55
                #second_loc = 56
                #print(first_loc)
                #print(second_loc)
                injection_text = injection_text + f"({first_loc} 1 1) "
                injection_text = injection_text + f"({second_loc} 1 1) "
                #injection_text = "-1"
                
                inserted_injection_map_contents = injection_map_contents.replace("INSERT", injection_text)

                with open("tmp/gaps_no_nop_injected.txt", "w") as new_inject:
                    new_inject.write(inserted_injection_map_contents)
                
                with open("inject_env.txt", "w") as inject_env:
                    inject_env.write("0\ntemplate.txt\n1\ntmp/gaps_no_nop_injected.txt\n")

                os.system(f"opt -load-pass-plugin=\"{PATH_TO_INJECTION_PASS}\" -passes=\"{INJECTION_PASS}\" tmp/gaps_no_nops.bc -o tmp/gaps_no_nops_injected.bc")
                os.system("clang tmp/gaps_no_nops_injected.bc -o tmp/gaps_no_nops_injected.out")
                #os.system("clang tmp/gaps_nops.bc -o tmp/gaps_no_nops_injected.out")

                start_time = time.time()
                no_nop = os.system("./tmp/gaps_no_nops_injected.out > /dev/null")
                end_time = time.time()
                no_nop_time = no_nop_time + (end_time - start_time)
                if no_nop != 0:
                    no_nop_detections += 1

                with open("tmp/gaps_nops_template.txt", "r") as nop_template_file:
                    inserted_injection_map_contents = nop_template_file.read()
                    inserted_injection_map_contents_split = inserted_injection_map_contents.split("\n")

                line_num = 0
                first_line_num = 0
                last_line_num = 0
                for line in inserted_injection_map_contents_split:
                    line_num = line_num + 1
                    if "load i32, i32* %3" in line:
                        last_line_num = line_num
                        if first_line_num == 0:
                            first_line_num = line_num

                injection_text = ""

                first_loc = random.randrange(first_line_num + 1, last_line_num + 7)
                second_loc = random.randrange(first_loc + 1, last_line_num + 8)
                
                injection_text = injection_text + f"({first_loc} 1 1) "
                injection_text = injection_text + f"({second_loc} 1 1) "

                inserted_injection_map_contents_split[first_line_num - 1] = inserted_injection_map_contents_split[first_line_num - 1][:-2] + injection_text

                injection_contents_connected = "\n".join(inserted_injection_map_contents_split)
                with open ("tmp/gaps_nops_injected.txt", "w") as fp:
                    fp.write(injection_contents_connected)

                with open("inject_env.txt", "w") as inject_env:
                    inject_env.write("0\ntmp/gaps_nops_template.txt\n1\ntmp/gaps_nops_injected.txt\n")

                os.system(f"opt -load-pass-plugin=\"{PATH_TO_INJECTION_PASS}\" -passes=\"{INJECTION_PASS}\" tmp/gaps_nops.bc -o tmp/gaps_nops_injected.bc")
                os.system("clang tmp/gaps_nops_injected.bc -o tmp/gaps_nops_injected.out")

                start_time = time.time()
                nop = os.system("./tmp/gaps_nops_injected.out > /dev/null")
                end_time = time.time()
                nop_time = nop_time + (end_time - start_time)
                if nop != 0:
                    nop_detections += 1
                    #print("fault found")
                else:
                    #print("no fault found")
                    a = 1
                
            no_nop_prct_detexts = 100 * no_nop_detections / TESTS_PER_GAP_NUM
            no_nop_avg_time = no_nop_time / TESTS_PER_GAP_NUM

            nop_prct_detexts = 100 * nop_detections / TESTS_PER_GAP_NUM
            nop_avg_time = nop_time / TESTS_PER_GAP_NUM

            data_file.write(f"{gap_num}, {no_nop_prct_detexts:.2f}, {nop_prct_detexts:.2f}, {len(a_injection_map_contents_split)}, {len(inserted_injection_map_contents_split)}\n")
            print(f"{gap_num}, {no_nop_prct_detexts:.2f}, {nop_prct_detexts:.2f}, {len(a_injection_map_contents_split)}, {len(inserted_injection_map_contents_split)}\n")
            if (i == 1 * TOTAL_GAP_TESTS // 10): print("10% of tests complete")
            if (i == 2 * TOTAL_GAP_TESTS // 10): print("20% of tests complete")
            if (i == 3 * TOTAL_GAP_TESTS // 10): print("30% of tests complete")
            if (i == 4 * TOTAL_GAP_TESTS // 10): print("40% of tests complete")
            if (i == 5 * TOTAL_GAP_TESTS // 10): print("50% of tests complete")
            if (i == 6 * TOTAL_GAP_TESTS // 10): print("60% of tests complete")
            if (i == 7 * TOTAL_GAP_TESTS // 10): print("70% of tests complete")
            if (i == 8 * TOTAL_GAP_TESTS // 10): print("80% of tests complete")
            if (i == 9 * TOTAL_GAP_TESTS // 10): print("90% of tests complete")

    #os.system("rm tmp/*")

if __name__ == "__main__":
    main()