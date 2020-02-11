library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity generic_four_Input_Mux is 
    generic (
                width : positive
            );
    port(
            i1      : in std_logic_vector(width - 1 downto 0 );
            i2      : in std_logic_vector(width - 1 downto 0);
            i3      : in std_logic_vector(width - 1 downto 0 );
            i4      : in std_logic_vector(width - 1 downto 0);
            iSEL    : in STD_LOGIC_VECTOR(1 downto 0);
            Output  : out std_logic_vector(width - 1 downto 0)
            
        );
end generic_four_Input_Mux;

architecture behave of generic_four_Input_Mux is    
    begin 
        with iSEL select Output <= 
            i1 when "00",
            i2 when "01",
            i3 when "10",
            i4 when others;
    end behave;