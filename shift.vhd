library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift is
    Port ( a_full : in STD_LOGIC_VECTOR (23 downto 0);
           b : in STD_LOGIC;
           shift_out : out STD_LOGIC_VECTOR (23 downto 0));
end shift;

architecture Behavioral of shift is

begin
process(a_full, b) begin


end process;

end Behavioral;
