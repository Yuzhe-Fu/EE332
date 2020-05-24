----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/05/15 16:39:43
-- Design Name: 
-- Module Name: mul_191 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mul_191 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end mul_191;

architecture Behavioral of mul_191 is
signal a_full:STD_LOGIC_VECTOR(23 downto 0);
begin
a_full(23 downto 18) <= (others=>a(11));
a_full(17 downto 0) <= a&"000000";
output <= to_stdlogicvector(to_bitvector(a_full) sll 1)+a_full-to_stdlogicvector(to_bitvector(a_full) sra 6);

end Behavioral;
