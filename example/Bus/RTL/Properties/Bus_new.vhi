-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
--macro master_in_sync : boolean := end macro;
--macro master_out_sync : boolean := end macro;
--macro slave_in0_sync : boolean := end macro;
--macro slave_in1_sync : boolean := end macro;
--macro slave_in2_sync : boolean := end macro;
--macro slave_in3_sync : boolean := end macro;
--macro slave_out0_sync : boolean := end macro;
--macro slave_out1_sync : boolean := end macro;
--macro slave_out2_sync : boolean := end macro;
--macro slave_out3_sync : boolean := end macro;
--macro master_in_notify : boolean := end macro;
--macro master_out_notify : boolean := end macro;
--macro slave_in0_notify : boolean := end macro;
--macro slave_in1_notify : boolean := end macro;
--macro slave_in2_notify : boolean := end macro;
--macro slave_in3_notify : boolean := end macro;
--macro slave_out0_notify : boolean := end macro;
--macro slave_out1_notify : boolean := end macro;
--macro slave_out2_notify : boolean := end macro;
--macro slave_out3_notify : boolean := end macro;


-- DP SIGNALS --
macro master_in_sig_addr : signed := master_in.addr end macro;
macro master_in_sig_data : signed := master_in.data end macro;
macro master_in_sig_trans_type : trans_t := master_in.trans_type end macro;
macro master_out_sig_ack : ack_t := master_out.ack end macro;
macro master_out_sig_data : signed := master_out.data end macro;
macro slave_in0_sig_ack : ack_t := slave_in0.ack end macro;
macro slave_in0_sig_data : signed := slave_in0.data end macro;
macro slave_in1_sig_ack : ack_t := slave_in1.ack end macro;
macro slave_in1_sig_data : signed := slave_in1.data end macro;
macro slave_in2_sig_ack : ack_t := slave_in2.ack end macro;
macro slave_in2_sig_data : signed := slave_in2.data end macro;
macro slave_in3_sig_ack : ack_t := slave_in3.ack end macro;
macro slave_in3_sig_data : signed := slave_in3.data end macro;
macro slave_out0_sig_addr : signed := slave_out0.addr end macro;
macro slave_out0_sig_data : signed := slave_out0.data end macro;
macro slave_out0_sig_trans_type : trans_t := slave_out0.trans_type end macro;
macro slave_out1_sig_addr : signed := slave_out1.addr end macro;
macro slave_out1_sig_data : signed := slave_out1.data end macro;
macro slave_out1_sig_trans_type : trans_t := slave_out1.trans_type end macro;
macro slave_out2_sig_addr : signed := slave_out2.addr end macro;
macro slave_out2_sig_data : signed := slave_out2.data end macro;
macro slave_out2_sig_trans_type : trans_t := slave_out2.trans_type end macro;
macro slave_out3_sig_addr : signed := slave_out3.addr end macro;
macro slave_out3_sig_data : signed := slave_out3.data end macro;
macro slave_out3_sig_trans_type : trans_t := slave_out3.trans_type end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro req_addr : signed := req_signal.addr end macro;
macro req_data : signed := req_signal.data end macro;
macro req_trans_type : trans_t := req_signal.trans_type end macro;
macro resp_ack : ack_t := resp_signal.ack end macro;
macro resp_data : signed := resp_signal.data end macro;


-- STATES --
macro state_8 : boolean :=
	section=run and
	master_in_notify = true and
	master_out_notify = false and
	slave_in0_notify = false and
	slave_in1_notify = false and
	slave_in2_notify = false and
	slave_in3_notify = false and
	slave_out0_notify = false and
	slave_out1_notify = false and
	slave_out2_notify = false and
	slave_out3_notify = false
end macro;

macro state_13 : boolean :=
	section=run and
	master_in_notify = false and
	master_out_notify = false and
	slave_in0_notify = false and
	slave_in1_notify = false and
	slave_in2_notify = false and
	slave_in3_notify = false and
	slave_out0_notify = true and
	slave_out1_notify = false and
	slave_out2_notify = false and
	slave_out3_notify = false
end macro;

macro state_14 : boolean :=
	section=run and
	master_in_notify = false and
	master_out_notify = false and
	slave_in0_notify = true and
	slave_in1_notify = false and
	slave_in2_notify = false and
	slave_in3_notify = false and
	slave_out0_notify = false and
	slave_out1_notify = false and
	slave_out2_notify = false and
	slave_out3_notify = false
end macro;

