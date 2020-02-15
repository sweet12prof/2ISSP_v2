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
 

## Instruction Set
* Instructions are a subset of the MIPS32 ISA 
* Architecture of these instructions in exception of the halt instruction are adopted from that ISA
* To halt the CPU simply use the instruction x"F-------"('-' refer to dont cares)
* No way to put the processor back into operation yet

### R-Format
| Instructions | Meaning | Opcode | Rs | Rt | Rd | shamt | Funct|
|--------------|---------|--------|----|----|----|-------|------| 
| | | 6 bits| 5 bits | 5 bits | 5 bits | 5 bits | 6 bits|
| add rd, rs, rt| Rd = Rs + Rt | 000000| sssss| ttttt| ddddd| 00000| 100000| 
|sub rd, rs, rt| Rd = Rs -Rt|000000|sssss|ttttt|ddddd|00000| 100010|
|and rd, rs, rt|Rd = Rs and Rt |000000| sssss| ttttt | ddddd| 00000| 100100 |
|or rd, rs, rt|Rd = Rs or Rt |000000| sssss| ttttt | ddddd| 00000| 100101 |
|slt rd, rs,rt |rd = rs == rt ? 1:0 |000000| sssss| ttttt | ddddd| 00000| 101010 |
|sll rd, rs, rx | rd =rs sll rx | 000000 | sssss | 00000 | 00000 | xxxxxx | 000000 |
| srl rd, rs, rx | rd = rs = srl rx | 000000 | sssss | 00000 | 00000 | xxxxxx | 000010 |  
| xor rd, rs, rt | rd = rs xor rt | 000000 | sssss | ttttt | ddddd | 00000 | 100110 |
|Jr rs  | Jump to Address in register(rs) : pc = $rs| 000000 | ssssss | 000000 | 000000 | 00000 | 001000 |  
### I-Format
| Instructions | Meaning | Opcode | Rs | Rt | Address | 
|-|-|-|-|-|-|
|||6 bits| 5  bits | 5 bits | 16 bits |
|addi rs, rt, #**Imm**|rt = rs + Imm |001000| sssss | ttttt | Immediate(Imm)|
|lw rt, Offset(Address) | rt = MEM[Offset + Address] | 100011| sssss | ttttt | Address |
|sw rt, Offset(Address) | MEM[Offset + Address] = rt | 101011 | sssss| ttttt | Address |
|beq rs, rt, Address | pc = rs == rt ? Label + (pc + 4) : pc += 4 | 000100 | sssss | ttttt | Label | 
|bne rs, rt, Address | pc = rs != rt ?  Label + (pc + 4) : pc += 4 | | sssss| ttttt | Label | 
|andi rs, rt, Imm| rt = rs and Imm || sssss | ttttt | Immediate(Imm)|
|ori rs, rt, Imm | rt = rs or Imm ||  sssss | ttttt | Immediate(Imm)|
|slti rs, rt, Imm| rt = rs == Imm ? 1 : 0  || sssss | ttttt | Immediate(Imm) |
|xori rs, rt, Imm | rt = rs xor Imm || sssss | ttttt | Immediate(Imm) |
|lui rt, Imm| rt[31: 16] = Imm || xxxxx | ttttt | Immediate(Imm) |

### J-Format 
| Instructions | Meaning | Opccode | Jump Address |
|-|-|-|-|
|J Address | pc = Address | 000010 | Address |
| Jal Address | Jump and Link : $ra($31) = pc + 4 then pc = Address | 000011 | Address |  



### Halt CPU
| Instructrion | Meaning | Opcode | Remaining bits |
|--------------|---------|--------|----------------|
| |  | 6 bits | 26 bits |
| halt         | halt the CPU | 11111 | (dont care) |

## Design Methodolgy
 * Schematic created for design is included in project directory.
 * VHDL used to describe design in vivado webpack
 * Design is based on the havard archiutecture( Working on a Von Neumann Equivalent )
 * Design contains the ff architectural state and combitional sub-systems sufficient for an instruction pair
     * register File with 4 read ports and 2 write ports.
     * Instruction memory(Imem), issues 2 instructions based on address
     * Data Mem (Dmem) holds data, implemented as a simple Dual port ram
     * Instruction Scheduler, determines if execution pair are a valid pair for execution. 
     * Control Unit
     * Hazard Detection and Resolution Unit
     * Pair of ALU

## Testing/Simulation(Pre- Synthesis)
  * Open the xise/xpr project File, or add the vhd files to your new project.
  * There are multiple programs in the instruction memory with their corresponding program data in the data memory.
  * Only one of them is going to run, since all others are commented out.
  * The programs in the instruction memory(Imem.vhd), consists of MIPS programs translated into hex.
  * The uncommented program is an implementation of the "ADD-SHIFT" multiplication Algorithm to multiply 2 numbers
  * The numbers in the particular program are 40 and 5, hence a result of 200 is expected at the end of the program 
  * The program exits execution by saving the result into memory Location 100
  * A simple run of the testbench file reveals this. 
  * To run a different program with the tesbench, do as follows : 
      * Uncomment out one of the existing programs/Write your own based on the implemented subset. 
      * Assemble it and generate a hex file (You can use the MARS simulator for this!)
      * Edit the Imem file 
      * Edit tesbench according to the outputs expected by your program
      * Run and compare results
      
 ## Synthesis For FPGA
  * The registerFile used in the design couldn't be synthesised using block RAMS
  * This forces usage of registers by the synthesiser and utilizes a lot of resources
  * The design synthesises successfully for a basys 3 artix 7 FPGA, this can be used as the baseline if you intend to 
    synthesise for an fpga
  * Don't synthesise the tesbench won't work
  * The top module is what you're looking for, as for I/O, The unbounded Outputs include memory Address and data ports, 
    this can be changed by editing all the way from the datapath file through to the top level module 
  
   
  
  
 
    
    
  
  
  
     
     

