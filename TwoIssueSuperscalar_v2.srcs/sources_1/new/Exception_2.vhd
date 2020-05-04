----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2020 02:10:09 PM
-- Design Name: 
-- Module Name: Exception_Unit - Behavioral
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

entity Exception_Unit is
  Port ( 
            overflow1   : in std_logic; 
            overflow2   : in std_logic;
            unknownOp   : in std_logic;
            
            CauseCode   : out std_logic_vector(31 downto 0);
            EPCWrite    : out std_logic;
            CauseWrite  : out std_logic;
            PCBit       : out std_logic
            
        );
end Exception_Unit;

architecture Behavioral of Exception_Unit is
    signal  Exception_W1, Exception_W2 : std_logic;
    signal  CauseCode_Signal : std_logic_vector(31 downto 0);
begin
                Exception_W1   <= overflow1 or unknownOp;
                Exception_W2   <= overflow2;
                
                --PCBit <= '1' when (Exception_W1 <= '1' or Exception_W2 = '1') else 
                   --      '0';
                 
                CauseCode_Signal <= 
    x"0000_00" & "000" & Exception_W2 & Exception_W1 & overflow2 & overflow1 & unknownOp;
                
                CauseCode <= CauseCode_Signal;
                
                EPCWrite <= overflow1 or overflow2 or unknownOp;
                CauseWrite <= overflow1 or overflow2 or unknownOp;
                
     Excep_PCBit_gen :  process(Exception_W1, Exception_W2)
                            begin 
                                PCBit <= '0';
                                if(Exception_W1 = '1' or  Exception_W2 = '1') then 
                                    PCBit <= '1';
                                else 
                                    PCBit <= '0';
                                end if;
                                
                            end process;

end Behavioral;
