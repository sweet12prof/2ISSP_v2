----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/01/2020 06:44:38 PM
-- Design Name: 
-- Module Name: FD_pipe_REG - Behavioral
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

entity FD_pipe_REG is
  Port ( 
            clk             : in std_logic;
            stallF          : in std_logic;
            reset           : in std_logic;
            FlushF          : in std_logic;
            Instr1F         : in std_logic_vector(31 downto 0);
            Instr2F         : in std_logic_vector(31 downto 0);
            pcF             : in std_logic_vector(31 downto 0);
            PCplus4_8F      : in std_logic_vector(31 downto 0);
           
           
            Instr1D         : out std_logic_vector(31 downto 0);
            Instr2D         : out std_logic_vector(31 downto 0);
            PCplus4_8D      : out std_logic_vector(31 downto 0);
            pcD             : out std_logic_vector(31 downto 0)
            
        );
end FD_pipe_REG;

architecture Behavioral of FD_pipe_REG is

begin

flopProcess : process(clk, reset)
                begin 
                    if( reset = '1') then 
                          Instr1D    <= (others => '0');
                          Instr2D    <= (others => '0');
                          PCplus4_8D <= (others => '0');
                          pcD        <= (others => '0');
                    elsif(rising_edge(clk)) then 
                        if(FlushF = '1') then 
                            Instr1D    <= (others => '0');
                            Instr2D    <= (others => '0');
                            PCplus4_8D <= (others => '0');
                            pcD        <= (others => '0');
                        elsif (stallF = '0') then                            
                            Instr1D    <=   Instr1F   ;
                            Instr2D    <=   Instr2F   ;
                            PCplus4_8D <=   PCplus4_8F;
                            pcD        <=   pcF;
                        end if;   
                    end if;    
                end process;    

end Behavioral;
