library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elevator_ctrl_tb is   
end  elevator_ctrl_tb;

architecture behav of elevator_ctrl_tb is
--module declaration 
component elevator_ctrl_top is
   port(
      clk, rst: in std_logic;
      req: in std_logic_vector(3 downto 0);
      floor_out: out std_logic_vector(3 downto 0);
      op_en_out: out std_logic;
      up_out: out std_logic;
      down_out: out std_logic
   );
end component;
	
	

--internal signals
 
signal clk: std_logic := '0';
signal rst: std_logic;
signal flor,req: std_logic_vector(3 downto 0);
signal up, down, op_door: std_logic; 

--clock period
constant PERIOD: time := 20 ns;


begin
--unit under test instance

UUT: elevator_ctrl_top
    port map(
    clk	=> clk,
    rst	=> rst,
    req	=> req,
    floor_out   => flor,
    op_en_out => op_door,
    up_out     => up,
    down_out   => down   
    );
	
--clock
 clk <= not clk after PERIOD/2;

-- stimulus process
 process begin
	rst     <= '1';
    -- deassert reset
	wait for (3*PERIOD);
    rst    <= '0';	
    -- load value 
   wait for (2*PERIOD);

   -- load value 
   wait until op_door = '1';
   wait for (2*PERIOD);
 
    wait until op_door = '1';
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
                                       