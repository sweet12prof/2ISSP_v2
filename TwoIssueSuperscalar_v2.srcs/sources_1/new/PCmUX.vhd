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

entity pc_Mux is
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
            iSel    : in    std_logic_vector(4 downto 0);
            Output  : out    std_logic_vector(width - 1 downto 0)           
        );
end pc_Mux;

architecture Behavioral of pc_Mux is

begin
    with isel select Output <= 
        i1 when "00000",
        i2 when "00001",
        i3 when "00010",
        i4 when "00100",
        i5 when "01000",
        i6 when "1----",
        X"0000_0000" when others;        
end Behavioral;
