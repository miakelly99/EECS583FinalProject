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
#include "llvm/IR/CFG.h"
#include <iostream>
#include <vector>
#include <list>
#include <map>
#include <fstream>

using namespace llvm;

const std::string ENV_FILENAME = "checksum_env.txt";

// PLEASE USE A MINIMUM OF 10 FOR MIA'S SANTIY
// Other values may be smaller than the code necessary to add a checksum, causing an infinite loop
int MINIMUM_LINE_GAP;

namespace {

struct ChecksumPass : public PassInfoMixin<ChecksumPass> {

  Type* checksum_type;
  Type* use_count_type;

  ConstantInt* const_zero_val;
  ConstantInt* const_one_val;

  GlobalVariable* global_def_checksum;
  GlobalVariable* global_use_checksum;

  std::map<AllocaInst*, std::pair<GlobalVariable*, GlobalVariable*>> alloca_insts;

  // Add instructions to ensure minimum distance.
  void ensure_minimum (Instruction* start_loc, AllocaInst* alloca_inst, int minimum_line_gap, std::set<LoadInst*>& added_checksum_loads) {
    //errs() << "beginning search at " << *start_loc << " for " << *alloca_inst << "\n";
    if (start_loc == nullptr) { return; }
    Instruction* current_loc = start_loc;
    GlobalVariable* local_def = alloca_insts[alloca_inst].first;
    GlobalVariable* local_use = alloca_insts[alloca_inst].second;
    while (minimum_line_gap > 0)
    {
      //errs() << "considering inst " << *current_loc << " for " << *alloca_inst << "\n";
      //errs() << minimum_line_gap << "\n";
      if(current_loc != start_loc)
      {
        if (LoadInst* load_inst = dyn_cast<LoadInst>(current_loc))
        {
          if (alloca_inst == load_inst->getPointerOperand()) { return; }
          else { minimum_line_gap -= 6; }
        }
        else if (StoreInst* store_inst = dyn_cast<StoreInst>(current_loc))
        {
          if (alloca_inst == store_inst->getPointerOperand()) { return; }
          else { minimum_line_gap -= 8; }
        } else { minimum_line_gap -= 1; }
      } else { minimum_line_gap -= 1; }

      current_loc = current_loc->getNextNode();
      
      if (current_loc == nullptr)
      {
        BasicBlock* currBB = start_loc->getParent();
        DominatorTree dom_tree(*alloca_inst->getParent()->getParent());
        for (BasicBlock* succ: successors(currBB))
        {
          ensure_minimum(succ->getFirstNonPHI(), alloca_inst, minimum_line_gap, added_checksum_loads);
        }
        return;
      }
    }
    if (current_loc == nullptr)
    {
      return;
    }
    // add the new load and recursively call the thing
    LoadInst* new_load = new LoadInst(alloca_inst->getAllocatedType(), alloca_inst, "NOP_CHECKSUM_LOAD", current_loc);
    /*Instruction* load_use_num = new LoadInst(use_count_type, local_use, "", new_load->getNextNode());
    Instruction* increment_use_num = BinaryOperator::Create(Instruction::Add, load_use_num, const_one_val, "", load_use_num->getNextNode());
    Instruction* store_incr_use_num = new StoreInst(increment_use_num, local_use, increment_use_num->getNextNode());

    Instruction* load_global_cs = new LoadInst(checksum_type, global_use_checksum, "", store_incr_use_num->getNextNode());
    Instruction* increment_global_cs = BinaryOperator::Create(Instruction::Add, load_global_cs, new_load, "", load_global_cs->getNextNode());
    Instruction* store_incr_global_cs = new StoreInst(increment_global_cs, global_use_checksum, increment_global_cs->getNextNode());*/
    
    added_checksum_loads.insert(new_load);
    ensure_minimum(new_load->getNextNode(), alloca_inst, MINIMUM_LINE_GAP, added_checksum_loads);
  }

