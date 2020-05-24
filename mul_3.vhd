
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mul_3 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end mul_3;

architecture Behavioral of mul_3 is
signal a_full:STD_LOGIC_VECTOR(23 downto 0);
begin
a_full(23 downto 12) <= (others=>a(11));
a_full(11 downto 0) <= a;
output <= to_stdlogicvector(to_bitvector(a_full) sll 1)+a_full;

end Behavioral;
