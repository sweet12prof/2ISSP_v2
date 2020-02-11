----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2020 01:16:30 PM
-- Design Name: 
-- Module Name: mainDEC - Behavioral
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

entity aluDEC is
  Port ( 
                funct        : in std_logic_vector(5 downto 0);
                ALUOp        : in std_logic_vector(2 downto 0);
                alucontrol   : out std_logic_vector(3 downto 0);
                shifts       : out std_logic;
                jr           : out std_logic
      );
end aluDEC;

architecture synth of aluDEC is 
signal control: STD_LOGIC_VECTOR(5 downto 0);
begin 
	process(ALUOp, funct) begin
		case aluop is
			when "000" => control <= "000010"; -- add (for 1w/sw/addi)
			when "001" => control <= "001010"; -- sub (for beq)
			when "010" => case funct is -- R-type instructions
					when "100000" => control <= "000010"; -- add
					when "100010" => control <= "001010"; -- sub
					when "100100" => control <= "000000"; -- and
					when "100101" => control <= "000001"; -- or
					when "101010" => control <= "001011"; -- slt
					when "100110" => control <= "000100"; -- xor
					when "000000" => control <= "010101"; -- sll
					when "000010"  =>control <= "010110"; --srl
					when "001000" =>control <=  "100000"; --jr
					when others =>   control <= "000---"; -- ???
			end case;
			when "011" => control <= "000000";
			when "100" => control <= "000001";
			when "101" => control <= "001011";
			when "110" => control <= "000100";
			when others => control <="000---";
		end case;
	end process;
	alucontrol <= control(3 downto 0);
	shifts <= control(4);
	jr <= control(5);
end synth;
