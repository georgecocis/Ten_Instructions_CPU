library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity register_file is
Port (clk : in std_logic;
rn : in std_logic_vector (3 downto 0);
sh_o : in std_logic_vector (3 downto 0);
rd : in std_logic_vector (3 downto 0);
wr_d : in std_logic_vector (31 downto 0);
we : in std_logic;
rd1 : out std_logic_vector (31 downto 0);
rd2 : out std_logic_vector (31 downto 0) );
end register_file;

architecture Behavioral of register_file is
type reg_array is array (0 to 15) of std_logic_vector(31 downto 0);
signal reg_file : reg_array := (others => x"00000000");
begin
process(clk)
begin
if rising_edge(clk) then
if we = '1' then
reg_file(conv_integer(rd)) <= wr_d;
end if;
end if;
end process;
rd1 <= reg_file(conv_integer(rn));
rd2 <= reg_file(conv_integer(sh_o));
end Behavioral;
