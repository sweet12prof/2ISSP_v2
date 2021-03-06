----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2020 12:22:00 PM
-- Design Name: 
-- Module Name: Datapath - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Datapath is
  
  Port ( 
            clk                             : in std_logic; 
            reset                           : in std_logic; 
            
            pc                              : out std_logic_vector(31 downto 0);
            -------------------------------
            --Memory Signals
            -------------------------------
            IMem_Instr1_F                   : in std_logic_vector(31 downto 0); 
            IMem_Instr2_F                   : in std_logic_vector(31 downto 0);
            
            DP_W1_ALUout_M                    : out std_logic_vector(31 downto 0);
            DP_W2_ALUout_M                    : out std_logic_vector(31 downto 0);
            
            DP_W1_writeData_M                    : out std_logic_vector(31 downto 0);  
            DP_W2_writeData_M                    : out std_logic_vector(31 downto 0);  
            
            DP_W1_memWrite_M                : out std_logic;
            DP_W2_memWrite_M                : out std_logic;
            
            Dmem_readData1_M                : in std_logic_vector(31 downto 0);
            Dmem_readData2_M                : in std_logic_vector(31 downto 0);
            
            DP_W1_unknownOp_W              : OUT std_logic;
            DP_W2_unknownOp_W              : out std_logic;
            
            DP_W1_overflow                  : OUT std_logic;  
            DP_W2_overflow                  : out std_logic; 
            --------------------------------
            ---CU Signals
            --------------------------------
            CU1_Opcode                       : out std_logic_vector(5 downto 0);
            CU1_Funct                        : out std_logic_vector(5 downto 0); 
            CU2_Opcode                       : out std_logic_vector(5 downto 0); 
            CU2_Funct                        : out std_logic_vector(5 downto 0); 
            
            
            CU1_ShamtSel_D                   : in std_logic;          
            CU1_regWrite_D                   : in std_logic;
            CU1_memtoReg_D                   : in std_logic;
            CU1_memWrite_D                   : in std_logic;
            CU1_ALUControl_D                 : in std_logic_vector(3 downto 0);
            CU1_ALUSrc_D                     : in std_logic;
            CU1_RegDst_D                     : in std_logic;
            CU1_lui_D                          : in std_logic;
            CU1_Jal_D                         : in std_logic;
            
            CU1_Jr_D                          : in std_logic;
            --CU1_Jump_D                        : in std_logic;
            CU1_Branch_D                       : in std_logic;
            CU1_BranchNotEqual_D               : in std_logic;
            CU1_pcSrc_D                       : in std_logic_vector(3 downto 0);
            CU1_Equal_D                      : out STD_LOGIC;
            CU1_MFc0_D                      : in STD_LOGIC;
            CU2_MFc0_D                      : in std_logic;
            
            
            CU2_ShamtSel_D                   : in std_logic;      
            CU2_regWrite_D                   : in std_logic;  
            CU2_memtoReg_D                   : in std_logic;  
            CU2_memWrite_D                   : in std_logic;  
            CU2_ALUControl_D                 : in std_logic_vector(3 downto 0);
            CU2_ALUSrc_D                     : in std_logic;  
            CU2_RegDst_D                     : in std_logic;  
            CU2_lui_D                          : in std_logic;
            
            CU1_unknownOp_D               : in std_logic;
            CU2_unknownOp_D               : in std_logic;
              
            --------------------------------
            ---HU_Signals
            --------------------------------
            HU_W1_RS_E                      : OUT std_logic_vector(4 downto 0);
            HU_W1_RT_E                      : OUT std_logic_vector(4 downto 0);
            HU_W1_WriteReg_M                : OUT std_logic_vector(4 downto 0);
            HU_W1_WriteReg_W                : OUT std_logic_vector(4 downto 0);
            HU_W1_RegWrite_M                : OUT std_logic;   
            HU_W1_RegWrite_W                : OUT std_logic; 
                                            
            HU_W2_RS_E                      : OUT std_logic_vector(4 downto 0); 
            HU_W2_RT_E                      : OUT std_logic_vector(4 downto 0); 
            HU_W2_WriteReg_M                : OUT std_logic_vector(4 downto 0); 
            HU_W2_WriteReg_W                : OUT std_logic_vector(4 downto 0); 
            HU_W2_RegWrite_M                : OUT std_logic;                    
            HU_W2_RegWrite_W                : OUT std_logic;                    
                                            
            HU_W1_RS_D                      : OUT std_logic_vector(4 downto 0); 
            HU_W1_RT_D                      : OUT std_logic_vector(4 downto 0); 
                                            
            HU_W2_RS_D                      : OUT std_logic_vector(4 downto 0);      
            HU_W2_RT_D                      : OUT std_logic_vector(4 downto 0); 
                                           
            HU_W1_memtoRegE                 : OUT std_logic;
            HU_W2_memtoRegE                 : OUT std_logic;
                                           
            HU_W1_memtoRegM                 : OUT std_logic;
            HU_W2_memtoRegM                 : OUT std_logic;
                                          
            HU_W1_regWriteE                 : OUT std_logic;
            HU_W2_regWriteE                 : OUT std_logic;
                                         
            HU_W1_WriteRegE                 : OUT std_logic_vector(4 downto 0);
            HU_W2_WriteRegE                 : OUT std_logic_vector(4 downto 0);
                                             
            HU_BranchD                      : OUT std_logic;   
            HU_BranchnotEqualD              : OUT std_logic; 
            HU_JrD                          : OUT std_logic; 
                                            
            HU_StallF                       : in std_logic; 
            HU_StallD                       : in std_logic; 
            HU_FlushE                       : in std_logic; 
            
            HU_W1_ForwardAD                 : in std_logic_vector(1 downto 0);
            HU_W1_ForwardBD                 : in std_logic_vector(1 downto 0);
            HU_W1_ForwardCD                 : in std_logic_vector(1 downto 0);
                                            
            HU_W1_ForwardAE                 : in std_logic_vector(2 downto 0);
            HU_W1_ForwardBE                 : in std_logic_vector(2 downto 0);
                                            
            HU_W2_ForwardAE                 : in std_logic_vector(2 downto 0);
            HU_W2_ForwardBE                 : in std_logic_vector(2 downto 0);
            
            ----------------------------------------------------------
            -- Exception Unit
            -----------------------------------------------------------------------
            CauseCode   : in std_logic_vector(31 downto 0);
            EPCWrite    : in std_logic;
            CauseWrite  : in std_logic;
            PCBit       : in std_logic
        );
end Datapath;

