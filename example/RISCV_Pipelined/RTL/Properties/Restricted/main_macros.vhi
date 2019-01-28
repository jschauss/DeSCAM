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
macro execute_5 		  	: boolean 	:= state_05 								 end macro;
macro execute_11(location:boolean) 	: boolean 	:= if(location) then getState(11) else state_11 end if; 		 end macro;
macro execute_12		 	: boolean 	:= state_12								 end macro;
macro fetch_16  (location:boolean)   	: boolean 	:= if(location and prevState_17) then getState(16) else state_16 end if; end macro;
macro fetch_17  		   	: boolean 	:= state_17 								 end macro;

-- DP SIGNALS --
macro fromMemoryPort_sig_loadedData 	: unsigned 	:= if(instrFlushed or stallWhileFetching) then nop else loadedData end if; end macro;
macro fromRegsPort_sig_reg_file_01      : unsigned 	:= getRegValue( 1,DP/RF/reg_file(1)) 	end macro;
macro fromRegsPort_sig_reg_file_02  	: unsigned 	:= getRegValue( 2,DP/RF/reg_file(2)) 	end macro;
macro fromRegsPort_sig_reg_file_03  	: unsigned 	:= DP/RF/reg_file(3) 		      	end macro;
macro fromRegsPort_sig_reg_file_04  	: unsigned 	:= DP/RF/reg_file(4) 		      	end macro;
macro fromRegsPort_sig_reg_file_05  	: unsigned 	:= DP/RF/reg_file(5) 			end macro;
macro fromRegsPort_sig_reg_file_06  	: unsigned 	:= DP/RF/reg_file(6)			end macro;
macro fromRegsPort_sig_reg_file_07  	: unsigned 	:= DP/RF/reg_file(7) 			end macro;
macro fromRegsPort_sig_reg_file_08  	: unsigned 	:= DP/RF/reg_file(8) 			end macro;
macro fromRegsPort_sig_reg_file_09  	: unsigned 	:= DP/RF/reg_file(9) 			end macro;
macro fromRegsPort_sig_reg_file_10  	: unsigned 	:= DP/RF/reg_file(10) 			end macro;
macro fromRegsPort_sig_reg_file_11  	: unsigned 	:= DP/RF/reg_file(11)	 		end macro;
macro fromRegsPort_sig_reg_file_12  	: unsigned 	:= DP/RF/reg_file(12) 			end macro;
macro fromRegsPort_sig_reg_file_13  	: unsigned 	:= DP/RF/reg_file(13) 			end macro;
macro fromRegsPort_sig_reg_file_14  	: unsigned 	:= DP/RF/reg_file(14) 			end macro;
macro fromRegsPort_sig_reg_file_15  	: unsigned 	:= DP/RF/reg_file(15) 			end macro;
macro fromRegsPort_sig_reg_file_16  	: unsigned 	:= DP/RF/reg_file(16) 			end macro;
macro fromRegsPort_sig_reg_file_17  	: unsigned 	:= DP/RF/reg_file(17) 			end macro;
macro fromRegsPort_sig_reg_file_18  	: unsigned 	:= DP/RF/reg_file(18) 			end macro;
macro fromRegsPort_sig_reg_file_19  	: unsigned 	:= DP/RF/reg_file(19) 			end macro;
macro fromRegsPort_sig_reg_file_20  	: unsigned 	:= DP/RF/reg_file(20)	 		end macro;
macro fromRegsPort_sig_reg_file_21  	: unsigned 	:= DP/RF/reg_file(21) 			end macro;
macro fromRegsPort_sig_reg_file_22  	: unsigned 	:= DP/RF/reg_file(22) 			end macro;
macro fromRegsPort_sig_reg_file_23  	: unsigned 	:= DP/RF/reg_file(23) 			end macro;
macro fromRegsPort_sig_reg_file_24  	: unsigned 	:= DP/RF/reg_file(24) 			end macro;
macro fromRegsPort_sig_reg_file_25  	: unsigned 	:= DP/RF/reg_file(25) 			end macro;
macro fromRegsPort_sig_reg_file_26  	: unsigned 	:= DP/RF/reg_file(26) 			end macro;
macro fromRegsPort_sig_reg_file_27  	: unsigned 	:= DP/RF/reg_file(27) 			end macro;
macro fromRegsPort_sig_reg_file_28  	: unsigned 	:= DP/RF/reg_file(28) 			end macro;
macro fromRegsPort_sig_reg_file_29  	: unsigned 	:= DP/RF/reg_file(29) 			end macro;
macro fromRegsPort_sig_reg_file_30  	: unsigned 	:= DP/RF/reg_file(30) 			end macro;
macro fromRegsPort_sig_reg_file_31  	: unsigned 	:= DP/RF/reg_file(31) 			end macro;
macro toMemoryPort_sig_addrIn 	    	: unsigned 	:= if(prevState_17) then getAddrIn else addrIn end if; end macro;
macro toMemoryPort_sig_dataIn 	    	: unsigned 	:= if(prevState_17) then getDataIn else dataIn end if; end macro;
macro toMemoryPort_sig_mask 	        : ME_MaskType 	:= if(prevState_17) then getMask   else mask   end if; end macro;
macro toMemoryPort_sig_req 	        : ME_AccessType := if(prevState_17) then getReq    else req    end if; end macro;
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
