library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use ieee.numeric_std.all;

entity adder is
    Port ( a : in STD_LOGIC_VECTOR (23 downto 0);
           b : in STD_LOGIC_VECTOR (23 downto 0);
           s : out STD_LOGIC_VECTOR (23 downto 0));
end adder;
architecture Behavioral of adder is
--signal a_temp: STD_LOGIC_VECTOR (23 downto 0);
--signal b_temp: STD_LOGIC_VECTOR (23 downto 0);
--signal s_temp: STD_LOGIC_VECTOR (23 downto 0);
--signal c:std_logic:= '0';
begin
--process(a,b)
--begin
--for i in 0 to 23 loop
--s_temp(i)<=(a_temp(i) xor b_temp(i)) xor c;
--c <= (a_temp(i) and b_temp(i)) or (c and (a_temp(i) or b_temp(i)));
--end loop;
--s <= s_temp;
--end process;
s<=a + b;
end Behavioral;
