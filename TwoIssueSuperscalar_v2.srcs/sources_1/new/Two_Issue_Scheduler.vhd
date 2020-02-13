----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2020 12:02:46 PM
-- Design Name: 
-- Module Name: Two_Issue_Scheduler - Behavioral
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

entity Two_Issue_Scheduler is

 Port (
            Instr1          : in    std_logic_vector(31 downto 0);
            Instr2          : in    std_logic_vector(31 downto 0);
            EX_Instr1       : out   std_logic_vector(31 downto 0);    
            EX_Instr2       : out   std_logic_vector(31 downto 0);
            PC_Adder_Mux    : out   std_logic
            
       );
end Two_Issue_Scheduler;

architecture Behavioral of Two_Issue_Scheduler is
    signal opCode1, opCode2, funct1, funct2 : std_logic_vector(5 downto 0);
    signal rs1, rs2, rt1, rt2, rd1, rd2 : std_logic_vector(4 downto 0);
    
    constant Beq      : std_logic_vector(5 downto 0) :=  "000100";
    constant J        : std_logic_vector(5 downto 0) :=  "000010";
    constant Jal      : std_logic_vector(5 downto 0) :=  "000011";
    constant JrFunct  : std_logic_vector(5 downto 0) :=  "001000";
    constant RType    : std_logic_vector(5 downto 0) :=  "000000";
    constant addi     : std_logic_vector(5 downto 0) :=  "001000";
    constant lw       : std_logic_vector(5 downto 0) :=  "100011";
    constant sw       : std_logic_vector(5 downto 0) :=  "101011";
    constant haltCPU  : std_logic_vector(5 downto 0) :=  "111111";
    constant andi     : std_logic_vector(5 downto 0) :=  "001100";
    constant ori      : std_logic_vector(5 downto 0) :=  "001101";
    constant xori     : std_logic_vector(5 downto 0) :=  "001110";
    constant slti     : std_logic_vector(5 downto 0) :=  "001010";
    constant lui      : std_logic_vector(5 downto 0) :=  "001111";
    constant bne      : std_logic_vector(5 downto 0) :=  "000101";    

    
    
    signal Instr1_isImmediate, Instr2_isImmediate,  Instr2_isImmediate_without_sw_lw, Instr1_isImmediate_without_sw_lw : std_logic;
    signal ALUprocess_out: std_logic_vector(64 downto 0);
    
    signal Immprocess_out: std_logic_vector(64 downto 0);
    signal Swprocess_out: std_logic_vector(64 downto 0);
    signal lwprocess_out: std_logic_vector(64 downto 0);
    signal lui_process_out: std_logic_vector(64 downto 0);
    signal Branch_Jump_process_out: std_logic_vector(64 downto 0);
    signal finalOut : std_logic_vector(64 downto 0);
    
    signal Instr1_isJtype, Instr2_isJtype  : std_logic;
    signal Instr1_isJrtype, Instr2_isJrtype  : std_logic;
    
    signal Is_JR      : std_logic;
--    signal ALUprocess_out_HI : std_logic_vector(31 downto 0);
--    signal ALUprocess_out_LO : std_logic_vector(31 downto 0);
begin

       opCode1 <= Instr1(31 downto 26);
       opCode2 <= Instr2(31 downto 26);
       
       funct1 <= Instr1(5 downto 0);
       funct2 <= Instr2(5 downto 0);
       
       rs1 <= instr1(25 downto 21);
       rs2 <= instr2(25 downto 21);
       
       rt1 <= instr1(20 downto 16);
       rt2 <= instr2(20 downto 16);
       
       rd1 <= instr1(15 downto 11);
       rd2 <= instr2(15 downto 11);

    
with opCode1 select 
    Instr1_isImmediate <= '1' when  addi | lw | sw|  andi | ori | xori | slti, '0' when others;

with opCode2 select 
    Instr2_isImmediate <= '1' when  addi | lw | sw | andi | ori | xori | slti, '0' when others;
    
Is_Jrtype_process : process(opcode2, funct2)
    begin 
        if((to_integer(unsigned(opcode2)) = 0) and funct2 = jRfunct) then 
            Instr2_isJrtype <= '1' ;
            else
             Instr2_isJrtype <= '0'; 
         end if;
    end process;
    
 Is_Jrtype_process2 : process(opcode1, funct1)
    begin 
        if((to_integer(unsigned(opcode1)) = 0) and funct1 = jRfunct) then 
            Instr1_isJrtype <= '1' ;
            else
             Instr1_isJrtype <= '0'; 
         end if;
    end process;
    
    
    
    
 Is_Rtype_without_JR_proc    : Is_JR <= '1' when (opCode1 = Rtype and funct1 = jrfunct)  else '0';

