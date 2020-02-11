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

entity HazardUnit is
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
end HazardUnit;

architecture behave of HazardUnit is
        signal stallD_inter     : std_logic;
		signal lwstallD, branchstallD, jrstallD: STD_LOGIC;
		signal lwstallD_W1, branchstallD_W1, jrstallD_W1: STD_LOGIC;
		signal lwstallD_W2 : STD_LOGIC;
begin
    
    ---Forwarding Sources to D stage (branch Equality)
HU_FowardAD_process:     
                                   HU_W1_ForwardAD <= "01" when ((HU_W1_RS_D /= "00000") and (HU_W1_RS_D = HU_W1_WriteReg_M) and (HU_W1_RegWrite_M = '1')) else
                                                      "10" when ((HU_W1_RS_D /= "00000") and (HU_W1_RS_D = HU_W2_WriteReg_M) and (HU_W2_RegWrite_M = '1')) else 
                                                      "00";
                                   
HU_FowardBD_process:              
                                  HU_W1_ForwardBD  <= "01" when ((HU_W1_RT_D /= "00000") and (HU_W1_RT_D = HU_W1_WriteReg_M) and (HU_W1_RegWrite_M = '1')) else 
                                                      "10" when ((HU_W1_RT_D /= "00000") and (HU_W1_RT_D = HU_W2_WriteReg_M) and (HU_W2_RegWrite_M = '1')) else 
                                                      "00";

HU_FowardCD_process:     
                                   HU_W1_ForwardCD <= "01" when ((HU_W1_RS_D /= "00000") and (HU_W1_RS_D = HU_W1_WriteReg_M) and (HU_W1_RegWrite_M = '1')) else
                                                      "10" when ((HU_W1_RS_D /= "00000") and (HU_W1_RS_D = HU_W2_WriteReg_M) and (HU_W2_RegWrite_M = '1')) else 
                                                      "00";                                                      
 
 --------------Forwarding sources to E stage        
W1_ForwardAE_toExecuteStageprocess :     process(HU_W1_RS_E, HU_W1_WriteReg_M, HU_W1_RegWrite_M, HU_W1_WriteReg_W, HU_W1_RegWrite_W, 

                                                                     HU_W2_WriteReg_M, HU_W2_RegWrite_M, HU_W2_WriteReg_W, HU_W2_RegWrite_W)                              
                                        begin 
                                          HU_W1_ForwardAE <= "000";
                                          
                                            if (HU_W1_RS_E /= "00000") then 
                                                
                                                
                                                if((HU_W1_RS_E = HU_W1_WriteReg_M) and (HU_W1_RegWrite_M = '1')) then 
                                                   HU_W1_ForwardAE <= "010";
                                                
                                                 elsif(((HU_W1_RS_E = HU_W2_WriteReg_M) and (HU_W2_RegWrite_M = '1'))) then
                                                    HU_W1_ForwardAE <= "100";
                                                
                                                
                                                elsif( (HU_W1_RS_E = HU_W1_WriteReg_W) and (HU_W1_RegWrite_W = '1')) then 
                                                   HU_W1_ForwardAE <= "001";
                                                
                                               
                                                   
                                                elsif((HU_W1_RS_E = HU_W2_WriteReg_W) and (HU_W2_RegWrite_W = '1')) then 
                                                    HU_W1_ForwardAE <= "011";
                                                
                                                
                                                    
                                                end if;
                                            end if;
                                        end process; 
                                        

