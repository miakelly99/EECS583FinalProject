#include "llvm/IR/CFG.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/IR/IRBuilder.h"
#include <llvm/Support/raw_ostream.h>

#include  <iostream>
#include  <fstream>
#include  <list>
#include  <string>
#include  <vector>
#include  <set>
#include  <map>
#include  <bits/stdc++.h>
#include  <iomanip>

using namespace llvm;

static const std::string ENV_FILENAME = "inject_env.txt";

typedef std::map<std::pair<unsigned int, unsigned int>, std::set<unsigned short>> InjectionMap;

std::vector<InjectionMap> parse_import_file(const std::string& import_filename)
{
  std::vector<InjectionMap> injections;
  std::ifstream import_file; import_file.open(import_filename);
  if (!import_file.good())
  {
    errs() << "Cannot read injection file " << import_filename << "\n";
    exit(1);
  }
  while(!import_file.eof())
  {
    InjectionMap inj_map;
    std::string line;
    std::getline(import_file, line);
    std::string str;
    if (line.substr(line.find("(") + 1, line.find(")") - line.find("(") - 1) == std::string("NOLD")) { continue; }
    str = line.substr(line.find(":") + 1);
    while (str.find(")") != std::string::npos)
    {
      std::string item = str.substr(str.find("(") + 1);
      std::stringstream ss(item);
      unsigned int inst_index;
      ss >> inst_index;
      unsigned int iteration;
      ss >> iteration;
      std::set<unsigned short> bits_to_flip;
      unsigned short bit;
      while (ss >> bit)
      {
        bits_to_flip.insert(bit);
      }
      inj_map[std::make_pair(inst_index, iteration)] = bits_to_flip;
      str = str.substr(str.find(")") + 1);
    }
    injections.push_back(inj_map);
  }
  return injections;
}

struct Environment
{
  bool create_template;
  std::string template_filename;
  bool import;
  std::string import_filename;
};

Environment readEnvFile()
{
  std::ifstream env_file; env_file.open(ENV_FILENAME);
  if (!env_file.good())
  {
    errs() << "Cannot read enviornment file " << ENV_FILENAME << "\n";
    exit(1);
  }
  struct Environment env;
  env_file >> env.create_template;
  env_file >> env.template_filename;
  env_file >> env.import;
  env_file >> env.import_filename;
  env_file.close();
  return env;
};

