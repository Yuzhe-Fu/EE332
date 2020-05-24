library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.std_logic_arith.all;

entity improve2_z2top_s1 is
    generic (WIDTH: natural:=25);-- the number of h
    Port ( x : in STD_LOGIC_VECTOR (11 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (15 downto 0));
end improve2_z2top_s1;

architecture Behavioral of improve2_z2top_s1 is

component adder is
    Port ( a : in STD_LOGIC_VECTOR (23 downto 0);
           b : in STD_LOGIC_VECTOR (23 downto 0);
           s : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component reg_24bit is
    Port ( input : in STD_LOGIC_VECTOR (23 downto 0);
           clk : in std_logic;
           rst : in std_logic;
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;

component mul_2 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_3 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_minus2 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_minus8 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_minus4 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_10 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_16 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_minus3 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_minus32 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_minus24 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_48 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_144 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
component mul_191 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;

type reg_array IS array (WIDTH-2 downto 0) of std_logic_vector (23 downto 0);
signal reg_out : reg_array;
type sum_array IS array (WIDTH-2 downto 0) of std_logic_vector (23 downto 0);
signal sum_out : sum_array;
type mul_array IS array (12 downto 0) of std_logic_vector (23 downto 0);
signal mul_out : mul_array;
signal finalout: STD_LOGIC_VECTOR (23 downto 0);

begin

h_0: mul_2 port map(x,mul_out(0));
h_1: mul_3 port map(x,mul_out(1));
h_2: mul_minus2 port map(x,mul_out(2));
h_3: mul_minus8 port map(x,mul_out(3));
h_4: mul_minus8 port map(x,mul_out(4));

h_5: mul_10 port map(x,mul_out(5));
h_6: mul_16 port map(x,mul_out(6));
h_7: mul_minus3 port map(x,mul_out(7));
h_8: mul_minus32 port map(x,mul_out(8));
h_9: mul_minus24 port map(x,mul_out(9));

h_10: mul_48 port map(x,mul_out(10));
h_11: mul_144 port map(x,mul_out(11));
h_12: mul_191 port map(x,mul_out(12));

sum_op1:for i in 0 to 12 generate
     sum_u: adder port map(mul_out(i),reg_out(i),sum_out(i));
end generate sum_op1;

sum_op2:for i in 13 to WIDTH - 2 generate
    sum_u: adder port map(mul_out(24-i),reg_out(i),sum_out(i));
end generate sum_op2;

reg_op:for i in 0 to WIDTH - 3 generate
    reg_u: reg_24bit port map(sum_out(i+1),clk,rst,reg_out(i));
end generate reg_op;
reg_rightest: reg_24bit port map(mul_out(0),clk,rst,reg_out(WIDTH-2));
reg_leftest: reg_24bit port map(sum_out(0),clk,rst,finalout);

y <= finalout(23 downto 8);
end Behavioral;
