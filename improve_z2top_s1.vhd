library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.std_logic_arith.all;

entity improve_z2top_s1 is
    generic (WIDTH: natural:=25);-- the number of h
    Port ( x : in STD_LOGIC_VECTOR (11 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (15 downto 0));
end improve_z2top_s1;

architecture Behavioral of improve_z2top_s1 is
component h is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           b : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end component;
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

type reg_array IS array (WIDTH-2 downto 0) of std_logic_vector (23 downto 0);
signal reg_out : reg_array;
type sum_array IS array (WIDTH-2 downto 0) of std_logic_vector (23 downto 0);
signal sum_out : sum_array;
type h_array IS array (12 downto 0) of std_logic_vector (11 downto 0);
signal h_value : h_array;
type mul_array IS array (12 downto 0) of std_logic_vector (23 downto 0);
signal mul_out : mul_array;
signal finalout: STD_LOGIC_VECTOR (23 downto 0);

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

h_op:for i in 0 to 12 generate
    h_u: h port map(x,h_value(i),mul_out(i));
end generate h_op;

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
reg_seconde_leftest: reg_24bit port map(sum_out(0),clk,rst,finalout);
--reg_leftest: reg_24bit port map(secoundout,clk,rst,finalout);
y <= finalout(23 downto 8);
end Behavioral;
