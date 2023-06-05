library ieee;
use ieee.std_logic_1164.all;
entity elevator_top is
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
end elevator_top;

architecture top_behav of elevator_top is

   signal req: std_logic_vector(3 downto 0);
   signal curr_floor : std_logic_vector(3 downto 0);
   signal up , down: std_logic;
   component elevator_ctrl_top is
    port(
       clk: in std_logic;
       rst: in std_logic;
       req: in std_logic_vector(3 downto 0);
       op_en_out: out std_logic;
       up_out: out std_logic;
       down_out: out std_logic;
       floor_out: out std_logic_vector(3 downto 0)
    );
    end component;

    component req_resolver is 
    port (
    	rst		: in std_logic;
    	clk		: in std_logic;
    	b       : in std_logic_vector(9 downto 0);
        curr_floor : in std_logic_vector(3 downto 0);
        b_up    : in std_logic_vector(9 downto 0);
        b_down  : in std_logic_vector(9 downto 0);
        req     : out std_logic_vector(3 downto 0);
        up      : in std_logic;
        down    : in std_logic

    );
    end component;
begin

    elev_ctrl_unit: elevator_ctrl_top port map(
           clk => clk,
           rst => rst,
           req => req,
           op_en_out => op_en,
           up_out => up,
           down_out => down,
           floor_out => curr_floor
        );

    req_gen: req_resolver port map(
    	rst		=> rst,
    	clk		=> clk,
    	b       => b,
        curr_floor => curr_floor,
        b_up    => b_up,
        b_down  => b_down,
        req     => req,
        up => up,
        down => down
    );
    up_out <= up;
    down_out <= down;
    floor_out <= curr_floor;
end top_behav;