----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2020 06:02:29 PM
-- Design Name: 
-- Module Name: ExceptionUnit - Behavioral
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

entity ExceptionUnit is
  Port ( 
            overflow1   : in std_logic;
            overflow2   : in std_logic;
            unknownOp1  : in std_logic;
            --unknownOp2  : in std_logic;
            
            EPCWrite    : out std_logic;
            Cause_W1_Write  : out std_logic;
            Cause_W2_Write  : out std_logic;
            
            PCBit           : out std_logic;
            
            whichWay        : out  std_logic_vector(31 downto 0);
            
            Cause_W1_Code   : out std_logic_vector(31 downto 0);
            Cause_W2_Code   : out std_logic_vector(31 downto 0)
            
       );
end ExceptionUnit;

architecture Behavioral of ExceptionUnit is
    signal Exception, Exception1, Exception2             : std_logic;
     
    signal OF1_UOp1, Ex_Res :  std_logic_vector(1 downto 0);
    signal OF1_UOp2 :  std_logic;
    
    constant overflow_EXCode     : std_logic_vector(31 downto 0) := x"0000_0010"; -- Overflow 
    constant unknownOp_EXCode     : std_logic_vector(31 downto 0) := x"0000_0011"; -- Overflow 
    constant zero     : std_logic_vector(31 downto 0) := x"0000_0000";
    
    
begin
    Exception       <= overflow1 or overflow2 or unknownop1;
    
    EPCWrite <= Exception;
    Cause_W1_Write <= overflow1 and unknownOp1;
    Cause_W2_Write <= overflow2;
    
    OF1_UOp1 <= overflow1 & unknownOp1;
    
    with OF1_UOp1 select Cause_W1_Code <= 
         overflow_EXCode when "10",
         unknownOp_EXCode when "01",
         zero when others;
    
    OF1_UOp2 <= overflow2;
    with OF1_UOp2 select Cause_W2_Code <= 
         overflow_EXCode when '1',
         zero when others;
         
   Exception1 <= overflow1 or unknownOp1;
   Exception2 <= overflow2;
   
   whichWay <= x"0000_000" & "00"& Exception2 & Exception1;
   PCBit <= Exception1 or Exception2;    
end Behavioral;
