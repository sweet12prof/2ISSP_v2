----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2020 11:17:17 AM
-- Design Name: 
-- Module Name: MW_pipe_REG - Behavioral
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

entity MW_pipe_REG is
    generic (CU_signals_Width : positive);
  Port ( 
            clk                 : in std_logic;
            reset               : in std_logic;
            FlushW              : in std_logic;
            CU_Signals_M        : in std_logic_vector(CU_signals_Width - 1 downto 0);
            W1_ALUout_M         : in std_logic_vector(31 downto 0);
            W1_ReadData_M       : in std_logic_vector(31 downto 0);
            W1_writeReg_M       : in std_logic_vector(4 downto 0);
            W1_overflow_M       : in std_logic;
            
            
            W2_ALUout_M         : in std_logic_vector(31 downto 0);
            W2_ReadData_M       : in std_logic_vector(31 downto 0);
            W2_writeReg_M       : in std_logic_vector(4 downto 0); 
            W2_overflow_M       : in std_logic;
            
            pcM                  : in  std_logic_vector(31 downto 0);
            
            
            CU_Signals_W        : out std_logic_vector(CU_signals_Width - 1 downto 0);
            W1_ALUout_W         : out std_logic_vector(31 downto 0);
            W1_ReadData_W       : out std_logic_vector(31 downto 0);
            W1_writeReg_W       : out std_logic_vector(4 downto 0);
            W1_overflow_W       : out std_logic;
                                 
            W2_ALUout_W         : out std_logic_vector(31 downto 0);
            W2_ReadData_W       : out std_logic_vector(31 downto 0);
            W2_writeReg_W       : out std_logic_vector(4 downto 0);
            W2_overflow_W       : out std_logic;
            
            pcW                  :  out  std_logic_vector(31 downto 0)
              
        );
end MW_pipe_REG;

architecture Behavioral of MW_pipe_REG is

begin

MW_pipe_REG_process : process(clk, reset)
                        begin
                            if(reset = '1') then 
                                CU_Signals_W    <= ( others => '0');
                                W1_ALUout_W     <= ( others => '0');
                                W1_ReadData_W   <= ( others => '0');
                                W1_writeReg_W   <= ( others => '0');
                                W1_overflow_W  <= '0';
                                
                                                
                                W2_ALUout_W     <= ( others => '0');
                                W2_ReadData_W   <= ( others => '0');
                                W2_writeReg_W   <= ( others => '0');
                                W2_overflow_W  <= '0';
                                
                                pcW             <= ( others => '0');
                             
                             elsif(rising_edge(clk))    then
                                if(FlushW = '1') then
                                    CU_Signals_W    <= ( others => '0');
                                    W1_ALUout_W     <= ( others => '0');
                                    W1_ReadData_W   <= ( others => '0');
                                    W1_writeReg_W   <= ( others => '0');
                                    W1_overflow_W  <= '0';
                                    
                                                    
                                    W2_ALUout_W     <= ( others => '0');
                                    W2_ReadData_W   <= ( others => '0');
                                    W2_writeReg_W   <= ( others => '0');
                                    W2_overflow_W  <= '0';
                                    
                                    pcW             <= ( others => '0');
                                else 
                                    CU_Signals_W    <=     CU_Signals_M  ;
                                    W1_ALUout_W     <=     W1_ALUout_M   ;
                                    W1_ReadData_W   <=     W1_ReadData_M ;
                                    W1_writeReg_W   <=     W1_writeReg_M ;
                                    W1_overflow_W   <=     W1_overflow_M;
                                    
                                               
                                    W2_ALUout_W     <=     W2_ALUout_M   ;
                                    W2_ReadData_W   <=     W2_ReadData_M ;
                                    W2_writeReg_W   <=     W2_writeReg_M ;
                                    W2_overflow_W   <=     W2_overflow_M;
                                    
                                    pcW             <= pcM;
                                end if;
                            end if;
                        end process;

end Behavioral;
