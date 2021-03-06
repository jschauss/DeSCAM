library ieee ;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all; 
use work.SCAM_Model_types.all;

entity Regs is
port(	
	clk:		in std_logic;
	rst:		in std_logic;
	ecall_reg_Port:		in RegfileWriteType;
	ecall_reg_Port_sync:	 in bool;
	ecall_reg_Port_notify:	 out bool;
	fromRegsPort:		out RegfileType;
	fromRegsPort_sync:	 in bool;
	fromRegsPort_notify:	 out bool;
	reg_ecall_Port:		out RegfileECallType;
	reg_ecall_Port_sync:	 in bool;
	reg_ecall_Port_notify:	 out bool;
	toRegsPort:		in RegfileWriteType;
	toRegsPort_sync:	 in bool;
	toRegsPort_notify:	 out bool);
end Regs;

architecture Regs_arch of Regs is
signal section: Regs_SECTIONS;
			 signal rec_signal:bool;
			 signal reg_file_01_signal:unsigned(31 down to 0);
			 signal reg_file_02_signal:unsigned(31 down to 0);
			 signal reg_file_03_signal:unsigned(31 down to 0);
			 signal reg_file_04_signal:unsigned(31 down to 0);
			 signal reg_file_05_signal:unsigned(31 down to 0);
			 signal reg_file_06_signal:unsigned(31 down to 0);
			 signal reg_file_07_signal:unsigned(31 down to 0);
			 signal reg_file_08_signal:unsigned(31 down to 0);
			 signal reg_file_09_signal:unsigned(31 down to 0);
			 signal reg_file_10_signal:unsigned(31 down to 0);
			 signal reg_file_11_signal:unsigned(31 down to 0);
			 signal reg_file_12_signal:unsigned(31 down to 0);
			 signal reg_file_13_signal:unsigned(31 down to 0);
			 signal reg_file_14_signal:unsigned(31 down to 0);
			 signal reg_file_15_signal:unsigned(31 down to 0);
			 signal reg_file_16_signal:unsigned(31 down to 0);
			 signal reg_file_17_signal:unsigned(31 down to 0);
			 signal reg_file_18_signal:unsigned(31 down to 0);
			 signal reg_file_19_signal:unsigned(31 down to 0);
			 signal reg_file_20_signal:unsigned(31 down to 0);
			 signal reg_file_21_signal:unsigned(31 down to 0);
			 signal reg_file_22_signal:unsigned(31 down to 0);
			 signal reg_file_23_signal:unsigned(31 down to 0);
			 signal reg_file_24_signal:unsigned(31 down to 0);
			 signal reg_file_25_signal:unsigned(31 down to 0);
			 signal reg_file_26_signal:unsigned(31 down to 0);
			 signal reg_file_27_signal:unsigned(31 down to 0);
			 signal reg_file_28_signal:unsigned(31 down to 0);
			 signal reg_file_29_signal:unsigned(31 down to 0);
			 signal reg_file_30_signal:unsigned(31 down to 0);
			 signal reg_file_31_signal:unsigned(31 down to 0);
			 signal regfile_signal:RegfileType;
			 signal regfileECall_signal:RegfileECallType;
			 signal regfileECallWrite_signal:RegfileWriteType;
			 signal regfileWrite_signal:RegfileWriteType;
begin
	 process(clk)
	 begin
	 if(clk='1' and clk'event) then
		 if rst = '1' then
			 section <=run;
			rec_signal<=false;
			reg_file_01_signal:= (others => 0);
			reg_file_02_signal:= (others => 0);
			reg_file_03_signal:= (others => 0);
			reg_file_04_signal:= (others => 0);
			reg_file_05_signal:= (others => 0);
			reg_file_06_signal:= (others => 0);
			reg_file_07_signal:= (others => 0);
			reg_file_08_signal:= (others => 0);
			reg_file_09_signal:= (others => 0);
			reg_file_10_signal:= (others => 0);
			reg_file_11_signal:= (others => 4096);
			reg_file_12_signal:= (others => 0);
			reg_file_13_signal:= (others => 0);
			reg_file_14_signal:= (others => 0);
			reg_file_15_signal:= (others => 0);
			reg_file_16_signal:= (others => 0);
			reg_file_17_signal:= (others => 0);
			reg_file_18_signal:= (others => 0);
			reg_file_19_signal:= (others => 0);
			reg_file_20_signal:= (others => 0);
			reg_file_21_signal:= (others => 0);
			reg_file_22_signal:= (others => 0);
			reg_file_23_signal:= (others => 0);
			reg_file_24_signal:= (others => 0);
			reg_file_25_signal:= (others => 0);
			reg_file_26_signal:= (others => 0);
			reg_file_27_signal:= (others => 0);
			reg_file_28_signal:= (others => 0);
			reg_file_29_signal:= (others => 0);
			reg_file_30_signal:= (others => 0);
			reg_file_31_signal:= (others => 0);
			regfile_signal.reg_file_01<=0;
			regfile_signal.reg_file_02<=0;
			regfile_signal.reg_file_03<=0;
			regfile_signal.reg_file_04<=0;
			regfile_signal.reg_file_05<=0;
			regfile_signal.reg_file_06<=0;
			regfile_signal.reg_file_07<=0;
			regfile_signal.reg_file_08<=0;
			regfile_signal.reg_file_09<=0;
			regfile_signal.reg_file_10<=0;
			regfile_signal.reg_file_11<=0;
			regfile_signal.reg_file_12<=0;
			regfile_signal.reg_file_13<=0;
			regfile_signal.reg_file_14<=0;
			regfile_signal.reg_file_15<=0;
			regfile_signal.reg_file_16<=0;
			regfile_signal.reg_file_17<=0;
			regfile_signal.reg_file_18<=0;
			regfile_signal.reg_file_19<=0;
			regfile_signal.reg_file_20<=0;
			regfile_signal.reg_file_21<=0;
			regfile_signal.reg_file_22<=0;
			regfile_signal.reg_file_23<=0;
			regfile_signal.reg_file_24<=0;
			regfile_signal.reg_file_25<=0;
			regfile_signal.reg_file_26<=0;
			regfile_signal.reg_file_27<=0;
			regfile_signal.reg_file_28<=0;
			regfile_signal.reg_file_29<=0;
			regfile_signal.reg_file_30<=0;
			regfile_signal.reg_file_31<=0;
			regfileECall_signal.reg_file_10<=0;
			regfileECall_signal.reg_file_11<=0;
			regfileECall_signal.reg_file_12<=0;
			regfileECall_signal.reg_file_17<=0;
			regfileECallWrite_signal.dst<=0;
			regfileECallWrite_signal.dstData<=0;
			regfileECallWrite_signal.exception<=0;
			regfileWrite_signal.dst<=0;
			regfileWrite_signal.dstData<=0;
			regfileWrite_signal.exception<=0;
			ecall_reg_Port_notify <= false;
			fromRegsPort_notify <= true;
			reg_ecall_Port_notify <= false;
			toRegsPort_notify <= false;
		 else
		 if section = run then
		 -- FILL OUT HERE;
		 end if;
		 end if;
	 end if;
	 end process;
end Regs_arch;
