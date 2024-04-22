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

struct InjectionPass : public PassInfoMixin<InjectionPass> {

  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {
  errs() << "running mod" << "\n";
	  for (Function &F: M.getFunctionList())
  {
	  errs() << F.getName() << "\n";
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
      errs() << *inst << "\n";
      /*
      GlobalVariable* inject_guard = new GlobalVariable(M, Type::getInt1Ty(F.getContext()), false, GlobalValue::CommonLinkage, nullptr);
      inject_guard->setAlignment(Align());
      ConstantInt* const_zero_val = ConstantInt::get(F.getContext(), APInt(1,0));
      inject_guard->setInitializer(const_zero_val);
      
      Instruction* true_block = llvm::SplitBlockAndInsertIfThen(M.getNamedValue(inject_guard->getName()), inst, false);
      Value* const_one_val = ConstantInt::get(F.getContext(), APInt(1,1));
      StoreInst* update_guard = new StoreInst(const_one_val, (Value*) inject_guard, true_block);
      */
      TypeSize type_size = TypeSize::getFixed(32); //M.getDataLayout().getTypeAllocSize(store_inst->getPointerOperand()->getType());
      int type_size_int = (int) type_size;
      int bit_to_flip = 0; //(rand() % type_size_int);
      int flip_value = (1 << bit_to_flip);
      ConstantInt* const_bit_flip = ConstantInt::get(F.getContext(), APInt(type_size_int, flip_value));
      errs() << *(store_inst->getValueOperand()) << "\n";
      errs() << *(store_inst->getPointerOperand()) << "\n";
      BinaryOperator* bin_op = BinaryOperator::Create(Instruction::Xor, store_inst->getValueOperand(), const_bit_flip, "", store_inst);
      errs() << *bin_op << "\n";
      StoreInst* new_store = new StoreInst(bin_op, store_inst->getPointerOperand(), store_inst);
      new_store->moveAfter(store_inst);
      store_inst->removeFromParent();
      break;
    }
  }
  return PreservedAnalyses::all();
}
};
}

extern "C" ::llvm::PassPluginLibraryInfo LLVM_ATTRIBUTE_WEAK llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "InjectionPass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, ModulePassManager &MPM,
        ArrayRef<PassBuilder::PipelineElement>) {
          if(Name == "inject"){
            MPM.addPass(InjectionPass());
            return true;
          }
          return false;
        }
      );
    }
  };
}