architecture Behavioral of Datapath is
    component generic_eight_input_Mux 
        generic (
                    width : positive
                );
        Port ( 
                    i1      : in    std_logic_vector(width - 1 downto 0);
                    i2      : in    std_logic_vector(width - 1 downto 0);
                    i3      : in    std_logic_vector(width - 1 downto 0);
                    i4      : in    std_logic_vector(width - 1 downto 0);
                    i5      : in    std_logic_vector(width - 1 downto 0);
                    i6      : in    std_logic_vector(width - 1 downto 0);
                    i7      : in    std_logic_vector(width - 1 downto 0);
                    i8      : in    std_logic_vector(width - 1 downto 0);
                    iSel    : in    std_logic_vector(2 downto 0);
                    Output  : out    std_logic_vector(width - 1 downto 0)           
               );
    end component;
    
    component pcFlopr 
        Port (  
              clk       : in std_logic; 
              reset     : in std_logic;
              StallPC   : in std_logic;
              d         : in std_logic_vector(31 downto 0);
              q         : out std_logic_vector(31 downto 0)
            );
    end component;
    
    component Adder32 is
        port(
                Add32i1       : in std_logic_vector(31 downto 0); 
                Add32i2       : in std_logic_vector(31 downto 0);
                Cin32         : in std_logic;
                Add32Sum      : out std_logic_vector(31 downto 0);
                Cout32        : out std_logic;
                overflow : out std_logic
        );
    end component;
    
    component generic_2_input_mux 
        generic
            (
                width : positive            
            );
        Port (
                MUX_in1     : in std_logic_vector(width - 1 downto 0);
                MUX_in2     : in std_logic_vector(width - 1 downto 0);
                Mux_SEL     : in std_logic;
                Mux_Out     : out std_logic_vector(width-1 downto 0)
             );
    end component;
    
    component pc_Mux is
        generic (
                    width : positive
                );
          Port ( 
                    i1      : in    std_logic_vector(width - 1 downto 0);
                    i2      : in    std_logic_vector(width - 1 downto 0);
                    i3      : in    std_logic_vector(width - 1 downto 0);
                    i4      : in    std_logic_vector(width - 1 downto 0);
                    i5      : in    std_logic_vector(width - 1 downto 0);
                    i6      : in    std_logic_vector(width - 1 downto 0);      
                    iSel    : in    std_logic_vector(4 downto 0);
                    Output  : out    std_logic_vector(width - 1 downto 0)           
            );
    end component;
    
    component FD_pipe_REG is
          Port ( 
                    clk             : in std_logic;
                    stallF          : in std_logic;
                    reset           : in std_logic;
                    FlushF          : in std_logic;
                    Instr1F         : in std_logic_vector(31 downto 0);
                    Instr2F         : in std_logic_vector(31 downto 0);
                    PCplus4_8F      : in std_logic_vector(31 downto 0);
                    PCF             : in std_logic_vector(31 downto 0);
                   
                   
                    Instr1D         : out std_logic_vector(31 downto 0);
                    Instr2D         : out std_logic_vector(31 downto 0);
                    PCplus4_8D      : out std_logic_vector(31 downto 0);
                    PCD      : out std_logic_vector(31 downto 0)
                
                 );
    end component;
    
    component Two_Issue_Scheduler 
             Port (
                        Instr1          : in    std_logic_vector(31 downto 0);
                        Instr2          : in    std_logic_vector(31 downto 0);
                        EX_Instr1       : out   std_logic_vector(31 downto 0);    
                        EX_Instr2       : out   std_logic_vector(31 downto 0);
                        PC_Adder_Mux    : out   std_logic
                
                    );
    end component;
    
    component registerFile is
             Port ( 
                        clk, W1WE, W2WE       : std_logic;
                        W1A1                  : in std_logic_vector(4 downto 0);
                        W1A2                  : in std_logic_vector(4 downto 0);
                        W1WA                : in std_logic_vector(4 downto 0);
                        W1WD                  : in std_logic_vector(31 downto 0);
                        W1RD1                 : out std_logic_vector(31 downto 0);
                        W1RD2                 : out std_logic_vector(31 downto 0);
                        
                        W2A1                  : in std_logic_vector(4 downto 0);
                        W2A2                  : in std_logic_vector(4 downto 0);
                        W2WA                 : in std_logic_vector(4 downto 0);
                        W2WD                  : in std_logic_vector(31 downto 0);
                        W2RD1                 : out std_logic_vector(31 downto 0);
                        W2RD2                 : out std_logic_vector(31 downto 0)          
            );
    end component;
    
    component  signExtender is 
                   generic( width : positive);
                   port (
                           Input   : in std_logic_vector( width - 1 downto 0);
                           Output  : out std_logic_vector((2 * width - 1)  downto 0)
                       );  
    end component;
    
    component sl2 is
              	port(
              		a : in std_logic_vector(31 downto 0);
              		b : out std_logic_vector(31 downto 0)
              	);
    end component;
    
    component zeroPadder is 
        generic( width : positive );
        port (
                Input   : in std_logic_vector( width - 1 downto 0);
                Output  : out std_logic_vector((2 * width - 1)  downto 0)
            );  
    end component;
    
    component   generic_four_Input_Mux is 
            generic (
                        width : positive
                    );
            port(
                    i1      : in std_logic_vector(width - 1 downto 0 );
                    i2      : in std_logic_vector(width - 1 downto 0);
                    i3      : in std_logic_vector(width - 1 downto 0 );
                    i4      : in std_logic_vector(width - 1 downto 0);
                    iSEL    : in STD_LOGIC_VECTOR(1 downto 0);
                    Output  : out std_logic_vector(width - 1 downto 0)
                
                 );
    end component;
    
    component comparator is
              generic( width : positive );
              Port ( 
                        Input1  : in    std_logic_vector(width -1 downto 0);
                        Input2  : in    std_logic_vector(width -1 downto 0);
                        Output  : out   std_logic
                );
    end component;
    
    component DE_pipe_REG is
          generic( CU_Signals_Width : positive );
          Port ( 
                    clk             :   in std_logic;
                    reset           :   in std_logic;
                    FlushE          :   in std_logic;
                    
                    CU_SignalsD     :   in std_logic_vector(CU_Signals_Width - 1 downto 0);    
                    W1_RD1_D        :   in std_logic_vector(31 downto 0);
                    W1_RD2_D        :   in std_logic_vector(31 downto 0);
                    W1_rs_D         :   in std_logic_vector(4 downto 0);
                    W1_rt_D         :   in std_logic_vector(4 downto 0);
                    W1_rd_D         :   in std_logic_vector(4 downto 0);
                    W1_SignImm_D    :   in std_logic_vector(31 downto 0);
                    W1_ZeroPad_D    :   in std_logic_vector(31 downto 0);
                          
                    
                    W2_RD1_D        :   in std_logic_vector(31 downto 0);
                    W2_RD2_D        :   in std_logic_vector(31 downto 0);
                    W2_rs_D         :   in std_logic_vector(4 downto 0);
                    W2_rt_D         :   in std_logic_vector(4 downto 0);
                    W2_rD_D         :   in std_logic_vector(4 downto 0);
                    W2_SignImm_D    :   in std_logic_vector(31 downto 0);
                    W2_ZeroPad_D    :   in std_logic_vector(31 downto 0);    
                    
                    PCplus4_8D      :   in std_logic_vector(31 downto 0);
                    PCD      :   in std_logic_vector(31 downto 0);
                    
                    
                    CU_SignalsE     :   out std_logic_vector(CU_Signals_Width - 1 downto 0);         
                    W1_RD1_E        :   out std_logic_vector(31 downto 0);
                    W1_RD2_E        :   out std_logic_vector(31 downto 0);
                    W1_rs_E         :   out std_logic_vector(4 downto 0);
                    W1_rt_E         :   out std_logic_vector(4 downto 0);
                    W1_rd_E         :   out std_logic_vector(4 downto 0);
                    W1_SignImm_E    :   out std_logic_vector(31 downto 0);
                    W1_ZeroPad_E    :   out std_logic_vector(31 downto 0);      
                                        
                    W2_RD1_E        :   out std_logic_vector(31 downto 0);
                    W2_RD2_E        :   out std_logic_vector(31 downto 0);
                    W2_rs_E         :   out std_logic_vector(4 downto 0);
                    W2_rt_E         :   out std_logic_vector(4 downto 0);
                    W2_rD_E         :   out std_logic_vector(4 downto 0);
                    W2_SignImm_E    :   out std_logic_vector(31 downto 0);
                    W2_ZeroPad_E    :   out std_logic_vector(31 downto 0);    
                                    
                     PCplus4_8E      :   out std_logic_vector(31 downto 0);
                     PCE             :   out std_logic_vector(31 downto 0)         
                
                 );
        end component;
        
        component ALU 
            port
                (
                   ALUinput1,ALUinput2  : in STD_LOGIC_VECTOR(31 downto 0);
                   ALUctrl              :  in STD_LOGIC_VECTOR(3 downto 0);
                   output               : out STD_LOGIC_VECTOR(31 downto 0);
                   zero                 : out std_logic;
                   carryOut             : out STD_LOGIC;
                   overflow : out std_logic
                );
         end component;
         
         component  EM_pipe_REG
              generic (cu_EM_signalsWidth : positive);
              Port ( 
                       clk                  : in std_logic;
                       reset                : in std_logic;
                       FlushM               : in std_logic;
                       
                       CU_Signals_E         : in std_logic_vector(cu_EM_signalsWidth - 1 downto 0);
                       PC_Plus4_8_E         : in std_logic_vector(31 downto 0); 
                       W1_ALUout_E          : in std_logic_vector(31 downto 0);
                       W1_writeData_E       : in std_logic_vector(31 downto 0);
                       W1_WriteReg_E        : in std_logic_vector(4 downto 0);
                       W1_zeroPad_E         : in std_logic_vector(31 downto 0);
                       W1_overflow_E         : in std_logic;
                       
                       W2_ALUout_E          : in std_logic_vector(31 downto 0);
                       W2_writeData_E       : in std_logic_vector(31 downto 0);
                       W2_writeReg_E        : in std_logic_vector(4 downto 0);
                       W2_zeroPad_E         : in std_logic_vector(31 downto 0);
                       W2_overflow_E         : in std_logic;
                       PCE                  :  in std_logic_vector(31 downto 0);
                       
                       CU_Signals_M         : OUT std_logic_vector(cu_EM_signalsWidth - 1 downto 0);
                       PC_Plus4_8_M         : OUT std_logic_vector(31 downto 0);
                       W1_ALUout_M          : OUT std_logic_vector(31 downto 0);
                       W1_writeData_M       : OUT std_logic_vector(31 downto 0);
                       W1_WriteReg_M        : OUT std_logic_vector(4 downto 0);
                       W1_zeroPad_M         : OUT std_logic_vector(31 downto 0);
                       W1_overflow_M        : Out std_logic;
                                              
                       W2_ALUout_M          : OUT std_logic_vector(31 downto 0);
                       W2_writeData_M       : OUT std_logic_vector(31 downto 0);
                       W2_writeReg_M        : OUT std_logic_vector(4 downto 0);
                       W2_zeroPad_M         : OUT std_logic_vector(31 downto 0);
                       W2_overflow_M        : Out std_logic;       
                       PCM                 :  out std_logic_vector(31 downto 0)        
            );
        end component;
        
        component MW_pipe_REG is
                generic (CU_signals_Width : positive);
              Port ( 
                        clk                 : in std_logic;
                        reset               : in std_logic;
                        FlushW              : IN std_logic;
                        
                        CU_Signals_M        : in std_logic_vector(CU_signals_Width - 1 downto 0);
                        W1_ALUout_M         : in std_logic_vector(31 downto 0);
                        W1_ReadData_M       : in std_logic_vector(31 downto 0);
                        W1_writeReg_M       : in std_logic_vector(4 downto 0);
                        W1_overflow_M       : in std_logic;
                        
                        
                        W2_ALUout_M         : in std_logic_vector(31 downto 0);
                        W2_ReadData_M       : in std_logic_vector(31 downto 0);
                        W2_writeReg_M       : in std_logic_vector(4 downto 0);
                        W2_overflow_M       : in std_logic; 
                        PCm                  :  in std_logic_vector(31 downto 0);
                        
                        
                        CU_Signals_W        : out std_logic_vector(CU_signals_Width - 1 downto 0);
                        W1_ALUout_W         : out std_logic_vector(31 downto 0);
                        W1_ReadData_W       : out std_logic_vector(31 downto 0);
                        W1_writeReg_W       : out std_logic_vector(4 downto 0);
                        W1_overflow_W      : out std_logic;
                        
                                             
                        W2_ALUout_W         : out std_logic_vector(31 downto 0);
                        W2_ReadData_W       : out std_logic_vector(31 downto 0);
                        W2_writeReg_W       : out std_logic_vector(4 downto 0);
                        W2_overflow_W      : out std_logic;
                        PCW                  :  out std_logic_vector(31 downto 0)
                            
                     );
                end component;
                
                component CauseReg 
                  Port (    
                            clk, En : in std_logic;
                            d       : in std_logic_vector(31 downto 0);
                            q       : out std_logic_vector(31 downto 0)
                        );
                end component;
                
                component EPC 
                  Port (
                            clk, En : in std_logic;
                            d       : in std_logic_vector(31 downto 0);
                            q       : out std_logic_vector(31 downto 0)
                         );
                end component;
                
