----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2019 05:32:59 PM
-- Design Name: 
-- Module Name: 2WSsP_2InputMux_32 - Behavioral
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

entity WSsP_2InputMux_32 is
generic(
            width : positive
       );
  Port (    
            i1, i2 : std_logic_vector(width -1 downto 0);
            iSel : in std_logic;
            iOut : out std_logic_vector(width - 1 downto 0)
        );
end WSsP_2InputMux_32;

architecture Behavioral of WSsP_2InputMux_32 is
constant Zero : std_logic_vector(width - 1 downto 0) := (others => '0');
begin

    iOut <= i1 when iSel = '0' else i2;
end Behavioral;
