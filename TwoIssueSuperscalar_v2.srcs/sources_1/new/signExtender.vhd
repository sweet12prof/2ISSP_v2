library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity signExtender is 
    generic( width : positive := 32);
    port (
            Input   : in std_logic_vector( width - 1 downto 0);
            Output  : out std_logic_vector((2 * width - 1)  downto 0)
        );  
end signExtender;

architecture synth of signExtender is 
    signal signExt  : std_logic_vector(width - 1 downto 0);
    begin 
          signExt <= (others => Input(width - 1));
          Output <= signExt & Input;
    end synth;
    