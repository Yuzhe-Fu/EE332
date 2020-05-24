----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/05/15 15:25:37
-- Design Name: 
-- Module Name: mul_minus24 - Behavioral
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

entity mul_minus24 is
    Port ( a : in STD_LOGIC_VECTOR (11 downto 0);
           output : out STD_LOGIC_VECTOR (23 downto 0));
end mul_minus24;

architecture Behavioral of mul_minus24 is
signal a_full:STD_LOGIC_VECTOR(23 downto 0);
begin
a_full(23 downto 15) <= (others=>a(11));
a_full(14 downto 0) <= a&"000";
output <= NOT(to_stdlogicvector(to_bitvector(a_full) sll 1)+a_full)+1;

end Behavioral;