macro state_17 : boolean :=
	section=run and
	master_in_notify = false and
	master_out_notify = true and
	slave_in0_notify = false and
	slave_in1_notify = false and
	slave_in2_notify = false and
	slave_in3_notify = false and
	slave_out0_notify = false and
	slave_out1_notify = false and
	slave_out2_notify = false and
	slave_out3_notify = false
end macro;

macro state_22 : boolean :=
	section=run and
	master_in_notify = false and
	master_out_notify = false and
	slave_in0_notify = false and
	slave_in1_notify = false and
	slave_in2_notify = false and
	slave_in3_notify = false and
	slave_out0_notify = false and
	slave_out1_notify = true and
	slave_out2_notify = false and
	slave_out3_notify = false
end macro;

macro state_23 : boolean :=
	section=run  and
	master_in_notify = false and
	master_out_notify = false and
	slave_in0_notify = false and
	slave_in1_notify = true and
	slave_in2_notify = false and
	slave_in3_notify = false and
	slave_out0_notify = false and
	slave_out1_notify = false and
	slave_out2_notify = false and
	slave_out3_notify = false
end macro;

macro state_27 : boolean :=
	section=run and
	master_in_notify = false and
	master_out_notify = false and
	slave_in0_notify = false and
	slave_in1_notify = false and
	slave_in2_notify = false and
	slave_in3_notify = false and
	slave_out0_notify = false and
	slave_out1_notify = false and
	slave_out2_notify = true and
	slave_out3_notify = false
end macro;

macro state_28 : boolean :=
	section=run  and
	master_in_notify = false and
	master_out_notify = false and
	slave_in0_notify = false and
	slave_in1_notify = false and
	slave_in2_notify = true and
	slave_in3_notify = false and
	slave_out0_notify = false and
	slave_out1_notify = false and
	slave_out2_notify = false and
	slave_out3_notify = false
end macro;

macro state_32 : boolean :=
	section=run and
	master_in_notify = false and
	master_out_notify = false and
	slave_in0_notify = false and
	slave_in1_notify = false and
	slave_in2_notify = false and
	slave_in3_notify = false and
	slave_out0_notify = false and
	slave_out1_notify = false and
	slave_out2_notify = false and
	slave_out3_notify = true
end macro;

macro state_33 : boolean :=
	section=run  and
	master_in_notify = false and
	master_out_notify = false and
	slave_in0_notify = false and
	slave_in1_notify = false and
	slave_in2_notify = false and
	slave_in3_notify = true and
	slave_out0_notify = false and
	slave_out1_notify = false and
	slave_out2_notify = false and
	slave_out3_notify = false
end macro;


-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: state_8;
	 at t: req_addr = resize(0,32);
	 at t: req_data = resize(0,32);
	 at t: req_trans_type = SINGLE_READ;
	 at t: resp_ack = ERR;
	 at t: resp_data = resize(0,32);
	 at t: master_in_notify = true;
	 at t: master_out_notify = false;
	 at t: slave_in0_notify = false;
	 at t: slave_in1_notify = false;
	 at t: slave_in2_notify = false;
	 at t: slave_in3_notify = false;
	 at t: slave_out0_notify = false;
	 at t: slave_out1_notify = false;
	 at t: slave_out2_notify = false;
	 at t: slave_out3_notify = false;
end property;


property state_13_11 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_13;
	at t: slave_out0_sync;
prove:
	at t_end: state_14;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end-1]: slave_in0_notify = false;
	at t_end: slave_in0_notify = true;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_14_12 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	slave_in0_sig_ack_at_t = slave_in0_sig_ack@t;
assume:
	at t: state_14;
	at t: slave_in0_sync;
	at t: (SINGLE_WRITE = req_trans_type);
prove:
	at t_end: state_17;
	at t_end: master_out_sig_ack = slave_in0_sig_ack_at_t;
	at t_end: master_out_sig_data = 0;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in0_sig_ack_at_t;
	at t_end: resp_data = 0;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_14_13 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	slave_in0_sig_ack_at_t = slave_in0_sig_ack@t,
	slave_in0_sig_data_at_t = slave_in0_sig_data@t;
assume:
	at t: state_14;
	at t: slave_in0_sync;
	at t: not((SINGLE_WRITE = req_trans_type));
prove:
	at t_end: state_17;
	at t_end: master_out_sig_ack = slave_in0_sig_ack_at_t;
	at t_end: master_out_sig_data = slave_in0_sig_data_at_t;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in0_sig_ack_at_t;
	at t_end: resp_data = slave_in0_sig_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_17_14 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_17;
	at t: master_out_sync;
prove:
	at t_end: state_8;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end-1]: master_in_notify = false;
	at t_end: master_in_notify = true;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_22_15 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_22;
	at t: slave_out1_sync;
