-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
macro test_in_sync : boolean := end macro;
macro test_out_sync : boolean := end macro;
macro test_in_notify : boolean := end macro;
macro test_out_notify : boolean := end macro;


-- DP SIGNALS --
macro test_in_sig : signed := end macro;
macro test_out_sig : unsigned := end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro bar : unsigned := end macro;
macro list : unsigned_5 := end macro;


-- STATES --
macro state_2 : boolean := true end macro;
macro state_1 : boolean := true end macro;


-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: state_1;
	 at t: bar = resize(0,32);
	 at t: list(0) = resize(0,32);
	 at t: list(1) = resize(0,32);
	 at t: list(2) = resize(0,32);
	 at t: list(3) = resize(0,32);
	 at t: list(4) = resize(0,32);
	 at t: test_in_notify = true;
	 at t: test_out_notify = false;
end property;


property state_2_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	bar_at_t = bar@t,
	list_0_at_t = list(0)@t,
	list_1_at_t = list(1)@t,
	list_2_at_t = list(2)@t,
	list_3_at_t = list(3)@t,
	list_4_at_t = list(4)@t;
assume:
	at t: state_2;
	at t: test_out_sync;
prove:
	at t_end: state_1;
	at t_end: bar = bar_at_t;
	at t_end: list(0) = list_0_at_t;
	at t_end: list(1) = list_1_at_t;
	at t_end: list(2) = list_2_at_t;
	at t_end: list(3) = list_3_at_t;
	at t_end: list(4) = list_4_at_t;
	during[t+1, t_end-1]: test_in_notify = false;
	at t_end: test_in_notify = true;
	during[t+1, t_end]: test_out_notify = false;
end property;


property state_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	bar_at_t = bar@t,
	list_0_at_t = list(0)@t,
	list_1_at_t = list(1)@t,
	list_2_at_t = list(2)@t,
	list_3_at_t = list(3)@t,
	list_4_at_t = list(4)@t,
	test_in_sig_at_t = test_in_sig@t;
assume:
	at t: state_1;
	at t: test_in_sync;
prove:
	at t_end: state_2;
	at t_end: bar = (((bar_at_t + unsigned(compute2(test_in_sig_at_t,bar_at_t)))(31 downto 0) + compute(3,compute2(test_in_sig_at_t,(bar_at_t + unsigned(compute2(test_in_sig_at_t,bar_at_t)))(31 downto 0))))(31 downto 0) + compute(list_0_at_t,5))(31 downto 0);
	at t_end: list(0) = list_0_at_t;
	at t_end: list(1) = list_1_at_t;
	at t_end: list(2) = list_2_at_t;
	at t_end: list(3) = list_3_at_t;
	at t_end: list(4) = list_4_at_t;
	at t_end: test_out_sig = (((bar_at_t + unsigned(compute2(test_in_sig_at_t,bar_at_t)))(31 downto 0) + compute(3,compute2(test_in_sig_at_t,(bar_at_t + unsigned(compute2(test_in_sig_at_t,bar_at_t)))(31 downto 0))))(31 downto 0) + compute(list_0_at_t,5))(31 downto 0);
	during[t+1, t_end]: test_in_notify = false;
	during[t+1, t_end-1]: test_out_notify = false;
	at t_end: test_out_notify = true;
end property;


property wait_state_2 is
dependencies: no_reset;
freeze:
	bar_at_t = bar@t,
	list_0_at_t = list(0)@t,
	list_1_at_t = list(1)@t,
	list_2_at_t = list(2)@t,
	list_3_at_t = list(3)@t,
	list_4_at_t = list(4)@t,
	test_out_sig_at_t = test_out_sig@t;
assume:
	at t: state_2;
	at t: not(test_out_sync);
prove:
	at t+1: state_2;
	at t+1: bar = bar_at_t;
	at t+1: list(0) = list_0_at_t;
	at t+1: list(1) = list_1_at_t;
	at t+1: list(2) = list_2_at_t;
	at t+1: list(3) = list_3_at_t;
	at t+1: list(4) = list_4_at_t;
	at t+1: test_out_sig = test_out_sig_at_t;
	at t+1: test_in_notify = false;
	at t+1: test_out_notify = true;
end property;


property wait_state_1 is
dependencies: no_reset;
freeze:
	bar_at_t = bar@t,
	list_0_at_t = list(0)@t,
	list_1_at_t = list(1)@t,
	list_2_at_t = list(2)@t,
	list_3_at_t = list(3)@t,
	list_4_at_t = list(4)@t;
assume:
	at t: state_1;
	at t: not(test_in_sync);
prove:
	at t+1: state_1;
	at t+1: bar = bar_at_t;
	at t+1: list(0) = list_0_at_t;
	at t+1: list(1) = list_1_at_t;
	at t+1: list(2) = list_2_at_t;
	at t+1: list(3) = list_3_at_t;
	at t+1: list(4) = list_4_at_t;
	at t+1: test_in_notify = true;
	at t+1: test_out_notify = false;
end property;


