library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.std_logic_arith.all;

entity for_z1top is
    generic (WIDTH: natural:=57);-- the number of h
    Port ( x : in STD_LOGIC_VECTOR (11 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (15 downto 0));
end for_z1top;

architecture Behavioral of for_z1top is
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
type sum_array IS array (WIDTH-2 downto 0) of std_logic_vector (23 downto 0);
signal sum_out : sum_array;
type h_array IS array (WIDTH-1 downto 0) of std_logic_vector (11 downto 0);
signal h_value : h_array;
type mul_array IS array (WIDTH-1 downto 0) of std_logic_vector (23 downto 0);
signal mul_out : mul_array;
signal finalout: STD_LOGIC_VECTOR (23 downto 0);

begin
process(clk, rst) begin 
        if(rst = '1')then 
        --set up h value here     
       --1~5
                h_value(0)<=conv_std_logic_vector(0,12);
                h_value(1)<=conv_std_logic_vector(0,12);
                h_value(2)<=conv_std_logic_vector(0,12);
                h_value(3)<=conv_std_logic_vector(0,12);
                h_value(4)<=conv_std_logic_vector(0,12);
                --6-10
                h_value(5)<=conv_std_logic_vector(-1,12);
                h_value(6)<=conv_std_logic_vector(-1,12);
                h_value(7)<=conv_std_logic_vector(-2,12);
                h_value(8)<=conv_std_logic_vector(-3,12);
                h_value(9)<=conv_std_logic_vector(-3,12);
                --11~15
                h_value(10)<=conv_std_logic_vector(-4,12);
                h_value(11)<=conv_std_logic_vector(-4,12);
                h_value(12)<=conv_std_logic_vector(-5,12);
                h_value(13)<=conv_std_logic_vector(-4,12);
                h_value(14)<=conv_std_logic_vector(-4,12);
                --16-20
                h_value(15)<=conv_std_logic_vector(-2,12);
                h_value(16)<=conv_std_logic_vector(0,12);
                h_value(17)<=conv_std_logic_vector(3,12);
                h_value(18)<=conv_std_logic_vector(6,12);
                h_value(19)<=conv_std_logic_vector(10,12);
                --21~25
                h_value(20)<=conv_std_logic_vector(15,12);
                h_value(21)<=conv_std_logic_vector(20,12);
                h_value(22)<=conv_std_logic_vector(25,12);
                h_value(23)<=conv_std_logic_vector(30,12);
                h_value(24)<=conv_std_logic_vector(34,12);
                --26-30
                h_value(25)<=conv_std_logic_vector(38,12);
                h_value(26)<=conv_std_logic_vector(41,12);
                h_value(27)<=conv_std_logic_vector(42,12);
                h_value(28)<=conv_std_logic_vector(43,12);
                h_value(29)<=conv_std_logic_vector(42,12);     
                --31~35
                h_value(30)<=conv_std_logic_vector(41,12);
                h_value(31)<=conv_std_logic_vector(38,12);
                h_value(32)<=conv_std_logic_vector(34,12);
                h_value(33)<=conv_std_logic_vector(30,12);
                h_value(34)<=conv_std_logic_vector(25,12);
                --36-40
                h_value(35)<=conv_std_logic_vector(20,12);
                h_value(36)<=conv_std_logic_vector(15,12);
                h_value(37)<=conv_std_logic_vector(10,12);
                h_value(38)<=conv_std_logic_vector(6,12);
                h_value(39)<=conv_std_logic_vector(3,12);        
                --41~45
                h_value(40)<=conv_std_logic_vector(0,12);
                h_value(41)<=conv_std_logic_vector(-2,12);
                h_value(42)<=conv_std_logic_vector(-4,12);
                h_value(43)<=conv_std_logic_vector(-4,12);
                h_value(44)<=conv_std_logic_vector(-5,12);
                --46-50
                h_value(45)<=conv_std_logic_vector(-4,12);
                h_value(46)<=conv_std_logic_vector(-4,12);
                h_value(47)<=conv_std_logic_vector(-3,12);
                h_value(48)<=conv_std_logic_vector(-3,12);
                h_value(49)<=conv_std_logic_vector(-2,12);       
                --51~55
                h_value(50)<=conv_std_logic_vector(-1,12);
                h_value(51)<=conv_std_logic_vector(-1,12);
                h_value(52)<=conv_std_logic_vector(0,12);
                h_value(53)<=conv_std_logic_vector(0,12);
                h_value(54)<=conv_std_logic_vector(0,12);
                --56-57
                h_value(55)<=conv_std_logic_vector(0,12);
                h_value(56)<=conv_std_logic_vector(0,12);
        end if;
end process;

h_first: h port map(x,h_value(0),mul_out(0));
h_op:for i in 1 to WIDTH - 1 generate
    h_u: h port map(reg_out(i-1),h_value(i),mul_out(i));
end generate h_op;

sum_first: adder port map(mul_out(0),mul_out(1),sum_out(0));
sum_op:for i in 1 to WIDTH - 2 generate
    sum_u: adder port map(sum_out(i-1),mul_out(i+1),sum_out(i));
end generate sum_op;

reg_first: reg_12bit port map(x,clk,rst,reg_out(0));
reg_op:for i in 1 to WIDTH - 2 generate
    reg_u: reg_12bit port map(reg_out(i-1),clk,rst,reg_out(i));
end generate reg_op;

reg_rightest: reg_24bit port map(sum_out(WIDTH-2),clk,rst,finalout);

y <= finalout(23 downto 8);
end Behavioral;
