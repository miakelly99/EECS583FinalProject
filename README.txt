This system is designed to allow simulation of transient faults within code as a pass in LLVM IR.
Specifically, whenever data is loaded from memory, there is a possibility that it will become corrupted by bit flips, affecting both the loaded value and the underlying memory itself.
To use the program, you must use the "inject_env.txt" file located in the examples folder

The format is as follows:
0/1
template_file_name
0/1
import_file_name

where the first 0/1 represents whether to create a template file for the program (0 meaning no)
and the second 0/1 represents whether to load an injection schedule from a file (0 meaning no).

See examples/simple_example_inject.txt for an example of an injection schedule.
For each load instruction you want to add injections to, place injections in the following form after the ":" and make sure to include the parenthesis
(iteration bit_1 bit_2 ...)
where iteration represents which iteration of the instruction to execute the injection on. e.g. 1 means the first time it is executed, while 10 would mean the 10th time
and bit_1 bit_2 ... is the bit numbers you want to flip during that injection (1 meaning rightmost bit, 32 being leftmost bit).

For example, (1 4 2 1) would represent an injection on the first execution of the instruction that flips bits 4,2, and 1.

If an instruction should not have any faults attatched to it, simply put -1 to indicate that no faults are present.



Once you have set up the injection environment and potentially a test injection schedule, build and run the test by executing
    sh bnr.sh TEST

where TEST is the prefix of the file to test (e.g. "simple")
    e.g. sh bnr.sh simple
would test and transform the code in examples/src/simple.c

Once the pass is complete, the original code and the injected code will be executed and their results shown.