with opCode1 select 
    Instr1_isJtype <= '1' when jal | j, '0' when others;
    
 with opCode2 select 
    Instr2_isJtype <= '1' when jal | j, '0' when others;
    
    
    ALU_as_Instr1 : process(opCode2, Instr2_isImmediate, Instr2_isJrtype, Instr2_isJtype, rd1, rd2, rs2, rt2, Instr1, Instr2)
        begin 
            if(Instr2_isImmediate = '1' and ((rd1 /= rs2) and (rd1 /= rt2))) then 
               ALUprocess_out <= '0' & Instr1 & Instr2 ;
            
            elsif(opCode2 = Rtype and (rd1 /= rd2) and (rd1 /= rs2) and (rd1 /= rt2)) then 
                ALUprocess_out <= '0' & Instr1 & Instr2 ;
            
            elsif((opCode2 = Beq or opCode2 = Bne) and (rd1 /= rs2) and (rd1 /= rt2 )) then 
                ALUprocess_out <= '0' & Instr2 & Instr1;
            
            elsif(opCode2 = lui and (rd1 /= rt2)) then 
                ALUprocess_out <= '0' & Instr1 & Instr2;
                
            elsif(Instr2_isJtype = '1') then 
                ALUprocess_out <= '0' & Instr2 & Instr1;
            
            elsif( Instr2_isJrtype = '1' and rd1 /=  rs2) then 
                 ALUprocess_out <= '0' & Instr2 & Instr1;
            else 
                ALUprocess_out <= '1' & Instr1 & x"0000_0000";
            end if;
        end process;
        
 
 with opCode1 select 
    Instr1_isImmediate_without_sw_lw <= '1' when  addi | andi | ori | xori | slti, '0' when others;

