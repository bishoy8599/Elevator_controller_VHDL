library IEEE;
use IEEE.std_logic_1164.all;

entity curr_floor_reg is
port ( 
    curr_floor :out  std_logic_vector(3 downto 0) ;
    wr: in std_logic;
    reset: in std_logic;
    clk: in std_logic;
    new_floor: in std_logic_vector(3 downto 0)
     );
end curr_floor_reg;
architecture behav of curr_floor_reg is
    begin
        process(clk) is
            begin
                if rising_edge(clk) then
                    if(wr='1') then 
                        curr_floor<=new_floor;
                    elsif(reset='1') then
                        curr_floor<=(others => '0');
                    end if;
                end if;
                end process;
end behav;