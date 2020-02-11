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

entity mainDEC is
  Port ( 
                 op           : in std_logic_vector(5 downto 0);
                memWrite     : out std_logic;
                memtoReg     : out std_logic;
                regWrite     : out std_logic;
                regDst       : out std_logic;
                alusrc       : out std_logic; 
                branch       : out std_logic;
                bne          : out std_logic;
                ALUOp        : out std_logic_vector(2 downto 0);
                jump         : out std_logic;
                jal          : out std_logic;
                lui          : out std_logic;
                haltCPU      : out std_logic
      );
end mainDEC;

architecture synth of mainDEC is 
	signal controls: STD_LOGIC_VECTOR(13 downto 0);
begin 
	process(op) begin
		case op is 
			when "000000" => controls <= "00001100000010"; -- RTYPE
			when "100011" => controls <= "00001010010000"; -- LW
			when "001111" => controls <= "10001000000000"; --lui
			when "101011" => controls <= "00000010100000"; -- SW
			when "000100" => controls <= "00000001000001"; -- BEQ
			when "000101" => controls <= "01000000000001"; --BNE
			when "001000" => controls <= "00001010000000"; -- ADDI
			when "001100" => controls <= "00001010000011"; --andi
			when "001101" => controls <= "00001010000100"; --ori
			when "001010" => controls <= "00001010000101"; --slti
			when "001110" => controls <= "00001010000110"; --xori
			when "000010" => controls <= "00000000001000"; -- J
			when "000011" => controls <= "00011000000000"; -- Jal
			when "111111" => controls <= "00100000000000";
			when others => controls <=   "--------------"; -- illegal op 
		end case;
	end process;
 --	(regWrite, regDst, alusrc, branch, memWrite, memtoReg, jump, ALUOp(1 downto 0)) <= controls;
 lui <= controls(13);
 bne <= controls(12);
 haltCPU <= controls(11) when op ="111111" else '0';
 jal <= controls(10);
 regWrite <= controls(9);
 regDst <= controls(8);
 alusrc <= controls(7);
 branch <= controls(6);
 memWrite <= controls(5);
 memtoReg <= controls(4);
 jump <= controls(3);
 ALUOp <= controls (2 downto 0);
end synth;
