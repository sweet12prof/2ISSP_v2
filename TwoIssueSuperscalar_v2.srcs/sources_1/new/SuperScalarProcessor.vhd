----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2020 04:06:09 PM
-- Design Name: 
-- Module Name: SuperScalarProcessor - Behavioral
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

entity SuperScalarProcessor is
  Port ( 
            clk              : std_logic;        
            reset            : std_logic;
           
            pc               : out std_logic_vector(31 downto 0);
     
            DP_W1_ALUout     : out std_logic_vector(31 downto 0);
            DP_W2_ALUout     : out std_logic_vector(31 downto 0);
                              
            DP_W1_writeData  : out std_logic_vector(31 downto 0);
            DP_W2_writeData  : out std_logic_vector(31 downto 0);
           
            Dmem_readData1   : in std_logic_vector(31 downto 0);
            Dmem_readData2   : in std_logic_vector(31 downto 0);
            IMem_Instr1      : in std_logic_vector(31 downto 0);
            IMem_Instr2      : in std_logic_vector(31 downto 0);
            DP_W1_memWrite   : out std_logic;
            DP_W2_memWrite   : out std_logic;
            
             DP_W1_unknownOp             : OUT std_logic;
             DP_W2_unknownOp               : out std_logic
            
            
        );
end SuperScalarProcessor;

