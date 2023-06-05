library ieee;
use ieee.std_logic_1164.all;
entity elevator_top_SSD is
   port(
      clk, rst: in std_logic;
      b       : in std_logic_vector(9 downto 0);
      b_up    : in std_logic_vector(9 downto 0);
      b_down  : in std_logic_vector(9 downto 0);
      op_en: out std_logic;
      up_out: out std_logic;
      down_out: out std_logic;
      floor_out_ssd : out std_logic_vector(6 downto 0)
   );
end elevator_top_SSD;


architecture top_behav of elevator_top_SSD is

   signal floor_out_sig: std_logic_vector(3 downto 0);

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

component SSD is
    port(
        SSD_in: In std_logic_vector(3 downto 0);
        SSD_out: Out std_logic_vector(6 downto 0)
    );
end component;

begin

elevator: elevator_top
    port map(
    clk  => clk,
    rst  => rst,
    b    => b,
    b_up => b_up,
    b_down => b_down,
    floor_out => floor_out_sig,
    op_en => op_en,
    up_out => up_out,
    down_out => down_out
    );

    SSD_inst: SSD port map(
    	SSD_in		=> floor_out_sig,
    	SSD_out		=> floor_out_ssd
    );
end top_behav;