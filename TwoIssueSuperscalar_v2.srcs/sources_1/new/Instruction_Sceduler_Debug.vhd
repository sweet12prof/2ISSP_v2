----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2020 06:31:47 PM
-- Design Name: 
-- Module Name: Instruction_Sceduler_Debug - Behavioral
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

entity Instruction_Sceduler_Debug is
  Port ( 
           clk          : in std_logic;
           reset        : in std_logic;
           EX_Instr1    : out std_logic_vector(31 downto 0);
           EX_Instr2    : out std_logic_vector(31 downto 0)
           
           
        );
end Instruction_Sceduler_Debug;

--architecture Behavioral of Instruction_Sceduler_Debug is
   
--   component Two_port_simple_ROM 
--          Port ( 
--                    A               : in std_logic_vector(5 downto 0);
--                    ReadData1       : out std_logic_vector(31 downto 0);
--                    ReadData2       : out std_logic_vector(31 downto 0)
--            );
--    end component;
    
    
--    component Adder32 
--          port(
--                Add32i1, Add32i2 : in std_logic_vector(31 downto 0);
--                Cin32 : in std_logic;
--                Add32Sum : out std_logic_vector(31 downto 0);
--                 Cout32 : out std_logic
--             );
--    end component;
    
    
--    component generic_2_input_mux is
--    generic
--        (
--            width : positive            
--        );
--    Port (
--            MUX_in1     : in std_logic_vector(width - 1 downto 0);
--            MUX_in2     : in std_logic_vector(width - 1 downto 0);
--            Mux_SEL     : in std_logic;
--            Mux_Out     : out std_logic_vector(width-1 downto 0)
--         );
--    end component;
    
    
--    component Two_Issue_Scheduler is
--             Port (
--                        Instr1          : in    std_logic_vector(31 downto 0);
--                        Instr2          : in    std_logic_vector(31 downto 0);
--                        EX_Instr1       : out   std_logic_vector(31 downto 0);    
--                        EX_Instr2       : out   std_logic_vector(31 downto 0);
--                        PC_Adder_Mux    : out   std_logic
                
--           );
--     end component;
    
    
--    component pcFlopr is
--        Port (  
--              clk       : in std_logic; 
--              reset     : in std_logic;
--              d         : in std_logic_vector(31 downto 0);
--              q         : out std_logic_vector(31 downto 0)
--            );
--    end component;

    
--    signal pc_Out, pc_In, Instr1, Instr2, post_pcMux : std_logic_vector(31 downto 0);
--    signal mux_sel : std_logic;
--begin
    
--    pc_B_IOB : pcFlopr port map(
--                                   clk    => clk,
--                                   reset  => reset,
--                                   d      => pc_In,
--                                   q      => pc_Out
                                   
--                                );
                                
--    ROM_B_ioB : Two_port_simple_ROM port map (
--                                                A           =>  pc_Out(7 downto 2),
--                                                ReadData1   =>  Instr1,
--                                                ReadData2   =>  Instr2                                               
--                                             );
  
--  mux_B_IOB : generic_2_input_mux generic map (32)
--                                  port map (
--                                                    MUX_in1      => x"0000_0008",
--                                                    MUX_in2      => x"0000_0004",
--                                                    Mux_SEL      => mux_sel,
--                                                    Mux_Out      => post_pcMux
--                                           );
  
--  adder_B_IOB   :  Adder32 port map (
--                                         Add32i1   =>  pc_Out,
--                                         Add32i2   =>  post_pcMux,
--                                         Cin32     =>  '0',  
--                                         Add32Sum  =>  pc_In,   
--                                         Cout32    =>  open 
--                                    );
                                    
 
-- Scheduler_B_IOB    : Two_Issue_Scheduler port map (
--                                                       Instr1       =>   Instr1,
--                                                       Instr2       =>   Instr2,
--                                                       EX_Instr1    =>   EX_Instr1,
--                                                       EX_Instr2    =>   EX_Instr2,
--                                                       PC_Adder_Mux =>   mux_sel
----                                                    );
--end Behavioral;