--                component whichway_Reg is
--                 Port ( 
--                            clk, En : in std_logic;
--                            d       : in std_logic_vector(31 downto 0);
--                            q       : out std_logic_vector(31 downto 0)
--                         );
--                end component;
                
               component  mux_5select is
                  Port ( 
                            Input1  : in std_logic_vector(31 downto 0);
                            Input2  : in std_logic_vector(31 downto 0);
                            muxSEL  : in std_logic_vector(4 downto 0);
                            Output  : out std_logic_vector(31 downto 0)
                         );
                end component;
              
                    
                
                

             

    ----------------------------------------------------------------------
    --Fetch Stage Signals
    ----------------------------------------------------------------------
     signal     pcIn, pcOut             : std_logic_vector(31 downto 0);
     signal     Instr1, Instr2          : std_logic_vector(31 downto 0);
     signal     PC_AdderMux_Sig         : std_logic;
     signal     PC_AdderInput_1         : std_logic_vector(31 downto 0);
     signal     PC_plus4_8_F            : std_logic_vector(31 downto 0);
     signal     Flush_FD_pipe_REG       : STD_LOGIC;
     
     ---------------------------------------------------------------------
     --Decode Stage Signals
     ---------------------------------------------------------------------
     signal     PC_Branch_D             : std_logic_vector(31 downto 0);
     signal     PC_Jump_D               : std_logic_vector(31 downto 0);
     signal     pc_Jr_D                 : std_logic_vector(31 downto 0);
     signal     Instr1D, Instr2D        : std_logic_vector(31 downto 0);
     signal     PC_plus4_8_D            : std_logic_vector(31 downto 0);
     
     signal     W1_RD1_D                  : std_logic_vector(31 downto 0);
     signal     W1_RD2_D                 : std_logic_vector(31 downto 0);
     signal     W2_RD1_D                  : std_logic_vector(31 downto 0);
     signal     W2_RD2_D                  : std_logic_vector(31 downto 0);
     
     signal     W1_SignImm_D               : std_logic_vector(31 downto 0); 
     signal     W1_sl2_SignImm_D           : std_logic_vector(31 downto 0); 
     signal     W2_SignImm_D               : std_logic_vector(31 downto 0);  
     
     signal     W1_UpperImm                : std_logic_vector(31 downto 0); 
     signal     W2_UpperImm                : std_logic_vector(31 downto 0);
     signal     compIn1                     : std_logic_vector(31 downto 0);
     signal     compIn2                     : std_logic_vector(31 downto 0);
     
     signal     CU_ControlSigs_D            : STD_logic_vector(26 downto 0);
     signal     CU1_ControlSigs_D            : STD_logic_vector(13 downto 0);
     signal     CU2_ControlSigs_D            : STD_logic_vector(12 downto 0);
     
     signal Flush_DE_pipe_REG                  : STD_logic;
     signal RegWriteFinal_W1                   : std_logic;
     signal RegWriteFinal_W2                   : std_logic;
     
     
     ---------------------------------------------------------------------
     --Execute Stage Signals
     ---------------------------------------------------------------------
     signal     CU_ControlSigs_E            : STD_logic_vector(26 downto 0);
     signal     CU1_ControlSigs_E            : STD_logic_vector(13 downto 0);
     signal     CU2_ControlSigs_E            : STD_logic_vector(12 downto 0);
                
     signal    CU1_ShamtSel_E                :  std_logic;                    
     signal    CU1_regWrite_E                :  std_logic;                    
     signal    CU1_memtoReg_E                :  std_logic;                    
     signal    CU1_memWrite_E                :  std_logic;                    
     signal    CU1_ALUControl_E              :  std_logic_vector(3 downto 0); 
     signal    CU1_ALUSrc_E                  :  std_logic;                    
     signal    CU1_RegDst_E                  :  std_logic;                    
     signal    CU1_lui_E                     :  std_logic;                  
     signal    CU1_Jal_E                     :  std_logic;                   
     
     signal    CU2_ShamtSel_E               :   std_logic;                    
     signal    CU2_regWrite_E               :   std_logic;                    
     signal    CU2_memtoReg_E               :   std_logic;                    
     signal    CU2_memWrite_E               :   std_logic;                    
     signal    CU2_ALUControl_E            :   std_logic_vector(3 downto 0); 
     signal    CU2_ALUSrc_E                :   std_logic;                    
     signal    CU2_RegDst_E                :   std_logic;                    
     signal    CU2_lui_E                   :   std_logic;        
     
     signal CU1_unknownOp_E                 :  std_logic;
     signal CU2_unknownOp_E                 :  std_logic;            

     signal     W1_RD1_E                    : std_logic_vector(31 downto 0);
     signal     W1_RD2_E                    : std_logic_vector(31 downto 0);
     signal     W1_rs_E                     : std_logic_vector(4 downto 0 );
     signal     W1_rt_E                     : std_logic_vector(4 downto 0 );
     signal     W1_rd_E                     : std_logic_vector(4 downto 0 );
     signal     W1_SignImm_E                : std_logic_vector(31 downto 0 );
     signal     W1_ZeroPad_E                : std_logic_vector(31 downto 0 );
                                            
     signal     W2_RD1_E                    : std_logic_vector(31 downto 0);
     signal     W2_RD2_E                    : std_logic_vector(31 downto 0);
     signal     W2_rs_E                     : std_logic_vector(4 downto 0 );
     signal     W2_rt_E                     : std_logic_vector(4 downto 0 );
     signal     W2_rD_E                     : std_logic_vector(4 downto 0 );
     signal     W2_SignImm_E                : std_logic_vector(31 downto 0);
     signal     W2_ZeroPad_E                : std_logic_vector(31 downto 0);
     signal     PCplus4_8E                  : std_logic_vector(31 downto 0);
     
     signal     W1_writeRegE                   : std_logic_vector(4 downto 0);
     signal     W2_writeRegE                   : std_logic_vector(4 downto 0);
     signal     W1_prewriteRegMUX_SEL          : std_logic_vector(1 downto 0);
     
     signal     W1_srcA_E                      : STD_LOGIC_VECTOR(31 downto 0);
     signal     W1_srcB_E                      : STD_LOGIC_VECTOR(31 downto 0);
     signal     W2_srcA_E                      : STD_LOGIC_VECTOR(31 downto 0);
     signal     W2_srcB_E                      : STD_LOGIC_VECTOR(31 downto 0);
     
     signal     W1_ALUout_E                    : STD_LOGIC_VECTOR(31 downto 0); 
     signal     W2_ALUout_E                    : STD_LOGIC_VECTOR(31 downto 0); 
     
     signal     CU_ControlSigs_E_M             : std_logic_vector(12 downto 0);
     signal     CU1_ControlSigs_E_M            : STD_logic_vector(6 downto 0);
     signal     CU2_ControlSigs_E_M            : STD_logic_vector(5 downto 0);
     
     SIGNAL     W1_writeData_E                 : STD_LOGIC_vector(31 downto 0);
     SIGNAL     W2_writeData_E                 : STD_LOGIC_vector(31 downto 0);
     
     ---------------------------------------------------------------------
     --Memory Stage Signals
     ---------------------------------------------------------------------
     
     signal CU1_ControlSigs_M               : STD_logic_vector(6 downto 0);
     signal CU2_ControlSigs_M               : STD_logic_vector(5 downto 0);
     
     signal     W1_preSrcAE_MUX             : std_logic_vector(31 downto 0); 
     signal     W1_preSrcBE_MUX             : std_logic_vector(31 downto 0); 
     signal     W2_preSrcAE_MUX             : std_logic_vector(31 downto 0); 
     signal     W2_preSrcBE_MUX             : std_logic_vector(31 downto 0); 
 
     signal     CU_Signals_M                : std_logic_vector(12 downto 0);
     signal     PC_Plus4_8_M                : std_logic_vector(31 downto 0);
     signal     W1_ALUout_M                 : std_logic_vector(31 downto 0);
     signal     W1_writeData_M              : std_logic_vector(31 downto 0);
     signal     W1_WriteReg_M               : std_logic_vector(4 downto 0);
     signal     W1_zeroPad_M                : std_logic_vector(31 downto 0);
                      
     signal     W2_ALUout_M                 : std_logic_vector(31 downto 0); 
     signal     W2_writeData_M              : std_logic_vector(31 downto 0); 
     signal     W2_writeReg_M               : std_logic_vector(4 downto 0);  
     signal     W2_zeroPad_M                : std_logic_vector(31 downto 0); 
     
     signal CU1_regWrite_M                  : std_logic;
     signal CU1_memtoReg_M                  : std_logic;
     signal CU1_memWrite_M                  : std_logic;
     signal CU1_lui_M                       : std_logic;
     signal CU1_Jal_M                       : std_logic;
                                            
     signal CU2_regWrite_M                  : std_logic;
     signal CU2_memtoReg_M                  : std_logic;
     signal CU2_memWrite_M                  : std_logic;
     signal CU2_lui_M                       : std_logic;
     
     signal CU1_unknownOp_M                 :  std_logic;
     signal CU2_unknownOp_M                 :  std_logic;  
     
     signal ALUoutMres_mux_SEL              : std_logic_vector(1 downto 0);
     
     
     
     signal     W1_ALUoutMres               : std_logic_vector(31 downto 0);
     signal     W2_ALUoutMres               : std_logic_vector(31 downto 0);
     
     signal     CU_ControlSigs_M_W          : std_logic_vector(7 downto 0);
     signal     CU1_ControlSigs_M_W         : std_logic_vector(3 downto 0);
     signal     CU2_ControlSigs_M_W         : std_logic_vector(3 downto 0);  
     
     signal     CU1_regWrite_W           : std_logic;
     signal     CU2_regWrite_W           : std_logic;
     signal     W1_writeReg_W            :   std_logic_vector(4 downto 0);
     signal     W2_writeReg_W            :   std_logic_vector(4 downto 0);
     signal     W1_Result_W              :   std_logic_vector(31 downto 0); 
     signal     W2_Result_W              :   std_logic_vector(31 downto 0); 
        
     signal CU_Signals_W                    : std_logic_vector(7 downto 0);
     signal W1_ALUout_W                     : std_logic_vector(31 downto 0);
     signal W1_ReadData_W                   : std_logic_vector(31 downto 0);
     
                                            
                                            
     signal W2_ALUout_W                     : std_logic_vector(31 downto 0);
     signal W2_ReadData_W                   : std_logic_vector(31 downto 0);
     
     
     signal CU1_ControlSigs_W               : std_logic_vector(3 downto 0);
     signal CU2_ControlSigs_W               : std_logic_vector(3 downto 0);
     
     
     SIGNAL CU1_memtoReg_W                   : STD_LOGIC;
     SIGNAL CU2_memtoReg_W                  : STD_LOGIC;
     
     
     ----------------------------------------------------------------------------------------------------------
     --Exceptions
     ---------------------------------------------------------------------------------------------------------------------------
     SIGNAL CauseCode_Q, EPC_q                              : std_logic_vector(31 downto 0);
     SIGNAL overflow1, overflow2                   : STD_LOGIC;
     
     signal CU1_unknownOp_W                  :  std_logic;
     signal CU2_unknownOp_W,  W1_overflow_M,  W2_overflow_M, W1_overflow_W, W2_overflow_W                 :  std_logic;  
     
     signal     PCD            : std_logic_vector(31 downto 0);
     signal     PCE            : std_logic_vector(31 downto 0);
     signal     PCm            : std_logic_vector(31 downto 0);
     signal     PCW            : std_logic_vector(31 downto 0);
     
     signal CO_WriteData       : std_logic_vector(31 downto 0);
     signal CO_WriteData2       : std_logic_vector(31 downto 0);
     
     signal W1_result_MuxMap2_SelectSig    : std_logic_vector(1 downto 0);
     signal W2_result_MuxMap2_SelectSig    : std_logic_vector(1 downto 0);
     
      signal CU1_MFc0_W                  :  std_logic;
      signal CU1_MFc0_M                  :  std_logic;
      signal CU1_MFc0_E                  :  std_logic;
      
      signal CU2_MFc0_W                  :  std_logic;
      signal CU2_MFc0_M                  :  std_logic;
      signal CU2_MFc0_E                  :  std_logic;
      
      signal PCmuxSEL                    :  std_logic_vector(4 downto 0);
      
     
