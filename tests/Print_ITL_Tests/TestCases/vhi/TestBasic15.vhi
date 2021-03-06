-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
macro b_in_sync : boolean := end macro;
macro b_out_sync : boolean := end macro;
macro b_in_notify : boolean := end macro;
macro b_out_notify : boolean := end macro;


-- DP SIGNALS --
macro b_in_sig : CompoundType := end macro;
macro b_in_sig_mode : Mode := end macro;
macro b_in_sig_x : signed := end macro;
macro b_in_sig_y : boolean := end macro;
macro b_out_sig : CompoundType := end macro;
macro b_out_sig_mode : Mode := end macro;
macro b_out_sig_x : signed := end macro;
macro b_out_sig_y : boolean := end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro nextphase : Phases := end macro;
macro phase : Phases := end macro;


-- STATES --
macro state_1 : boolean := true end macro;
macro state_2 : boolean := true end macro;


-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: state_1;
	 at t: nextphase = SECTION_A;
	 at t: phase = SECTION_A;
	 at t: b_in_notify = true;
	 at t: b_out_notify = false;
end property;


property state_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	b_in_sig_mode_at_t = b_in_sig_mode@t,
	b_in_sig_x_at_t = b_in_sig_x@t,
	b_in_sig_y_at_t = b_in_sig_y@t;
assume:
	at t: state_1;
	at t: b_in_sync;
	at t: (b_in_sig_mode = WRITE);
	at t: not((phase = SECTION_B));
prove:
	at t_end: state_2;
	at t_end: b_out_sig_mode = b_in_sig_mode_at_t;
	at t_end: b_out_sig_x = (1 + b_in_sig_x_at_t)(31 downto 0);
	at t_end: b_out_sig_y = b_in_sig_y_at_t;
	at t_end: nextphase = SECTION_B;
	at t_end: phase = SECTION_B;
	during[t+1, t_end]: b_in_notify = false;
	during[t+1, t_end-1]: b_out_notify = false;
	at t_end: b_out_notify = true;
end property;


property state_1_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	nextphase_at_t = nextphase@t;
assume:
	at t: state_1;
	at t: b_in_sync;
	at t: not((b_in_sig_mode = WRITE));
	at t: not((phase = SECTION_B));
	at t: (nextphase = SECTION_A);
prove:
	at t_end: state_1;
	at t_end: nextphase = nextphase_at_t;
	at t_end: phase = nextphase_at_t;
	during[t+1, t_end-1]: b_in_notify = false;
	at t_end: b_in_notify = true;
	during[t+1, t_end]: b_out_notify = false;
end property;


property state_2_3 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_2;
	at t: b_out_sync;
prove:
	at t_end: state_1;
	at t_end: nextphase = SECTION_A;
	at t_end: phase = SECTION_A;
	during[t+1, t_end-1]: b_in_notify = false;
	at t_end: b_in_notify = true;
	during[t+1, t_end]: b_out_notify = false;
end property;


property state_2_5 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_2;
	at t: not(b_out_sync);
prove:
	at t_end: state_1;
	at t_end: nextphase = SECTION_A;
	at t_end: phase = SECTION_A;
	during[t+1, t_end-1]: b_in_notify = false;
	at t_end: b_in_notify = true;
	during[t+1, t_end]: b_out_notify = false;
end property;


property wait_state_1 is
dependencies: no_reset;
freeze:
	nextphase_at_t = nextphase@t,
	phase_at_t = phase@t;
assume:
	at t: state_1;
	at t: not(b_in_sync);
prove:
	at t+1: state_1;
	at t+1: nextphase = nextphase_at_t;
	at t+1: phase = phase_at_t;
	at t+1: b_in_notify = true;
	at t+1: b_out_notify = false;
end property;