architecture Behavioral of SuperScalarProcessor is
        component Datapath is
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
                              
                              DP_W1_unknownOp_W              : OUT std_logic;
                              DP_W2_unknownOp_W               : out std_logic;
        
                              Dmem_readData1_M                : in std_logic_vector(31 downto 0);
                              Dmem_readData2_M                : in std_logic_vector(31 downto 0);
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
                              HU_W2_ForwardBE                 : in std_logic_vector(2 downto 0)
                              
        
                          );
      end component;
      
      
      component ControlUnit is
         Port (
            CU1_Opcode                  : in std_logic_vector(5 downto 0);    
            CU1_Funct                   : in std_logic_vector(5 downto 0);    
            CU2_Opcode                  : in std_logic_vector(5 downto 0);    
            CU2_Funct                   : in std_logic_vector(5 downto 0);    
                                  
                                  
            CU1_ShamtSel_D              : out std_logic;                        
            CU1_regWrite_D              : out std_logic;                        
            CU1_memtoReg_D              : out std_logic;                        
            CU1_memWrite_D              : out std_logic;                        
            CU1_ALUControl_D            : out std_logic_vector(3 downto 0);     
            CU1_ALUSrc_D                : out std_logic;                        
            CU1_RegDst_D                : out std_logic;                        
            CU1_lui_D                   : out std_logic;                      
            CU1_Jal_D                   : out std_logic;                       
                                          
            CU1_Jr_D                    : out std_logic;                       
            --CU1_Jump_D                : out std_logic;                     
            CU1_Branch_D                : out std_logic;                      
            CU1_BranchNotEqual_D        : out std_logic;                      
            CU1_pcSrc_D                 : out std_logic_vector(3 downto 0);    
            CU1_Equal_D                 : in STD_LOGIC;                       
                                  
                                  
            CU2_ShamtSel_D              : out std_logic;                        
            CU2_regWrite_D              : out std_logic;                        
            CU2_memtoReg_D              : out std_logic;                        
            CU2_memWrite_D              : out std_logic;                        
            CU2_ALUControl_D            : out std_logic_vector(3 downto 0);     
            CU2_ALUSrc_D                : out std_logic;                        
            CU2_RegDst_D                : out std_logic;                        
            CU2_lui_D                   : out std_logic;
            
            CU1_unknownOp               : out std_logic;
            CU2_unknownOp               : out std_logic                      
          );
        end component;
        
        component HazardUnit 
            Port (
                HU_W1_RS_E                      : in std_logic_vector(4 downto 0);
                HU_W1_RT_E                      : in std_logic_vector(4 downto 0);
                HU_W1_WriteReg_M                : in std_logic_vector(4 downto 0);
                HU_W1_WriteReg_W                : in std_logic_vector(4 downto 0);
                HU_W1_RegWrite_M                : in std_logic;                   
                HU_W1_RegWrite_W                : in std_logic;                   
                                                                               
                HU_W2_RS_E                      : in std_logic_vector(4 downto 0);
                HU_W2_RT_E                      : in std_logic_vector(4 downto 0);
                HU_W2_WriteReg_M                : in std_logic_vector(4 downto 0);
                HU_W2_WriteReg_W                : in std_logic_vector(4 downto 0);
                HU_W2_RegWrite_M                : in std_logic;                   
                HU_W2_RegWrite_W                : in std_logic;                   
                                                                            
                HU_W1_RS_D                      : in std_logic_vector(4 downto 0);
                HU_W1_RT_D                      : in std_logic_vector(4 downto 0);
                                                                               
                HU_W2_RS_D                      : in std_logic_vector(4 downto 0);
                HU_W2_RT_D                      : in std_logic_vector(4 downto 0);
                                                                               
                HU_W1_memtoRegE                 : in std_logic;                   
                HU_W2_memtoRegE                 : in std_logic;                   
                                                                               
                HU_W1_memtoRegM                 : in std_logic;                   
                HU_W2_memtoRegM                 : in std_logic;                   
                                                                               
                HU_W1_regWriteE                 : in std_logic;                   
                HU_W2_regWriteE                 : in std_logic;                   
                                                                               
                HU_W1_WriteRegE                 : in std_logic_vector(4 downto 0);
                HU_W2_WriteRegE                 : in std_logic_vector(4 downto 0);
                                                                             
                HU_BranchD                      : in std_logic;                   
                HU_BranchnotEqualD              : in std_logic;                   
                HU_JrD                          : in std_logic;                   
                                                                                   
                HU_StallF                       : out std_logic;                    
                HU_StallD                       : out std_logic;                    
                HU_FlushE                       : out std_logic;                    
                                                                                 
                HU_W1_ForwardAD                 : out std_logic_vector(1 downto 0); 
                HU_W1_ForwardBD                 : out std_logic_vector(1 downto 0); 
                HU_W1_ForwardCD                 : out std_logic_vector(1 downto 0); 
                                                                                
                HU_W1_ForwardAE                 : out std_logic_vector(2 downto 0); 
                HU_W1_ForwardBE                 : out std_logic_vector(2 downto 0); 
                                                                                
                HU_W2_ForwardAE                 : out std_logic_vector(2 downto 0); 
                HU_W2_ForwardBE                 : out std_logic_vector(2 downto 0)          
        );
            end component;
            
            
           -----------------------
           ---CU Signals
           ---------------------- 
            signal CU1_Opcode                  :    std_logic_vector(5 downto 0);    
            signal CU1_Funct                   :    std_logic_vector(5 downto 0);    
            signal CU2_Opcode                  :    std_logic_vector(5 downto 0);    
            signal CU2_Funct                   :    std_logic_vector(5 downto 0);    
                                                                              
                                                                             
            signal CU1_ShamtSel_D              :     std_logic;                      
            signal CU1_regWrite_D              :     std_logic;                      
            signal CU1_memtoReg_D              :     std_logic;                      
            signal CU1_memWrite_D              :     std_logic;                      
            signal CU1_ALUControl_D            :     std_logic_vector(3 downto 0);   
            signal CU1_ALUSrc_D                :     std_logic;                      
            signal CU1_RegDst_D                :     std_logic;                      
            signal CU1_lui_D                   :     std_logic;                      
            signal CU1_Jal_D                   :     std_logic;                      
                                                                              
            signal CU1_Jr_D                    :     std_logic;                      
          --CU1_Jup_D                : out std_lo   ;                      
            signal CU1_Branch_D                :     std_logic;                      
            signal CU1_BranchNotEqual_D        :     std_logic;                      
            signal CU1_pcSrc_D                 :     std_logic_vector(3 downto 0);   
            signal CU1_Equal_D                 :    STD_LOGIC;                       
                                                                              
                                                                              
            signal CU2_ShamtSel_D              :     std_logic;                      
            signal CU2_regWrite_D              :     std_logic;                      
            signal CU2_memtoReg_D              :     std_logic;                      
            signal CU2_memWrite_D              :     std_logic;                      
            signal CU2_ALUControl_D            :     std_logic_vector(3 downto 0);   
            signal CU2_ALUSrc_D                :     std_logic;                      
            signal CU2_RegDst_D                :     std_logic;                      
            signal CU2_lui_D                   :     std_logic;     
            signal CU1_unknownOp               :  std_logic;
            signal CU2_unknownOp               :  std_logic;                 
   
   
   -------------------------
   ---HU Signals
   --------------------------
            signal     HU_W1_RS_E                      : std_logic_vector(4 downto 0);        
            signal     HU_W1_RT_E                      : std_logic_vector(4 downto 0);        
            signal     HU_W1_WriteReg_M                : std_logic_vector(4 downto 0);        
            signal     HU_W1_WriteReg_W                : std_logic_vector(4 downto 0);        
            signal     HU_W1_RegWrite_M                : std_logic;                           
            signal     HU_W1_RegWrite_W                : std_logic;                           
            
            signal     HU_W2_RS_E                      : std_logic_vector(4 downto 0);        
            signal     HU_W2_RT_E                      : std_logic_vector(4 downto 0);        
            signal     HU_W2_WriteReg_M                : std_logic_vector(4 downto 0);        
            signal     HU_W2_WriteReg_W                : std_logic_vector(4 downto 0);        
            signal     HU_W2_RegWrite_M                : std_logic;                           
            signal     HU_W2_RegWrite_W                : std_logic;                           
            
            signal     HU_W1_RS_D                      : std_logic_vector(4 downto 0);        
            signal     HU_W1_RT_D                      : std_logic_vector(4 downto 0);        
            
            signal     HU_W2_RS_D                      : std_logic_vector(4 downto 0);        
            signal     HU_W2_RT_D                      : std_logic_vector(4 downto 0);        
            
            signal     HU_W1_memtoRegE                 : std_logic;                           
            signal     HU_W2_memtoRegE                 : std_logic;                           
            
            signal     HU_W1_memtoRegM                 : std_logic;                           
            signal     HU_W2_memtoRegM                 : std_logic;                           
            
            signal     HU_W1_regWriteE                 : std_logic;                           
            signal     HU_W2_regWriteE                 : std_logic;                           
            
            signal     HU_W1_WriteRegE                 : std_logic_vector(4 downto 0);        
            signal     HU_W2_WriteRegE                 : std_logic_vector(4 downto 0);        
            
            signal     HU_BranchD                      : std_logic;                           
            signal     HU_BranchnotEqualD              : std_logic;                           
            signal     HU_JrD                          : std_logic;                           
            
            signal     HU_StallF                       :  std_logic;                          
            signal     HU_StallD                       :  std_logic;                          
            signal     HU_FlushE                       :  std_logic;                          
            
            signal     HU_W1_ForwardAD                 :  std_logic_vector(1 downto 0);       
            signal     HU_W1_ForwardBD                 :  std_logic_vector(1 downto 0);       
            signal     HU_W1_ForwardCD                 :  std_logic_vector(1 downto 0);       
            
            signal     HU_W1_ForwardAE                 :  std_logic_vector(2 downto 0);       
            signal     HU_W1_ForwardBE                 :  std_logic_vector(2 downto 0);       
            
            signal     HU_W2_ForwardAE                 :  std_logic_vector(2 downto 0);       
            signal     HU_W2_ForwardBE                 :  std_logic_vector(2 downto 0);        
   

   