begin


--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------FETCH STAGE LOGIC AND MAPS------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
pcRegisterMap   : pcflopr port map(
                                         clk       => clk,
                                         reset     => reset,
                                         StallPC   => HU_StallF,
                                         d         => pcIn,
                                         q         => pcOut
                                   );
                                   
 pc <= pcOut;
 
 Scheduler_Map       : Two_Issue_Scheduler port map (
                                                            Instr1        =>    IMem_Instr1_F ,
                                                            Instr2        =>    IMem_Instr2_F ,
                                                            EX_Instr1     =>    Instr1,
                                                            EX_Instr2     =>    Instr2,
                                                            PC_Adder_Mux  =>    PC_AdderMux_Sig                                                
                                                );

PC_Adder_mUX_map    : generic_2_input_mux generic map(32)
                                          port map(
                                                        MUX_in1  => x"0000_0008",
                                                        MUX_in2  => x"0000_0004",
                                                        Mux_SEL  => PC_AdderMux_Sig,
                                                        Mux_Out  => PC_AdderInput_1
                                                                                                                                                            
                                                   );   
                                                   
Pc_Adder             :   Adder32 port map (
                                                 Add32i1   => PC_AdderInput_1,
                                                 Add32i2   => pcOut,
                                                 Cin32     => '0',
                                                 Add32Sum  => PC_plus4_8_F,
                                                 Cout32    => open,
                                                  overflow => open                                          
                                           );
