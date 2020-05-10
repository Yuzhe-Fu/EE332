library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity tb_forz2top is
--  Port ( );
end tb_forz2top;

architecture Behavioral of tb_forz2top is
component for_z2top is
    --generic (WIDTH: natural:=10);
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
       clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal clk,rst: STD_LOGIC:='0';
signal x,y:STD_LOGIC_VECTOR (7 downto 0);
begin
my_forz2top: for_z2top port map
(x,clk,rst,y);
clk_process: process
constant period:time:= 20ns;
begin
clk <= '1'; wait for period/2;
clk <= '0'; wait for period/2;
end process;
initial: process
constant period:time:= 20ns;
begin
rst<= '1'; wait for 210ns;
rst<= '0';
x <= x"01"; wait for period;
x <= x"01"; wait for period;
x <= x"01"; wait for period;
x <= x"01"; wait for period;
x <= x"01"; wait for period;
x <= x"00";
wait;
end process;
end Behavioral;