begin
            
            
Datapath_PORT_MAP :  Datapath port map (
                                                clk                           =>    clk,
                                                reset                         =>    reset,
                                                                             
                                                pc                            =>    pc,
                                                ---------------------------   =>
                                                --Memory Signals              =>
                                                ---------------------------   =>
                                                IMem_Instr1_F                 =>    IMem_Instr1     ,    
                                                IMem_Instr2_F                 =>    IMem_Instr2     ,
                                                                                                   
                                                DP_W1_ALUout_M                =>    DP_W1_ALUout    ,
                                                DP_W2_ALUout_M                =>    DP_W2_ALUout    ,
                                                                                                  
                                                DP_W1_writeData_M             =>    DP_W1_writeData ,
                                                DP_W2_writeData_M             =>    DP_W2_writeData ,
                                                                                                   
                                                DP_W1_memWrite_M              =>    DP_W1_memWrite  ,
                                                DP_W2_memWrite_M              =>    DP_W2_memWrite ,
                                                
                                                DP_W1_unknownOp_W             =>    DP_W1_unknownOp,
                                                DP_W2_unknownOp_W             =>    DP_W2_unknownOp,
                                                                                                   
                                                Dmem_readData1_M              =>    Dmem_readData1 ,
                                                Dmem_readData2_M              =>    Dmem_readData2 ,
                                                ---------------------------   =>
                                                ---CU Signals                 =>
                                                ---------------------------   =>
                                                CU1_Opcode                    =>    CU1_Opcode          ,
                                                CU1_Funct                     =>    CU1_Funct           ,
                                                CU2_Opcode                    =>    CU2_Opcode          ,
                                                CU2_Funct                     =>    CU2_Funct           ,
                                                                                                      
                                                                                                      
                                                CU1_ShamtSel_D                =>    CU1_ShamtSel_D      ,
                                                CU1_regWrite_D                =>    CU1_regWrite_D      ,
                                                CU1_memtoReg_D                =>    CU1_memtoReg_D      ,
                                                CU1_memWrite_D                =>    CU1_memWrite_D      ,
                                                CU1_ALUControl_D              =>    CU1_ALUControl_D    ,
                                                CU1_ALUSrc_D                  =>    CU1_ALUSrc_D        ,
                                                CU1_RegDst_D                  =>    CU1_RegDst_D        ,
                                                CU1_lui_D                     =>    CU1_lui_D           ,
                                                CU1_Jal_D                     =>    CU1_Jal_D           ,
                                                                                                     
                                                CU1_Jr_D                      =>    CU1_Jr_D            ,
                                                --CU1_Jump_D                  =>    _D                
                                                CU1_Branch_D                  =>    CU1_Branch_D        ,
                                                CU1_BranchNotEqual_D          =>    CU1_BranchNotEqual_D,
                                                CU1_pcSrc_D                   =>    CU1_pcSrc_D         ,
                                                CU1_Equal_D                   =>    CU1_Equal_D         ,
                                                                                                     
                                                                                                     
                                                CU2_ShamtSel_D                =>    CU2_ShamtSel_D      ,
                                                CU2_regWrite_D                =>    CU2_regWrite_D      ,
                                                CU2_memtoReg_D                =>    CU2_memtoReg_D      ,
                                                CU2_memWrite_D                =>    CU2_memWrite_D      ,
                                                CU2_ALUControl_D              =>    CU2_ALUControl_D    ,
                                                CU2_ALUSrc_D                  =>    CU2_ALUSrc_D        ,
                                                CU2_RegDst_D                  =>    CU2_RegDst_D        ,
                                                CU2_lui_D                     =>    CU2_lui_D           ,
                                                ---------------------------   =>
                                                ---HU_Signals                 =>
                                                ---------------------------   =>
                                                HU_W1_RS_E                    =>    HU_W1_RS_E         ,       
                                                HU_W1_RT_E                    =>    HU_W1_RT_E         , 
                                                HU_W1_WriteReg_M              =>    HU_W1_WriteReg_M   , 
                                                HU_W1_WriteReg_W              =>    HU_W1_WriteReg_W   , 
                                                HU_W1_RegWrite_M              =>    HU_W1_RegWrite_M   , 
                                                HU_W1_RegWrite_W              =>    HU_W1_RegWrite_W   , 
                                                                                                        
                                                HU_W2_RS_E                    =>    HU_W2_RS_E         , 
                                                HU_W2_RT_E                    =>    HU_W2_RT_E         , 
                                                HU_W2_WriteReg_M              =>    HU_W2_WriteReg_M   , 
                                                HU_W2_WriteReg_W              =>    HU_W2_WriteReg_W   , 
                                                HU_W2_RegWrite_M              =>    HU_W2_RegWrite_M   , 
                                                HU_W2_RegWrite_W              =>    HU_W2_RegWrite_W   , 
                                                                                                        
                                                HU_W1_RS_D                    =>    HU_W1_RS_D         , 
                                                HU_W1_RT_D                    =>    HU_W1_RT_D         , 
                                                                                                        
                                                HU_W2_RS_D                    =>    HU_W2_RS_D         , 
                                                HU_W2_RT_D                    =>    HU_W2_RT_D         , 
                                                                                                       
                                                HU_W1_memtoRegE               =>    HU_W1_memtoRegE    , 
                                                HU_W2_memtoRegE               =>    HU_W2_memtoRegE    , 
                                                                                                       
                                                HU_W1_memtoRegM               =>    HU_W1_memtoRegM    , 
                                                HU_W2_memtoRegM               =>    HU_W2_memtoRegM    , 
                                                                                                       
                                                HU_W1_regWriteE               =>    HU_W1_regWriteE    , 
                                                HU_W2_regWriteE               =>    HU_W2_regWriteE    , 
                                                                                                        
                                                HU_W1_WriteRegE               =>    HU_W1_WriteRegE    , 
                                                HU_W2_WriteRegE               =>    HU_W2_WriteRegE    , 
                                                                                                      
                                                HU_BranchD                    =>    HU_BranchD         , 
                                                HU_BranchnotEqualD            =>    HU_BranchnotEqualD , 
                                                HU_JrD                        =>    HU_JrD             , 
                                                                                                       
                                                HU_StallF                     =>    HU_StallF          , 
                                                HU_StallD                     =>    HU_StallD          , 
                                                HU_FlushE                     =>    HU_FlushE          , 
                                                                                                    
                                                HU_W1_ForwardAD               =>    HU_W1_ForwardAD    , 
                                                HU_W1_ForwardBD               =>    HU_W1_ForwardBD    , 
                                                HU_W1_ForwardCD               =>    HU_W1_ForwardCD    , 
                                                                                                       
                                                HU_W1_ForwardAE               =>    HU_W1_ForwardAE    , 
                                                HU_W1_ForwardBE               =>    HU_W1_ForwardBE    , 
                                                                                                       
                                                HU_W2_ForwardAE               =>    HU_W2_ForwardAE    , 
                                                HU_W2_ForwardBE               =>    HU_W2_ForwardBE    ,
                                                CU1_unknownOp_D                   =>  CU1_unknownOp ,
                                                CU2_unknownOp_D                  =>  CU2_unknownOp 
                                       ); 



