----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2020 12:47:03 PM
-- Design Name: 
-- Module Name: generic_Control - Behavioral
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

entity generic_Control is
  Port ( 
                CU_Opcode                       : in std_logic_vector(5 downto 0);   
                CU_Funct                        : in std_logic_vector(5 downto 0);   
                                   
                CU_ShamtSel_D                   : out std_logic;                     
                CU_regWrite_D                   : out std_logic;                     
                CU_memtoReg_D                   : out std_logic;                     
                CU_memWrite_D                   : out std_logic;                     
                CU_ALUControl_D                 : out std_logic_vector(3 downto 0);  
                CU_ALUSrc_D                     : out std_logic;                     
                CU_RegDst_D                     : out std_logic;                     
                CU_lui_D                        : out std_logic;                     
                CU_Jal_D                        : out std_logic;                     
                                   
                CU_Jr_D                         : out std_logic;                     
                --CU1_Jump_D                     : out std_logic;                    
                CU_Branch_D                     : out std_logic;                     
                CU_BranchNotEqual_D             : out std_logic;                     
                CU_pcSrc_D                      : out std_logic_vector(3 downto 0);  
                CU_Equal_D                      : in STD_LOGIC;  
                
                CU_unknownOp               : out std_logic
                                 
      );
end generic_Control;

architecture Behavioral of generic_Control is
   component mainDEC
   		port(
                op           : in std_logic_vector(5 downto 0);
                memWrite     : out std_logic;
                memtoReg     : out std_logic;
                regWrite     : out std_logic;
                regDst       : out std_logic;
                alusrc       : out std_logic; 
                branch       : out std_logic;
                bne          : out std_logic;
                ALUOp        : out std_logic_vector(2 downto 0);
                jump         : out std_logic;
                jal          : out std_logic;
                lui          : out std_logic;
                haltCPU      : out std_logic;
                unknownOp    : out std_logic
   		   );
   	end component;
   	
   	component aluDEC
   		port(
                funct        : in std_logic_vector(5 downto 0);
                ALUOp        : in std_logic_vector(2 downto 0);
                alucontrol   : out std_logic_vector(3 downto 0);
                shifts       : out std_logic;
                jr           : out std_logic
   			);
    end component;

    signal branchSig, branchNotequalSig, preSrc, preSrc2, preSrcFinal, jumpSig,  aludecShifts,jalSig, jrSig, haltCPUsig : std_logic;     
    signal ALUopSig : std_logic_vector(2 downto 0);                                                
   
begin
        md: mainDEC port map(                                               
                                 op       =>  CU_Opcode,                           
                                 memWrite =>  CU_memWrite_D,                     
                                 memtoReg =>  CU_memtoReg_D ,                     
                                 regWrite =>  CU_regWrite_D,                     
                                 regDst   =>  CU_RegDst_D,                       
                                 alusrc   =>  CU_ALUSrc_D,                       
                                 branch   =>  branchSig,  
                                 bne      =>  branchNotequalSig,                   
                                 ALUOp    =>  ALUopSig,                     
                                 jump     =>  jumpSig,                      
                                 jal      =>  jalSig,     
                                 lui      =>  CU_lui_D,                 
                                 haltCPU  =>  haltCPUsig,
                                 unknownOp => CU_unknownOp                 
                              );                                            
                                                                            
        ad: aluDEC port map(                                                
                                  funct      => CU_Funct,                      
                                  ALUOp      => ALUopSig,                   
                                  alucontrol => CU_ALUControl_D,                 
                                  shifts     => aludecShifts,               
                                  jr         => jrSig                       
                            );                                              
        
        --haltCPU <= haltCPUsig;
	    CU_Jal_D <= jalSig;
	    preSrc <= branchSig and CU_Equal_D;
	    preSrc2 <= branchNotequalSig and (not CU_Equal_D);
	    preSrcFinal <= preSrc or preSrc2;
	    CU_pcSrc_D <=  jrSig & jalSig & jumpSig & preSrcFinal;
	    CU_Branch_D <= branchSig;
	    CU_BranchNotEqual_D <= branchNotequalSig;
	    --jump <= jumpSig;
	    CU_Jr_D <= jrSig;
	    CU_ShamtSel_D <= aludecShifts;
end Behavioral;
