----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2020 10:35:38 AM
-- Design Name: 
-- Module Name: DataMemory - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMemory is
  Port (  
            clk         : in std_logic;  
            W1_A        : in std_logic_vector(7 downto 0);
            W1_WD       : IN std_logic_vector(31 downto 0);
            W1_RD       : OUT std_logic_vector(31 downto 0);
            W1_memWrite : in std_logic;
            
            W2_A        : in std_logic_vector(7 downto 0);
            W2_WD       : IN std_logic_vector(31 downto 0);
            W2_RD       : out std_logic_vector(31 downto 0);
            W2_memWrite : in std_logic
        );
end DataMemory;

architecture Behavioral of DataMemory is
    type mem_array is array(0 to 255) of std_logic_vector(31 downto 0);
    signal MEM    : mem_array := (
                                    --x"0000_0000",
                                   
--                                    x"00000001",
--                                    x"00000001" ,
--                                    x"0000000a",
                                   
--                                     x"00000014",
--                                     x"00000000",
--                                     x"00000000",
--                                     x"00000000",
--                                     x"00000000",
--                                     x"430a1f9b",
--                                     x"728cd2e3",
                                   
                                   
--			                       x"0000000a",
--                                   x"00000008",
--                                   x"00000005",
--                                   x"00000004",
--                                   x"00000009",
--                                   x"00000001",
--                                   x"00000007",
--                                   x"00000006",
--                                   x"0000000a",
--                                   x"00000003",
--                                   x"00000002",
--                                   x"0000000a",
--                                   x"00000018",
--                                   x"00000024",
--                                   x"00000020",
--                                   x"00000014",
--                                   x"00000008",
--                                   x"00000028",
--                                   x"00000010",
--                                   x"00000004",
--                                   x"0000000c",
--                                   x"0000001c",	



--                     x"0000000c",
--                     x"0000000f",
--                     x"0000000a",
--                     x"00000005",
--                     x"00000007",
--                     x"00000003",
--                     x"00000002",
--                     x"00000001",               


x"00000008",
x"00000066",
x"00000003",
x"00000001",
x"00000002",
x"00000004",
x"00000009",
x"00000008",
x"0000001d",














											  others => (others => '0')
                                 );
begin

Write_Mem_Process_Way1 : process(clk)
                        begin 
                            if(rising_edge(clk)) then 
                                if(W1_memWrite = '1') then 
                                    MEM(to_integer(unsigned(W1_A))) <= W1_WD;
                                end if;
                                
                                if(W2_memWrite = '1') then 
                                    MEM(to_integer(unsigned(W2_A))) <= W2_WD;
                                end if;
                            end if;
                        end process;

--Write_Mem_Process_Way2 : process(clk)
--                        begin 
--                            if(rising_edge(clk)) then 
--                                  if(W2_memWrite = '1') then 
--                                    MEM(to_integer(unsigned(W2_A))) <= W2_WD;
--                                end if;
--                            end if;
--                        end process;
                        
                        
 W1_RD  <= MEM(to_integer(unsigned(W1_A)));
 W2_RD  <= MEM(to_integer(unsigned(W2_A)));                       

end Behavioral;