prove:
	at t_end: state_23;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end-1]: slave_in1_notify = false;
	at t_end: slave_in1_notify = true;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_23_16 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	slave_in1_sig_ack_at_t = slave_in1_sig_ack@t;
assume:
	at t: state_23;
	at t: slave_in1_sync;
	at t: (SINGLE_WRITE = req_trans_type);
prove:
	at t_end: state_17;
	at t_end: master_out_sig_ack = slave_in1_sig_ack_at_t;
	at t_end: master_out_sig_data = 0;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in1_sig_ack_at_t;
	at t_end: resp_data = 0;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_23_17 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	slave_in1_sig_ack_at_t = slave_in1_sig_ack@t,
	slave_in1_sig_data_at_t = slave_in1_sig_data@t;
assume:
	at t: state_23;
	at t: slave_in1_sync;
	at t: not((SINGLE_WRITE = req_trans_type));
prove:
	at t_end: state_17;
	at t_end: master_out_sig_ack = slave_in1_sig_ack_at_t;
	at t_end: master_out_sig_data = slave_in1_sig_data_at_t;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in1_sig_ack_at_t;
	at t_end: resp_data = slave_in1_sig_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_27_18 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_27;
	at t: slave_out2_sync;
prove:
	at t_end: state_28;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end-1]: slave_in2_notify = false;
	at t_end: slave_in2_notify = true;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_28_19 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	slave_in2_sig_ack_at_t = slave_in2_sig_ack@t;
assume:
	at t: state_28;
	at t: slave_in2_sync;
	at t: (SINGLE_WRITE = req_trans_type);
prove:
	at t_end: state_17;
	at t_end: master_out_sig_ack = slave_in2_sig_ack_at_t;
	at t_end: master_out_sig_data = 0;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in2_sig_ack_at_t;
	at t_end: resp_data = 0;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_28_20 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	slave_in2_sig_ack_at_t = slave_in2_sig_ack@t,
	slave_in2_sig_data_at_t = slave_in2_sig_data@t;
assume:
	at t: state_28;
	at t: slave_in2_sync;
	at t: not((SINGLE_WRITE = req_trans_type));
prove:
	at t_end: state_17;
	at t_end: master_out_sig_ack = slave_in2_sig_ack_at_t;
	at t_end: master_out_sig_data = slave_in2_sig_data_at_t;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in2_sig_ack_at_t;
	at t_end: resp_data = slave_in2_sig_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_32_21 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_32;
	at t: slave_out3_sync;
prove:
	at t_end: state_33;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end-1]: slave_in3_notify = false;
	at t_end: slave_in3_notify = true;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_33_22 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	slave_in3_sig_ack_at_t = slave_in3_sig_ack@t;
assume:
	at t: state_33;
	at t: slave_in3_sync;
	at t: (SINGLE_WRITE = req_trans_type);
prove:
	at t_end: state_17;
	at t_end: master_out_sig_ack = slave_in3_sig_ack_at_t;
	at t_end: master_out_sig_data = 0;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in3_sig_ack_at_t;
	at t_end: resp_data = 0;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_33_23 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	slave_in3_sig_ack_at_t = slave_in3_sig_ack@t,
	slave_in3_sig_data_at_t = slave_in3_sig_data@t;
assume:
	at t: state_33;
	at t: slave_in3_sync;
	at t: not((SINGLE_WRITE = req_trans_type));
prove:
	at t_end: state_17;
	at t_end: master_out_sig_ack = slave_in3_sig_ack_at_t;
	at t_end: master_out_sig_data = slave_in3_sig_data_at_t;
	at t_end: req_addr = req_addr_at_t;
	at t_end: req_data = req_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in3_sig_ack_at_t;
	at t_end: resp_data = slave_in3_sig_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_8_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_8;
	at t: master_in_sync;
	at t: (SINGLE_READ = master_in_sig_trans_type);
	at t: (master_in_sig_addr >= resize(0,32));
	at t: (master_in_sig_addr <= resize(7,32));
prove:
	at t_end: state_13;
	at t_end: req_addr = master_in_sig_addr_at_t;
	at t_end: req_data = 0;
	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out0_sig_addr = master_in_sig_addr_at_t;
	at t_end: slave_out0_sig_data = 0;
	at t_end: slave_out0_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end-1]: slave_out0_notify = false;
	at t_end: slave_out0_notify = true;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_8_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_8;
	at t: master_in_sync;
	at t: (SINGLE_READ = master_in_sig_trans_type);
	at t: (master_in_sig_addr >= resize(8,32));
	at t: (master_in_sig_addr <= resize(15,32));
