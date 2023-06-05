LIBRARY IEEE,STD;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY timer is 
port (
	rst		: in std_logic;
	clk		: in std_logic;
	time_en   : in std_logic_vector(1 downto 0);
    time_done   : out std_logic
);
end timer;

ARCHITECTURE rtl OF timer IS

signal count_reg	: integer;

begin	


process(clk, rst)
begin
	if (rst = '1') then
		count_reg <= 0;
	elsif rising_edge(clk) then
		if(time_en(1) = '1' and not((count_reg = 100 and time_en(0) = '0') or (count_reg = 50 and time_en(0) = '1') )) then
			count_reg <= count_reg + 1;
        else
            count_reg <= 0;
		end if;
	end if;
end process;

time_done <= '1' when (count_reg = 100 and (time_en(0) = '0')) or ((count_reg = 50) and (time_en(0) = '1')) else
             '0';
end rtl;