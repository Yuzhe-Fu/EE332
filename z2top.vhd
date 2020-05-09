library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;

entity z2top is
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (7 downto 0));
end z2top;

architecture Behavioral of z2top is
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

signal h0,h1, h2, h3, h4: STD_LOGIC_VECTOR (7 downto 0);
signal mul0, mul1, mul2, mul3, mul4: STD_LOGIC_VECTOR (15 downto 0);
signal sum0, sum1, sum2, sum3: STD_LOGIC_VECTOR (15 downto 0);
signal reg0, reg1, reg2, reg3,reg4: STD_LOGIC_VECTOR (15 downto 0);

begin
h0 <= x"01";
h1 <= x"ff";
h2 <= x"01";
h3 <= x"ff";
h4 <= x"01";

h_u0: h port map(x,h0,mul0);
h_u1: h port map(x,h1,mul1);
h_u2: h port map(x,h2,mul2);
h_u3: h port map(x,h3,mul3);
h_u4: h port map(x,h4,mul4);

reg_u0: reg_16bit port map(mul0,clk,rst,reg0);
reg_u1: reg_16bit port map(sum0,clk,rst,reg1);
reg_u2: reg_16bit port map(sum1,clk,rst,reg2);
reg_u3: reg_16bit port map(sum2,clk,rst,reg3);
reg_u4: reg_16bit port map(sum3, clk, rst, reg4);

sum_u0: adder port map(reg0,mul1,sum0);
sum_u1: adder port map(reg1,mul2,sum1);
sum_u2: adder port map(reg2,mul3,sum2);
sum_u3: adder port map(reg3,mul4,sum3);

y <= reg4(7 downto 0);
--y <= sum3(7 downto 0);
end Behavioral;
