-- CONSTRAINTS --
constraint no_reset := rst = '0'; 				  end constraint;
constraint no_wait  := toMemoryPort_sync and fromMemoryPort_sync; end constraint;

-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
macro fromMemoryPort_notify 		: boolean 	:= CU/MEtoCU_port_notify end macro;
macro fromMemoryPort_sync 		: boolean 	:= CU/MEtoCU_port_sync   end macro;
macro toMemoryPort_notify 		: boolean 	:= CU/CUtoME_port_notify end macro;
macro toMemoryPort_sync 		: boolean 	:= CU/CUtoME_port_sync   end macro;
macro toRegsPort_notify 		: boolean 	:= if((prevState_17 and not(prev(stallWhileFetching) or prev(instrFlushed)) and (I_L_ENC or S_ENC or ERR_ENC or B_ENC)) or prevState_05) then DP/DPtoRF_port_notify else next(DP/DPtoRF_port_notify) end if; end macro;

-- STATES --
macro execute_4 (location:boolean) 	: boolean 	:= if(location) then getState(04) else state_04 end if; 		 end macro;
macro execute_5 (location:boolean) 		  	: boolean 	:= state_05 								 end macro;
macro execute_11(location:boolean) 	: boolean 	:= if(location) then getState(11) else state_11 end if; 		 end macro;
macro execute_12 (location:boolean) 		 	: boolean 	:= state_12								 end macro;
macro fetch_16  (location:boolean)   	: boolean 	:= if(location and prevState_17) then getState(16) else state_16 end if; end macro;
macro fetch_17  (location:boolean) 		   	: boolean 	:= state_17 								 end macro;

