library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.std_logic_arith.all;

entity improve_z1top_S1 is
    generic (WIDTH: natural:=25);-- the number of h
    Port ( x : in STD_LOGIC_VECTOR (11 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (15 downto 0));
end improve_z1top_S1;

architecture Behavioral of improve_z1top_S1 is
component h is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           b : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;

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
type reg_array IS array (WIDTH-2 downto 0) of std_logic_vector (11 downto 0);
signal reg_out : reg_array;
type sum_12bit_array IS array (12 downto 0) of std_logic_vector (11 downto 0);
signal sum_12bit_out : sum_12bit_array;
type h_array IS array (12 downto 0) of std_logic_vector (11 downto 0);
signal h_value : h_array;
type mul_array IS array (12 downto 0) of std_logic_vector (23 downto 0);
signal mul_out : mul_array;
signal outtemp,finalout: STD_LOGIC_VECTOR (23 downto 0);

begin
process(clk, rst) begin 
        if(rst = '1')then 
        --set up h value here     
        --1~5
        h_value(0)<=conv_std_logic_vector(2,12);
        h_value(1)<=conv_std_logic_vector(3,12);
        h_value(2)<=conv_std_logic_vector(-2,12);
        h_value(3)<=conv_std_logic_vector(-8,12);
        h_value(4)<=conv_std_logic_vector(-4,12);
        --6-10
        h_value(5)<=conv_std_logic_vector(10,12);
        h_value(6)<=conv_std_logic_vector(16,12);
        h_value(7)<=conv_std_logic_vector(-3,12);
        h_value(8)<=conv_std_logic_vector(-32,12);
        h_value(9)<=conv_std_logic_vector(-24,12);
        --11~15
        h_value(10)<=conv_std_logic_vector(48,12);
        h_value(11)<=conv_std_logic_vector(144,12);
        h_value(12)<=conv_std_logic_vector(191,12);
        end if;
end process;
sum_first: adder_12bit port map(x,reg_out(23),sum_12bit_out(0));
sum_op:for i in 1 to 11 generate
    sum_u: adder_12bit port map(reg_out(i-1),reg_out(23-i),sum_12bit_out(i));
end generate sum_op;

h_op:for i in 0 to 11 generate
    h_u: h port map(sum_12bit_out(i),h_value(i),mul_out(i));
end generate h_op;
h_right: h port map(reg_out(11),h_value(12),mul_out(12));

reg_first: reg_12bit port map(x,clk,rst,reg_out(0));
reg_op:for i in 1 to WIDTH - 2 generate
    reg_u: reg_12bit port map(reg_out(i-1),clk,rst,reg_out(i));
end generate reg_op;
outtemp<=mul_out(0)+mul_out(1)+mul_out(2)+mul_out(3)+mul_out(4)+mul_out(5)+mul_out(6)+mul_out(7)+mul_out(8)+mul_out(9)+mul_out(10)+mul_out(11)+mul_out(12);
reg_rightest: reg_24bit port map(outtemp,clk,rst,finalout);

y <= finalout(23 downto 8);
end Behavioral;
