odkaz na repositar [DE1](https://github.com/MartinSomsak00/DE1) 

# Task 1 

## connection of push buttons on Nexys A7 board
| **PIN** | **PORT** | **VALUE** |
| :-: | :-: | :-: |
| N17 | BTNC | 1 |
| M18 | BTNU | 1 |
| P17 | BTNL | 1 |
| M17 | BTNR | 1 |
| P18 | BTND | 1 |
## Table with calculated values:

| **Time interval** | **Number of clk periods** | **Number of clk periods in hex** | **Number of clk periods in binary** |
   | :-: | :-: | :-: | :-: |
   | 2&nbsp;ms | 200 000 | `x"3_0d40"` | `b"0011_0000_1101_0100_0000"` |
   | 4&nbsp;ms | 400 000 | `x"6_1A80"` | `b"0110_0001_1010_1000_0000"` |
   | 10&nbsp;ms | 1 000 000 | `x"F_4240"` | `b"1111_0100_0010_0100_0000"` |
   | 250&nbsp;ms | 25 000 000 | `x"17D_7840"` | `b"0001_0111_1101_0111_1000_0100_0000"` |
   | 500&nbsp;ms | 50 000 000 | `x"2FA_F080"` | `b"0010_1111_1010_1111_0000_1000_0000"` |
   | 1&nbsp;sec | 100 000 000 | `x"5F5_E100"` | `b"0101_1111_0101_1110_0001_0000_0000"` |
   
   # Task 2 
   
   ## Listing of VHDL code of the process p_cnt_up_down: 
   
   ```vhdl
     p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then
        
            if (reset = '1') then               -- Synchronous reset
                s_cnt_local <= (others => '0'); -- Clear all bits

            elsif (en_i = '1') then       -- Test if counter is enabled


                -- TEST COUNTER DIRECTION HERE


                s_cnt_local <= s_cnt_local + 1;


            end if;
        end if;
    end process p_cnt_up_down;

    -- Output must be retyped from "unsigned" to "std_logic_vector"
    cnt_o <= std_logic_vector(s_cnt_local);
   ```
   
   ## Listing of VHDL reset and stimulus processes from testbench file:
   
   ```vhdl
     p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        -- Enable counting
        s_en     <= '1';
        
        -- Change counter direction
        s_cnt_up <= '1';
        wait for 380 ns;
        s_cnt_up <= '0';
        wait for 220 ns;

        -- Disable counting
        s_en     <= '0';

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
   ```
   
   ## Screenshot with simulated time waveforms

![waveforms](images/graf1.PNG)

# Task 3

## Listing of VHDL code from source file top.vhd:

```vhdl
 -- Instance (copy) of clock_enable entity
    clk_en0 : entity work.clock_enable
        generic map(
        
        g_MAX => 100000000
           
        )
        port map(
            --- WRITE YOUR CODE HERE
            
            clk => CLK100MHZ,
            reset =>  BTNC,
            ce_o => s_en
        );

    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            --- WRITE YOUR CODE HERE
            g_CNT_WIDTH => 4
        )
        port map(
            --- WRITE YOUR CODE HERE
            clk => CLK100MHZ,
            reset => BTNC,
            en_i => s_en,
            cnt_up_i => SW(0),
            cnt_o => s_cnt
        );

    -- Display input value on LEDs
    LED(3 downto 0) <= s_cnt;

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => s_cnt,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    
    
```


## Images of the top layer 4 and a 16-bit counters

   ![top4](images/TOP4.PNG)
   
   
   ![top16](images/TOP16.PNG)