-- DP SIGNALS --
macro fromMemoryPort_sig_loadedData 	: unsigned 	:= if(instrFlushed or stallWhileFetching) then nop else loadedData end if; end macro;
macro fromRegsPort_sig_reg_file_01  	: unsigned 	:= getRegValue( 1,DP/RF/reg_file( 1)) end macro;
macro fromRegsPort_sig_reg_file_02  	: unsigned 	:= getRegValue( 2,DP/RF/reg_file( 2)) end macro;
macro fromRegsPort_sig_reg_file_03  	: unsigned 	:= getRegValue( 3,DP/RF/reg_file( 3)) end macro;
macro fromRegsPort_sig_reg_file_04  	: unsigned 	:= getRegValue( 4,DP/RF/reg_file( 4)) end macro;
macro fromRegsPort_sig_reg_file_05  	: unsigned 	:= getRegValue( 5,DP/RF/reg_file( 5)) end macro;
macro fromRegsPort_sig_reg_file_06  	: unsigned 	:= getRegValue( 6,DP/RF/reg_file( 6)) end macro;
macro fromRegsPort_sig_reg_file_07  	: unsigned 	:= getRegValue( 7,DP/RF/reg_file( 7)) end macro;
macro fromRegsPort_sig_reg_file_08  	: unsigned 	:= getRegValue( 8,DP/RF/reg_file( 8)) end macro;
macro fromRegsPort_sig_reg_file_09  	: unsigned 	:= getRegValue( 9,DP/RF/reg_file( 9)) end macro;
macro fromRegsPort_sig_reg_file_10  	: unsigned 	:= getRegValue(10,DP/RF/reg_file(10)) end macro;
macro fromRegsPort_sig_reg_file_11  	: unsigned 	:= getRegValue(11,DP/RF/reg_file(11)) end macro;
macro fromRegsPort_sig_reg_file_12  	: unsigned 	:= getRegValue(12,DP/RF/reg_file(12)) end macro;
macro fromRegsPort_sig_reg_file_13  	: unsigned 	:= getRegValue(13,DP/RF/reg_file(13)) end macro;
macro fromRegsPort_sig_reg_file_14  	: unsigned 	:= getRegValue(14,DP/RF/reg_file(14)) end macro;
macro fromRegsPort_sig_reg_file_15  	: unsigned 	:= getRegValue(15,DP/RF/reg_file(15)) end macro;
macro fromRegsPort_sig_reg_file_16  	: unsigned 	:= getRegValue(16,DP/RF/reg_file(16)) end macro;
macro fromRegsPort_sig_reg_file_17  	: unsigned 	:= getRegValue(17,DP/RF/reg_file(17)) end macro;
macro fromRegsPort_sig_reg_file_18  	: unsigned 	:= getRegValue(18,DP/RF/reg_file(18)) end macro;
macro fromRegsPort_sig_reg_file_19  	: unsigned 	:= getRegValue(19,DP/RF/reg_file(19)) end macro;
macro fromRegsPort_sig_reg_file_20  	: unsigned 	:= getRegValue(20,DP/RF/reg_file(20)) end macro;
macro fromRegsPort_sig_reg_file_21  	: unsigned 	:= getRegValue(21,DP/RF/reg_file(21)) end macro;
macro fromRegsPort_sig_reg_file_22  	: unsigned 	:= getRegValue(22,DP/RF/reg_file(22)) end macro;
macro fromRegsPort_sig_reg_file_23  	: unsigned 	:= getRegValue(23,DP/RF/reg_file(23)) end macro;
macro fromRegsPort_sig_reg_file_24  	: unsigned 	:= getRegValue(24,DP/RF/reg_file(24)) end macro;
macro fromRegsPort_sig_reg_file_25  	: unsigned 	:= getRegValue(25,DP/RF/reg_file(25)) end macro;
macro fromRegsPort_sig_reg_file_26  	: unsigned 	:= getRegValue(26,DP/RF/reg_file(26)) end macro;
macro fromRegsPort_sig_reg_file_27  	: unsigned 	:= getRegValue(27,DP/RF/reg_file(27)) end macro;
macro fromRegsPort_sig_reg_file_28  	: unsigned 	:= getRegValue(28,DP/RF/reg_file(28)) end macro;
macro fromRegsPort_sig_reg_file_29 	: unsigned 	:= getRegValue(29,DP/RF/reg_file(29)) end macro;
macro fromRegsPort_sig_reg_file_30  	: unsigned 	:= getRegValue(30,DP/RF/reg_file(30)) end macro;
macro fromRegsPort_sig_reg_file_31  	: unsigned 	:= getRegValue(31,DP/RF/reg_file(31)) end macro;
macro toMemoryPort_sig_addrIn 	    	: unsigned 	:= if(prevState_17) then getAddrIn else addrIn end if; end macro;
macro toMemoryPort_sig_dataIn 	    	: unsigned 	:= if(prevState_17) then getDataIn else dataIn end if; end macro;
macro toMemoryPort_sig_mask 	     	: ME_MaskType 	:= if(prevState_17) then getMask   else mask   end if; end macro;
macro toMemoryPort_sig_req 	     	: ME_AccessType := if(prevState_17) then getReq    else req    end if; end macro;
macro toRegsPort_sig_dst 	  	: unsigned 	:= if(prevState_17) then getDst    else dst    end if; end macro;
macro toRegsPort_sig_dstData      	: unsigned 	:= if(prevState_17) then getDstData elsif(prevState_12 or prevState_05) then next(dstData) else dstData	end if;	end macro;

-- VISIBLE REGISTERS --
macro memoryAccess_addrIn (location:boolean) 	: unsigned 	:= if(location and prevState_17) then getAddrIn else addrIn end if; end macro;
macro memoryAccess_dataIn (location:boolean) 	: unsigned 	:= if(location and prevState_17) then getDataIn else dataIn end if; end macro;
macro memoryAccess_mask   (location:boolean) 	: ME_MaskType 	:= if(location and prevState_17) then getMask   else mask   end if; end macro;
macro memoryAccess_req    (location:boolean) 	: ME_AccessType := if(location and prevState_17) then getReq    else req    end if; end macro;
macro pcReg               (location:boolean) 	: unsigned 	:= if(not(location)) then getFreezedPC elsif(prevState_17) then getPC else pc end if; end macro;
macro regfileWrite_dst    (location:boolean)   	: unsigned 	:= if(not(location)) then getFreezed(dst) elsif(prevState_17) then getDst elsif(prevState_11 or prevState_04 or prevState_16) then next(dst) else dst end if; end macro;
macro regfileWrite_dstData(location:boolean)    : unsigned 	:= if(not(location)) then getFreezed(dstData) elsif(prevState_17) then getDstData elsif(prevState_11 or prevState_04 or prevState_16 or prevState_12 or prevState_05) then next(dstData) else dstData end if; end macro;