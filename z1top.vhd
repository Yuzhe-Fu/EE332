library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity z1top is
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (7 downto 0));
end z1top;

architecture Behavioral of z1top is

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

component reg_8bit is
    Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in std_logic;
           rst : in std_logic;
           output : out STD_LOGIC_VECTOR (7 downto 0));
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
signal reg0, reg1, reg2, reg3: STD_LOGIC_VECTOR (7 downto 0);

signal reg4: STD_LOGIC_VECTOR (15 downto 0);
begin
h0 <= x"01";
h1 <= x"ff";
h2 <= x"01";
h3 <= x"ff";
h4 <= x"01";

h_u0: h port map(x,h0,mul0);
h_u1: h port map(reg0,h1,mul1);
h_u2: h port map(reg1,h2,mul2);
h_u3: h port map(reg2,h3,mul3);
h_u4: h port map(reg3,h4,mul4);

sum_u1: adder port map(mul0,mul1,sum1);
sum_u2: adder port map(sum1,mul2,sum2);
sum_u3: adder port map(sum2,mul3,sum3);
sum_u4: adder port map(sum3,mul4,sum4);

reg_u0: reg_8bit port map(x,clk,rst,reg0);
reg_u1: reg_8bit port map(reg0,clk,rst,reg1);
reg_u2: reg_8bit port map(reg1,clk,rst,reg2);
reg_u3: reg_8bit port map(reg2,clk,rst,reg3);

reg_u4: reg_16bit port map(sum4,clk,rst,reg4);

y <= reg4(7 downto 0);
--y <= sum4(7 downto 0);
end Behavioral;
