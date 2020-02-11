----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2020 12:27:32 PM
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
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
            CU2_lui_D                   : out std_logic                      
        );
end ControlUnit;

architecture Behavioral of ControlUnit is

component generic_Control
    port (
              CU_Opcode                 : in std_logic_vector(5 downto 0);  
              CU_Funct                  : in std_logic_vector(5 downto 0);  
              
              CU_ShamtSel_D             : out std_logic;                      
              CU_regWrite_D             : out std_logic;                    
              CU_memtoReg_D             : out std_logic;                    
              CU_memWrite_D             : out std_logic;                    
              CU_ALUControl_D           : out std_logic_vector(3 downto 0); 
              CU_ALUSrc_D               : out std_logic;                    
              CU_RegDst_D               : out std_logic;                    
              CU_lui_D                  : out std_logic;                    
              CU_Jal_D                  : out std_logic;                    
                                        
              CU_Jr_D                   : out std_logic;                    
              --CU1_Jump_D               : out std_logic;                    
              CU_Branch_D               : out std_logic;                    
              CU_BranchNotEqual_D       : out std_logic;                    
              CU_pcSrc_D                : out std_logic_vector(3 downto 0); 
              CU_Equal_D                : in STD_LOGIC                  
          );
end component;


begin
    
    W1_Control_signals_port_MAP: generic_Control port map (
                                                            CU_Opcode                   =>          CU1_Opcode,
                                                            CU_Funct                    =>          CU1_Funct ,
                                                                                        
                                                            CU_ShamtSel_D               =>          CU1_ShamtSel_D      ,
                                                            CU_regWrite_D               =>          CU1_regWrite_D      ,
                                                            CU_memtoReg_D               =>          CU1_memtoReg_D      ,
                                                            CU_memWrite_D               =>          CU1_memWrite_D      ,
                                                            CU_ALUControl_D             =>          CU1_ALUControl_D    ,
                                                            CU_ALUSrc_D                 =>          CU1_ALUSrc_D        ,
                                                            CU_RegDst_D                 =>          CU1_RegDst_D        ,
                                                            CU_lui_D                    =>          CU1_lui_D           ,
                                                            CU_Jal_D                    =>          CU1_Jal_D           ,
                                                                                                                        
                                                            CU_Jr_D                     =>          CU1_Jr_D            ,
                                                            --CU1_Jump_D                =>          --CU1_Jump_D        ,
                                                            CU_Branch_D                 =>          CU1_Branch_D        ,
                                                            CU_BranchNotEqual_D         =>          CU1_BranchNotEqual_D,
                                                            CU_pcSrc_D                  =>          CU1_pcSrc_D         ,
                                                            CU_Equal_D                  =>          CU1_Equal_D         
                                                            
                                                        );  
                                                        
                                                        
   
   
   W2_Control_signals_port_MAP  :    generic_Control port map (
                                                                    CU_Opcode                =>     CU2_Opcode,
                                                                    CU_Funct                 =>     CU2_Funct ,
                                                                                             
                                                                    CU_ShamtSel_D            =>    CU2_ShamtSel_D    ,
                                                                    CU_regWrite_D            =>    CU2_regWrite_D    ,
                                                                    CU_memtoReg_D            =>    CU2_memtoReg_D    ,
                                                                    CU_memWrite_D            =>    CU2_memWrite_D    ,
                                                                    CU_ALUControl_D          =>    CU2_ALUControl_D  ,
                                                                    CU_ALUSrc_D              =>    CU2_ALUSrc_D      ,
                                                                    CU_RegDst_D              =>    CU2_RegDst_D      ,
                                                                    CU_lui_D                 =>    CU2_lui_D         ,
                                                                    CU_Jal_D                 =>    open,
                                                                                            
                                                                    CU_Jr_D                  =>    open,     
                                                                    --CU1_Jump_D             =>    open,
                                                                    CU_Branch_D              =>    open,
                                                                    CU_BranchNotEqual_D      =>    open,
                                                                    CU_pcSrc_D               =>    open,
                                                                    CU_Equal_D               =>  '0'
                                                                ); 

end Behavioral;
