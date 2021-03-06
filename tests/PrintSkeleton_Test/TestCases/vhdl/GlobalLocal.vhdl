library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all; 
use work.top_level_types.all;
use work.GlobalLocal_types.all;

entity GlobalLocal is
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
end GlobalLocal;

architecture GlobalLocal_arch of GlobalLocal is
	signal ge_signal: global_enum;
	signal gec_signal: global_enum_class;
	signal le_signal: local_enum;
	signal lec_signal: local_enum_class;
	signal local_array_signal: int_5;

begin
	process(clk)
	begin
	if(clk='1' and clk'event) then
		if rst = '1' then
			ge_signal <= A;
			gec_signal <= M;
			le_signal <= X;
			lec_signal <= D;
			local_array_signal <= (others => to_signed(0, 32));
			b_in_notify <= true;
			b_out_notify <= false;
		else
			 -- FILL OUT HERE;
		end if;
	end if;
	end process;
end GlobalLocal_arch;