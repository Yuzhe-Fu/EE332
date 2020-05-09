library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity reg_8bit is
    Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in std_logic;
           rst : in std_logic;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end reg_8bit;
architecture Behavioral of reg_8bit is
begin
process(clk,rst) is
begin
if(rst = '1') then
output <= x"00";
elsif CLK 'event and CLK = '1' then 
output<=input;
end if;
end process;

end Behavioral;
