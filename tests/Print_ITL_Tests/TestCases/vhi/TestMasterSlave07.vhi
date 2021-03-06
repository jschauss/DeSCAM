-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
macro s_in_sync : boolean := end macro;


-- DP SIGNALS --
macro s_in_sig : signed := end macro;
macro s_out_sig : signed := end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro phase : Phases := end macro;
macro val : signed := end macro;


-- STATES --
macro state_1 : boolean := true end macro;
macro state_2 : boolean := true end macro;


-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: state_1;
	 at t: phase = SECTION_A;
	 at t: s_out_sig = resize(0,32);
	 at t: val = resize(0,32);
end property;


property state_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	s_in_sig_at_t = s_in_sig@t;
assume:
	at t: state_1;
	at t: s_in_sync;
	at t: not((phase = SECTION_B));
prove:
	at t_end: state_2;
	at t_end: phase = SECTION_B;
	at t_end: s_out_sig = s_in_sig_at_t;
	at t_end: val = s_in_sig_at_t;
end property;


property state_1_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	val_at_t = val@t;
assume:
	at t: state_1;
	at t: not(s_in_sync);
	at t: not((phase = SECTION_B));
prove:
	at t_end: state_2;
	at t_end: phase = SECTION_B;
	at t_end: s_out_sig = val_at_t;
	at t_end: val = val_at_t;
end property;


property state_2_3 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	s_in_sig_at_t = s_in_sig@t;
assume:
	at t: state_2;
	at t: s_in_sync;
prove:
	at t_end: state_1;
	at t_end: phase = SECTION_A;
	at t_end: s_out_sig = (1 + s_in_sig_at_t)(31 downto 0);
	at t_end: val = (1 + s_in_sig_at_t)(31 downto 0);
end property;


property state_2_4 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	val_at_t = val@t;
assume:
	at t: state_2;
	at t: not(s_in_sync);
prove:
	at t_end: state_1;
	at t_end: phase = SECTION_A;
	at t_end: s_out_sig = (1 + val_at_t)(31 downto 0);
	at t_end: val = (1 + val_at_t)(31 downto 0);
end property;


