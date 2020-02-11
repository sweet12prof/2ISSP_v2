----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2020 04:41:06 PM
-- Design Name: 
-- Module Name: Top_MemoryInterface - Behavioral
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

entity Top_MemoryInterface is
  Port (
            clk                 : in std_logic;
            reset               : in std_logic;
            
            WriteData1          : out std_logic_vector(31 downto 0);
            WriteData2          : out std_logic_vector(31 downto 0);
            
            dataAdr1            : out std_logic_vector(31 downto 0);
            dataAdr2            : out std_logic_vector(31 downto 0);
            
            memWrite1           : out std_logic;
            memWrite2           : out std_logic
         );
end Top_MemoryInterface;

architecture Behavioral of Top_MemoryInterface is
    component SuperScalarProcessor is
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
                    DP_W2_memWrite   : out std_logic
                
                
            );
      end component;
    
      component DataMemory is
              Port (
                        clk         : in std_logic;                        
                        W1_A        : in std_logic_vector(7 downto 0);     
                        W1_WD       : IN std_logic_vector(31 downto 0);    
                        W1_RD       : OUT std_logic_vector(31 downto 0);   
                        W1_memWrite : in std_logic;                        
                                                                           
                        W2_A        : in std_logic_vector(7 downto 0);     
                        W2_WD       : IN std_logic_vector(31 downto 0);    
                        W2_RD       : out std_logic_vector(31 downto 0);   
                        W2_memWrite : in std_logic                         
                                                
             );
        end COMPONENT;
        
        component Two_port_simple_ROM is
              Port ( 
                        A               : in std_logic_vector(7 downto 0);
                        ReadData1       : out std_logic_vector(31 downto 0);
                        ReadData2       : out std_logic_vector(31 downto 0)
                     );
        end component;
        
        
       signal pc               :   std_logic_vector(31 downto 0);   
                                                           
       signal DP_W1_ALUout     :   std_logic_vector(31 downto 0);   
       signal DP_W2_ALUout     :   std_logic_vector(31 downto 0);   
                                                              
       signal DP_W1_writeData  :   std_logic_vector(31 downto 0);   
       signal DP_W2_writeData  :   std_logic_vector(31 downto 0);   
                                                              
       signal Dmem_readData1   :  std_logic_vector(31 downto 0);    
       signal Dmem_readData2   :  std_logic_vector(31 downto 0);    
                                                          
       signal IMem_Instr1      :  std_logic_vector(31 downto 0);    
       signal IMem_Instr2      :  std_logic_vector(31 downto 0);    
                                                            
       signal DP_W1_memWrite   :   std_logic;                       
       signal DP_W2_memWrite   :   std_logic;                        
        
        
        
        
        
        
        
        
begin
  
  
Processor_Port_MAP  :       SuperScalarProcessor port map (
                                                                clk              =>  clk,
                                                                reset            =>  reset,
                                                                                 
                                                                pc               =>     pc             ,
                                                                                                    
                                                                DP_W1_ALUout     =>     DP_W1_ALUout   ,
                                                                DP_W2_ALUout     =>     DP_W2_ALUout   ,
                                                                                                       
                                                                DP_W1_writeData  =>     DP_W1_writeData,
                                                                DP_W2_writeData  =>     DP_W2_writeData,
                                                                                                     
                                                                Dmem_readData1   =>     Dmem_readData1 ,
                                                                Dmem_readData2   =>     Dmem_readData2 ,
                                                                                                       
                                                                IMem_Instr1      =>     IMem_Instr1    ,
                                                                IMem_Instr2      =>     IMem_Instr2    ,
                                                                                                       
                                                                DP_W1_memWrite   =>     DP_W1_memWrite ,
                                                                DP_W2_memWrite   =>     DP_W2_memWrite 
                                                                
                                                                
                                                          );
                                                          
DataMemory_Port_Map :       DataMemory port map (
                                                     clk         =>  CLK,
                                                     W1_A        =>  DP_W1_ALUout(9 downto 2),
                                                     W1_WD       =>  DP_W1_writeData,
                                                     W1_RD       =>  Dmem_readData1 ,
                                                     W1_memWrite =>  DP_W1_memWrite , 
                                                                   
                                                     W2_A        =>   DP_W2_ALUout(9 downto 2), 
                                                     W2_WD       =>   DP_W2_writeData,          
                                                     W2_RD       =>   Dmem_readData2 ,          
                                                     W2_memWrite =>   DP_W2_memWrite           
                                                  );                                                         
 
 
 
Instruction_Memory_Port_Map     :    Two_port_simple_ROM port map      (
                                                                            A           =>   pc(9 downto 2),
                                                                            ReadData1   =>   IMem_Instr1 ,
                                                                            ReadData2   =>   IMem_Instr2 
                                                                        
                                                                        );                                                 


WriteData1    <=    DP_W1_writeData;
WriteData2    <=    DP_W2_writeData;
              
dataAdr1      <=    DP_W1_ALUout;
dataAdr2      <=    DP_W2_ALUout;
                      
memWrite1     <=    DP_W1_memWrite;
memWrite2     <=    DP_W2_memWrite;
       
        

end Behavioral;
