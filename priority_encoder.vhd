library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity PRI_EN is
port (A: In unsigned (9 downto 0);
    Valid: out std_logic;
    pri_out: out unsigned (3 downto 0)
    );
end PRI_EN;

architecture behav of PRI_EN is

begin
process (A)
begin

Valid <= '1';

If (A(9) = '1') then pri_out <= "1001";
elsif (A(8) = '1') then pri_out <= "1000";
elsif (A(7) = '1') then pri_out <= "0111";    
elsif (A(6) = '1') then pri_out <= "0110";
elsif (A(5) = '1') then pri_out <= "0101";
elsif (A(4) = '1') then pri_out <= "0100";
elsif (A(3) = '1') then pri_out <= "0011";
elsif (A(2) = '1') then pri_out <= "0010";
elsif (A(1) = '1') then pri_out <= "0001";
elsif (A(0) = '1') then pri_out <= "0000";
else
Valid <= '0';
pri_out <= "XXXX";

end if ;
end process ;
end behav;