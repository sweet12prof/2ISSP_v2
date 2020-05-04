----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2020 03:16:33 PM
-- Design Name: 
-- Module Name: mux_5select - Behavioral
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

entity mux_5select is
  Port ( 
            Input1  : in std_logic_vector(31 downto 0);
            Input2  : in std_logic_vector(31 downto 0);
            muxSEL  : in std_logic_vector(4 downto 0);
            Output  : out std_logic_vector(31 downto 0)
        );
end mux_5select;

architecture Behavioral of mux_5select is

begin
    with muxSEL select Output <= 
            Input1  when "01101",
            Input2 when "01110",
            x"0000_0000" when others;

end Behavioral;
