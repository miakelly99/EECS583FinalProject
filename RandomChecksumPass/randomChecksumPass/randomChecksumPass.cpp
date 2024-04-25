#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Format.h"
#include <llvm/IR/DebugLoc.h>
#include <llvm/IR/DebugInfo.h>
#include <llvm/IR/DebugInfoMetadata.h>

#include  <iostream>

using namespace llvm;

namespace {

struct RandomChecksumPass : public PassInfoMixin<RandomChecksumPass> {
  std::map<Value*, int> checksums;

  int computeChecksum(Value *val) {
    int checksum = 0;
    if (auto *constInt = dyn_cast<ConstantInt>(val)) {
        // If the value is a constant integer (which should be)
        checksum = constInt->getZExtValue();
    } else if (auto *arg = dyn_cast<Argument>(val)) {
        checksum = reinterpret_cast<std::uintptr_t>(arg);
    }
    return checksum;
  }

  void storeChecksum(int checksum, Value *value) {
    checksums[value] = checksum;
  }

  int getInstLineNumber(Instruction *instruction){
    //Return the line number for an instruction

    // Retrieve the debug location for the instruction, if available
    const DebugLoc &debugLoc = instruction->getDebugLoc();
    if (debugLoc) {
        // Get the line number
        return debugLoc.getLine();
    }
    //Return -1 if there isn't debug info for the instruction
    return -1;
  }

  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {

    // loop through functions in module
    for (Function &F: M.getFunctionList()) {

      // loop through basic blocks in function
      for (BasicBlock &block : F) {

        // loop through instructions in basic block
        for (Instruction &instr : block) {

          instr.print(errs());
          errs() << "\n";

          errs() << "Line number: " << getInstLineNumber(&instr) << "\n";

          // After each store, recompute checksum
          if (StoreInst *storeInst = dyn_cast<StoreInst>(&instr)) {

            // Compute info
            Value *storedValue = storeInst->getOperand(0);
            Value *storeLocation = storeInst->getPointerOperand();

            // Compute checksum 
            int checksum = computeChecksum(storedValue);
            // Store checksum
            checksums[storeLocation] = checksum;

            // Get all the loads that use this store's value
            for (auto *U : instr.users()) {
              errs() << "USER: " << U << "\n";
              // Cast the user to Instruction, if possible
              if (auto *UserInst = dyn_cast<Instruction>(U)) {
                errs() << "Instruction ";
                instr.print(errs());
                errs() << " is used in instruction ";
                UserInst->print(errs());
                errs() << "\n";
              }
              else{
                errs() << "NOT AN INSTRUCTION\n";
              }
            }
            
          }

          // Begin each each, verify checksum
          if (LoadInst *loadInst = dyn_cast<LoadInst>(&instr)) {

            Value *loadedValue = loadInst->getPointerOperand();

            auto it = checksums.find(loadedValue);
            if (it != checksums.end()) {
                int storedChecksum = it->second;

                // NEED TO FIX
                int currentChecksum = 0;

                // Print the checksum values for comparison
                errs() << "Load Instruction";
                errs() << " | Stored Checksum: " << storedChecksum << " | Current Checksum: " << currentChecksum << "\n";

                if (currentChecksum != storedChecksum) {
                    errs() << "Checksum mismatch detected. Potential data corruption.\n";
                }
            } else {
                errs() << "No checksum recorded for loaded value.\n";
            }

          }
        }
      }
  }
    return PreservedAnalyses::all();
  }
};
}

extern "C" ::llvm::PassPluginLibraryInfo LLVM_ATTRIBUTE_WEAK llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "RandomChecksumPass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, ModulePassManager &MPM,
        ArrayRef<PassBuilder::PipelineElement>) {
          if(Name == "randomChecksum"){
            MPM.addPass(RandomChecksumPass());
            return true;
          }
          return false;
        }
      );
    }
  };
}
