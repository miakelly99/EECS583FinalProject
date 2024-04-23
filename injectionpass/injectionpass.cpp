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

using namespace llvm;

static const std::string ENV_FILENAME = "inject_env.txt";

typedef std::map<unsigned int, std::set<unsigned short>> InjectionMap;

std::vector<InjectionMap> parse_import_file(const std::string& import_filename)
{
  std::vector<InjectionMap> injections;
  std::ifstream import_file; import_file.open(import_filename);
  while(!import_file.eof())
  {
    InjectionMap inj_map;
    std::string line;
    std::getline(import_file, line);
    std::string str;
    str = line.substr(line.find(":") + 1);
    while (str.find(")") != std::string::npos)
    {
      std::string item = str.substr(str.find("(") + 1, str.find(")"));
      std::stringstream ss(item);
      unsigned int iteration;
      ss >> iteration;
      std::set<unsigned short> bits_to_flip;
      unsigned short bit;
      while (ss >> bit)
      {
        bits_to_flip.insert(bit);
      }
      inj_map[iteration] = bits_to_flip;
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
  struct Environment env;
  env_file >> env.create_template;
  if (env.create_template)
  {
    env_file >> env.template_filename;
  }
  env_file >> env.import;
  if (env.import)
  {
    env_file >> env.import_filename;
  }
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
    }

    std::vector<InjectionMap> injection_maps;
    if (env.import)
    {
      injection_maps = parse_import_file(env.import_filename);
    }

	  for (Function &F: M.getFunctionList())
    {
      std::list<StoreInst*> store_insts;
      for (BasicBlock& BB: F)
      {
        for (const Instruction &inst: BB)
        {
          Value* V = (Value*) &inst;
          if (StoreInst* store_inst = dyn_cast<StoreInst>(V))
          {
            store_insts.push_back(store_inst);
            if (env.create_template)
            {
              std::string instr_str;
              llvm::raw_string_ostream(instr_str) << *store_inst;
              template_file << "\"" << instr_str << "\"\t(" << "32" << " bits)" << " : \t-1\n";
            }
          }
        }
      }
      unsigned int instruction_number = 0;
      for (StoreInst* store_inst: store_insts)
      {
        InjectionMap inj_map = injection_maps[instruction_number];
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

        GlobalVariable* iteration_number = new GlobalVariable(M, iteration_number_type, false, GlobalValue::InternalLinkage, nullptr, "");
        iteration_number->setAlignment(Align());
        iteration_number->setInitializer(const_zero_val);

        GlobalVariable* injection_index = new GlobalVariable(M, injection_index_type, false, GlobalValue::InternalLinkage, nullptr, "");
        injection_index->setAlignment(Align());
        injection_index->setInitializer(const_zero_val);

        GlobalVariable* iteration_number_array = new GlobalVariable(M, iteration_array_type, false, GlobalValue::InternalLinkage, nullptr, "");
        iteration_number_array->setAlignment(Align());

        GlobalVariable* injection_array = new GlobalVariable(M, inject_array_type, false, GlobalValue::InternalLinkage, nullptr, "");
        injection_array->setAlignment(Align());

        std::vector<Constant*> iteration_numbers;
        std::vector<Constant*> injection_values;

        for (auto injection_pair: inj_map)
        {
          unsigned int iteration_num = injection_pair.first;
          std::set<unsigned short> bits_to_flip = injection_pair.second;

          unsigned int bit_flip_value = 0;

          for(unsigned short s: bits_to_flip)
          {
            bit_flip_value += (1 << (s - 1));
          }

          iteration_numbers.push_back((Constant*) ConstantInt::get(F.getContext(), APInt(32,iteration_num)));
          injection_values.push_back((Constant*) ConstantInt::get(F.getContext(), APInt(32,bit_flip_value)));
        }

        llvm::Constant* iteration_number_array_init = llvm::ConstantArray::get(iteration_array_type, iteration_numbers);
        llvm::Constant* injection_values_array_init = llvm::ConstantArray::get(inject_array_type, injection_values);
        iteration_number_array->setInitializer(iteration_number_array_init);
        injection_array->setInitializer(injection_values_array_init);

        Instruction* load_iteration_num = new LoadInst(iteration_number_type, iteration_number, "", store_inst->getNextNode());
        Instruction* load_inj_index = new LoadInst(injection_index_type, injection_index, "", load_iteration_num->getNextNode());
        Instruction* gep_iteration_target = GetElementPtrInst::Create(iteration_array_type, iteration_number_array, {const_zero_val, load_inj_index}, "", load_inj_index->getNextNode());
        Instruction* load_target_iteration = new LoadInst(iteration_number_type, gep_iteration_target, "", gep_iteration_target->getNextNode());
        Instruction* increment_iteration_num = BinaryOperator::Create(Instruction::Add, load_iteration_num, const_one_val, "", load_target_iteration->getNextNode());
        Instruction* store_incr_it_num = new StoreInst(increment_iteration_num, iteration_number, increment_iteration_num->getNextNode());
        Instruction* icmp_iter_nums = new ICmpInst(store_incr_it_num->getNextNode(), CmpInst::Predicate::ICMP_EQ, load_target_iteration, increment_iteration_num);

        Instruction* true_block = llvm::SplitBlockAndInsertIfThen(icmp_iter_nums, icmp_iter_nums->getNextNode(), false);
        Instruction* gep_injection_value = GetElementPtrInst::Create(inject_array_type, injection_array, {const_zero_val, load_inj_index}, "", true_block);
        Instruction* load_inj_value = new LoadInst(inject_value_type, gep_injection_value, "", gep_injection_value->getNextNode());
        Instruction* corrupt_instr = BinaryOperator::Create(Instruction::Xor, store_inst->getValueOperand(), load_inj_value, "", load_inj_value->getNextNode());
        Instruction* inject_corrupt_value = new StoreInst(corrupt_instr, store_inst->getPointerOperand(), corrupt_instr->getNextNode());
        Instruction* increment_inj_index = BinaryOperator::Create(Instruction::Add, load_inj_index, const_one_val, "", inject_corrupt_value->getNextNode());
        Instruction* store_incr_inj_index = new StoreInst(increment_inj_index, injection_index, increment_inj_index->getNextNode());
      }
    }
    template_file.close();
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
