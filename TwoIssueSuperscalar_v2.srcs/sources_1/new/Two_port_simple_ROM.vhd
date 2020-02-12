----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2020 05:52:40 PM
-- Design Name: 
-- Module Name: Two_port_simple_ROM - Behavioral
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

entity Two_port_simple_ROM is
  Port ( 
            A               : in std_logic_vector(7 downto 0);
            ReadData1       : out std_logic_vector(31 downto 0);
            ReadData2       : out std_logic_vector(31 downto 0)
        );
end Two_port_simple_ROM;

architecture Behavioral of Two_port_simple_ROM is
    
    type mem_array is array ( 0 to 255 ) of 
                      std_logic_vector(31 downto 0);
                      
    signal ROM : mem_array := (
--                                        x"20040028",  
--                                        x"20050005",  
--                                        x"200b0000",  
--                                        x"20060020",  
--                                        x"20070001",  
--                                        x"20080001",  
--                                        x"200a0000",  
--                                        x"20090000",  
--                                        x"00a84824",  
--                                        x"20e70001",  
--                                        x"112a0001",  
--                                        x"008b5820",  
--                                        x"00052842",
--                                        x"00042040",
--                                        x"10e60002",
--                                        x"0c000c08",
--                                        x"08000c12",
--                                        x"03e00008",
--                                        x"ac0b0064",
--                                        x"ffffffff",

                                            
--                                           x"00000022",
--                                           x"8c010000",
--                                           x"8c020004",
--                                           x"8c030008",
--                                           x"00842022",
--                                           x"00442020",
--                                           x"0043282a",
--                                           x"10a00002",
--                                           x"00221020",
--                                           x"1000fffb",
--                                           x"ac040000",


--                                             x"00000022",
--                                             x"8c010000",
--                                             x"8c220000",
--                                             x"8c230004",
--                                             x"00432024",
--                                             x"00432825",
--                                             x"ac040004",
--                                             x"ac050008",
--                                             x"1000ffff",

--                                                x"20140004",
--                                                x"20170001",
--                                                x"20040030",
--                                                x"8c08002c",
--                                                x"00084080",
--                                                x"00882820",
--                                                x"0c000c08",
--                                                x"08000c49",
--                                                x"23bdfff0",
--                                                x"afbf0000",
--                                                x"afa40004",
--                                                x"afa50008",
--                                                x"00a44022",
--                                                x"1114000e",
--                                                x"0114c82a",
--                                                x"1337000c",
--                                                x"000840c2",
--                                                x"00084080",
--                                                x"00882820",
--                                                x"afa5000c",
--                                                x"0c000c08",
--                                                x"8fa4000c",
--                                                x"8fa50008",
--                                                x"0c000c08",
--                                                x"8fa40004",
--                                                x"8fa5000c",
--                                                x"8fa60008",
--                                                x"0c000c1f",
--                                                x"8fbf0000",
--                                                x"23bd0010",
--                                                x"03e00008",
--                                                x"23bdfff0",
--                                                x"afbf0000",
--                                                x"afa40004",
--                                                x"afa50008",
--                                                x"afa6000c",
--                                                x"00048020",
--                                                x"00a08820",
--                                                x"8e080000",
--                                                x"8e290000",
--                                                x"8d080000",
--                                                x"8d290000",
--                                                x"11280002",
--                                                x"0128c82a",
--                                                x"13200004",
--                                                x"00112020",
--                                                x"00102820",
--                                                x"0c000c3d",
--                                                x"22310004",
--                                                x"22100004",
--                                                x"8fa6000c",
--                                                x"12060006",
--                                                x"0206c82a",
--                                                x"13200004",
--                                                x"12260003",
--                                                x"0226c82a",
--                                                x"13200001",
--                                                x"08000c26",
--                                                x"8fbf0000",
--                                                x"23bd0010",
--                                                x"03e00008",
--                                                x"2008000a",
--                                                x"10850009",
--                                                x"0085c82a",
--                                                x"12f90007",
--                                                x"208efffc",
--                                                x"8c8f0000",
--                                                x"8dd80000",
--                                                x"adcf0000",
--                                                x"ac980000",
--                                                x"000e2020",
--                                                x"08000c3d",
--                                                x"03e00008",
--                                                x"20080000",
--                                                x"8c09002c",
--                                                x"1109000c",
--                                                x"0109c82a",
--                                                x"1320000a",
--                                                x"00085080",
--                                                x"8d4b0030",
--                                                x"8d640000",
--                                                x"20020001",
--                                                x"0000000c",
--                                                x"20040000",
--                                                x"20020004",
--                                                x"0000000c",
--                                                x"21080001",
--                                                x"08000c4a",
--                                                x"2002000a",
--                                                x"0000000c",
--                                        others => x"00000000"
--x"20080000",
--x"21040000",
--x"20050000",
--x"20060007",
--x"0c000c39",
--x"2002000a",
--x"08000c4f",
--x"0000000c",
--x"23bdfff4",
--x"afa40000",
--x"afa50004",
--x"afa60008",
--x"00054880",
--x"00894820",
--x"8d330000",
--x"00065080",
--x"008a5020",
--x"8d540000",
--x"ad340000",
--x"ad530000",
--x"23bd000c",
--x"03e00008",
--x"23bdfff0",
--x"afa40000",
--x"afa50004",
--x"afa60008",
--x"afbf000c",
--x"00058820",
--x"00069020",
--x"00124880",
--x"00894820",
--x"8d2a0000",
--x"222bffff",
--x"00116020",
--x"224dffff",
--x"01ac702a",
--x"15c0000d",
--x"000c4880",
--x"01244820",
--x"8d2f0000",
--x"014fc02a",
--x"17000006",
--x"216b0001",
--x"000b2820",
--x"000c3020",
--x"0c000c08",
--x"218c0001",
--x"08000c23",
--x"218c0001",
--x"08000c23",
--x"21650001",
--x"00123020",
--x"00051020",
--x"0c000c08",
--x"8fbf000c",
--x"23bd0010",
--x"03e00008",
--x"23bdfff0",
--x"afa40000",
--x"afa50004",
--x"afa60008",
--x"afbf000c",
--x"00064020",
--x"00a8482a",
--x"11200008",
--x"0c000c16",
--x"00028020",
--x"8fa50004",
--x"2206ffff",
--x"0c000c39",
--x"22050001",
--x"8fa60008",
--x"0c000c39",
--x"8fa40000",
--x"8fa50004",
--x"8fa60008",
--x"8fbf000c",
--x"23bd0010",
--x"03e00008",


x"3c011001",
x"8c240000",
x"3c011001",
x"34250004",
x"0c10000f",
x"00044020",
x"20020001",
x"0008082a",
x"10200021",
x"8ca40000",
x"0000000c",
x"20a50004",
x"20010001",
x"01014022",
x"08100007",
x"200f0000",
x"00047020",
x"20010001",
x"01c17022",
x"29fa0001",
x"1340fff0",
x"200f0001",
x"11c0fff9",
x"20010001",
x"01c16822",
x"000e4080",
x"000d4880",
x"01055020",
x"01255820",
x"8d4c0000",
x"8d6d0000",
x"018d082a",
x"14200003",
x"20010001",
x"01c17022",
x"08100016",
x"ad4d0000",
x"ad6c0000",
x"20010001",
x"01c17022",
x"200f0000",
x"08100016",
x"2002000a",
x"0000000c",
















































others => (others => '0')
                                );
                                    
                                    
begin
    process(A)
        begin 
            ReadData1 <= ROM(to_integer(unsigned(A)));
            ReadData2  <= ROM(to_integer(unsigned(A) + 1));
            
        end process;

end Behavioral;
