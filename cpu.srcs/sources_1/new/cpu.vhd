library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpu is
 Port (
 clk: in std_logic;
 reset: in std_logic );
end cpu;

architecture Behavioral of cpu is
component ALU is
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
end component;

component adder is
    port (
    a: in std_logic;
    b: in std_logic;
    cin: in std_logic;
    sum: out std_logic;
    cout: out std_logic
     );
end component;

component instr_fetch is
Port( 
    clk : in std_logic;
    reset: in std_logic;
    instr: out std_logic_vector(31 downto 0));
end component;

component mem is
Port( clk: in std_logic;
addr : in std_logic_vector(31 downto 0);
rd: in std_logic_vector(31 downto 0);
write_en: in std_logic;	
readData:out std_logic_vector(31 downto 0));
end component;

component mux is
Port (
sel: in std_logic;
a: in std_logic_vector(31 downto 0);
b: in std_logic_vector(31 downto 0);
x: out std_logic_vector(31 downto 0)
);
end component;

component register_file is
Port (clk : in std_logic;
rn : in std_logic_vector (3 downto 0);
sh_o : in std_logic_vector (3 downto 0);
rd : in std_logic_vector (3 downto 0);
wr_d : in std_logic_vector (31 downto 0);
we : in std_logic;
rd1 : out std_logic_vector (31 downto 0);
rd2 : out std_logic_vector (31 downto 0) );
end component;

component rotateUnit is
Port (
rotateA: in std_logic_vector(3 downto 0);
immediate: in std_logic_vector(7 downto 0);
rotated: out std_logic_vector(31 downto 0)
);
end component;

signal instr1: std_logic_vector(31 downto 0);
signal wrd: std_logic_vector(31 downto 0);
signal rd1, rd2: std_logic_vector(31 downto 0);
signal wre: std_logic;
signal rotatedd: std_logic_vector(31 downto 0);
signal sig_x: std_logic_vector(31 downto 0);
signal inflags: std_logic_vector(3 downto 0);
signal flags: std_logic_vector(3 downto 0) := (others=>'0');
signal aluout: std_logic_vector(31 downto 0);
signal rddata: std_logic_vector(31 downto 0);

begin
if1: instr_fetch port map(clk, reset, instr1);
rf1: register_file port map(clk, instr1(19 downto 16), instr1(3 downto 0), instr1(15 downto 12), aluout, wre, rd1, rd2);
ro: rotateUnit port map (instr1(11 downto 8), instr1(7 downto 0), rotatedd);
al: alu port map (flags, instr1(25), rd1, rd2, rotatedd, instr1(31 downto 28), aluout, inflags);
mm: mem port map (clk, aluout, rd1, '0', rddata);

process(clk, reset)
begin
if rising_edge(clk) then
  if (reset = '1') then
    flags <= "0000";
  end if;
  flags <= inflags;
end if;
end process;

process(instr1)
begin
case instr1(31 downto 28) is
  when "0100" => -- add
  wre <= '1';
when "0010" => --sub
  wre <= '1';
when "1100" => --orr
   wre <= '1';
when "0101" => --adc
   wre <= '1';
when "0110" => --sbc
    wre <= '1';
when "0011" => --rsb
   wre <= '1';
when "1010" => --cmp
  wre <= '0';
when "1101" => --mov 
  wre <= '1';
when "1110" => --ldr
   wre <= '0';
when "1111" => --str
   wre <= '0';
when others =>
   wre <= '0';
end case;
end process;

end Behavioral;