with opCode2 select 
    Instr2_isImmediate_without_sw_lw <= '1' when  addi | andi | ori | xori | slti, '0' when others;       
    
    
    
    Immediate_as_Instr1 : process(opCode2, Instr2_isImmediate, Instr2_isJrtype, Instr2_isJtype, rt1, rt2, rs2, rd2, Instr1, Instr2)
        begin 
            if( Instr2_isImmediate = '1' and (rt1 /= rt2) and (rt1 /= rs2) ) then 
                Immprocess_out <= '0' & Instr1 & Instr2;
            
            elsif(opCode2 = RType and (rt1 /= rd2) and (rt1 /= rs2) and (rt1 /= rt2)) then 
                Immprocess_out <= '0' & Instr1 & Instr2;
            
            elsif((opCode2 = Beq or opCode2 = Bne) and (rt1 /= rs2) and (rt1 /= rt2)) then 
                Immprocess_out <= '0' & Instr2 & Instr1;
            
            elsif(opCode2 = lui and (rt1 /= rt2)) then 
                Immprocess_out <= '0' & Instr1 & Instr2;
            
            elsif(Instr2_isJtype = '1') then 
                Immprocess_out <= '0' & Instr2 & Instr1;
            
            elsif(Instr2_isJrtype = '1' and (rt1 /= rs2)) then 
                Immprocess_out <= '0' & Instr2 & Instr1;    
            
            else 
                Immprocess_out <= '1' & Instr1 & x"0000_0000";
            
            end if;
        end process;
        
        
      
      Branch_Jump_process_out <= '1' & Instr1 & x"0000_0000";
      
      
      sw_as_Instr1 : process(opCode2, Instr2_isImmediate_without_sw_lw, Instr2_isJrtype, Instr2_isJtype,rs1,rd2, rs2, rt2, Instr1, Instr2)
            begin 
                if(Instr2_isImmediate_without_sw_lw = '1' and (rs1 /= rs2) and (rs1 /= rt2)) then
                    Swprocess_out <= '0' & Instr1 & Instr2;
                
                elsif(opCode2 = Rtype and (rs1 /= rs2 ) and ( rs1 /= rt2) and ( rs1 /= rd2) ) then 
                    Swprocess_out <= '0' & Instr1 & Instr2;
                
                elsif((opcode2 = Beq or  opCode2 = Bne ) and (rs1 /= rs2) and (rs1 /= rt2) ) then 
                    Swprocess_out <= '0' & Instr2 & Instr1;
                
                elsif(opCode2 = lui and (rs1 /= rt2)) then 
                    Swprocess_out <= '0' & Instr1 & Instr2;
                
                elsif (Instr2_isJtype = '1') then 
                    Swprocess_out <= '0' & Instr2 & Instr1;
                    
                elsif (Instr2_isJrtype = '1' and (rs1 /= rs2)) then 
                    Swprocess_out <= '0' & Instr2 & Instr1;
                    
                elsif((opCode2 = sw or opCode2 = lw) ) then
                    Swprocess_out <= '1' & Instr1 & x"0000_0000";
                else 
                    Swprocess_out <= '1' & Instr1 & x"0000_0000";
                end if; 
            end process;
            
      
      lui_as_Instr1 : process(opCode2, Instr2_isImmediate, Instr2_isJrtype, Instr2_isJtype,rt1,rd2, rs2, rt2, Instr1, Instr2) 
            begin 
                if(opCode2 = RType and (rt1 /= rd2) and (rt1 /= rs2) and (rt1 /= rt2)) then 
                    lui_process_out <= '0' & Instr1 & Instr2;
                
                elsif(Instr2_isImmediate = '1' and (rt1 /= rs2) and (rt1 /= rt2)) then 
                    lui_process_out <= '0' & Instr1 & Instr2;
               
               elsif((opCode2 = Beq or opCode2 = Bne) and (rt1 /= rs2) and (rt1 /= rt2)) then     
                    lui_process_out <= '0' & Instr2 & Instr1;
               
               elsif(Instr2_isJrtype= '1' and (rt1 /= rs2)) then 
                    lui_process_out <= '0' & Instr2 & Instr1;
               
               elsif(Instr2_isJtype = '1') then 
                    lui_process_out <= '0' & Instr2 & Instr1;
                   
               elsif(opCode2 = lui and  ( rt1 /= rt2)) then 
                    lui_process_out <= '0' & Instr1 & Instr2;
               else 
                    lui_process_out <= '1' & Instr1 & x"0000_0000";
                end if;
            end process;
      
      
      lw_as_Instr1  : process(opCode2, Instr2_isImmediate_without_sw_lw, Instr2_isJrtype, Instr2_isJtype, rt1, rs1,rd2, rs2, rt2, Instr1, Instr2)  
            begin 
                if(Instr2_isImmediate_without_sw_lw = '1' and (rt1 /= rs2) and (rt1 /= rt2)) then
                    lwprocess_out <= '0' & Instr1 & Instr2;
                
                elsif(opCode2 = Rtype and (rt1 /= rs2 ) and ( rt1 /= rt2) and ( rt1 /= rd2) ) then 
                    lwprocess_out <= '0' & Instr1 & Instr2;
                
                elsif((opcode2 = Beq or  opCode2 = Bne ) and (rt1 /= rs2) and (rt1 /= rt2) ) then 
                    lwprocess_out <= '0' & Instr2 & Instr1;
                
                elsif(opCode2 = lui and (rt1 /= rt2)) then 
                    lwprocess_out <= '0' & Instr1 & Instr2;
                
                elsif (Instr2_isJtype = '1') then 
                    lwprocess_out <= '0' & Instr2 & Instr1;
                    
                elsif (Instr2_isJrtype = '1' and (rt1 /= rs2)) then 
                    lwprocess_out <= '0' & Instr2 & Instr1;
                    
                elsif((opCode2 = sw or opCode2 = lw) ) then
                    lwprocess_out <= '1' & Instr1 & x"0000_0000";
                else 
                    lwprocess_out <= '1' & Instr1 & x"0000_0000";
                end if;     
            end process;
        
 finalOutputProcess :    process(opCode1,  Instr1_isImmediate_without_sw_lw, Instr1_isJrtype, Instr1_isJtype, rd1, rd2, rs2, rt2, ALUprocess_out, Immprocess_out,Branch_Jump_process_out,Swprocess_out, lwprocess_out, lui_process_out, Is_JR )
        begin 
            if((opCode1 = Rtype and Is_JR = '0')) then 
                finalOut <=  ALUprocess_out;
            
            elsif(Instr1_isImmediate_without_sw_lw = '1') then 
                 finalOut <= Immprocess_out;
                 
            elsif(Instr1_isJrtype = '1' or Instr1_isJtype = '1' or opCode1 = Beq or opCode1 = Bne or opCode1 = haltCPU ) then
                 finalOut <= Branch_Jump_process_out;
            
            elsif(opCode1 = sw) then 
                finalOut <= Swprocess_out;
            
            elsif(opCode1 = lui) then 
                finalOut <= lui_process_out;
            
            elsif(opCode1 = lw ) then 
                finalOut <= lwprocess_out;
            else 
                finalOut <= (others => '0');
            end if;
            
        end process;
        
         EX_Instr1 <= finalOut(63 downto 32);
         EX_Instr2 <= finalOut(31 downto 0);
        
         PC_Adder_Mux <= finalOut(64);
        
end Behavioral;
