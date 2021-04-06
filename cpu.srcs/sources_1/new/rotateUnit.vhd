library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rotateUnit is
Port (
rotateA: in std_logic_vector(3 downto 0);
immediate: in std_logic_vector(7 downto 0);
rotated: out std_logic_vector(31 downto 0)
);
end rotateUnit;

architecture Behavioral of rotateUnit is
signal rot: bit_vector(31 downto 0);
begin
rot(7 downto 0) <= to_bitvector(immediate);
rot(31 downto 8) <= (others=>'0');
rotated <= to_stdlogicvector((rot ror conv_integer(rotateA)) ror conv_integer(rotateA));
end Behavioral;
