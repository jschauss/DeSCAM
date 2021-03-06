-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
macro b_in_sync : boolean := end macro;
macro b_out_sync : boolean := end macro;
macro b_in_notify : boolean := end macro;
macro b_out_notify : boolean := end macro;


-- DP SIGNALS --
macro b_in_sig : signed := end macro;
macro b_out_sig : int_2 := end macro;
macro b_out_sig_0 : signed := end macro;
macro b_out_sig_1 : signed := end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro myArray : int_2 := end macro;
macro test : signed := end macro;


-- STATES --
macro state_1 : boolean := true end macro;
macro state_2 : boolean := true end macro;


-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: state_1;
	 at t: myArray(1) = resize(0,32);
	 at t: test = resize(0,32);
	 at t: b_in_notify = true;
	 at t: b_out_notify = false;
end property;


property state_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	b_in_sig_at_t = b_in_sig@t,
	myArray_1_at_t = myArray(1)@t;
assume:
	at t: state_1;
	at t: b_in_sync;
prove:
	at t_end: state_2;
	at t_end: b_out_sig(0) = (b_in_sig_at_t + myArray_1_at_t)(31 downto 0);
	at t_end: b_out_sig(1) = b_in_sig_at_t;
	at t_end: myArray(1) = b_in_sig_at_t;
	at t_end: test = b_in_sig_at_t;
	during[t+1, t_end]: b_in_notify = false;
	during[t+1, t_end-1]: b_out_notify = false;
	at t_end: b_out_notify = true;
end property;


property state_1_4 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	myArray_1_at_t = myArray(1)@t,
	test_at_t = test@t;
assume:
	at t: state_1;
	at t: not(b_in_sync);
prove:
	at t_end: state_2;
	at t_end: b_out_sig(0) = (test_at_t + myArray_1_at_t)(31 downto 0);
	at t_end: b_out_sig(1) = test_at_t;
	at t_end: myArray(1) = test_at_t;
	at t_end: test = test_at_t;
	during[t+1, t_end]: b_in_notify = false;
	during[t+1, t_end-1]: b_out_notify = false;
	at t_end: b_out_notify = true;
end property;


property state_2_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	myArray_1_at_t = myArray(1)@t,
	test_at_t = test@t;
assume:
	at t: state_2;
	at t: b_out_sync;
prove:
	at t_end: state_1;
	at t_end: myArray(1) = (1 + myArray_1_at_t)(31 downto 0);
	at t_end: test = test_at_t;
	during[t+1, t_end-1]: b_in_notify = false;
	at t_end: b_in_notify = true;
	during[t+1, t_end]: b_out_notify = false;
end property;


property state_2_6 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	myArray_1_at_t = myArray(1)@t,
	test_at_t = test@t;
assume:
	at t: state_2;
	at t: not(b_out_sync);
prove:
	at t_end: state_1;
	at t_end: myArray(1) = myArray_1_at_t;
	at t_end: test = test_at_t;
	during[t+1, t_end-1]: b_in_notify = false;
	at t_end: b_in_notify = true;
	during[t+1, t_end]: b_out_notify = false;
end property;


