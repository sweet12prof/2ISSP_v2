----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/01/2020 07:16:36 PM
-- Design Name: 
-- Module Name: DE_pipe_REG - Behavioral
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

entity DE_pipe_REG is
  generic( CU_Signals_Width : positive :=11);
  Port ( 
            clk             :   in std_logic;
            reset           :   in std_logic;
            FlushE          :   in std_logic;
            
            CU_SignalsD     :   in std_logic_vector(CU_Signals_Width - 1 downto 0);    
            W1_RD1_D        :   in std_logic_vector(31 downto 0);
            W1_RD2_D        :   in std_logic_vector(31 downto 0);
            W1_rs_D         :   in std_logic_vector(4 downto 0);
            W1_rt_D         :   in std_logic_vector(4 downto 0);
            W1_rd_D         :   in std_logic_vector(4 downto 0);
            W1_SignImm_D    :   in std_logic_vector(31 downto 0);
            W1_ZeroPad_D    :   in std_logic_vector(31 downto 0);      
            
            W2_RD1_D        :   in std_logic_vector(31 downto 0);
            W2_RD2_D        :   in std_logic_vector(31 downto 0);
            W2_rs_D         :   in std_logic_vector(4 downto 0);
            W2_rt_D         :   in std_logic_vector(4 downto 0);
            W2_rD_D         :   in std_logic_vector(4 downto 0);
            W2_SignImm_D    :   in std_logic_vector(31 downto 0);
            W2_ZeroPad_D    :   in std_logic_vector(31 downto 0);    
            
            PCplus4_8D      :   in std_logic_vector(31 downto 0);
            
            
            CU_SignalsE     :   out std_logic_vector(CU_Signals_Width - 1 downto 0);         
            W1_RD1_E        :   out std_logic_vector(31 downto 0);
            W1_RD2_E        :   out std_logic_vector(31 downto 0);
            W1_rs_E         :   out std_logic_vector(4 downto 0);
            W1_rt_E         :   out std_logic_vector(4 downto 0);
            W1_rd_E         :   out std_logic_vector(4 downto 0);
            W1_SignImm_E    :   out std_logic_vector(31 downto 0);
            W1_ZeroPad_E    :   out std_logic_vector(31 downto 0);      
                                
            W2_RD1_E        :   out std_logic_vector(31 downto 0);
            W2_RD2_E        :   out std_logic_vector(31 downto 0);
            W2_rs_E         :   out std_logic_vector(4 downto 0);
            W2_rt_E         :   out std_logic_vector(4 downto 0);
            W2_rD_E         :   out std_logic_vector(4 downto 0);
            W2_SignImm_E    :   out std_logic_vector(31 downto 0);
            W2_ZeroPad_E    :   out std_logic_vector(31 downto 0);    
                                
            PCplus4_8E      :   out std_logic_vector(31 downto 0)         
            
        );
end DE_pipe_REG;

architecture Behavioral of DE_pipe_REG is

begin

DE_pipe_rEG_PROCESS : process(clk, reset )
                        begin 
                            if(reset = '1') then 
                                CU_SignalsE    <=    (others => '0') ;
                                W1_RD1_E       <=    (others => '0') ;
                                W1_RD2_E       <=    (others => '0') ;
                                W1_rs_E        <=    (others => '0') ;
                                W1_rt_E        <=    (others => '0') ;
                                W1_rd_E        <=    (others => '0') ;
                                W1_SignImm_E   <=    (others => '0') ;
                                W1_ZeroPad_E   <=    (others => '0') ;
                                                                     
                                W2_RD1_E       <=    (others => '0') ;
                                W2_RD2_E       <=    (others => '0') ;
                                W2_rs_E        <=    (others => '0') ;
                                W2_rt_E        <=    (others => '0') ;
                                W2_rD_E        <=    (others => '0') ;
                                W2_SignImm_E   <=    (others => '0') ;
                                W2_ZeroPad_E   <=    (others => '0') ;
                                                                     
                                PCplus4_8E     <=    (others => '0') ;
                             
                            elsif (rising_edge(clk)) then 
                                if(flushE = '1') then 
                                    CU_SignalsE    <=    (others => '0') ;
                                    W1_RD1_E       <=    (others => '0') ;
                                    W1_RD2_E       <=    (others => '0') ;
                                    W1_rs_E        <=    (others => '0') ;
                                    W1_rt_E        <=    (others => '0') ;
                                    W1_rd_E        <=    (others => '0') ;
                                    W1_SignImm_E   <=    (others => '0') ;
                                    W1_ZeroPad_E   <=    (others => '0') ;
                                                                         
                                    W2_RD1_E       <=    (others => '0') ;
                                    W2_RD2_E       <=    (others => '0') ;
                                    W2_rs_E        <=    (others => '0') ;
                                    W2_rt_E        <=    (others => '0') ;
                                    W2_rD_E        <=    (others => '0') ;
                                    W2_SignImm_E   <=    (others => '0') ;
                                    W2_ZeroPad_E   <=    (others => '0') ;
                                                         
                                    PCplus4_8E     <=    (others => '0') ;
                                    
                                 else 
                                      CU_SignalsE    <=    CU_SignalsD   ; 
                                      W1_RD1_E       <=    W1_RD1_D      ; 
                                      W1_RD2_E       <=    W1_RD2_D      ; 
                                      W1_rs_E        <=    W1_rs_D       ; 
                                      W1_rt_E        <=    W1_rt_D       ; 
                                      W1_rd_E        <=    W1_rd_D       ; 
                                      W1_SignImm_E   <=    W1_SignImm_D  ; 
                                      W1_ZeroPad_E   <=    W1_ZeroPad_D  ; 
                                    
                                      W2_RD1_E       <=    W2_RD1_D      ; 
                                      W2_RD2_E       <=    W2_RD2_D      ; 
                                      W2_rs_E        <=    W2_rs_D       ; 
                                      W2_rt_E        <=    W2_rt_D       ; 
                                      W2_rD_E        <=    W2_rD_D       ; 
                                      W2_SignImm_E   <=    W2_SignImm_D  ; 
                                      W2_ZeroPad_E   <=    W2_ZeroPad_D  ; 
                                    
                                      PCplus4_8E     <=    PCplus4_8D    ;     
                                 end if;                              
                            end if;
                        end process; 
end Behavioral;
