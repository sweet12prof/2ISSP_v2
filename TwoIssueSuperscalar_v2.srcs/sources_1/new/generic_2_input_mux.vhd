----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2020 06:19:41 PM
-- Design Name: 
-- Module Name: generic_2_input_mux - Behavioral
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

entity generic_2_input_mux is
    generic
        (
            width : positive            
        );
    Port (
            MUX_in1     : in std_logic_vector(width - 1 downto 0);
            MUX_in2     : in std_logic_vector(width - 1 downto 0);
            Mux_SEL     : in std_logic;
            Mux_Out     : out std_logic_vector(width-1 downto 0)
         );
end generic_2_input_mux;

architecture Behavioral of generic_2_input_mux is

begin
        Mux_Out <= MUX_in1 when Mux_SEL = '0' else Mux_in2;

end Behavioral;
