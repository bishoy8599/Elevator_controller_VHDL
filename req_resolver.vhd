LIBRARY IEEE,STD;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY req_resolver is 
port (
    rst     : in std_logic;
    clk     : in std_logic;
    b       : in std_logic_vector(9 downto 0);
    curr_floor : in std_logic_vector(3 downto 0);
    b_up    : in std_logic_vector(9 downto 0);
    b_down  : in std_logic_vector(9 downto 0);
    req     : out std_logic_vector(3 downto 0);
    up      : in std_logic;
    down    : in std_logic
);
end req_resolver;

ARCHITECTURE rtl OF req_resolver IS

signal button	: std_logic_vector(9 downto 0);
signal button_x   : std_logic_vector(9 downto 0);

signal curr_floor_enc : std_logic_vector(9 downto 0);
signal arb_in: std_logic_vector(9 downto 0):= "0000000000" ;
signal arb_out: std_logic_vector(3 downto 0);
signal pri_in: unsigned(9 downto 0):= "0000000000" ;
signal pri_out: unsigned(3 downto 0);
signal pri_val: std_logic;
component arbiter is
    port (	
            R: in STD_LOGIC_VECTOR(9 downto 0);
            out_p: out STD_LOGIC_VECTOR(3 downto 0));
    end component;

component PRI_EN is
port (A: In unsigned (9 downto 0);
    Valid: out std_logic;
    pri_out: out unsigned (3 downto 0)
    );
end component;
begin

arb: arbiter port map(	
    R => arb_in,
    out_p =>  arb_out
    );
pri:PRI_EN port map(    
    A => pri_in,
    Valid => pri_val,
    pri_out =>  pri_out
    );
process(b_up,b_down,b, curr_floor_enc)
begin
     if(up = '0' and down = '0') then	
         button <= (b_up or ((b_down or b))) and not(curr_floor_enc);
    else 
        button <= button and not(curr_floor_enc);
    end if;
 --   button <= (b_up or ((b_down or b))) and not(curr_floor_enc);
end process;

process(curr_floor)
begin
    if(curr_floor = "0000")then
        curr_floor_enc <= "0000000001";
    elsif(curr_floor = "0001")then
        curr_floor_enc <= "0000000010";
    elsif(curr_floor = "0010")then
        curr_floor_enc <= "0000000100";
    elsif(curr_floor = "0011")then
        curr_floor_enc <= "0000001000";
    elsif(curr_floor = "0100")then
        curr_floor_enc <= "0000010000";
    elsif(curr_floor = "0101")then
        curr_floor_enc <= "0000100000";
    elsif(curr_floor = "0110")then
        curr_floor_enc <= "0001000000";
    elsif(curr_floor = "0111")then
        curr_floor_enc <= "0010000000";
    elsif(curr_floor = "1000")then
        curr_floor_enc <= "0100000000";
    elsif(curr_floor = "1001")then
        curr_floor_enc <= "1000000000";
    else
        curr_floor_enc <= "0000000000";
    end if;
end process;

 process(button)
begin
    if(button > curr_floor_enc) then
        arb_in <= std_logic_vector(unsigned(button) srl to_integer(unsigned(curr_floor)));
        pri_in <= (others => '0');  
    elsif (button < curr_floor_enc and button /= "0000000000") then
        pri_in <= (unsigned(button));
        arb_in <= (others => '0'); 
    end if;
end process ; 

process( arb_out , curr_floor_enc , up,down )
begin
 if(up = '0' and down = '0') then   

    if(button > curr_floor_enc)then
        req <= std_logic_vector(unsigned(arb_out) + unsigned(curr_floor));
    elsif (button < curr_floor_enc and button /= "0000000000" and pri_val = '1') then
        req <= std_logic_vector(unsigned(pri_out));
    else
        req <= curr_floor;
    end if;
 end if;   
end process ; -- 




end rtl;