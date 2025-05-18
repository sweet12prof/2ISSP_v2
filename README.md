# 2ISSP_v2
## General Info
Design of a two issue scalar, 32-bit MIPS processor that features an in-order scheduler and executes up to 22 instructions.


**This project is a re-design of a 2-issue super-scalar i designed some months ago, the other was bugged. I re-devised the
microacitecture by reducing multiplexer count in certain paths, increasing the number of supported instructions and redesigning the instruction scheduler. The new scheduler has it's own repository too.**

Included in this repo is the new schema and a powerpoint/pdf listing the changes i made, the steps i took, new findings and my thoughts. The ending part of the ppt/pdf also shows, the various test programs i used in testing/verifying the microarchitecture. Whereas they are exhaustive ways of verifying the design of a microarchoitecture, after resolving several issues with my design and description, The processor passed all of them. The simulation programs ranged from simple random programs to popular complex data structure algorithms. I am continually testing the design and will resolve any bugs as soon as i find them. 


## Behavior(Elaborate explanations in presentation files)
* The processor implements instruction level parallelism by employing both pipelinning and multiple issue techniques.
* It is an **IN-ORDER,** 2-issue(Way), 5-stage pipeline, dynamically scheduled, 32-bit MIPS based processor.
* It is Dynamically scheduled which implies the scheduler is implemented in hardware. 
* With the help of an instruction scheduler, the processor executes a pair of instructions in program order when 
  there are no data or control dependences between them.
* For an ideal case, where all pairs of instructions are not dependent on  each other, and also consist of only correctly       predicted branch instructions this CPU design records a CPI = 1, an IPC = 2 and also twice the throughput of a single         scalar pipeline design.
* CPI > 1 and IPC >= 1 for non ideal cases, which is mostly the case.
* The design's branch logic is based on an  **Always-not-taken** prediction scheme.(Working on an advanced branch           predictor though)
* In the case of a data dependency, the sceond instruction in the pair shuffled out and replaced by a nop,
  and the pc set to point to the swapped instruction.
* In the worst case scenario, where all pairs are dependent, the processor acts as a single-scalar pipeline.
* The microarchitecture design compels the ff instructions(Beq, J, Jal and Jr) to be executed on the 1st path(Way).The 
  instruction scheduler makes sure of this. 
* You can find out how it does this by checking out the presentation files or checking out the instruction 
  scheduler project. 
 
  
  
 
    
    
  
  
  
     
     

