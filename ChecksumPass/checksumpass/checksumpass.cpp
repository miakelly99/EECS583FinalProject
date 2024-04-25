#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Format.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include  <iostream>
#include <map>

using namespace llvm;

namespace {

struct ChecksumPass : public PassInfoMixin<ChecksumPass> {

  std::map<Value*, int> checksums;

  int recomputeChecksum(StoreInst *storeInst) {

  }

  void storeChecksum(int checksum) {
    // Assuming you have a specific location or a variable to store the checksum
    // Here we need a pointer to where we'll store it, which should be determined by the program's logic
    
  }


  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {

    // loop through functions in module
    for (Function &F: M.getFunctionList()) {

      // loop through basic blocks in function
      for (BasicBlock &block : F) {

        // loop through instructions in basic block
        for (Instruction &instr : block) {
          
          // Instruction builder at current instruction
          IRBuilder<> builder(&instr);

          // Print each instruction for debugging
          instr.print(llvm::outs());
          errs() << "\n";

          // After each store, recompute checksum
          if (StoreInst *storeInst = dyn_cast<StoreInst>(&instr)) {

            // Compute checksum

            // Store checksum

            // Get the value being stored, which is the first operand in a StoreInst
            llvm::Value* storedValue = storeInst->getOperand(0); // Value to be stored
            llvm::Value* pointerOperand = storeInst->getOperand(1); // Pointer to the memory location

            // Print the value being stored using LLVM's raw_ostream
            llvm::errs() << "Stored Value: ";
            storedValue->print(llvm::errs());
            llvm::errs() << "\n";

            // Print the pointer operand
            llvm::errs() << "Pointer Operand: ";
            pointerOperand->print(llvm::errs());
            llvm::errs() << "\n";

          }

          // Begin each each, verify checksum
          if (LoadInst *loadInst = dyn_cast<LoadInst>(&instr)) {
            llvm::Value* pointerOperand = loadInst->getPointerOperand();

            // Print it using LLVM's raw_ostream
            llvm::errs() << "Pointer Operand: ";
            pointerOperand->print(llvm::errs());
            llvm::errs() << "\n";

            // retrieve checksum

            // compute checksum for current value

            // compare the two

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
    LLVM_PLUGIN_API_VERSION, "ChecksumPass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, ModulePassManager &MPM,
        ArrayRef<PassBuilder::PipelineElement>) {
          if(Name == "checksum"){
            MPM.addPass(ChecksumPass());
            return true;
          }
          return false;
        }
      );
    }
  };
}
