----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2020 06:05:31 PM
-- Design Name: 
-- Module Name: EPC - Behavioral
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

entity EPC is
  Port (
            clk, En : in std_logic;
            d       : in std_logic_vector(31 downto 0);
            q       : out std_logic_vector(31 downto 0)
         );
end EPC;

architecture Behavioral of EPC is

begin
    EPC_proc: process(clk, en)
              begin 
                if(rising_edge(clk)) then 
                    if(en = '1') then
                        q <= d;
                    end if;
                end if;
              end process;

end Behavioral;
