#include "llvm/IR/CFG.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"

#include  <iostream>
#include  <list>

using namespace llvm;

namespace {

struct HW1Pass : public PassInfoMixin<HW1Pass> {

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    // These variables contain the results of some analysis passes.
    // Go through the documentation to see how they can be used.

    std::list<StoreInst*> store_insts;
    for (BasicBlock& BB: F)
    {
      for (const Instruction &inst: BB)
	    {

        Value* V = (Value*) &inst;
        if (StoreInst* store_inst = dyn_cast<StoreInst>(V))
        {
          store_insts.push_back(store_inst);
        }
      }
    }
    for (StoreInst* store_inst: store_insts)
    {
      Instruction* inst = (Instruction*) store_inst;
      GlobalVariable* inject_guard = new GlobalVariable(Type::getInt1Ty(F.getContext()), false, GlobalValue::CommonLinkage);
      inject_guard->setAlignment(Align());
      ConstantInt* const_zero_val = ConstantInt::get(F.getContext(), APInt(1,0));
      inject_guard->setInitializer(const_zero_val);

      Instruction* true_block = llvm::SplitBlockAndInsertIfThen(inject_guard, inst, false);
      Value* const_one_val = ConstantInt::get(F.getContext(), APInt(1,1));
      StoreInst* update_guard = new StoreInst(const_one_val, (Value*) inject_guard, true_block);
    }

    return PreservedAnalyses::all();
  }
};
}

extern "C" ::llvm::PassPluginLibraryInfo LLVM_ATTRIBUTE_WEAK llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "HW1Pass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
        ArrayRef<PassBuilder::PipelineElement>) {
          if(Name == "hw1"){
            FPM.addPass(HW1Pass());
            return true;
          }
          return false;
        }
      );
    }
  };
}