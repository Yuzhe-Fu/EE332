library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;

entity for_z2top is
    generic (WIDTH: natural:=5);
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (7 downto 0));
end for_z2top;

architecture Behavioral of for_z2top is
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
type reg_array IS array (WIDTH-2 downto 0) of std_logic_vector (15 downto 0);
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
        h_value(0)<=x"01";
        h_value(1)<=x"ff";
        h_value(2)<=x"01";
        h_value(3)<=x"ff";
        h_value(4)<=x"01";
        end if;
end process;

h_op:for i in 0 to WIDTH - 1 generate
    h_u: h port map(x,h_value(i),mul_out(i));
end generate h_op;

sum_op:for i in 0 to WIDTH - 2 generate
    sum_u: adder port map(mul_out(i),reg_out(i),sum_out(i));
end generate sum_op;

reg_op:for i in 0 to WIDTH - 3 generate
    reg_u: reg_16bit port map(sum_out(i+1),clk,rst,reg_out(i));
end generate reg_op;
reg_rightest: reg_16bit port map(mul_out(WIDTH-1),clk,rst,reg_out(WIDTH-2));
reg_leftest: reg_16bit port map(sum_out(0),clk,rst,finalout);

y <= finalout(7 downto 0);
end Behavioral;