Hazard_PORT_MAP         : HazardUnit port map (
                                                  HU_W1_RS_E                    =>    HU_W1_RS_E         ,   
                                                  HU_W1_RT_E                    =>    HU_W1_RT_E         ,   
                                                  HU_W1_WriteReg_M              =>    HU_W1_WriteReg_M   ,   
                                                  HU_W1_WriteReg_W              =>    HU_W1_WriteReg_W   ,   
                                                  HU_W1_RegWrite_M              =>    HU_W1_RegWrite_M   ,   
                                                  HU_W1_RegWrite_W              =>    HU_W1_RegWrite_W   ,   
                                                                                                             
                                                  HU_W2_RS_E                    =>    HU_W2_RS_E         ,   
                                                  HU_W2_RT_E                    =>    HU_W2_RT_E         ,   
                                                  HU_W2_WriteReg_M              =>    HU_W2_WriteReg_M   ,   
                                                  HU_W2_WriteReg_W              =>    HU_W2_WriteReg_W   ,   
                                                  HU_W2_RegWrite_M              =>    HU_W2_RegWrite_M   ,   
                                                  HU_W2_RegWrite_W              =>    HU_W2_RegWrite_W   ,   
                                                                                                             
                                                  HU_W1_RS_D                    =>    HU_W1_RS_D         ,   
                                                  HU_W1_RT_D                    =>    HU_W1_RT_D         ,   
                                                                                                             
                                                  HU_W2_RS_D                    =>    HU_W2_RS_D         ,   
                                                  HU_W2_RT_D                    =>    HU_W2_RT_D         ,   
                                                                                                             
                                                  HU_W1_memtoRegE               =>    HU_W1_memtoRegE    ,   
                                                  HU_W2_memtoRegE               =>    HU_W2_memtoRegE    ,   
                                                                                                             
                                                  HU_W1_memtoRegM               =>    HU_W1_memtoRegM    ,   
                                                  HU_W2_memtoRegM               =>    HU_W2_memtoRegM    ,   
                                                                                                             
                                                  HU_W1_regWriteE               =>    HU_W1_regWriteE    ,   
                                                  HU_W2_regWriteE               =>    HU_W2_regWriteE    ,   
                                                                                                             
                                                  HU_W1_WriteRegE               =>    HU_W1_WriteRegE    ,   
                                                  HU_W2_WriteRegE               =>    HU_W2_WriteRegE    ,   
                                                                                                             
                                                  HU_BranchD                    =>    HU_BranchD         ,   
                                                  HU_BranchnotEqualD            =>    HU_BranchnotEqualD ,   
                                                  HU_JrD                        =>    HU_JrD             ,   
                                                                                                             
                                                  HU_StallF                     =>    HU_StallF          ,   
                                                  HU_StallD                     =>    HU_StallD          ,   
                                                  HU_FlushE                     =>    HU_FlushE          ,   
                                                                                                             
                                                  HU_W1_ForwardAD               =>    HU_W1_ForwardAD    ,   
                                                  HU_W1_ForwardBD               =>    HU_W1_ForwardBD    ,   
                                                  HU_W1_ForwardCD               =>    HU_W1_ForwardCD    ,   
                                                                                                             
                                                  HU_W1_ForwardAE               =>    HU_W1_ForwardAE    ,   
                                                  HU_W1_ForwardBE               =>    HU_W1_ForwardBE    ,   
                                                                                                             
                                                  HU_W2_ForwardAE               =>    HU_W2_ForwardAE    ,   
                                                  HU_W2_ForwardBE               =>    HU_W2_ForwardBE        
                                             );
                                           