PCmuxSEL <=     PCBit &  CU1_pcSrc_D;                               

pc_Mux_map          :   pc_Mux generic map(32)
                                                port map(
                                                            i1     =>   PC_plus4_8_F,
                                                            i2     =>   PC_Branch_D,
                                                            i3     =>   PC_Jump_D,                                                           
                                                            i4     =>   PC_Jump_D,                                                           
                                                            i5     =>   pc_Jr_D,
                                                            i6     =>   x"80000180",
                                                            iSel   =>   PCmuxSEL,
                                                            Output =>   pcIn
                                                        
                                                        );

--Flush_FD_pipe_REG  <= '0' when HU_StallD = '1' else '1' when (CU1_pcSrc_D(3) = '1' or  CU1_pcSrc_D(2) = '1' or CU1_pcSrc_D(1) = '1');

FlushFD_pipe_REGFprocess : process(HU_stallD, CU1_pcSrc_D, PCBit)
                                begin 
                                    if (HU_stallD = '1') then 
                                            Flush_FD_pipe_REG <= '0';
                                    else
                                            Flush_FD_pipe_REG <= CU1_pcSrc_D(3) or CU1_pcSrc_D(2) or CU1_pcSrc_D(1) or CU1_pcSrc_D(0) or PCBit;
                                    end if;
                                end process;


FD_pipe_REG_map     : FD_pipe_REG   port map (
                                                clk          =>     clk,
                                                stallF       =>     HU_StallD,
                                                reset        =>     reset,
                                                FlushF       =>     Flush_FD_pipe_REG, 
                                                Instr1F      =>     Instr1,
                                                Instr2F      =>     Instr2,
                                                PCplus4_8F   =>     PC_plus4_8_F,
                                                pcF          =>     pcOut,
                                                             
                                                            
                                                Instr1D      =>     Instr1D,
                                                Instr2D      =>     Instr2D,
                                                PCplus4_8D   =>     PC_plus4_8_D,
                                                pcD          =>     pcd
                                             );                                                        


--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------Decode STAGE LOGIC AND MAPS------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
CU1_Opcode  <= Instr1D(31 downto 26);
CU1_Funct   <= Instr1D(5  downto 0);
CU2_Opcode  <= Instr2D(31 downto 26);
CU2_Funct   <= Instr2D(5  downto 0);


HU_BranchD           <=         CU1_Branch_D;
HU_BranchnotEqualD   <=         CU1_BranchNotEqual_D;
HU_JrD               <=         CU1_Jr_D;


PC_Jump_D <= PC_plus4_8_D(31 downto 28) & Instr1D(25 downto 0) & "00";

RegWriteFinal_W1 <= CU1_regWrite_W when PCBit = '0' else '0';
RegWriteFinal_W2 <= CU2_regWrite_W when PCBit = '0' else '0';


registerFileMap :   registerFile port map (
                                                clk     => clk,
                                                W1WE    => RegWriteFinal_W1,
                                                W2WE    => RegWriteFinal_W2,
                                                W1A1    => Instr1D(25 downto 21),      
                                                W1A2    => Instr1D(20 downto 16),    
                                                W1WA    => W1_writeReg_W, 
                                                W1WD    => W1_Result_W,      
                                                W1RD1   => W1_RD1_D,     
                                                W1RD2   => W1_RD2_D,      
                                                            
                                                W2A1    => Instr2D(25 downto 21),      
                                                W2A2    => Instr2D(20 downto 16),      
                                                W2WA    => W2_writeReg_W,              
                                                W2WD    => W2_Result_W,                
                                                W2RD1   => W2_RD1_D,                     
                                                W2RD2   => W2_RD2_D                      
                                          );  
                                          
HU_W1_RS_D           <=    Instr1D(25 downto 21);    
HU_W1_RT_D           <=    Instr1D(20 downto 16);    
HU_W2_RS_D           <=    Instr2D(25 downto 21);            
HU_W2_RT_D           <=    Instr2D(20 downto 16);     


W1_SignImm_Extender_MAP  : signExtender generic map(16) 
                                        port map(
                                                    Input  => Instr1D(15 downto 0),
                                                    Output => W1_SignImm_D
                                                );

W1_Shift_SignedImm_MAP      : sl2 port map(
                                                a =>  W1_SignImm_D,
                                                b =>  W1_sl2_SignImm_D
                                           );


W1_PCBranchAddress_Calulation_MAP   :   Adder32 port map (
                                                 Add32i1   => W1_sl2_SignImm_D,
                                                 Add32i2   => PC_plus4_8_D,
                                                 Cin32     => '0',
                                                 Add32Sum  => PC_Branch_D,
                                                 Cout32    => open                                             
                                           );


W1_ZeroPadding_For_Lui_MAP          : zeroPadder generic map(16)
                                                 port map (
                                                            Input  => Instr1D(15 downto 0),
                                                            Output =>  W1_UpperImm 
                                                          );


W2_SignImm_Extender_MAP             : signExtender generic map(16) 
                                        port map(
                                                    Input  => Instr2D(15 downto 0),
                                                    Output => W2_SignImm_D
                                                );


W2_ZeroPadding_For_Lui_MAP          : zeroPadder generic map(16)
                                                 port map (
                                                            Input  => Instr2D(15 downto 0),
                                                            Output =>  W2_UpperImm 
                                                          );      

                                        
Comparator_iNPUT1_Mux_MAP           : generic_four_Input_Mux generic map (32)
                                                                port map (
                                                                                 i1      =>  W1_RD1_D,
                                                                                 i2      =>  W1_ALUoutMres,
                                                                                 i3      =>  W2_ALUoutMres,
                                                                                 i4      =>  x"0000_0000",
                                                                                 iSEL    =>  HU_W1_ForwardAD,
                                                                                 Output  =>  compIn1
                                                                         );
                                                                        

Comparator_iNPUT2_Mux_MAP           : generic_four_Input_Mux generic map (32)
                                                                port map (
                                                                                 i1      =>  W1_RD2_D,
                                                                                 i2      =>  W1_ALUoutMres,
                                                                                 i3      =>  W2_ALUoutMres,
                                                                                 i4      =>  x"0000_0000",
                                                                                 iSEL    =>  HU_W1_ForwardBD,
                                                                                 Output  =>  compIn2
                                                                         );
                                                                         
                                                                         
comparator_MAP                       : comparator    generic map(32)
                                                    port map (
                                                                    Input1  => compIn1,
                                                                    Input2  => compIn2, 
                                                                    Output  => CU1_Equal_D 
                                                               );                                                                       


PcJrd_Mux                           : generic_four_Input_Mux generic map (32)
                                                                port map (
                                                                                 i1      =>  W1_RD1_D,
                                                                                 i2      =>  W1_ALUoutMres,
                                                                                 i3      =>  W2_ALUoutMres,
                                                                                 i4      =>  x"0000_0000",
                                                                                 iSEL    =>  HU_W1_ForwardCD,
                                                                                 Output  =>  pc_Jr_D 
                                                                         );
                                                                         
                                                                         