namespace {

struct InjectionPass : public PassInfoMixin<InjectionPass> {
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {
    struct Environment env = readEnvFile();
    std::ofstream template_file;
    if (env.create_template)
    {
      template_file.open(env.template_filename);
      if (!template_file.good())
      {
        errs() << "Template file " << env.template_filename << " unable to be written to. Continuing without generating..." << "\n";
        env.create_template = false;
      }
    }

    std::vector<InjectionMap> injection_maps;
    if (env.import)
    {
      injection_maps = parse_import_file(env.import_filename);
    }

    std::map<unsigned int, Instruction*> index_to_instruction;

	  for (Function &F: M.getFunctionList())
    {
      std::list<LoadInst*> load_insts;
      for (BasicBlock& BB: F)
      {
        unsigned int index = 1;
        for (Instruction &inst: BB)
        {
          Value* V = (Value*) &inst;
          bool load = false;
          if (LoadInst* load_inst = dyn_cast<LoadInst>(V))
          {
            load_insts.push_back(load_inst);
            load = true;
          }
          index_to_instruction[index] = &inst;

          if (env.create_template)
          {
            std::string instr_str;
            llvm::raw_string_ostream(instr_str) << inst;
            template_file << std::setw(5) << index << " ----> ";
            std::string default_val;
            if (load)
            {
              template_file << "(LOAD)";
              default_val = "-1";
            } else {
              template_file << "(NOLD)";
              default_val = "INVALID";
            }
            template_file << " \t\"" << std::left << std::setw(50) << instr_str.substr(0, 50) << "\"      (" << "32" << " bits)" << "   : \t" << default_val << "\n";
          }
          index++;
        }
      }
      template_file.close();
      unsigned int instruction_number = 0;
      for (LoadInst* load_inst: load_insts)
      {
        InjectionMap inj_map;
        if (instruction_number < injection_maps.size())
        {
          inj_map = injection_maps[instruction_number];
        }
        instruction_number++;
        unsigned int num_injections = inj_map.size();

        if (num_injections == 0)
        {
          continue;
        }

        Type* iteration_number_type = Type::getInt32Ty(F.getContext());
        Type* injection_index_type = Type::getInt32Ty(F.getContext());
        Type* inject_value_type = Type::getInt32Ty(F.getContext());
        ArrayType* iteration_array_type = ArrayType::get(iteration_number_type, inj_map.size());
        ArrayType* inject_array_type = ArrayType::get(inject_value_type, inj_map.size());

        ConstantInt* const_zero_val = ConstantInt::get(F.getContext(), APInt(32,0));
        ConstantInt* const_one_val = ConstantInt::get(F.getContext(), APInt(32,1));
        ConstantInt* const_max_injection_number = ConstantInt::get(F.getContext(), APInt(32, num_injections));

        GlobalVariable* iteration_number = new GlobalVariable(M, iteration_number_type, false, GlobalValue::InternalLinkage, nullptr, "iteration_number");
        iteration_number->setAlignment(Align());
        iteration_number->setInitializer(const_zero_val);

        GlobalVariable* injection_index = new GlobalVariable(M, injection_index_type, false, GlobalValue::InternalLinkage, nullptr, "injection_index");
        injection_index->setAlignment(Align());
        injection_index->setInitializer(const_zero_val);

        GlobalVariable* injection_index_max = new GlobalVariable(M, injection_index_type, false, GlobalValue::InternalLinkage, nullptr, "injection_index_max");
        injection_index_max->setAlignment(Align());
        injection_index_max->setInitializer(const_max_injection_number);

        GlobalVariable* iteration_number_array = new GlobalVariable(M, iteration_array_type, false, GlobalValue::InternalLinkage, nullptr, "iteration_number_array");
        iteration_number_array->setAlignment(Align());

        GlobalVariable* injection_array = new GlobalVariable(M, inject_array_type, false, GlobalValue::InternalLinkage, nullptr, "injection_array");
        injection_array->setAlignment(Align());

        std::vector<Constant*> iteration_numbers;
        std::vector<Constant*> injection_values;

        for (auto injection_pair: inj_map)
        {
          unsigned int instruction_num = injection_pair.first.first;
          unsigned int iteration_num = injection_pair.first.second;
          
          std::set<unsigned short> bits_to_flip = injection_pair.second;

          unsigned int bit_flip_value = 0;

          for(unsigned short s: bits_to_flip)
          {
            bit_flip_value += (1 << (s - 1));
          }

          iteration_numbers.push_back((Constant*) ConstantInt::get(F.getContext(), APInt(32,iteration_num)));
          injection_values.push_back((Constant*) ConstantInt::get(F.getContext(), APInt(32,bit_flip_value)));

          if (instruction_num != 0)
          {
            Instruction* remote_location = index_to_instruction[instruction_num];

            if (remote_location != load_inst)
            {
              PointerType* data_ptr_type = PointerType::get(load_inst->getType(), 0);
              GlobalVariable* pointer = new GlobalVariable(M, data_ptr_type, false, GlobalValue::InternalLinkage, nullptr, "remote_injection_ptr");
              pointer->setAlignment(Align());
              pointer->setInitializer(ConstantPointerNull::get(data_ptr_type));
              
              Instruction* remote_load_ptr = new LoadInst(data_ptr_type, pointer, "", remote_location);
              LoadInst* remote_load_value = new LoadInst(load_inst->getType(), remote_load_ptr, "", remote_load_ptr->getNextNode());
              Instruction* update_remote_ptr = new StoreInst(load_inst->getPointerOperand(), pointer, "", load_inst->getNextNode());

              load_inst = remote_load_value;
            }
          }
        }

        llvm::Constant* iteration_number_array_init = llvm::ConstantArray::get(iteration_array_type, iteration_numbers);
        llvm::Constant* injection_values_array_init = llvm::ConstantArray::get(inject_array_type, injection_values);
        iteration_number_array->setInitializer(iteration_number_array_init);
        injection_array->setInitializer(injection_values_array_init);

        Instruction* load_iteration_num = new LoadInst(iteration_number_type, iteration_number, "", load_inst->getNextNode());
        Instruction* load_inj_index = new LoadInst(injection_index_type, injection_index, "", load_iteration_num->getNextNode());
        Instruction* load_inj_index_max = new LoadInst(injection_index_type, injection_index_max, "", load_inj_index->getNextNode());
        Instruction* icmp_index_under_max = new ICmpInst(load_inj_index_max->getNextNode(), CmpInst::Predicate::ICMP_SLT, load_inj_index, load_inj_index_max);

        Instruction* safe_to_access_block = llvm::SplitBlockAndInsertIfThen(icmp_index_under_max, icmp_index_under_max->getNextNode(), false);
        Instruction* gep_iteration_target = GetElementPtrInst::Create(iteration_array_type, iteration_number_array, {const_zero_val, load_inj_index}, "", safe_to_access_block);
        Instruction* load_target_iteration = new LoadInst(iteration_number_type, gep_iteration_target, "", gep_iteration_target->getNextNode());
        Instruction* increment_iteration_num = BinaryOperator::Create(Instruction::Add, load_iteration_num, const_one_val, "", load_target_iteration->getNextNode());
        Instruction* store_incr_it_num = new StoreInst(increment_iteration_num, iteration_number, increment_iteration_num->getNextNode());
        Instruction* icmp_iter_nums = new ICmpInst(store_incr_it_num->getNextNode(), CmpInst::Predicate::ICMP_EQ, load_target_iteration, increment_iteration_num);

        Instruction* true_block = llvm::SplitBlockAndInsertIfThen(icmp_iter_nums, icmp_iter_nums->getNextNode(), false);
        Instruction* gep_injection_value = GetElementPtrInst::Create(inject_array_type, injection_array, {const_zero_val, load_inj_index}, "", true_block);
        Instruction* load_inj_value = new LoadInst(inject_value_type, gep_injection_value, "", gep_injection_value->getNextNode());
        Instruction* corrupt_value = BinaryOperator::Create(Instruction::Xor, load_inst, load_inj_value, "", load_inj_value->getNextNode());
        Instruction* inject_corrupt_value = new StoreInst(corrupt_value, load_inst->getPointerOperand(), corrupt_value->getNextNode());
        Instruction* increment_inj_index = BinaryOperator::Create(Instruction::Add, load_inj_index, const_one_val, "", inject_corrupt_value->getNextNode());
        Instruction* store_incr_inj_index = new StoreInst(increment_inj_index, injection_index, increment_inj_index->getNextNode());

        BasicBlock* join_block = true_block->getParent()->getSingleSuccessor();
        BasicBlock* nextBlock = join_block->getSingleSuccessor();

        PHINode* phi_node_1 = PHINode::Create(inject_value_type, 3, "", &join_block->front());
        phi_node_1->addIncoming(load_inst, icmp_iter_nums->getParent());
        phi_node_1->addIncoming(corrupt_value, corrupt_value->getParent());
        PHINode* phi_node_2 = PHINode::Create(inject_value_type, 3, "", &nextBlock->front());
        phi_node_2->addIncoming(load_inst, load_inst->getParent());
        phi_node_2->addIncoming(phi_node_1, phi_node_1->getParent());

        load_inst->replaceUsesWithIf(phi_node_2,
          [init_block = load_inst->getParent(), inject_block = corrupt_value->getParent(), phi_node_1 = phi_node_1, phi_node_2 = phi_node_2](Use& u) {
            bool val = false;
            if (Instruction* inst = dyn_cast<Instruction>(u.getUser()))
            {
              val = (inst->getParent() != init_block) && (inst->getParent() != inject_block) && (inst != phi_node_1) && (inst != phi_node_2);
            }
            return val;
          }
        );
      }
    }
    template_file.close();

    //errs() << M << "\n";
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
