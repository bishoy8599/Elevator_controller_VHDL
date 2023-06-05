library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elevator_tb is   
end  elevator_tb;

architecture behav of elevator_tb is
--module declaration 
component elevator_top is
   port(
      clk, rst: in std_logic;
      b       : in std_logic_vector(9 downto 0);
      b_up    : in std_logic_vector(9 downto 0);
      b_down  : in std_logic_vector(9 downto 0);
      floor_out : out std_logic_vector(3 downto 0);
      op_en: out std_logic;
      up_out: out std_logic;
      down_out: out std_logic
   );
end component;
	
	

--internal signals
 
signal clk: std_logic := '0';
signal rst: std_logic;
signal flor:  std_logic_vector(3 downto 0);
signal up, down, op_door: std_logic; 
signal but,up_but, down_but: std_logic_vector(9 downto 0);

--clock period
constant PERIOD: time := 20 ns;


begin
--unit under test instance

UUT: elevator_top
    port map(
    clk	=> clk,
    rst	=> rst,
    b    => but,
    b_up => up_but,
    b_down => down_but,
    floor_out => flor,
    op_en => op_door,
    up_out => up,
    down_out => down
    );
	
--clock
 clk <= not clk after PERIOD/2;

-- stimulus process
 process begin
   up_but <= (others => '0'); 
   down_but <= (others => '0');
   but <=  (others => '0');
	rst     <= '1';
    -- deassert reset
	wait for (3*PERIOD);
    rst    <= '0';	
    -- load value 
   wait for (2*PERIOD);
	but     <= "0000001000";
   -- load value 
   wait until op_door = '1';
   wait for (2*PERIOD);
    but <= "1001100000" ; 
    wait until op_door = '1';
      wait for (2*PERIOD);
    but <= "0001101100" ; 
    wait until op_door = '0';

    
    wait;
end process;

--monitor process
--process (ld, done)
--	variable m_tmp: std_logic_vector(9 downto 0);
--	variable n_tmp: std_logic_vector(9 downto 0);
--	variable error_status: boolean:= true;	
--begin
--	if (ld = '1') then 
--		m_tmp := m;
--		n_tmp := n;
--	end if;
--	if (done = '1' and m_tmp = std_logic_vector(to_unsigned(34, 10))) then 
--		if (q =  std_logic_vector(to_unsigned(2, 10))) then 
--			error_status := true;
--		else
--			error_status := false;
--		end if;
--	end if;
--	if (done = '1' and m_tmp = std_logic_vector(to_unsigned(25, 10))) then 
--		if (q =  std_logic_vector(to_unsigned(5, 10))) then 
--			error_status := true;
--		else
--			error_status := false;
--		end if;
--	end if;	
--	assert error_status
--		report ("Test Failed")
--		severity ERROR;		
--end process;
end behav;             
                                       