CU1_ControlSigs_D  <=       CU1_MFc0_D         &
                            CU1_unknownOp_D    &             
                            CU1_ShamtSel_D   &
                            CU1_regWrite_D   &
                            CU1_memtoReg_D   &
                            CU1_memWrite_D   &
                            CU1_ALUControl_D &
                            CU1_ALUSrc_D     &
                            CU1_RegDst_D     &
                            CU1_lui_D        &
                            CU1_Jal_D        ;
                            
                            
                            
 CU2_ControlSigs_D  <=      CU2_MFc0_D         &
                            CU2_unknownOp_D    &
                            CU2_ShamtSel_D     &
                            CU2_regWrite_D     &
                            CU2_memtoReg_D     &
                            CU2_memWrite_D     &
                            CU2_ALUControl_D   &
                            CU2_ALUSrc_D       &
                            CU2_RegDst_D       &
                            CU2_lui_D          ;
                            
                            
                            
  CU_ControlSigs_D  <=    CU1_ControlSigs_D  &  CU2_ControlSigs_D;
  
  
Flush_DE_pipe_REG <= HU_FlushE or PcBit;


DE_pipe_REG_MAP :  DE_pipe_REG generic map (27)
                               port map (
                                         clk               =>    clk,     
                                         reset             =>    reset,     
                                         FlushE            =>    Flush_DE_pipe_REG,      
                                                              
                                         CU_SignalsD       =>    CU_ControlSigs_D,
                                         W1_RD1_D          =>    W1_RD1_D,
                                         W1_RD2_D          =>    W1_RD2_D,     
                                         W1_rs_D           =>    Instr1D(25 downto 21),     
                                         W1_rt_D           =>    Instr1D(20 downto 16),    
                                         W1_rd_D           =>    Instr1D(15 downto 11),     
                                         W1_SignImm_D      =>    W1_SignImm_D,    
                                         W1_ZeroPad_D      =>    W1_UpperImm,    
                                                          
                                         W2_RD1_D          =>     W2_RD1_D,                   
                                         W2_RD2_D          =>     W2_RD2_D,                 
                                         W2_rs_D           =>     Instr2D(25 downto 21),    
                                         W2_rt_D           =>     Instr2D(20 downto 16),    
                                         W2_rD_D           =>     Instr2D(15 downto 11),    
                                         W2_SignImm_D      =>     W2_SignImm_D,             
                                         W2_ZeroPad_D      =>     W2_UpperImm,              
                                                                 
                                         PCplus4_8D        =>    PC_plus4_8_D,     
                                         PCD               =>    pcD,
                                                                
                                         CU_SignalsE       =>    CU_ControlSigs_E,     
                                         W1_RD1_E          =>    W1_RD1_E      ,     
                                         W1_RD2_E          =>    W1_RD2_E      ,     
                                         W1_rs_E           =>    W1_rs_E       ,     
                                         W1_rt_E           =>    W1_rt_E       ,     
                                         W1_rd_E           =>    W1_rd_E       ,     
                                         W1_SignImm_E      =>    W1_SignImm_E  ,     
                                         W1_ZeroPad_E      =>    W1_ZeroPad_E  ,     
                                                                               
                                         W2_RD1_E          =>    W2_RD1_E      ,     
                                         W2_RD2_E          =>    W2_RD2_E      ,     
                                         W2_rs_E           =>    W2_rs_E       ,     
                                         W2_rt_E           =>    W2_rt_E       ,     
                                         W2_rD_E           =>    W2_rD_E       ,     
                                         W2_SignImm_E      =>    W2_SignImm_E  ,     
                                         W2_ZeroPad_E      =>    W2_ZeroPad_E  ,     
                                                           
                                         PCplus4_8E       =>    PCplus4_8E    ,
                                         PCE              =>    pcE   
                                        );                   
 
 --------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------Execute STAGE LOGIC AND MAPS------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
 CU1_ControlSigs_E <=   CU_ControlSigs_E(26 downto 13);
 CU2_ControlSigs_E <=   CU_ControlSigs_E( 12 downto 0);
 
 CU1_MFc0_E         <= CU1_ControlSigs_E(13);
 CU1_unknownOp_E    <= CU1_ControlSigs_E(12);
 CU1_ShamtSel_E     <= CU1_ControlSigs_E(11);
 CU1_regWrite_E     <= CU1_ControlSigs_E(10);
 CU1_memtoReg_E     <= CU1_ControlSigs_E(9);
 CU1_memWrite_E     <= CU1_ControlSigs_E(8);
 CU1_ALUControl_E   <= CU1_ControlSigs_E(7 downto 4);
 CU1_ALUSrc_E       <= CU1_ControlSigs_E(3);
 CU1_RegDst_E       <= CU1_ControlSigs_E(2);
 CU1_lui_E          <= CU1_ControlSigs_E(1);
 CU1_Jal_E          <= CU1_ControlSigs_E(0);
    
    CU2_MFc0_E           <= CU2_ControlSigs_E(12);
    CU2_unknownOp_E      <= CU2_ControlSigs_E(11);
    CU2_ShamtSel_E       <= CU2_ControlSigs_E(10);           
    CU2_regWrite_E       <= CU2_ControlSigs_E(9);           
    CU2_memtoReg_E       <= CU2_ControlSigs_E(8);           
    CU2_memWrite_E       <= CU2_ControlSigs_E(7);           
    CU2_ALUControl_E     <= CU2_ControlSigs_E(6 downto 3); 
    CU2_ALUSrc_E         <= CU2_ControlSigs_E(2);           
    CU2_RegDst_E         <= CU2_ControlSigs_E(1);           
    CU2_lui_E            <= CU2_ControlSigs_E(0);     
    

HU_W1_RS_E    <=  W1_rs_E ;
HU_W1_RT_E    <=  W1_rt_E ;    
HU_W2_RS_E    <=  W2_rs_E ;
HU_W2_RT_E    <=  W2_rt_E ;

HU_W1_regWriteE  <= CU1_regWrite_E;
HU_W2_regWriteE  <= CU2_regWrite_E;
                
HU_W1_WriteRegE  <= W1_writeRegE ;
HU_W2_WriteRegE  <= W2_writeRegE ;

HU_W1_memtoRegE     <=    CU1_memtoReg_E;
HU_W2_memtoRegE     <=    CU2_memtoReg_E;




 W1_ForwardAE_MUX_MAP   :   generic_eight_input_Mux generic map(32)
                                                port map(
                                                            i1     =>   W1_RD1_E,   ------Way1 RD1
                                                            i2     =>   W1_Result_W,--------wAY1 ResultW
                                                            i3     =>   W1_ALUoutMres,------ Way1 ALuOut
                                                            i4     =>   W2_Result_W, --------Way2 ResultW
                                                            i5     =>   W2_ALUoutMres, -------Way2 AluOut
                                                            i6     =>   X"0000_0000",
                                                            i7     =>   X"0000_0000",
                                                            i8     =>   x"0000_0000",
                                                            iSel   =>   HU_W1_ForwardAE, ---hAZARD Way1 Forward AE
                                                            Output =>   W1_preSrcAE_MUX ------PreSrcAE Way1 
                                                        
                                                        );
 
 W1_ForwardBE_MUX_MAP   :   generic_eight_input_Mux generic map(32)
                                                port map(
                                                            i1     =>   W1_RD2_E,       -----Way 1 RD2
                                                            i2     =>   W1_Result_W,    ----Way1 Result W
                                                            i3     =>   W1_ALUoutMres,  -----Way1 ALUout result
                                                            i4     =>   W2_Result_W,    -----Way2 ResultW
                                                            i5     =>   W2_ALUoutMres,  ----Way2 ALUout ResultW
                                                            i6     =>   X"0000_0000",
                                                            i7     =>   X"0000_0000",
                                                            i8     =>   x"0000_0000",
                                                            iSel   =>   HU_W1_ForwardBE, ----Hazard Way1 ForwardBE
                                                            Output =>   W1_preSrcBE_MUX 
                                                        
                                                        );
 
 W2_ForwardAE_MUX_MAP   :   generic_eight_input_Mux generic map(32)
                                                port map(
                                                            i1     =>   W2_RD1_E,
                                                            i2     =>   W2_Result_W,  
                                                            i3     =>   W2_ALUoutMres,
                                                            i4     =>   W1_Result_W,   
                                                            i5     =>   W1_ALUoutMres, 
                                                            i6     =>   X"0000_0000",
                                                            i7     =>   X"0000_0000",
                                                            i8     =>   x"0000_0000",
                                                            iSel   =>   HU_W2_ForwardAE, 
                                                            Output =>   W2_preSrcAE_MUX 
                                                        
                                                        );
 
 W2_ForwardBE_MUX_MAP   :   generic_eight_input_Mux generic map(32)
                                                port map(
                                                            i1     =>   W2_RD2_E,
                                                            i2     =>   W2_Result_W,  
                                                            i3     =>   W2_ALUoutMres,
                                                            i4     =>   W1_Result_W,   
                                                            i5     =>   W1_ALUoutMres, 
                                                            i6     =>   X"0000_0000",
                                                            i7     =>   X"0000_0000",
                                                            i8     =>   x"0000_0000",
                                                            iSel   =>   HU_W2_ForwardBE, 
                                                            Output =>   W2_preSrcBE_MUX 
                                                        
                                                        );
