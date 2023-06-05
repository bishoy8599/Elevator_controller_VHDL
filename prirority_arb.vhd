library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;


entity arbiter is
port(	
		R: in STD_LOGIC_VECTOR(9 downto 0);
		out_p: out STD_LOGIC_VECTOR(3 downto 0));
		
end arbiter;

architecture grant of arbiter is
begin

 	out_p <= "1001" when R(9) = '1' and R(8) = '0' and R(7) = '0' and R(6) = '0' and R(5) = '0' and R(4) = '0' and R(3) = '0' and R(2) = '0' and R(1) = '0' and R(0) = '0' else
		   "1000" when R(8) = '1' and R(7) = '0' and R(6) = '0' and R(5) = '0' and R(4) = '0' and R(3) = '0' and R(2) = '0' and R(1) = '0' and R(0) = '0' else
		   "0111" when R(7) = '1' and R(6) = '0' and R(5) = '0' and R(4) = '0' and R(3) = '0' and R(2) = '0' and R(1) = '0' and R(0) = '0' else
           "0110" when R(6) = '1' and R(5) = '0' and R(4) = '0' and R(3) = '0' and R(2) = '0' and R(1) = '0' and R(0) = '0' else
           "0101" when R(5) = '1' and R(4) = '0' and R(3) = '0' and R(2) = '0' and R(1) = '0' and R(0) = '0' else
           "0100" when R(4) = '1' and R(3) = '0' and R(2) = '0' and R(1) = '0' and R(0) = '0' else
           "0011" when R(3) = '1' and R(2) = '0' and R(1) = '0' and R(0) = '0' else
           "0010" when R(2) = '1' and R(1) = '0' and R(0) = '0' else
           "0001" when R(1) = '1' and R(0) = '0' else
           "0000" when R(0) = '1' else
           "0000";
end grant;