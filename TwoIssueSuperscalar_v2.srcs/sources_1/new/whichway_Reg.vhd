----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2020 07:28:22 PM
-- Design Name: 
-- Module Name: whichway_Reg - Behavioral
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

entity whichway_Reg is
 Port ( 
            clk, En : in std_logic;
            d       : in std_logic_vector(31 downto 0);
            q       : out std_logic_vector(31 downto 0)
        );
end whichway_Reg;

architecture Behavioral of whichway_Reg is

begin
       whichWay_proc: process(clk, en)
              begin 
                if(rising_edge(clk)) then 
                    if(en = '1') then
                        q <= d;
                    end if;
                end if;
              end process;

end Behavioral;
