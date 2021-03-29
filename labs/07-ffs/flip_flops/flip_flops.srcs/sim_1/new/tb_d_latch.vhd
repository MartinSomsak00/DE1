----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2021 10:26:31 AM
-- Design Name: 
-- Module Name: tb_d_latch - Behavioral
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

entity tb_d_latch is
end tb_d_latch;

architecture Behavioral of tb_d_latch is
    signal s_en    : STD_LOGIC;
    signal s_d     : STD_LOGIC;
    signal s_arst  : STD_LOGIC;
    signal s_q     : STD_LOGIC;
    signal s_q_bar : STD_LOGIC;
begin


uut_d_latch : entity work.d_latch
    port map (
        en      =>  s_en,
        d       =>  s_d,
        arst    =>  s_arst,
        q       =>  s_q,
        q_bar   =>  s_q_bar
    );
    
    
    p_reset_gen :process
    begin
    s_arst  <=  '0';
    wait for 10 ns; 
    
    s_arst  <=  '1';
    wait for 10 ns; 
    
    s_arst  <=  '0';
    wait for 50 ns; 
    
      s_arst  <=  '1';
      wait;
    
    
    end process p_reset_gen;
    
    
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started. " severity note;
        
        s_en    <=  '0';
        
        s_d     <=  '0'; 
        wait for 10 ns; 
        
        wait for 10 ns;
        
        
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') 
        report "Failed 1" severity note;
        
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') 
        report "Failed 2" severity note;
        
        
        s_en    <=  '1';
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') 
        report "Failed 3" severity note;
       
        s_en    <=  '1';
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1')
        report "Failed 4" severity note;
        
        
        s_en    <=  '1';
        s_d     <=  '1';
        wait for 10ns;
        
        assert (s_q = '0' and s_q_bar = '1') 
        report "Failed 5" severity note;
        
        report "Stimulus process end." severity note;
        wait;
    end process p_stimulus;

end Behavioral;