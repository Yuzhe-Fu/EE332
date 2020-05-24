library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.std_logic_arith.all;

entity improve2_z1top_S1 is
    generic (WIDTH: natural:=25);-- the number of h
    Port ( x : in STD_LOGIC_VECTOR (11 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (15 downto 0));
end improve2_z1top_S1;

architecture Behavioral of improve2_z1top_S1 is

component adder_12bit is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           b : in STD_LOGIC_VECTOR (11 downto 0);
           s : out STD_LOGIC_VECTOR (11 downto 0));
end component;
component reg_12bit is
    Port ( input : in STD_LOGIC_VECTOR (11 downto 0);
           clk : in std_logic;
           rst : in std_logic;
           output : out STD_LOGIC_VECTOR (11 downto 0));
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

type reg_array IS array (WIDTH-2 downto 0) of std_logic_vector (11 downto 0);
signal reg_out : reg_array;
type sum_12bit_array IS array (12 downto 0) of std_logic_vector (11 downto 0);
signal sum_12bit_out : sum_12bit_array;
--type h_array IS array (12 downto 0) of std_logic_vector (11 downto 0);
--signal h_value : h_array;
type mul_array IS array (12 downto 0) of std_logic_vector (23 downto 0);
signal mul_out : mul_array;
signal outtemp,finalout: STD_LOGIC_VECTOR (23 downto 0);

begin
sum_first: adder_12bit port map(x,reg_out(23),sum_12bit_out(0));
sum_op:for i in 1 to 11 generate
    sum_u: adder_12bit port map(reg_out(i-1),reg_out(23-i),sum_12bit_out(i));
end generate sum_op;

h_0: mul_2 port map(sum_12bit_out(0),mul_out(0));
h_1: mul_3 port map(sum_12bit_out(1),mul_out(1));
h_2: mul_minus2 port map(sum_12bit_out(2),mul_out(2));
h_3: mul_minus8 port map(sum_12bit_out(3),mul_out(3));
h_4: mul_minus8 port map(sum_12bit_out(4),mul_out(4));

h_5: mul_10 port map(sum_12bit_out(5),mul_out(5));
h_6: mul_16 port map(sum_12bit_out(6),mul_out(6));
h_7: mul_minus3 port map(sum_12bit_out(7),mul_out(7));
h_8: mul_minus32 port map(sum_12bit_out(8),mul_out(8));
h_9: mul_minus24 port map(sum_12bit_out(9),mul_out(9));

h_10: mul_48 port map(sum_12bit_out(10),mul_out(10));
h_11: mul_144 port map(sum_12bit_out(11),mul_out(11));
h_12: mul_191 port map(reg_out(11),mul_out(12));

reg_first: reg_12bit port map(x,clk,rst,reg_out(0));
reg_op:for i in 1 to WIDTH - 2 generate
    reg_u: reg_12bit port map(reg_out(i-1),clk,rst,reg_out(i));
end generate reg_op;
outtemp<=mul_out(0)+mul_out(1)+mul_out(2)+mul_out(3)+mul_out(4)+mul_out(5)+mul_out(6)+mul_out(7)+mul_out(8)+mul_out(9)+mul_out(10)+mul_out(11)+mul_out(12);
reg_rightest: reg_24bit port map(outtemp,clk,rst,finalout);

y <= finalout(23 downto 8);
end Behavioral;
