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

entity ALU is
Port (
in_flags: in std_logic_vector(3 downto 0);
--s: in std_logic;
mux_sel: in std_logic;
firstReg: in std_logic_vector(31 downto 0);
sndReg: in std_logic_vector(31 downto 0);
immedVal: in std_logic_vector(31 downto 0);
sel: in std_logic_vector(3 downto 0);
alu_out: out std_logic_vector (31 downto 0);
out_flags: out std_logic_vector(3 downto 0)
);
end ALU;

architecture Behavioral of ALU is
signal alu_outsig: std_logic_vector(31 downto 0);
signal alu_snd_in: std_logic_vector(31 downto 0);

begin
--mux for alu
alu_snd_in <= sndReg when (mux_sel = '0') else immedVal;
process(firstReg, alu_snd_in, sel, in_flags)
begin
case (sel) is
when "0100" => -- add
 alu_outsig <= firstReg + alu_snd_in;
 out_flags <= in_flags;
when "0010" => --sub
 alu_outsig <= firstReg - alu_snd_in;
  out_flags <= in_flags;
when "1100" => --orr
 alu_outsig <= firstReg or alu_snd_in;
  out_flags <= in_flags;
when "0101" => --adc
 alu_outsig <= firstReg + alu_snd_in + in_flags(0);
  out_flags <= in_flags;
when "0110" => --sbc
  alu_outsig <= firstReg - alu_snd_in - in_flags(0);
   out_flags <= in_flags;
when "0011" => --rsb
 alu_outsig <= alu_snd_in - firstReg;
  out_flags <= in_flags;
when "1010" => --cmp
 alu_outsig <= (others=>'Z');
 if (firstReg > alu_snd_in) then out_flags(3 downto 0) <= "100" & in_flags(0);
 elsif (firstReg = alu_snd_in) then out_flags(3 downto 0) <= "010" & in_flags(0);
 else out_flags(3 downto 0) <= "001" & in_flags(0);
 end if;
when "1101" => --mov 
 alu_outsig <= alu_snd_in;
 out_flags <= in_flags;
when "1110" => --ldr
 alu_outsig <= (others=>'Z');
 out_flags <= in_flags;
when "1111" => --str
 alu_outsig <= (others=>'Z');
 out_flags <= in_flags;
when others =>
 alu_outsig <= (others=>'Z');
 out_flags <= in_flags;
end case;
end process;
alu_out <= alu_outsig;
end Behavioral;
