library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity pip is
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           x1 : out STD_LOGIC_VECTOR (7 downto 0);
           x2 : out STD_LOGIC_VECTOR (7 downto 0);
           x3 : out STD_LOGIC_VECTOR (7 downto 0);
           x4 : out STD_LOGIC_VECTOR (7 downto 0));
end pip;
architecture Behavioral of pip is
constant WIDTH : integer := 8;
signal x1_reg,x1_next,x2_reg,x2_next,x3_reg,x3_next,x4_reg,x4_next: std_logic_vector(WIDTH-1 downto 0);
begin
process (CLK , rst) is 
begin 
if rst = '1'then 
x1_reg <= x"00";
x2_reg <= x"00";
x3_reg <= x"00";
x4_reg <= x"00";
elsif CLK 'event and CLK = '1' then 
x1_reg<=x1_next;
x2_reg<=x2_next;
x3_reg<=x3_next;
x4_reg<=x4_next;
end if; 
end process ;

process(x,x1_reg,x2_reg,x3_reg,x4_reg) is
begin
x1_next <= x;
x2_next <= x1_reg;
x3_next <= x2_reg;
x4_next <= x3_reg;
end process;

x1 <= x1_reg;
x2 <= x2_reg;
x3 <= x3_reg;
x4 <= x4_reg;
end Behavioral;
