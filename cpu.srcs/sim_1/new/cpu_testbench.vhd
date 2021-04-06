----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/09/2021 06:41:52 PM
-- Design Name: 
-- Module Name: cpu_testbench - Behavioral
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

entity cpu_testbench is
--  Port ( );
end cpu_testbench;

architecture Behavioral of cpu_testbench is

component cpu is
 Port (
 clk: in std_logic;
 reset: in std_logic );
end component;

signal rst, clk: std_logic;
begin

process
begin
clk <= '0';
wait for 5ns;
clk <= '1';
wait for 5ns;
end process;

process
begin
rst <= '0';
wait for 200ns;
rst <= '1';
wait for 5ns;
end process;

cp: cpu port map(clk, rst);

end Behavioral;
