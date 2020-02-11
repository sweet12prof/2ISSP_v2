----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/01/2020 02:42:47 PM
-- Design Name: 
-- Module Name: registerFile - Behavioral
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

entity registerFile is
 Port ( 
            clk, W1WE, W2WE       : std_logic;
            W1A1                  : in std_logic_vector(4 downto 0);
            W1A2                  : in std_logic_vector(4 downto 0);
            W1WA                : in std_logic_vector(4 downto 0);
            W1WD                  : in std_logic_vector(31 downto 0);
            W1RD1                 : out std_logic_vector(31 downto 0);
            W1RD2                 : out std_logic_vector(31 downto 0);
            
            W2A1                  : in std_logic_vector(4 downto 0);
            W2A2                  : in std_logic_vector(4 downto 0);
            W2WA                 : in std_logic_vector(4 downto 0);
            W2WD                  : in std_logic_vector(31 downto 0);
            W2RD1                 : out std_logic_vector(31 downto 0);
            W2RD2                 : out std_logic_vector(31 downto 0)          
        );
end registerFile;

architecture Behavioral of registerFile is
     type mem_array is array (0 to 31) of std_logic_vector(31 downto 0);
     signal RAM : mem_array := (
                                       29 => x"0000_2ffc",
										others => (others => '0')
                                      
                                    );
begin
       
WriteProcesses1 : process(clk)
                        begin 
                            if(falling_edge(clk)) then 
                                if(W1WE = '1') then 
                                    if(W1WA /= "00000") then 
                                        RAM(to_integer(unsigned(W1WA))) <= W1WD;
                                    end if;
                                end if;
                                
                                if(W2WE = '1') then 
                                    if(W2WA /= "00000") then 
                                        RAM(to_integer(unsigned(W2WA))) <= W2WD;
                                    end if;
                                end if;
                            end if;
                   
                        end process;  

--WriteProcesses2 : process(clk)
--                        begin 
--                            if(falling_edge(clk)) then 
--                                if(W2WE = '1') then 
--                                    if(W2WA /= "00000") then 
--                                        RAM(to_integer(unsigned(W2WA))) <= W2WD;
--                                    end if;
--                                end if;
--                            end if;
                           
--                        end process;  


Read_Ports_Way1_Port1 : process(W1A1, W1WA, W2WA, RAM) 
                            begin 
                                if(W1A1 = "00000") then 
                                    W1RD1 <= x"0000_0000"; 
                                else     
                                    W1RD1 <= RAM(to_integer(unsigned(W1A1)));
                                end if;
                            end process;
                            
Read_Ports_Way1_Port2 : process(W1A2,W1WA, W2WA, RAM) 
                            begin 
                                if(W1A2 = "00000") then 
                                    W1RD2 <= x"0000_0000";
                                else 
                                    W1RD2 <= RAM(to_integer(unsigned(W1A2)));
                                end if;
                            end process;

Read_Ports_Way2_Port1 : process(W2A1,W1WA, W2WA, RAM) 
                            begin 
                                if(W2A1 = "00000") then
                                    w2rd1 <= x"0000_0000";
                                else  
                                    W2RD1 <= RAM(to_integer(unsigned(W2A1)));
                                end if;
                            end process;

Read_Ports_Way2_Port2 : process(W2A2,W1WA, W2WA, RAM) 
                            begin 
                                if(W2A2 = "00000") then
                                    w2rd2 <= x"0000_0000";
                                else 
                                    W2RD2 <= RAM(to_integer(unsigned(W2A2)));
                                end if;
                            end process;
                           

end Behavioral;