ControlUnit_PORT_MAP        :      ControlUnit port map (
                                                                    
                                                                    CU1_Opcode                    =>    CU1_Opcode          ,   
                                                                    CU1_Funct                     =>    CU1_Funct           ,   
                                                                    CU2_Opcode                    =>    CU2_Opcode          ,   
                                                                    CU2_Funct                     =>    CU2_Funct           ,   
                                                                                                                                
                                                                                                                                
                                                                    CU1_ShamtSel_D                =>    CU1_ShamtSel_D      ,   
                                                                    CU1_regWrite_D                =>    CU1_regWrite_D      ,   
                                                                    CU1_memtoReg_D                =>    CU1_memtoReg_D      ,   
                                                                    CU1_memWrite_D                =>    CU1_memWrite_D      ,   
                                                                    CU1_ALUControl_D              =>    CU1_ALUControl_D    ,   
                                                                    CU1_ALUSrc_D                  =>    CU1_ALUSrc_D        ,   
                                                                    CU1_RegDst_D                  =>    CU1_RegDst_D        ,   
                                                                    CU1_lui_D                     =>    CU1_lui_D           ,   
                                                                    CU1_Jal_D                     =>    CU1_Jal_D           ,   
                                                                                                                                
                                                                    CU1_Jr_D                      =>    CU1_Jr_D            ,   
                                                                    --CU1_Jump_D                  =>    _D                      
                                                                    CU1_Branch_D                  =>    CU1_Branch_D        ,   
                                                                    CU1_BranchNotEqual_D          =>    CU1_BranchNotEqual_D,   
                                                                    CU1_pcSrc_D                   =>    CU1_pcSrc_D         ,   
                                                                    CU1_Equal_D                   =>    CU1_Equal_D         ,   
                                                                                                                                
                                                                                                                                
                                                                    CU2_ShamtSel_D                =>    CU2_ShamtSel_D      ,   
                                                                    CU2_regWrite_D                =>    CU2_regWrite_D      ,   
                                                                    CU2_memtoReg_D                =>    CU2_memtoReg_D      ,   
                                                                    CU2_memWrite_D                =>    CU2_memWrite_D      ,   
                                                                    CU2_ALUControl_D              =>    CU2_ALUControl_D    ,   
                                                                    CU2_ALUSrc_D                  =>    CU2_ALUSrc_D        ,   
                                                                    CU2_RegDst_D                  =>    CU2_RegDst_D        ,   
                                                                    CU2_lui_D                     =>    CU2_lui_D   ,
                                                                     CU1_unknownOp                => CU1_unknownOp,
                                                                     CU2_unknownOp                => CU2_unknownOp        
                                                            ); 


























end Behavioral;
