library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity new_mul is
port (input,b:in std_logic_vector( 11 downto 0 );
output:out std_logic_vector( 23 downto 0 ));
end;
architecture new_mul of new_mul is
type r_array IS array (11 downto 0) of std_logic_vector (23 downto 0);
signal r : r_array;
signal a: std_logic_vector(23 downto 0);

begin
--process(input, b)begin
--if(input = x"000" or b=x"000")then
--output <= x"000000";
--else
--a(23 downto 12) <= (others=>input(11));
--a(11 downto 0) <= input;
--output <= outtemp;
--end if;
--end process;

r(0) <= a when b(0) = '1' else (others=>'0'); --12bit
r(1) <= (a(22 downto 0)&'0') when b(1) = '1' else (others=>'0'); --13bit
r(2) <= (a(21 downto 0)&"00") when b(2) = '1' else (others=>'0'); --14bit
r(3) <= (a(20 downto 0)&"000") when b(3) = '1' else (others=>'0'); --15bit
r(4) <= (a(19 downto 0)&"0000") when b(4) = '1' else (others=>'0'); --16bit
r(5) <= (a(18 downto 0)&"00000") when b(5) = '1' else (others=>'0'); --17bit
r(6) <= (a(17 downto 0)&"000000") when b(6) = '1' else (others=>'0'); --18bit
r(7) <= (a(16 downto 0)&"0000000") when b(7) = '1' else (others=>'0'); --19bit
r(8) <= (a(15 downto 0)&"00000000") when b(8) = '1' else (others=>'0'); --20bit
r(9) <= (a(14 downto 0)&"000000000") when b(9) = '1' else (others=>'0'); --21bit
r(10) <= (a(13 downto 0)&"0000000000") when b(10) = '1' else (others=>'0'); --22bit
r(11) <= (((NOT (input(11)&input))+1)&"00000000000") when b(11) = '1' else (others=>'0'); --23bit
output <= r(0)+r(1)+r(2)+r(3)+r(4)+r(5)+r(6)+r(7)+r(8)+r(9)+r(10)+r(11);
end;