prove:
	at t_end: state_22;
	at t_end: req_addr = (-8 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: req_data = 0;
	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out1_sig_addr = (-8 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out1_sig_data = 0;
	at t_end: slave_out1_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end-1]: slave_out1_notify = false;
	at t_end: slave_out1_notify = true;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_8_3 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_8;
	at t: master_in_sync;
	at t: (SINGLE_READ = master_in_sig_trans_type);
	at t: (master_in_sig_addr >= resize(16,32));
	at t: (master_in_sig_addr <= resize(23,32));
prove:
	at t_end: state_27;
	at t_end: req_addr = (-16 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: req_data = 0;
	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out2_sig_addr = (-16 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out2_sig_data = 0;
	at t_end: slave_out2_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end-1]: slave_out2_notify = false;
	at t_end: slave_out2_notify = true;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_8_4 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_8;
	at t: master_in_sync;
	at t: (SINGLE_READ = master_in_sig_trans_type);
	at t: (master_in_sig_addr >= resize(24,32));
	at t: (master_in_sig_addr <= resize(31,32));
prove:
	at t_end: state_32;
	at t_end: req_addr = (-24 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: req_data = 0;
	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out3_sig_addr = (-24 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out3_sig_data = 0;
	at t_end: slave_out3_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end-1]: slave_out3_notify = false;
	at t_end: slave_out3_notify = true;
end property;


property state_8_5 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_8;
	at t: master_in_sync;
	at t: (SINGLE_READ = master_in_sig_trans_type);
	at t: not(((master_in_sig_addr >= resize(0,32)) and not((resize(8,32) <= master_in_sig_addr))));
	at t: not(((master_in_sig_addr >= resize(8,32)) and not((resize(16,32) <= master_in_sig_addr))));
	at t: not(((master_in_sig_addr >= resize(16,32)) and not((resize(24,32) <= master_in_sig_addr))));
	at t: not(((master_in_sig_addr >= resize(24,32)) and not((resize(32,32) <= master_in_sig_addr))));
prove:
	at t_end: state_17;
	at t_end: master_out_sig_ack = resp_ack_at_t;
	at t_end: master_out_sig_data = resp_data_at_t;
	at t_end: req_addr = master_in_sig_addr_at_t;
	at t_end: req_data = 0;
	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_8_6 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_data_at_t = master_in_sig_data@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_8;
	at t: master_in_sync;
	at t: not((SINGLE_READ = master_in_sig_trans_type));
	at t: (master_in_sig_addr >= resize(0,32));
	at t: (master_in_sig_addr <= resize(7,32));
prove:
	at t_end: state_13;
	at t_end: req_addr = master_in_sig_addr_at_t;
	at t_end: req_data = master_in_sig_data_at_t;
	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out0_sig_addr = master_in_sig_addr_at_t;
	at t_end: slave_out0_sig_data = master_in_sig_data_at_t;
	at t_end: slave_out0_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end-1]: slave_out0_notify = false;
	at t_end: slave_out0_notify = true;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_8_7 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_data_at_t = master_in_sig_data@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_8;
	at t: master_in_sync;
	at t: not((SINGLE_READ = master_in_sig_trans_type));
	at t: (master_in_sig_addr >= resize(8,32));
	at t: (master_in_sig_addr <= resize(15,32));
prove:
	at t_end: state_22;
	at t_end: req_addr = (-8 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: req_data = master_in_sig_data_at_t;
	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out1_sig_addr = (-8 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out1_sig_data = master_in_sig_data_at_t;
	at t_end: slave_out1_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end-1]: slave_out1_notify = false;
	at t_end: slave_out1_notify = true;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_8_8 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_data_at_t = master_in_sig_data@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_8;
	at t: master_in_sync;
	at t: not((SINGLE_READ = master_in_sig_trans_type));
	at t: (master_in_sig_addr >= resize(16,32));
	at t: (master_in_sig_addr <= resize(23,32));
prove:
	at t_end: state_27;
	at t_end: req_addr = (-16 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: req_data = master_in_sig_data_at_t;
	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out2_sig_addr = (-16 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out2_sig_data = master_in_sig_data_at_t;
	at t_end: slave_out2_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end-1]: slave_out2_notify = false;
	at t_end: slave_out2_notify = true;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property state_8_9 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_data_at_t = master_in_sig_data@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_8;
	at t: master_in_sync;
	at t: not((SINGLE_READ = master_in_sig_trans_type));
	at t: (master_in_sig_addr >= resize(24,32));
	at t: (master_in_sig_addr <= resize(31,32));
prove:
	at t_end: state_32;
	at t_end: req_addr = (-24 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: req_data = master_in_sig_data_at_t;
	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out3_sig_addr = (-24 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out3_sig_data = master_in_sig_data_at_t;
	at t_end: slave_out3_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end-1]: slave_out3_notify = false;
	at t_end: slave_out3_notify = true;
end property;


property state_8_10 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_data_at_t = master_in_sig_data@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t;
assume:
	at t: state_8;
	at t: master_in_sync;
	at t: not(((master_in_sig_addr >= resize(0,32)) and not((resize(8,32) <= master_in_sig_addr))));
	at t: not(((master_in_sig_addr >= resize(8,32)) and not((resize(16,32) <= master_in_sig_addr))));
	at t: not(((master_in_sig_addr >= resize(16,32)) and not((resize(24,32) <= master_in_sig_addr))));
	at t: not(((master_in_sig_addr >= resize(24,32)) and not((resize(32,32) <= master_in_sig_addr))));
	at t: (SINGLE_WRITE = master_in_sig_trans_type);
prove:
	at t_end: state_17;
	at t_end: master_out_sig_ack = resp_ack_at_t;
	at t_end: master_out_sig_data = 0;
	at t_end: req_addr = master_in_sig_addr_at_t;
	at t_end: req_data = master_in_sig_data_at_t;
	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = 0;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property wait_state_13 is
dependencies: no_reset;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_13;
	at t: not(slave_out0_sync);
prove:
	at t+1: state_13;
	at t+1: req_addr = req_addr_at_t;
	at t+1: req_data = req_data_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: slave_out0_sig_addr = req_addr_at_t;
	at t+1: slave_out0_sig_data = req_data_at_t;
	at t+1: slave_out0_sig_trans_type = req_trans_type_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = true;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_state_14 is
dependencies: no_reset;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_14;
	at t: not(slave_in0_sync);
prove:
	at t+1: state_14;
	at t+1: req_addr = req_addr_at_t;
	at t+1: req_data = req_data_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = true;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_state_17 is
dependencies: no_reset;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_17;
	at t: not(master_out_sync);
prove:
	at t+1: state_17;
	at t+1: master_out_sig_ack = resp_ack_at_t;
	at t+1: master_out_sig_data = resp_data_at_t;
	at t+1: req_addr = req_addr_at_t;
	at t+1: req_data = req_data_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = true;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_state_22 is
dependencies: no_reset;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_22;
	at t: not(slave_out1_sync);
prove:
	at t+1: state_22;
	at t+1: req_addr = req_addr_at_t;
	at t+1: req_data = req_data_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: slave_out1_sig_addr = req_addr_at_t;
	at t+1: slave_out1_sig_data = req_data_at_t;
	at t+1: slave_out1_sig_trans_type = req_trans_type_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = true;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_state_23 is
dependencies: no_reset;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_23;
	at t: not(slave_in1_sync);
prove:
	at t+1: state_23;
	at t+1: req_addr = req_addr_at_t;
	at t+1: req_data = req_data_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = true;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_state_27 is
dependencies: no_reset;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_27;
	at t: not(slave_out2_sync);
prove:
	at t+1: state_27;
	at t+1: req_addr = req_addr_at_t;
	at t+1: req_data = req_data_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: slave_out2_sig_addr = req_addr_at_t;
	at t+1: slave_out2_sig_data = req_data_at_t;
	at t+1: slave_out2_sig_trans_type = req_trans_type_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = true;
	at t+1: slave_out3_notify = false;
end property;


property wait_state_28 is
dependencies: no_reset;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_28;
	at t: not(slave_in2_sync);
prove:
	at t+1: state_28;
	at t+1: req_addr = req_addr_at_t;
	at t+1: req_data = req_data_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = true;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_state_32 is
dependencies: no_reset;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_32;
	at t: not(slave_out3_sync);
prove:
	at t+1: state_32;
	at t+1: req_addr = req_addr_at_t;
	at t+1: req_data = req_data_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: slave_out3_sig_addr = req_addr_at_t;
	at t+1: slave_out3_sig_data = req_data_at_t;
	at t+1: slave_out3_sig_trans_type = req_trans_type_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = true;
end property;


property wait_state_33 is
dependencies: no_reset;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_33;
	at t: not(slave_in3_sync);
prove:
	at t+1: state_33;
	at t+1: req_addr = req_addr_at_t;
	at t+1: req_data = req_data_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = true;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_state_8 is
dependencies: no_reset;
freeze:
	req_addr_at_t = req_addr@t,
	req_data_at_t = req_data@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: state_8;
	at t: not(master_in_sync);
prove:
	at t+1: state_8;
	at t+1: req_addr = req_addr_at_t;
	at t+1: req_data = req_data_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = true;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;