W1_prewriteRegMUX_SEL <= CU1_Jal_E & CU1_RegDst_E;  
                                           
W1_prewriteReg_MUX_MAP: generic_four_Input_Mux generic map (5)
                                                                port map (
                                                                                 i1      =>  W1_rt_E,
                                                                                 i2      =>  W1_rd_E,
                                                                                 i3      =>  "11111",
                                                                                 i4      =>  "00000",
                                                                                 iSEL    =>  W1_prewriteRegMUX_SEL,
                                                                                 Output  =>  W1_writeRegE 
                                                                         );

W2_prewriteReg_MUX_MAP  : generic_2_input_mux generic map(5)
                                          port map(
                                                        MUX_in1  => W2_rt_E,
                                                        MUX_in2  => W2_rd_E,
                                                        Mux_SEL  => CU2_RegDst_E,
                                                        Mux_Out  => W2_writeRegE
                                                 );       


W1_srcAE_MUX            : generic_2_input_mux generic map(32)
                                          port map(
                                                        MUX_in1  =>  W1_preSrcAE_MUX,
                                                        MUX_in2  =>  W1_SignImm_E,
                                                        Mux_SEL  =>  CU1_ShamtSel_E,
                                                        Mux_Out  =>  W1_srcA_E
                                                 );  

W1_srcBE_MUX             : generic_2_input_mux generic map(32)
                                          port map(
                                                        MUX_in1  =>  W1_preSrcBE_MUX,
                                                        MUX_in2  =>  W1_SignImm_E,
                                                        Mux_SEL  =>  CU1_ALUSrc_E,
                                                        Mux_Out  =>  W1_srcB_E
                                                 );  


W2_srcAE_MUX            : generic_2_input_mux generic map(32)
                                          port map(
                                                        MUX_in1  =>  W2_preSrcAE_MUX,
                                                        MUX_in2  =>  W2_SignImm_E,
                                                        Mux_SEL  =>  CU2_ShamtSel_E,
                                                        Mux_Out  =>  W2_srcA_E
                                                 );  

W2_srcBE_MUX            : generic_2_input_mux generic map(32)
                                          port map(
                                                        MUX_in1  =>  W2_preSrcBE_MUX,
                                                        MUX_in2  =>  W2_SignImm_E,
                                                        Mux_SEL  =>  CU2_ALUSrc_E,
                                                        Mux_Out  =>  W2_srcB_E
                                                 );  


W1_ALU_MAP              :   alu port map (
                                          ALUinput1          =>     W1_srcA_E,
                                          ALUinput2          =>     W1_srcB_E, 
                                          ALUctrl            =>     CU1_ALUControl_E,
                                          output             =>     W1_ALUout_E,  
                                          zero               =>     open,
                                          carryOut           =>     open,
                                          overflow           =>     overflow1       
                                      );
                                      

W2_ALU_MAP              :   alu port map (
                                          ALUinput1          =>     W2_srcA_E,
                                          ALUinput2          =>     W2_srcB_E, 
                                          ALUctrl            =>     CU2_ALUControl_E,
                                          output             =>     W2_ALUout_E,  
                                          zero               =>     open,
                                          carryOut           =>     open,
                                          overflow           =>     overflow2       
                                      );                                      


CU1_ControlSigs_E_M <=      CU1_MFc0_E       & ----7  ---11
                            CU1_unknownOp_E   & ---6  --10
                            CU1_regWrite_E   &  ---5  --9
                            CU1_memtoReg_E   &  ---4  --8
                            CU1_memWrite_E   &  ---3  --7
                            CU1_lui_E        &-----2  --6
                            CU1_Jal_E        ;-----1  --5


CU2_ControlSigs_E_M     <=  CU2_MFc0_E         &
                            CU2_unknownOp_E    &    -----5   4
                            CU2_regWrite_E     &    ----4  ---3
                            CU2_memtoReg_E     &    ---3  ---2
                            CU2_memWrite_E     &    ---2   --1
                            CU2_lui_E          ;    ----1  --0


CU_ControlSigs_E_M <= CU1_ControlSigs_E_M & CU2_ControlSigs_E_M;
W1_writeData_E      <=      W1_preSrcBE_MUX;
W2_writeData_E      <=      W2_preSrcBE_MUX;

EM_pipe_REG_MAP     : EM_pipe_REG   generic map(13)
                                    port map (
                                                clk              =>     clk,
                                                reset            =>     reset,
                                                FlushM           =>     PcBit,
                                                                    
                                                CU_Signals_E     =>     CU_ControlSigs_E_M,
                                                PC_Plus4_8_E     =>     PCplus4_8E,
                                                W1_ALUout_E      =>     W1_ALUout_E,
                                                W1_writeData_E   =>     W1_writeData_E,
                                                W1_WriteReg_E    =>     W1_writeRegE ,
                                                W1_zeroPad_E     =>     W1_ZeroPad_E ,
                                                                    
                                                W2_ALUout_E      =>     W2_ALUout_E,
                                                W2_writeData_E   =>     W2_writeData_E,
                                                W2_writeReg_E    =>     W2_writeRegE  ,
                                                W2_zeroPad_E     =>     W2_ZeroPad_E,
                                                
                                                pcE             =>     PCE,
                                                                    
                                                CU_Signals_M     =>       CU_Signals_M    ,
                                                PC_Plus4_8_M     =>       PC_Plus4_8_M    ,
                                                W1_ALUout_M      =>       W1_ALUout_M     ,
                                                W1_writeData_M   =>       W1_writeData_M  ,
                                                W1_WriteReg_M    =>       W1_WriteReg_M   ,
                                                W1_zeroPad_M     =>       W1_zeroPad_M    ,
                                                                                          
                                                W2_ALUout_M      =>       W2_ALUout_M     ,
                                                W2_writeData_M   =>       W2_writeData_M  ,
                                                W2_writeReg_M    =>       W2_writeReg_M   ,
                                                W2_zeroPad_M     =>       W2_zeroPad_M    ,
                                                
                                                 W1_overflow_E   =>       overflow1,
                                                 W2_overflow_E   =>       overflow2,
                                                 W1_overflow_M   =>       W1_overflow_M,
                                                 W2_overflow_M   =>       W2_overflow_M,
                                                 
                                                 pcM            =>        pcM
                                                                                          
                                                    );

--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------Memory STAGE LOGIC AND MAPS------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
DP_W1_ALUout_M <=   W1_ALUout_M;
DP_W2_ALUout_M <=   W2_ALUout_M;       

DP_W1_writeData_M  <= W1_writeData_M;
DP_W2_writeData_M  <= W2_writeData_M;        

DP_W1_memWrite_M <= CU1_memWrite_M;
DP_W2_memWrite_M <= CU2_memWrite_M;                            
                                              
CU1_ControlSigs_M <= CU_Signals_M(12 downto 6);
CU2_ControlSigs_M <= CU_Signals_M(5 downto 0);

CU1_MFc0_M          <=      CU1_ControlSigs_M(6) ;
CU1_unknownOp_M     <=      CU1_ControlSigs_M(5) ;
CU1_regWrite_M      <=     CU1_ControlSigs_M(4) ;
CU1_memtoReg_M       <=     CU1_ControlSigs_M(3) ;
CU1_memWrite_M       <=     CU1_ControlSigs_M(2) ;
CU1_lui_M            <=     CU1_ControlSigs_M(1) ;
CU1_Jal_M            <=     CU1_ControlSigs_M(0) ;

