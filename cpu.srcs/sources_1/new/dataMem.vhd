library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mem is
Port( clk: in std_logic;
addr : in std_logic_vector(31 downto 0);
rd: in std_logic_vector(31 downto 0);
write_en: in std_logic;	
readData:out std_logic_vector(31 downto 0));
end mem;

architecture Behavioral of mem is

signal Address: std_logic_vector(7 downto 0);
type ram_type is array (0 to 255) of std_logic_vector(31 downto 0);
signal RAM:ram_type:=(others => "00000000000000000000000000000000");

begin

Address<=addr(7 downto 0);

process(clk) 			
begin
	if(rising_edge(clk)) then
			if write_en='1' then
				RAM(conv_integer(Address))<=rd;			
			end if;
	end if;
end process;
	
readData<=RAM(conv_integer(Address));
end Behavioral;


