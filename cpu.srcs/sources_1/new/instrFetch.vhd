library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity instr_fetch is
Port( 
    clk : in std_logic;
    reset: in std_logic;
    instr: out std_logic_vector(31 downto 0));
end instr_fetch;

architecture Behavioral of instr_fetch is
--ROM Instruction Memory
type reg_array is array (0 to 255) of std_logic_vector(31 downto 0);
signal reg_file : reg_array := (
0 => B"1101_00_1_1101_0_0000_0001_000000001000", --add rn
1 => B"1101_00_1_1101_0_0000_0010_000000000110", --add sh_o
2 => B"0100_00_0_0100_1_0001_0011_000000000010", --add
3 => B"1101_00_1_1101_0_0000_0001_000011111100", --sub rn
4 => B"0010_00_1_0010_1_0001_0011_111000000001", --sub
5 => B"1101_00_1_1101_0_0000_0001_000010000000", --orr rn
6 => B"1101_00_1_1101_0_0000_0010_000001000000", --orr sh_o
7 => B"1100_00_0_1100_1_0001_0011_000000000010", --orr
8 => B"1101_00_1_1101_0_0000_0001_000001000000", --adc rn
9 => B"1101_00_1_1101_0_0000_0010_000000100000", --adc sh_o
10 => B"0101_00_0_0101_1_0001_0011_000000000010", --adc
11 => B"1101_00_1_1101_0_0000_0001_000011000001", --sbc rn
12 => B"1101_00_1_1101_0_0000_0010_000010000000", --sbc sh_o
13 => B"0110_00_0_0110_1_0001_0011_000000000010", --sbc
14 => B"1101_00_1_1101_0_0000_0001_000000010000", --rsb rn
15 => B"1101_00_1_1101_0_0000_0010_000000100000", --rsb sh_o
16 => B"0011_00_0_0011_1_0001_0011_000000000010", --rsb
17 => B"1101_00_1_1101_0_0000_0001_000010000000", --cmp rn
18 => B"1101_00_1_1101_0_0000_0010_000010000000", --cmp sh_o
19 => B"1010_00_0_1010_1_0001_0011_000000000010", --cmp
20 => B"1101_00_1_1101_0_0000_0001_000110000000", --mov
21 => B"1110_01_0_0_1_0_0_1_0010_0011_000000000000",
22 => B"1111_01_0_0_0_0_0_0_0010_0011_000000000000",

others => B"00000000000000000000000000000000");

signal counter: std_logic_vector(15 downto 0) := (others=>'0');
--signal adder_out: std_logic_vector(15 downto 0);
signal ROM_instr: std_logic_vector(7 downto 0);


begin

--PC register
process (clk)
begin 
if clk = '1' and clk'event then   
    if reset='1' then
        counter <="0000000000000000";
          else counter <= counter + 1;
        end if;
     end if;
end process;

--ROM
ROM_instr <= counter(7 downto 0);
instr <= reg_file(conv_integer(ROM_instr));

end Behavioral;

