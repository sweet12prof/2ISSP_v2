----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2020 06:26:34 PM
-- Design Name: 
-- Module Name: pcFlopr - Behavioral
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

entity pcFlopr is
    Port (  
          clk       : in std_logic; 
          reset     : in std_logic;
          StallPC   : in std_logic;
          d         : in std_logic_vector(31 downto 0);
          q         : out std_logic_vector(31 downto 0)
        );
end pcFlopr;

architecture Behavioral of pcFlopr is

begin
    process(clk, reset)    
        begin 
            if(reset = '1') then 
                q <= (others => '0');
            
            elsif(rising_edge(clk)) then 
                if(stallPC = '0') then 
                     q <= d;
                end if;
            end if;
        end process;

end Behavioral;
