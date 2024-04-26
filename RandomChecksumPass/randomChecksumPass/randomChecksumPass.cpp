#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Format.h"
#include <llvm/IR/Instruction.h>
#include <llvm/IR/BasicBlock.h>
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include <llvm/IR/Function.h>
#include <iostream>
#include <queue>
#include <unordered_map>
#include <unordered_set>
#include <stack>

#include  <iostream>

using namespace llvm;

namespace {

struct RandomChecksumPass : public PassInfoMixin<RandomChecksumPass> {

  // This variable is the number of IR lines needed between 2 instructions accessing the same 
  // memory location before we insert a NOP checksum between them
  int MINIMUM_LINE_GAP = 20;

  
  int calculateDistanceBetweenInstructions(Instruction *instr1, Instruction *instr2) {
    // Return distance where instructions are in the same basic block
    int distance = 0;
    for (auto it = instr1->getIterator(); it != instr2->getIterator(); ++it) {
        ++distance;
    }
    return distance;
  }

  Instruction* getInstructionDistanceAway(Instruction *instr, int distance){
    // Return the instruction that is "distance" lines from instr
    // This depends on there being at least distance instructions left in current BB
    int current_distance = 0;
    Instruction *curr_instr = instr;
    while (current_distance < distance){
      curr_instr = curr_instr->getNextNode();
      current_distance++;
    }
    return curr_instr;
  }

  std::list<Instruction*> getNOPChecksumInsertionLocations(AllocaInst *allocaInst, int minimum_line_gap, bool verbose=false){
    // List of pointers to instructions where we need to insert a checksum
    std::list<Instruction*> outputInstructions;

    Instruction *prevInst = nullptr;

    for (Use& use: allocaInst->uses()){

      if (Instruction* inst = dyn_cast<Instruction>(use.getUser()))
      {
        if (LoadInst* load_inst = dyn_cast<LoadInst>(inst))
        {
          if (allocaInst != load_inst->getPointerOperand()) { continue; }
          //If there was a previous use, compare to see if we need to inject another check
          if (prevInst){
            int distance = calculateDistanceBetweenInstructions(inst, prevInst);
            // errs() << "DISTANCE = " << distance << "\n";
            if (distance >= MINIMUM_LINE_GAP){
              // Grab instruction from halfway point between the 2 instructions
              Instruction *halfway_inst = getInstructionDistanceAway(inst, distance / 2);
              outputInstructions.push_back(halfway_inst);
              // errs() << "INJECT CHECK BETWEEN ";
              // inst->print(errs());
              // errs() << " AND ";
              // prevInst->print(errs());
              // errs() << "\n";
            }
          }
        }
        else if (StoreInst* store_inst = dyn_cast<StoreInst>(inst))
        {
          if (allocaInst != store_inst->getPointerOperand()) { continue; }
            if (prevInst) {
              int distance = calculateDistanceBetweenInstructions(inst, prevInst);

              if (distance >= MINIMUM_LINE_GAP){
                // Grab instruction from halfway point between the 2 instructions
                Instruction *halfway_inst = getInstructionDistanceAway(inst, distance / 2);
                outputInstructions.push_back(halfway_inst);
                // errs() << "INJECT CHECK BETWEEN ";
                // inst->print(errs());
                // errs() << " AND ";
                // prevInst->print(errs());
                // errs() << "\n";
              }
            }
        }
        prevInst = inst;
      }
    }      
    if (verbose) {
      for (auto inst : outputInstructions){
        errs() << "INSERTED LINE: ";
        inst->print(errs());
        errs() << "\n";
      }
    }
    return outputInstructions;
  }
  
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {
    // loop through functions in module
    for (Function &F: M.getFunctionList()) {
          
      std::list<AllocaInst*> alloca_insts;
      ReturnInst* ret = nullptr;

      // loop through basic blocks in function
      for (BasicBlock &block : F) {

        // loop through instructions in basic block
        for (Instruction &instr : block) {

          // Begin each each, verify checksum
          if (AllocaInst *allocaInst = dyn_cast<AllocaInst>(&instr)) {
            alloca_insts.push_back(allocaInst);
          }
          else if (ReturnInst* ret_inst = dyn_cast<ReturnInst>(&instr)) {
            ret = ret_inst;
          }
        }
      }
      for (AllocaInst* allocaInst: alloca_insts)
      {
        getNOPChecksumInsertionLocations(allocaInst, MINIMUM_LINE_GAP);
      }
    }
    return PreservedAnalyses::all();
}};
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
