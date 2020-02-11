----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/01/2020 06:00:51 PM
-- Design Name: 
-- Module Name: eight_input_Mux - Behavioral
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

entity generic_eight_input_Mux is
generic (
            width : positive
        );
  Port ( 
            i1      : in    std_logic_vector(width - 1 downto 0);
            i2      : in    std_logic_vector(width - 1 downto 0);
            i3      : in    std_logic_vector(width - 1 downto 0);
            i4      : in    std_logic_vector(width - 1 downto 0);
            i5      : in    std_logic_vector(width - 1 downto 0);
            i6      : in    std_logic_vector(width - 1 downto 0);
            i7      : in    std_logic_vector(width - 1 downto 0);
            i8      : in    std_logic_vector(width - 1 downto 0);
            iSel    : in    std_logic_vector(2 downto 0);
            Output  : out    std_logic_vector(width - 1 downto 0)           
        );
end generic_eight_input_Mux;

architecture Behavioral of generic_eight_input_Mux is

begin
    with isel select Output <= 
        i1 when "000",
        i2 when "001",
        i3 when "010",
        i4 when "011",
        i5 when "100",
        i6 when "101",
        i7 when "110",
        i8 when others;
end Behavioral;
