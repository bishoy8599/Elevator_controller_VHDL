library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SSD is
    port(
        SSD_in: In std_logic_vector(3 downto 0);
        SSD_out: Out std_logic_vector(6 downto 0)
    );
end entity;

architecture SSD_arch of SSD is
begin
    with SSD_in select
        SSD_out <= "1111001" when "0001",
                   "0100100" when "0010",
                   "0110000" when "0011",
                   "0011001" when "0100",
                   "0010010" when "0101",
                   "0000010" when "0110",
                   "1111000" when "0111",
                   "0000000" when "1000",
                   "0011000" when "1001",
                   "1000000" when others;
end SSD_arch; 
