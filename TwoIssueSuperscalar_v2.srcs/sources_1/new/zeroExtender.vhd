library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zeroPadder is 
    generic( width : positive := 32);
    port (
            Input   : in std_logic_vector( width - 1 downto 0);
            Output  : out std_logic_vector((2 * width - 1)  downto 0)
        );  
end zeroPadder;

architecture synth of zeroPadder is 
    signal zeroExt  : std_logic_vector(width - 1 downto 0);
    begin 
          zeroExt <= (others => '0');
          Output <= Input & zeroExt;
    end synth;
    