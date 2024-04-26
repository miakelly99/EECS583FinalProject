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
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include <iostream>
#include <vector>
#include <list>
#include <map>

using namespace llvm;

int MINIMUM_LINE_GAP = 20;

namespace {

struct ChecksumPass : public PassInfoMixin<ChecksumPass> {

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
    Type* checksum_type = Type::getInt32Ty(M.getContext());
    Type* use_count_type = Type::getInt32Ty(M.getContext());

    ConstantInt* const_zero_val = ConstantInt::get(M.getContext(), APInt(32,0));
    ConstantInt* const_one_val = ConstantInt::get(M.getContext(), APInt(32,1));

    GlobalVariable* global_def_checksum = new GlobalVariable(M, checksum_type, false, GlobalValue::InternalLinkage, nullptr, "global_def");
    global_def_checksum->setAlignment(Align());
    global_def_checksum->setInitializer(const_zero_val);

    GlobalVariable* global_use_checksum = new GlobalVariable(M, checksum_type, false, GlobalValue::InternalLinkage, nullptr, "global_use");
    global_use_checksum->setAlignment(Align());
    global_use_checksum->setInitializer(const_zero_val);

    // loop through functions in module
    for (Function &F: M.getFunctionList()) {

      std::map<AllocaInst*, std::list<Instruction*>> nop_checks;

      std::list<AllocaInst*> alloca_insts;
      ReturnInst* ret = nullptr;

      // loop through basic blocks in function
      for (BasicBlock &block : F) {

        // loop through instructions in basic block
        for (Instruction &instr : block) {
          // Begin each each, verify checksum
          if (AllocaInst *allocaInst = dyn_cast<AllocaInst>(&instr)) {
            alloca_insts.push_back(allocaInst);
            nop_checks[allocaInst]; // = getNOPChecksumInsertionLocations(allocaInst, MINIMUM_LINE_GAP);
          }
          else if (ReturnInst* ret_inst = dyn_cast<ReturnInst>(&instr)) {
            ret = ret_inst;
          }
        }
      }

       

      for (AllocaInst* allocaInst: alloca_insts)
      {
        GlobalVariable* local_def_checksum = new GlobalVariable(M, checksum_type, false, GlobalValue::InternalLinkage, nullptr, "local_def");
        local_def_checksum->setAlignment(Align());
        local_def_checksum->setInitializer(const_zero_val);

        GlobalVariable* local_use_number = new GlobalVariable(M, use_count_type, false, GlobalValue::InternalLinkage, nullptr, "local_use_number");
        local_use_number->setAlignment(Align());
        local_use_number->setInitializer(const_zero_val);

        for (Use& use: allocaInst->uses())
        {
          if (Instruction* inst = dyn_cast<Instruction>(use.getUser()))
          {
            if (LoadInst* load_inst = dyn_cast<LoadInst>(inst))
            {
              if (allocaInst != load_inst->getPointerOperand()) { continue; }

              Instruction* load_use_num = new LoadInst(use_count_type, local_use_number, "", load_inst->getNextNode());
              Instruction* increment_use_num = BinaryOperator::Create(Instruction::Add, load_use_num, const_one_val, "", load_use_num->getNextNode());
              Instruction* store_incr_use_num = new StoreInst(increment_use_num, local_use_number, increment_use_num->getNextNode());

              Instruction* load_global_cs = new LoadInst(checksum_type, global_use_checksum, "", store_incr_use_num->getNextNode());
              Instruction* increment_global_cs = BinaryOperator::Create(Instruction::Add, load_global_cs, load_inst, "", load_global_cs->getNextNode());
              Instruction* store_incr_global_cs = new StoreInst(increment_global_cs, global_use_checksum, increment_global_cs->getNextNode());
            }
            else if (StoreInst* store_inst = dyn_cast<StoreInst>(inst))
            {
              if (allocaInst != store_inst->getPointerOperand()) { continue; }

              Instruction* load_use_num = new LoadInst(use_count_type, local_use_number, "", store_inst->getNextNode());
              Instruction* load_local_cs = new LoadInst(checksum_type, local_def_checksum, "", load_use_num->getNextNode());
              Instruction* load_global_cs = new LoadInst(checksum_type, global_def_checksum, "", load_local_cs->getNextNode());
              Instruction* mult_local_cs = BinaryOperator::Create(Instruction::Mul, load_local_cs, load_use_num, "", load_global_cs->getNextNode());
              Instruction* increment_global_cs = BinaryOperator::Create(Instruction::Add, load_global_cs, mult_local_cs, "", mult_local_cs->getNextNode());

              Instruction* zero_out_use_num = new StoreInst(const_zero_val, local_use_number, increment_global_cs->getNextNode());
              Instruction* store_global_cs = new StoreInst(increment_global_cs, global_def_checksum, zero_out_use_num->getNextNode());
              Instruction* store_local_cs = new StoreInst(store_inst->getValueOperand(), local_def_checksum, store_global_cs->getNextNode());
            }
          }
        }

        std::list<Instruction*> alloc_nop_checks = nop_checks[allocaInst];
        
        /*for (Instruction* nop_check_pt: alloc_nop_checks)
        {
          Instruction* load_value = new LoadInst(IntegerType::get(F.getContext(), 32), allocaInst, "", nop_check_pt);
          Instruction* load_use_num = new LoadInst(use_count_type, local_use_number, "", load_value->getNextNode());
          Instruction* increment_use_num = BinaryOperator::Create(Instruction::Add, load_use_num, const_one_val, "", load_use_num->getNextNode());
          Instruction* store_incr_use_num = new StoreInst(increment_use_num, local_use_number, increment_use_num->getNextNode());

          Instruction* load_global_cs = new LoadInst(checksum_type, global_use_checksum, "", store_incr_use_num->getNextNode());
          Instruction* increment_global_cs = BinaryOperator::Create(Instruction::Add, load_global_cs, load_value, "", load_global_cs->getNextNode());
          Instruction* store_incr_global_cs = new StoreInst(increment_global_cs, global_use_checksum, increment_global_cs->getNextNode());
        }*/

        Instruction* load_use_num = new LoadInst(use_count_type, local_use_number, "", ret);
        Instruction* load_local_cs = new LoadInst(checksum_type, local_def_checksum, "", load_use_num->getNextNode());
        Instruction* load_global_cs = new LoadInst(checksum_type, global_def_checksum, "", load_local_cs->getNextNode());
        Instruction* mult_local_cs = BinaryOperator::Create(Instruction::Mul, load_local_cs, load_use_num, "", load_global_cs->getNextNode());
        Instruction* increment_global_cs = BinaryOperator::Create(Instruction::Add, load_global_cs, mult_local_cs, "", mult_local_cs->getNextNode());

        Instruction* zero_out_use_num = new StoreInst(const_zero_val, local_use_number, increment_global_cs->getNextNode());
        Instruction* store_global_cs = new StoreInst(increment_global_cs, global_def_checksum, zero_out_use_num->getNextNode());
        Instruction* store_local_cs = new StoreInst(const_zero_val, local_def_checksum, store_global_cs->getNextNode());
      }
      if (F.getName() == std::string("main"))
      {
        Instruction* load_global_def = new LoadInst(checksum_type, global_def_checksum, "", ret);
        Instruction* load_global_use = new LoadInst(checksum_type, global_use_checksum, "", load_global_def->getNextNode());
        Instruction* icmp = new ICmpInst(load_global_use->getNextNode(), CmpInst::Predicate::ICMP_NE, load_global_def, load_global_use);
        Instruction* unsafe_block = llvm::SplitBlockAndInsertIfThen(icmp, icmp->getNextNode(), false);
        Instruction* ret_fail = ReturnInst::Create(F.getContext(), const_one_val, unsafe_block);
        ret_fail->getNextNode()->removeFromParent();
      }
  }
  errs() << M << "\n";
  return PreservedAnalyses::all();
}};
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
