library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use ieee.numeric_std.all;

entity h is
    Port ( a : in STD_LOGIC_VECTOR(11 downto 0);
           b : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end h;

architecture Behavioral of h is
begin
output <= a*b;
end Behavioral;
