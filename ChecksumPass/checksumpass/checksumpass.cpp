#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Format.h"
#include "llvm/IR/IRBuilder.h"
#include  <iostream>

using namespace llvm;

namespace {

struct ChecksumPass : public PassInfoMixin<ChecksumPass> {

  Value* recomputeChecksum(Value* data, IRBuilder<>& builder) {

    ConstantInt* xorValue = builder.getInt32(0xff); // Example constant
    return builder.CreateXor(data, xorValue, "checksumXor");
  }

  void storeChecksum(Value* checksum, IRBuilder<>& builder) {
    // Assuming you have a specific location or a variable to store the checksum
    // Here we need a pointer to where we'll store it, which should be determined by the program's logic
    Module* M = builder.GetInsertBlock()->getModule();
    LLVMContext& Context = M->getContext();
    GlobalVariable* checksumStorage = new GlobalVariable(
        *M,                                  // Module where this global variable will be added
        Type::getInt32Ty(Context),           // Variable type, assuming int32 for this example
        false,                               // isConstant
        GlobalValue::ExternalLinkage,        // Linkage
        ConstantInt::get(Type::getInt32Ty(Context), 0), // Initializer
        "checksumStorage"                    // Variable name
    );
    builder.CreateStore(checksum, checksumStorage);
  }

  Value* retrieveChecksum(Instruction* loadInst, IRBuilder<>& builder) {
    // Assuming checksum is stored in a known location linked to data
    GlobalVariable* checksumStorage = builder.GetInsertBlock()->getModule()->getGlobalVariable("checksumStorage", true);
    return builder.CreateLoad(checksumStorage->getValueType(), checksumStorage, "loadChecksum");
  } 

  void compareChecksums(Value* storedChecksum, Value* computedChecksum, IRBuilder<>& builder) {
    // Create a comparison instruction
    if (storedChecksum && computedChecksum) {
      errs() << "Type of storedChecksum: ";
      storedChecksum->getType()->print(errs());
      errs() << "\nType of computedChecksum: ";
      computedChecksum->getType()->print(errs());
      errs() << "\n";
    } else {
      errs() << "Null value detected: storedChecksum or computedChecksum is nullptr\n";
    }

    Value* isEqual = builder.CreateICmpEQ(storedChecksum, computedChecksum, "checksumCompare");
    // You might want to add code to handle the case where checksums do not match
    // For example, you can insert a branch that leads to an error handling block
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
          if (auto *storeInst = dyn_cast<StoreInst>(&instr)) {

            // Get value
            Value *address_of_store = storeInst->getValueOperand(0);

            // Compute checksum
            Value *checksum = recomputeChecksum(storedValue, builder);

            // Store checksum
            storeChecksum(checksum, builder);

          }

          // Begin each each, verify checksum
          if (auto *loadInst = dyn_cast<LoadInst>(&instr)) {

            // For load instructions, retrieve the stored value
            Value *loadedValue = loadInst->getPointerOperand();

            // Retrieve the stored checksum
            Value *storedChecksum = retrieveChecksum(loadInst, builder);

            // Recompute checksum of the loaded value
            Value *recomputedChecksum = recomputeChecksum(loadedValue, builder);

            // Compare checksums
            compareChecksums(storedChecksum, recomputedChecksum, builder);

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
