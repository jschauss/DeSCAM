library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all; 
use work.top_level_types.all;
use work.TestBasic5_types.all;

entity TestBasic5 is
port(	
	clk:		in std_logic;
	rst:		in std_logic;
	b_in:		in int;
	b_in_sync:		in bool;
	b_in_notify:		out bool;
	b_out:		out int;
	b_out_sync:		in bool;
	b_out_notify:		out bool
);
end TestBasic5;

architecture TestBasic5_arch of TestBasic5 is

begin
	process(clk)
	begin
	if(clk='1' and clk'event) then
		if rst = '1' then
			b_in_notify <= true;
			b_out_notify <= false;
		else
			 -- FILL OUT HERE;
		end if;
	end if;
	end process;
end TestBasic5_arch;