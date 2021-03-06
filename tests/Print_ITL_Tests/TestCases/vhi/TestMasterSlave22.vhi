-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
macro s_in_1_sync : boolean := end macro;
macro s_in_2_sync : boolean := end macro;
macro s_in_3_sync : boolean := end macro;


-- DP SIGNALS --
macro s_in_1_sig : signed := end macro;
macro s_in_2_sig : signed := end macro;
macro s_in_3_sig : signed := end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --


-- STATES --
macro state_1 : boolean := true end macro;
macro state_2 : boolean := true end macro;


-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: state_1;
end property;


property state_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_1;
	at t: s_in_1_sync;
	at t: s_in_2_sync;
	at t: s_in_3_sync;
prove:
	at t_end: state_2;
end property;


property state_1_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_1;
	at t: s_in_1_sync;
	at t: s_in_2_sync;
	at t: not(s_in_3_sync);
prove:
	at t_end: state_2;
end property;


property state_1_3 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_1;
	at t: s_in_1_sync;
	at t: not(s_in_2_sync);
	at t: s_in_3_sync;
prove:
	at t_end: state_2;
end property;


property state_1_4 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_1;
	at t: s_in_1_sync;
	at t: not(s_in_2_sync);
	at t: not(s_in_3_sync);
prove:
	at t_end: state_2;
end property;


property state_1_5 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_1;
	at t: not(s_in_1_sync);
	at t: s_in_2_sync;
	at t: s_in_3_sync;
prove:
	at t_end: state_2;
end property;


property state_1_6 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_1;
	at t: not(s_in_1_sync);
	at t: s_in_2_sync;
	at t: not(s_in_3_sync);
prove:
	at t_end: state_2;
end property;


property state_1_7 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_1;
	at t: not(s_in_1_sync);
	at t: not(s_in_2_sync);
	at t: s_in_3_sync;
prove:
	at t_end: state_2;
end property;


property state_1_8 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_1;
	at t: not(s_in_1_sync);
	at t: not(s_in_2_sync);
	at t: not(s_in_3_sync);
prove:
	at t_end: state_2;
end property;


property state_2_10 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_2;
	at t: s_in_1_sync;
	at t: s_in_2_sync;
	at t: not(s_in_3_sync);
prove:
	at t_end: state_1;
end property;


property state_2_11 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_2;
	at t: s_in_1_sync;
	at t: not(s_in_2_sync);
	at t: s_in_3_sync;
prove:
	at t_end: state_1;
end property;


property state_2_12 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_2;
	at t: s_in_1_sync;
	at t: not(s_in_2_sync);
	at t: not(s_in_3_sync);
prove:
	at t_end: state_1;
end property;


property state_2_13 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_2;
	at t: not(s_in_1_sync);
	at t: s_in_2_sync;
	at t: s_in_3_sync;
prove:
	at t_end: state_1;
end property;


property state_2_14 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_2;
	at t: not(s_in_1_sync);
	at t: s_in_2_sync;
	at t: not(s_in_3_sync);
prove:
	at t_end: state_1;
end property;


property state_2_15 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_2;
	at t: not(s_in_1_sync);
	at t: not(s_in_2_sync);
	at t: s_in_3_sync;
prove:
	at t_end: state_1;
end property;


property state_2_16 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_2;
	at t: not(s_in_1_sync);
	at t: not(s_in_2_sync);
	at t: not(s_in_3_sync);
prove:
	at t_end: state_1;
end property;


property state_2_9 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: state_2;
	at t: s_in_1_sync;
	at t: s_in_2_sync;
	at t: s_in_3_sync;
prove:
	at t_end: state_1;
end property;