  std::set<LoadInst*> getNOPChecksumInsertionLocations(AllocaInst *allocaInst, int minimum_line_gap){
    // List of instructions where we have created a checksum
    std::set<LoadInst*> added_checksum_loads;
    std::set<Instruction*> instructions_to_consider;

    for (Use& use: allocaInst->uses()){
      if (Instruction* inst = dyn_cast<Instruction>(use.getUser()))
      {
        if (LoadInst* load_inst = dyn_cast<LoadInst>(inst))
        {
          if (allocaInst != load_inst->getPointerOperand()) { continue; }
          instructions_to_consider.insert(inst);
        }
        else if (StoreInst* store_inst = dyn_cast<StoreInst>(inst))
        {
          if (allocaInst != store_inst->getPointerOperand()) { continue; }
          instructions_to_consider.insert(inst);
        }
      }
    }
    
    for (Instruction* inst: instructions_to_consider)
    {
      ensure_minimum(inst, allocaInst, minimum_line_gap, added_checksum_loads);
    }

    return added_checksum_loads;
  }

  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {
    bool add_nops;
    std::ifstream env_file; env_file.open(ENV_FILENAME);
    env_file >> add_nops;
    env_file >> MINIMUM_LINE_GAP;
    env_file.close();

    checksum_type = Type::getInt32Ty(M.getContext());
    use_count_type = Type::getInt32Ty(M.getContext());

    const_zero_val = ConstantInt::get(M.getContext(), APInt(32,0));
    const_one_val = ConstantInt::get(M.getContext(), APInt(32,1));

    global_def_checksum = new GlobalVariable(M, checksum_type, false, GlobalValue::InternalLinkage, nullptr, "global_def");
    global_def_checksum->setAlignment(Align());
    global_def_checksum->setInitializer(const_zero_val);

    global_use_checksum = new GlobalVariable(M, checksum_type, false, GlobalValue::InternalLinkage, nullptr, "global_use");
    global_use_checksum->setAlignment(Align());
    global_use_checksum->setInitializer(const_zero_val);

    // loop through functions in module
    for (Function &F: M.getFunctionList()) {

      std::set<LoadInst*> added_nop_loads_to_ignore;

      ReturnInst* ret = nullptr;

      // loop through basic blocks in function
      for (BasicBlock &block : F) {

        // loop through instructions in basic block
        for (Instruction &instr : block) {
          // Begin each each, verify checksum
          if (AllocaInst *allocaInst = dyn_cast<AllocaInst>(&instr)) {
            
            GlobalVariable* local_def_checksum = new GlobalVariable(M, checksum_type, false, GlobalValue::InternalLinkage, nullptr, "local_def");
            local_def_checksum->setAlignment(Align());
            local_def_checksum->setInitializer(const_zero_val);

            GlobalVariable* local_use_number = new GlobalVariable(M, use_count_type, false, GlobalValue::InternalLinkage, nullptr, "local_use_number");
            local_use_number->setAlignment(Align());
            local_use_number->setInitializer(const_zero_val);
            

            alloca_insts[allocaInst] = std::make_pair(local_def_checksum, local_use_number);

            if (add_nops)
            {
              std::set<LoadInst*> added_loads = getNOPChecksumInsertionLocations(allocaInst, MINIMUM_LINE_GAP);
              added_nop_loads_to_ignore.insert(added_loads.begin(), added_loads.end());
            }
          }
          else if (ReturnInst* ret_inst = dyn_cast<ReturnInst>(&instr)) {
            ret = ret_inst;
          }
        }
      }

      for (auto& m: alloca_insts)
      {
        AllocaInst* allocaInst = m.first;
        GlobalVariable* local_def_checksum = m.second.first;
        GlobalVariable* local_use_number = m.second.second;
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
        if (ret != nullptr)
        {
          Instruction* load_use_num = new LoadInst(use_count_type, local_use_number, "", ret);
          Instruction* load_local_cs = new LoadInst(checksum_type, local_def_checksum, "", load_use_num->getNextNode());
          Instruction* load_global_cs = new LoadInst(checksum_type, global_def_checksum, "", load_local_cs->getNextNode());
          Instruction* mult_local_cs = BinaryOperator::Create(Instruction::Mul, load_local_cs, load_use_num, "", load_global_cs->getNextNode());
          Instruction* increment_global_cs = BinaryOperator::Create(Instruction::Add, load_global_cs, mult_local_cs, "", mult_local_cs->getNextNode());

          Instruction* zero_out_use_num = new StoreInst(const_zero_val, local_use_number, increment_global_cs->getNextNode());
          Instruction* store_global_cs = new StoreInst(increment_global_cs, global_def_checksum, zero_out_use_num->getNextNode());
          Instruction* store_local_cs = new StoreInst(const_zero_val, local_def_checksum, store_global_cs->getNextNode());
        }
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
  //errs() << M << "\n";
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