W1_ForwardBE_toExecuteStageprocess :     process(HU_W1_RT_E, HU_W1_WriteReg_M, HU_W1_RegWrite_M, HU_W1_WriteReg_W, HU_W1_RegWrite_W, 

                                                                     HU_W2_WriteReg_M, HU_W2_RegWrite_M, HU_W2_WriteReg_W, HU_W2_RegWrite_W)                              
                                        begin 
                                          HU_W1_ForwardBE <= "000";
                                          
                                            if (HU_W1_RT_E /= "00000") then 
                                            
                                            if((HU_W1_RT_E = HU_W1_WriteReg_M) and (HU_W1_RegWrite_M = '1')) then 
                                                   HU_W1_ForwardBE <= "010";
                                                   
                                                elsif(((HU_W1_RT_E = HU_W2_WriteReg_M) and (HU_W2_RegWrite_M = '1'))) then
                                                    HU_W1_ForwardBE <= "100";
                                                
                                                
                                                elsif( (HU_W1_RT_E = HU_W1_WriteReg_W) and (HU_W1_RegWrite_W = '1')) then 
                                                   HU_W1_ForwardBE <= "001";
                                                
                                                 
                                                   
                                                 elsif((HU_W1_RT_E = HU_W2_WriteReg_W) and (HU_W2_RegWrite_W = '1')) then 
                                                    HU_W1_ForwardBE <= "011";
                                                
                                               
                                                    
                                                end if;
                                            end if;
                                        end process; 
                                  
 
 
 W2_ForwardAE_toExecuteStageprocess :     process(HU_W2_RS_E, HU_W1_WriteReg_M, HU_W1_RegWrite_M, HU_W1_WriteReg_W, HU_W1_RegWrite_W, 

                                                                     HU_W2_WriteReg_M, HU_W2_RegWrite_M, HU_W2_WriteReg_W, HU_W2_RegWrite_W)                              
                                        begin 
                                          HU_W2_ForwardAE <= "000";
                                          
                                            if (HU_W2_RS_E /= "00000") then 
                                            
                                             if((HU_W2_RS_E = HU_W1_WriteReg_M) and (HU_W1_RegWrite_M = '1')) then 
                                                   HU_W2_ForwardAE <= "100";
                                                   
                                                 elsif(((HU_W2_RS_E = HU_W2_WriteReg_M) and (HU_W2_RegWrite_M = '1'))) then
                                                    HU_W2_ForwardAE <= "010";
                                                
                                                elsif( (HU_W2_RS_E = HU_W1_WriteReg_W) and (HU_W1_RegWrite_W = '1')) then 
                                                   HU_W2_ForwardAE <= "011";
                                                
                                               
                                                   
                                                elsif((HU_W2_RS_E = HU_W2_WriteReg_W) and (HU_W2_RegWrite_W = '1')) then 
                                                    HU_W2_ForwardAE <= "001";
                                                
                                               
                                                    
                                                end if;
                                            end if;
                                        end process; 
 
 W2_ForwardBE_toExecuteStageprocess :     process(HU_W2_RT_E, HU_W1_WriteReg_M, HU_W1_RegWrite_M, HU_W1_WriteReg_W, HU_W1_RegWrite_W, 

                                                                     HU_W2_WriteReg_M, HU_W2_RegWrite_M, HU_W2_WriteReg_W, HU_W2_RegWrite_W)                              
                                        begin 
                                          HU_W2_ForwardBE <= "000";
                                          
                                            if (HU_W2_RT_E /= "00000") then 
                                            
                                             if((HU_W2_RT_E = HU_W1_WriteReg_M) and (HU_W1_RegWrite_M = '1')) then 
                                                    HU_W2_ForwardBE <= "100";
                                               
                                               elsif(((HU_W2_RT_E = HU_W2_WriteReg_M) and (HU_W2_RegWrite_M = '1'))) then
                                                    HU_W2_ForwardBE <= "010";
                                               
                                                    
                                                elsif( (HU_W2_RT_E = HU_W1_WriteReg_W) and (HU_W1_RegWrite_W = '1')) then 
                                                    HU_W2_ForwardBE <= "011";
                                                
                                               
                                                   
                                                elsif((HU_W2_RT_E = HU_W2_WriteReg_W) and (HU_W2_RegWrite_W = '1')) then 
                                                    HU_W2_ForwardBE <= "001";
                                                
                                                
                                                    
                                                end if;
                                            end if;
                                        end process;
                                        
                                        
lwstallD_W1 <= '1' when ((HU_W1_memtoRegE = '1') and ((HU_W1_RT_E = HU_W1_RS_D) or (HU_W1_RT_E = HU_W1_RT_D))) else 
               '1' when ((HU_W1_memtoRegE = '1') and ((HU_W1_RT_E = HU_W2_RS_D) or (HU_W1_RT_E = HU_W2_RT_D))) else
	           '0';

lwstallD_W2 <= '1' when ((HU_W2_memtoRegE = '1') and ((HU_W2_RT_E = HU_W1_RS_D) or (HU_W2_RT_E = HU_W1_RT_D))) else 
               '1' when ((HU_W2_memtoRegE = '1') and ((HU_W2_RT_E = HU_W2_RS_D) or (HU_W2_RT_E = HU_W2_RT_D))) else
	           '0';

	
jrstallD_W1 <= '1' when ((HU_JrD = '1') and (((HU_W1_regWriteE = '1') and (HU_W1_WriteRegE = HU_W1_RS_D)) or ((HU_W1_memtoRegM = '1') and((HU_W1_WriteReg_M = HU_W1_RS_D))))) else 
               '1' when ((HU_JrD = '1') and (((HU_W2_regWriteE = '1') and (HU_W2_WriteRegE = HU_W1_RS_D)) or ((HU_W2_memtoRegM = '1') and((HU_W2_WriteReg_M = HU_W1_RS_D))))) else 
               '0';


branchstallD_W1 <= '1' when (((HU_BranchD = '1') or (HU_BranchnotEqualD = '1')) and ((( HU_W1_regWriteE = '1') and ((HU_W1_WriteRegE = HU_W1_RS_D) or 
(HU_W1_WriteRegE = HU_W1_RT_D))) or ((HU_W1_memtoRegM = '1') and((HU_W1_WriteReg_M = HU_W1_RS_D) or (HU_W1_WriteReg_M = HU_W1_RT_D)))))     else 

'1' when (((HU_BranchD = '1') or (HU_BranchnotEqualD = '1')) and ((( HU_W2_regWriteE = '1') and ((HU_W2_WriteRegE = HU_W1_RS_D) or 
(HU_W2_WriteRegE = HU_W1_RT_D))) or ((HU_W2_memtoRegM = '1') and((HU_W2_WriteReg_M = HU_W1_RS_D) or (HU_W2_WriteReg_M = HU_W1_RT_D)))))


else '0';

lwstallD        <=      lwstallD_W1 or lwstallD_W2;
branchstallD    <=      branchstallD_W1;  
jrstallD        <=      jrstallD_W1;


stallD_inter <= (lwstallD or branchstallD  or jrstallD);      
HU_StallD <= stallD_inter;
HU_StallF <= stallD_inter; -- stalling D stalls all previous stages
HU_FlushE  <= stallD_inter;-- stalling D flushes next stage                           
                                   
end behave;























