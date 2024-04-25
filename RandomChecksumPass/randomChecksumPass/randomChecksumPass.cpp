#include "llvm/Analysis/BlockFrequencyInfo.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Format.h"

#include  <iostream>

using namespace llvm;

namespace {

struct RandomChecksumPass : public PassInfoMixin<RandomChecksumPass> {

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    // These variables contain the results of some analysis passes.
    // Go through the documentation to see how they can be used.
    llvm::BlockFrequencyAnalysis::Result &bfi = FAM.getResult<BlockFrequencyAnalysis>(F);
    llvm::BranchProbabilityAnalysis::Result &bpi = FAM.getResult<BranchProbabilityAnalysis>(F);

    //Collect statistics
    uint64_t totalOps = 0;
    double ialu = 0;
    double falu = 0;
    double mem = 0;
    double others = 0;
    double biased = 0;
    double unbiased = 0;
    for (BasicBlock &BB : F){
	   uint64_t currOps = bfi.getBlockProfileCount(&BB).value();

	   // totalOps = totalOps + bfi.getBlockProfileCount(&BB).value();
	   for (Instruction &I : BB){ 
		   totalOps += currOps;
		   //this isn't true, num operations != num instructions
		   //Use bfi to get what to add to total ops. Block freq. not 
		   //Mem operations
		   bool biasedBool = false;

		   switch(I.getOpcode()){
			   //IALU operations
			   case (Instruction::Add): case (Instruction::Sub): case (Instruction::Mul): case (Instruction::UDiv): case (Instruction::SDiv): case (Instruction::URem): case (Instruction::SRem): case (Instruction::Shl): case (Instruction::LShr): case (Instruction::AShr): case (Instruction::And): case (Instruction::Or): case (Instruction::Xor): case (Instruction::ICmp):
				   ialu += currOps; 
				   break;
			   case (Instruction::FAdd):
			   case (Instruction::FSub):
			   case (Instruction::FMul):
			   case (Instruction::FDiv):
			   case (Instruction::FRem):
			   case (Instruction::FCmp):
				   falu += currOps;  
				   break;
			   case Instruction::Alloca: case Instruction::Load: case Instruction::Store: case Instruction::GetElementPtr: case Instruction::Fence: case Instruction::AtomicCmpXchg: case Instruction::AtomicRMW:
				   mem += currOps;
				   break;
			   case Instruction::Br: case Instruction::Switch: case Instruction::IndirectBr:
				   biasedBool = false;

				   for (BasicBlock *succ : successors(&BB)){
					   BranchProbability e = bpi.getEdgeProbability(&BB, succ);
						   if ((double)e.getNumerator() / (double)e.getDenominator() > 0.8){
						   biasedBool = true;
					   }
				   }
				   if (biasedBool){
					   
					   biased += currOps;
				   } else {
					   unbiased += currOps;
				   }
				   break;	    
			   default:
				   others += currOps;
				   break;
		   }
	   }
    } 
//   if (biased + unbiased > 0){
//	   double denom = biased + unbiased;
//	   biased = biased / denom;
//	   unbiased = unbiased / denom;
//   }
    if (totalOps == 0){
	    biased = 0.000;
	    unbiased = 0.000;
    } else {
	    biased = (biased / totalOps);
	    unbiased = (unbiased / totalOps);
    }
    //double vals[6] = {ialu, falu, mem, biased, unbiased, others};
   // else{
   //         vals = {(ialu / totalOps), (falu / totalOps), (mem / totalOps)};
   // }
    //to get dynamic ops use bpi or bfi (or both?) from top of file 
	    // Pseudo code for printing statistics
    if (totalOps > 0){
	    ialu /= totalOps;
	    falu /= totalOps;
	    mem /= totalOps;
	    others /= totalOps;
    }
    errs() << F.getName();
    errs() << ", " << totalOps;
    errs() << ", " << format("%.3f", ialu);
    errs() << ", " << format("%.3f", falu);
    errs() << ", " << format("%.3f", mem);
    errs() << ", " << format("%.3f", biased);
    errs() << ", " << format("%.3f", unbiased);
    errs() << ", " << format("%.3f", others);
//    for (int i = 0; i < 6; i++) { // iterate all categories
//	if (totalOps == 0) errs() << ", " << format("%.3f", 0.000);
//	else errs() << ", " << format("%.3f", (float)(vals[i]/totalOps));
  //  }

    errs() << "\n";
    // Add your code here
    //std::cout << F.getName().str();
    //std::cout << "FuncName, DynOpCount, %IALU, %FALU, %MEM, %Biased-Br, %Unbiased-Br, %Others " << std::endl;
    
    return PreservedAnalyses::all();
  }
};
}

extern "C" ::llvm::PassPluginLibraryInfo LLVM_ATTRIBUTE_WEAK llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "RandomChecksumPass", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
        ArrayRef<PassBuilder::PipelineElement>) {
          if(Name == "randomChecksum"){
            FPM.addPass(RandomChecksumPass());
            return true;
          }
          return false;
        }
      );
    }
  };
}
