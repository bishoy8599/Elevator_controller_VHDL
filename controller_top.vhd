library ieee;
use ieee.std_logic_1164.all;
entity elevator_ctrl_top is
   port(
      clk, rst: in std_logic;
      req: in std_logic_vector(3 downto 0);
      floor_out: out std_logic_vector(3 downto 0);
      op_en_out: out std_logic;
      up_out: out std_logic;
      down_out: out std_logic
   );
end elevator_ctrl_top;

architecture top_behav of elevator_ctrl_top is

   signal curr_floor: std_logic_vector(3 downto 0);
   signal new_floor: std_logic_vector(3 downto 0);
   signal new_floor_wr: std_logic;
   signal up: std_logic;
   signal op_en: std_logic;
   signal down: std_logic;
   signal time_en : std_logic_vector(1 downto 0);
   signal timer_done  : std_logic;
   
   component timer is 
    port (
    	rst		: in std_logic;
    	clk		: in std_logic;
    	time_en   : in std_logic_vector(1 downto 0);
        time_done   : out std_logic
    );
    end component;
    
    component up_down is
        port(
           curr_floor: in std_logic_vector(3 downto 0);
           up: in std_logic;
           down: in std_logic;
           timer_done: in std_logic;
 --          time_en : out std_logic_vector(1 downto 0);
           new_floor : out std_logic_vector(3 downto 0);
           new_floor_wr : out std_logic
        );
     end component;
     component elevator_ctrl is
        port(
           clk : in std_logic;
           reset: in std_logic;
           req: in std_logic_vector(3 downto 0);
           curr_floor: in std_logic_vector(3 downto 0);
           up: out std_logic;
           down: out std_logic;
           op_en: out std_logic;
           time_en : out std_logic_vector(1 downto 0);
           timer_done   : in std_logic
        );
     end component;
     component curr_floor_reg is
        port ( 
            curr_floor :out  std_logic_vector(3 downto 0) ;
            wr: in std_logic;
            reset: in std_logic;
            clk: in std_logic;
            new_floor: in std_logic_vector(3 downto 0)
             );
        end component;
begin

    my_timer: timer 
    port map(
        rst	=> rst,
	    clk	=> clk,
	    time_en	=> time_en,
        time_done => timer_done
    );

    up_down_logic: up_down port map(
        curr_floor => curr_floor,
        up => up,
        down => down,
        timer_done => timer_done,
--        time_en => time_en,
        new_floor => new_floor,
        new_floor_wr => new_floor_wr
    );

    elevator_ctrl_module: elevator_ctrl port map(
       clk => clk,
       reset => rst,
       req => req,
       curr_floor => curr_floor,
       up => up,
       down => down,
       op_en => op_en,
       time_en => time_en,
       timer_done   => timer_done
    );

    reg: curr_floor_reg port map( 
        curr_floor => curr_floor,
        wr => new_floor_wr,
        reset => rst,
        clk => clk,
        new_floor => new_floor
    );

    up_out <= up;
    down_out <= down;
    op_en_out <= op_en;
    floor_out <= curr_floor;
end top_behav;