CU2_MFc0_M          <=    CU2_ControlSigs_M(5) ;
CU2_unknownOp_M     <=    CU2_ControlSigs_M(4) ;
CU2_regWrite_M     <=     CU2_ControlSigs_M(3) ;--&    ----4  ---3
CU2_memtoReg_M     <=     CU2_ControlSigs_M(2) ;--&    ---3  ---2 
CU2_memWrite_M     <=     CU2_ControlSigs_M(1) ;--&    ---2   --1 
CU2_lui_M          <=     CU2_ControlSigs_M(0) ;--;    ----1  --0 


HU_W1_WriteReg_M   <=  W1_WriteReg_M;
HU_W1_RegWrite_M   <=  CU1_regWrite_M;
HU_W1_memtoRegM    <=  CU1_memtoReg_M; 

HU_W2_WriteReg_M   <=  W2_WriteReg_M; 
HU_W2_RegWrite_M   <=  CU2_regWrite_M;
HU_W2_memtoRegM    <=  CU2_memtoReg_M;

ALUoutMres_mux_SEL <= CU1_lui_M & CU1_Jal_M;

W1_ALUoutMres_mux_MAP:      generic_four_Input_Mux generic map (32)
                                                                port map (
                                                                                 i1      =>  W1_ALUout_M,
                                                                                 i2      =>  PC_Plus4_8_M,
                                                                                 i3      =>  W1_zeroPad_M,
                                                                                 i4      =>  x"0000_0000",
                                                                                 iSEL    =>  ALUoutMres_mux_SEL,
                                                                                 Output  =>  W1_ALUoutMres
                                                                         ); 

W2_ALUoutMres_mux_MAP           : generic_2_input_mux generic map(32)
                                          port map(
                                                        MUX_in1  =>     W2_ALUout_M,
                                                        MUX_in2  =>     W2_zeroPad_M,
                                                        Mux_SEL  =>     CU2_lui_M,
                                                        Mux_Out  =>     W2_ALUoutMres
                                                 );  
                                                 
 
 

CU1_ControlSigs_M_W <=      CU1_MFc0_M       &
                            CU1_unknownOp_M  & 
                            CU1_regWrite_M   &  ---3  --1
                            CU1_memtoReg_M   ;  ---2  --0

CU2_ControlSigs_M_W     <=  CU2_MFc0_M         &
                            CU2_unknownOp_M    &
                            CU2_regWrite_M     &    ----1  ---1
                            CU2_memtoReg_M     ;   ---0  ---0
                                                     
                           
CU_ControlSigs_M_W <= CU1_ControlSigs_M_W & CU2_ControlSigs_M_W;


 MW_pipe_REG_MAP                : MW_pipe_REG generic map(8)  
                                  port MAP (
                                                clk                 =>  clk,       
                                                reset               =>  reset,
                                                FlushW              =>  PCBit,
                                                
                                                                
                                                CU_Signals_M        =>  CU_ControlSigs_M_W,
                                                W1_ALUout_M         =>  W1_ALUoutMres,
                                                W1_ReadData_M       =>  Dmem_readData1_M,
                                                W1_writeReg_M       =>  W1_WriteReg_M,
                                                W1_overflow_M       =>  W1_overflow_M,
                                                
                                                                
                                                W2_ALUout_M         =>  W2_ALUoutMres,
                                                W2_ReadData_M       =>  Dmem_readData2_M,
                                                W2_writeReg_M       =>  W2_WriteReg_M,
                                                W2_overflow_M       =>  W2_overflow_M,
                                                
                                                pcM                 => pcM,
                                                                
                                                CU_Signals_W        => CU_Signals_W   , 
                                                W1_ALUout_W         => W1_ALUout_W    ,
                                                W1_ReadData_W       => W1_ReadData_W  ,
                                                W1_writeReg_W       => W1_writeReg_W  ,
                                                W1_overflow_W       =>  W1_overflow_W,
                                                                                      
                                                                                      
                                                W2_ALUout_W         => W2_ALUout_W    ,
                                                W2_ReadData_W       => W2_ReadData_W  ,
                                                W2_writeReg_W       => W2_writeReg_W  ,
                                                W2_overflow_W       => W2_overflow_W  ,
                                                
                                                pcW                 => pcW
                                           );                                              
 --------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------WriteBack STAGE LOGIC AND MAPS-------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------   

CU1_ControlSigs_W <= CU_Signals_W(7 downto 4);
CU2_ControlSigs_W <= CU_Signals_W(3 downto 0);

CU1_MFc0_W        <=  CU1_ControlSigs_W(3);
CU1_unknownOp_W   <=  CU1_ControlSigs_W(2);
CU1_regWrite_W  <=  CU1_ControlSigs_W(1);
CU1_memtoReg_W  <=  CU1_ControlSigs_W(0);

CU2_MFc0_W        <=  CU2_ControlSigs_W(3); 
CU2_unknownOp_W   <=  CU2_ControlSigs_W(2);               
CU2_regWrite_W  <=    CU2_ControlSigs_W(1);                                        
CU2_memtoReg_W  <=    CU2_ControlSigs_W(0);

HU_W1_regWrite_W   <= CU1_regWrite_W;
HU_W1_WriteReg_W   <= W1_writeReg_W;

HU_W2_regWrite_W    <= CU2_regWrite_W;
HU_W2_writeReg_W    <= W2_writeReg_W;

W1_result_MuxMap2_SelectSig <= CU1_MFc0_W & CU1_memtoReg_W;
W2_result_MuxMap2_SelectSig <= CU2_MFc0_W & CU2_memtoReg_W;

--W1_result_MUX_MAP           : generic_2_input_mux generic map(32)
--                                          port map(
--                                                        MUX_in1  =>     W1_ALUout_W,
--                                                        MUX_in2  =>     W1_ReadData_W,
--                                                        Mux_SEL  =>     CU1_memtoReg_W,
--                                                        Mux_Out  =>     W1_Result_W
--                                                 );       
W1_result_MUX_MAP2          :   generic_four_Input_Mux generic map(32)
                                            port map(
                                                    i1      =>  W1_ALUout_W,  
                                                    i2      =>  W1_ReadData_W,
                                                    i3      =>  CO_WriteData,
                                                    i4      =>  x"0000_0000",
                                                    iSEL    =>  W1_result_MuxMap2_SelectSig,
                                                    Output  =>  W1_Result_W
                                                );
    
--W2_result_MUX_MAP           : generic_2_input_mux generic map(32)
--                                          port map(
--                                                        MUX_in1  =>     W2_ALUout_W,
--                                                        MUX_in2  =>     W2_ReadData_W,
--                                                        Mux_SEL  =>     CU2_memtoReg_W,
--                                                        Mux_Out  =>     W2_Result_W
--                                                 );       

W2_result_MUX_MAP2          :   generic_four_Input_Mux generic map(32)
                                            port map(
                                                    i1      =>  W2_ALUout_W,  
                                                    i2      =>  W2_ReadData_W,
                                                    i3      =>  CO_WriteData2,
                                                    i4      =>  x"0000_0000",
                                                    iSEL    =>  W2_result_MuxMap2_SelectSig,
                                                    Output  =>  W2_Result_W
                                                );


DP_W1_unknownOp_W <= CU1_unknownOp_W;
DP_W2_unknownOp_W <= CU2_unknownOp_W;


DP_W1_overflow <= W1_overflow_W;
DP_W2_overflow <= W2_overflow_W;


CauseReg_Map  : CauseReg Port map (    
                                        clk  =>  clk,
                                        En   =>  CauseWrite,
                                        d    =>  CauseCode,
                                        q    =>  CauseCode_Q
                                   );
               
EPCReg_Map    : EPC Port map (
                            clk    =>   clk,
                            En     =>   EPCWrite,     
                            d      =>   pcW,      
                            q      =>   EPC_Q    
                         );

C0_mux_5select : mux_5select Port MAP( 
                            Input1  => CauseCode_Q,
                            Input2  => EPC_Q,
                            muxSEL  => W1_writeReg_W,
                            Output  => CO_WriteData
                         );

C0_mux_5select2 : mux_5select Port MAP( 
                            Input1  => CauseCode_Q,
                            Input2  => EPC_Q,
                            muxSEL  => W2_writeReg_W,
                            Output  => CO_WriteData2
                         );


 
 
end Behavioral;
