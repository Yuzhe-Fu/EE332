library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity z1top is
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (7 downto 0));
end z1top;

architecture Behavioral of z1top is
component pip is
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           x1 : out STD_LOGIC_VECTOR (7 downto 0);
           x2 : out STD_LOGIC_VECTOR (7 downto 0);
           x3 : out STD_LOGIC_VECTOR (7 downto 0);
           x4 : out STD_LOGIC_VECTOR (7 downto 0));
end component;
component h is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end component;
component adder is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           s : out STD_LOGIC_VECTOR (15 downto 0));
end component;
component reg_16bit is
    Port ( input : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in std_logic;
           rst : in std_logic;
           output : out STD_LOGIC_VECTOR (15 downto 0));
end component;
signal x1, x2, x3, x4: STD_LOGIC_VECTOR (7 downto 0);
signal h0,h1, h2, h3, h4: STD_LOGIC_VECTOR (7 downto 0);
signal mul0, mul1, mul2, mul3, mul4: STD_LOGIC_VECTOR (15 downto 0);
signal sum1, sum2, sum3, sum4: STD_LOGIC_VECTOR (15 downto 0);
signal regout: STD_LOGIC_VECTOR (15 downto 0);
begin
h0 <= x"01";
h1 <= x"01";
h2 <= x"01";
h3 <= x"01";
h4 <= x"01";
pip_u1: pip port map(x,clk,rst,x1,x2,x3,x4);

h_u1: h port map(x,h0,mul0);
h_u2: h port map(x1,h1,mul1);
h_u3: h port map(x2,h2,mul2);
h_u4: h port map(x3,h3,mul3);
h_u5: h port map(x4,h4,mul4);

sum_u1: adder port map(mul0,mul1,sum1);
sum_u2: adder port map(sum1,mul2,sum2);
sum_u3: adder port map(sum2,mul3,sum3);
sum_u4: adder port map(sum3,mul4,sum4);

reg_u1: reg_16bit port map(sum4,clk,rst,regout);
y <= regout(7 downto 0);

end Behavioral;
