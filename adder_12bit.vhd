library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use ieee.numeric_std.all;

entity adder_12bit is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           b : in STD_LOGIC_VECTOR (11 downto 0);
           s : out STD_LOGIC_VECTOR (11 downto 0));
end adder_12bit;
architecture Behavioral of adder_12bit is
begin
s<=a + b;
end Behavioral;
