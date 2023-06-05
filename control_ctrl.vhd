--=============================
-- Listing 10.7 edge detector (Moore)
--=============================
library ieee;
use ieee.std_logic_1164.all;
entity elevator_ctrl is
   port(
      clk, reset: in std_logic;
      req: in std_logic_vector(3 downto 0);
      curr_floor: in std_logic_vector(3 downto 0);
      up: out std_logic;
      down: out std_logic;
      op_en: out std_logic;
      time_en : out std_logic_vector(1 downto 0);
      timer_done   : in std_logic
   );
end elevator_ctrl;

architecture moore_arch of elevator_ctrl is
   type state_type is (go_up, go_down, idle, door_open);
   signal state_reg, state_next: state_type;
   
   
   --component timer is 
   -- port (
   -- 	rst		: in std_logic;
   -- 	clk		: in std_logic;
   -- 	time_en   : in std_logic_vector(1 downto 0);
   --     time_done   : out std_logic
   -- );
   -- end component;
begin

    --my_timer: timer 
    --port map(
    --rst	=> rst,
	--clk	=> clk,
	--time_en	=> time_en,
    --time_done => timer_done
    --);

   -- state register
   process(clk,reset)
   begin
      if (reset='1') then
         state_reg <= idle;
      elsif (clk'event and clk='1') then
         state_reg <= state_next;
      end if;
   end process;
   -- next-state logic
   ctrl_fsm: process(state_reg,req,timer_done,curr_floor)
   begin
      case state_reg is
         when idle=>
            if req = curr_floor then
               state_next <= idle;
            elsif(req < curr_floor)then
               state_next <= go_down;
            else
                state_next <= go_up;
            end if;
         when go_up =>
            if req > curr_floor then
               state_next <= go_up;
            else
               state_next <= door_open;
            end if;
         when door_open =>
            if timer_done = '0' then
               state_next <= door_open;
            else
               state_next <= idle;
            end if;
         when go_down =>
            if req < curr_floor then
               state_next <= go_down;
            else
               state_next <= door_open;
            end if;
      end case;
   end process ctrl_fsm;

   -- Moore output logic
   up <= '1' when state_reg=go_up else
         '0';
   down <= '1' when state_reg=go_down else
         '0';
   op_en <= '1' when state_reg=door_open or state_reg=idle else
         '0';
   time_en <= "10" when state_reg=door_open else
        "11" when state_reg=go_up or state_reg=go_down else
        "00";
end moore_arch;