library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;

entity for_z1top is
    generic (WIDTH: natural:=10);-- the number of h
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (7 downto 0));
end for_z1top;

architecture Behavioral of for_z1top is
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
type reg_array IS array (WIDTH-2 downto 0) of std_logic_vector (7 downto 0);
signal reg_out : reg_array;
type sum_array IS array (WIDTH-2 downto 0) of std_logic_vector (15 downto 0);
signal sum_out : sum_array;
type h_array IS array (WIDTH-1 downto 0) of std_logic_vector (7 downto 0);
signal h_value : h_array;
type mul_array IS array (WIDTH-1 downto 0) of std_logic_vector (15 downto 0);
signal mul_out : mul_array;
signal finalout: STD_LOGIC_VECTOR (15 downto 0);

begin
process(clk, rst) begin 
        if(rst = '1')then 
        --set up h value here     
        h_value(0)<=x"01";
        h_value(1)<=x"ff";
        h_value(2)<=x"01";
        h_value(3)<=x"ff";
        h_value(4)<=x"01";
        h_value(5)<=x"ff";
        h_value(6)<=x"01";
        h_value(7)<=x"ff";
        h_value(8)<=x"01";
        h_value(9)<=x"ff";
--        h_value(10)<=x"01";
--        h_value(11)<=x"ff";
--        h_value(12)<=x"01";
--        h_value(13)<=x"ff";
--        h_value(14)<=x"01";
--        h_value(15)<=x"ff";
--        h_value(16)<=x"01";
--        h_value(17)<=x"ff";
--        h_value(18)<=x"01";
--        h_value(19)<=x"ff";
--        h_value(20)<=x"01";
--        h_value(21)<=x"ff";
--        h_value(22)<=x"01";
--        h_value(23)<=x"ff";
--        h_value(24)<=x"01";
--        h_value(25)<=x"ff";
--        h_value(26)<=x"01";
--        h_value(27)<=x"ff";
--        h_value(28)<=x"01";
--        h_value(29)<=x"ff";
--        h_value(30)<=x"01";
--        h_value(31)<=x"ff";
--        h_value(32)<=x"01";
--        h_value(33)<=x"ff";
--        h_value(34)<=x"01";
--        h_value(35)<=x"ff";
--        h_value(36)<=x"01";
--        h_value(37)<=x"ff";
--        h_value(38)<=x"01";
--        h_value(39)<=x"ff";
--        h_value(40)<=x"01";
--        h_value(41)<=x"ff";
--        h_value(42)<=x"01";
--        h_value(43)<=x"ff";
--        h_value(44)<=x"01";
--        h_value(45)<=x"ff";
--        h_value(46)<=x"01";
--        h_value(47)<=x"ff";
--        h_value(48)<=x"01";
--        h_value(49)<=x"ff";
--        h_value(50)<=x"01";
--        h_value(51)<=x"ff";
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

reg_first: reg_8bit port map(x,clk,rst,reg_out(0));
reg_op:for i in 1 to WIDTH - 2 generate
    reg_u: reg_8bit port map(reg_out(i-1),clk,rst,reg_out(i));
end generate reg_op;

reg_rightest: reg_16bit port map(sum_out(WIDTH-2),clk,rst,finalout);

y <= finalout(7 downto 0);
end Behavioral;
