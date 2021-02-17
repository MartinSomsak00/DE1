# CV-02-Lgic
## Task1
| **Dec. equivalent** | **B[1:0]** | **A[1:0]** | **B is greater than A** | **B equals A** | **B is less than A** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 0 | 0 0 | 0 | 1 | 0 |
| 1 | 0 0 | 0 1 | 0 | 0 | 1 |
| 2 | 0 0 | 1 0 | 0 | 0 | 1 |
| 3 | 0 0 | 1 1 | 0 | 0 | 1 |
| 4 | 0 1 | 0 0 | 1 | 0 | 0 |
| 5 | 0 1 | 0 1 | 0 | 1 | 0 |
| 6 | 0 1 | 1 0 | 0 | 0 | 1 |
| 7 | 0 1 | 1 1 | 0 | 0 | 1 |
| 8 | 1 0 | 0 0 | 1 | 0 | 0 |
| 9 | 1 0 | 0 1 | 1 | 0 | 0 |
| 10 | 1 0 | 1 0 | 0 | 1 | 0 |
| 11 | 1 0 | 1 1 | 0 | 0 | 1 |
| 12 | 1 1 | 0 0 | 1 | 0 | 0 |
| 13 | 1 1 | 0 1 | 1 | 0 | 0 |
| 14 | 1 1 | 1 0 | 1 | 0 | 0 |
| 15 | 1 1 | 1 1 | 0 | 1 | 0 |


## Task2

![B>A](images/BgreaterA.png) 

B>A=B1*!A1+B1*B0*!A0+B0*!A0*!A1

![B=A](images/BequalsA.png) 

![B<A](images/BlessA.png) 

B<A=(!B1+A1)*(!B0+A1)*(A1+A0)*(!B1+!B0)*(!B1+A0)

VHDL code (design.vhd)

```vhdl
entity comparator_2bit is
    port(
        a_i           : in  std_logic_vector(2 - 1 downto 0);
        b_i           : in  std_logic_vector(2 - 1 downto 0);
        B_greater_A_o : out std_logic;
        B_equals_A_o  : out std_logic;
        B_less_A_o    : out std_logic       -- B is less than A


        -- COMPLETE ENTITY DECLARATION


        
        
    );
end entity comparator_2bit;

------------------------------------------------------------------------
-- Architecture body for 2-bit binary comparator
------------------------------------------------------------------------
architecture Behavioral of comparator_2bit is
begin
    B_greater_A_o <= '1' when (b_i > a_i) else '0';
    B_less_A_o <= '1' when (b_i < a_i) else '0';
    B_equals_A_o <= '1' when (b_i = a_i) else '0';
	
	```
	
	VHDL testbench (testbench.vhd)
	```vhdl
	begin
    -- Connecting testbench signals with comparator_2bit entity (Unit Under Test)
    uut_comparator_2bit : entity work.comparator_2bit
        port map(
            a_i           => s_a,
            b_i           => s_b,
            B_greater_A_o => s_B_greater_A,
            B_equals_A_o  => s_B_equals_A,
            B_less_A_o    => s_B_less_A
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;


        -- First test values
        s_b <= "00"; s_a <= "00"; wait for 100 ns;
        -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
        -- If false, then report an error
        report "Test failed for input combination: 00, 00" severity error;
          s_b <= "00"; s_a <= "01"; wait for 100 ns;
           s_b <= "00"; s_a <= "10"; wait for 100 ns;
           s_b <= "00"; s_a <= "11"; wait for 100 ns;
            s_b <= "01"; s_a <= "00"; wait for 100 ns;
          s_b <= "01"; s_a <= "01"; wait for 100 ns;
           s_b <= "01"; s_a <= "10"; wait for 100 ns;
           s_b <= "01"; s_a <= "11"; wait for 100 ns;
           s_b <= "10"; s_a <= "00"; wait for 100 ns;
           s_b <= "10"; s_a <= "01"; wait for 100 ns;
           s_b <= "10"; s_a <= "10"; wait for 100 ns;
            s_b <= "10"; s_a <= "11"; wait for 100 ns;
          s_b <= "11"; s_a <= "00"; wait for 100 ns;
           s_b <= "11"; s_a <= "01"; wait for 100 ns;
           s_b <= "11"; s_a <= "10"; wait for 100 ns;
           s_b <= "11"; s_a <= "11"; wait for 100 ns;
```
![simulated time waveforms](images/02graf.png) 

[EDAPLAYGROUND](https://www.edaplayground.com/x/RCQs)

