----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2020 10:35:38 AM
-- Design Name: 
-- Module Name: EM_pipe_REG - Behavioral
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

entity EM_pipe_REG is
  generic (cu_EM_signalsWidth : positive);
  Port ( 
           clk                  : in std_logic;
           reset                : in std_logic;
           
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
           
           pcE             :  in  std_logic_vector(31 downto 0);
           
           CU_Signals_M         : OUT std_logic_vector(cu_EM_signalsWidth - 1 downto 0);
           PC_Plus4_8_M         : OUT std_logic_vector(31 downto 0);
           W1_ALUout_M          : OUT std_logic_vector(31 downto 0);
           W1_writeData_M       : OUT std_logic_vector(31 downto 0);
           W1_WriteReg_M        : OUT std_logic_vector(4 downto 0);
           W1_zeroPad_M         : OUT std_logic_vector(31 downto 0);
           W1_overflow_M         : OUT std_logic;
                                  
           W2_ALUout_M          : OUT std_logic_vector(31 downto 0);
           W2_writeData_M       : OUT std_logic_vector(31 downto 0);
           W2_writeReg_M        : OUT std_logic_vector(4 downto 0);
           W2_zeroPad_M         : OUT std_logic_vector(31 downto 0);
           W2_overflow_M         : out std_logic;
           
           pcM                  :  out  std_logic_vector(31 downto 0)           
        );
end EM_pipe_REG;

architecture Behavioral of EM_pipe_REG is

begin

EM_pipe_REG_process : process(clk, reset)
                        begin 
                            if(reset = '1') then 
                                CU_Signals_M     <= (others => '0');
                                PC_Plus4_8_M     <= (others => '0');
                                W1_ALUout_M      <= (others => '0');
                                W1_writeData_M   <= (others => '0');
                                W1_WriteReg_M    <= (others => '0');
                                W1_zeroPad_M     <= (others => '0');
                                W1_overflow_M    <= '0';
                                               
                                W2_ALUout_M      <= (others => '0');
                                W2_writeData_M   <= (others => '0');
                                W2_writeReg_M    <= (others => '0');
                                W2_zeroPad_M     <= (others => '0');
                                W2_overflow_M    <= '0';
                                pcM              <= (others => '0');
                            elsif(rising_edge(clk)) then 
                                CU_Signals_M     <=    CU_Signals_E   ;
                                PC_Plus4_8_M     <=    PC_Plus4_8_E   ;
                                W1_ALUout_M      <=    W1_ALUout_E    ;
                                W1_writeData_M   <=    W1_writeData_E ;
                                W1_WriteReg_M    <=    W1_WriteReg_E  ;
                                W1_zeroPad_M     <=    W1_zeroPad_E   ;
                                W1_overflow_M    <=  W1_overflow_E;
                                                                      
                                W2_ALUout_M      <=    W2_ALUout_E    ;
                                W2_writeData_M   <=    W2_writeData_E ;
                                W2_writeReg_M    <=    W2_writeReg_E  ;
                                W2_zeroPad_M     <=    W2_zeroPad_E   ;
                                W2_overflow_M    <= W2_overflow_E;
                                pcM             <= pcE;
                            end if;
                        end process;

end Behavioral;
