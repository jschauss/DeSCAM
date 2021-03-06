import top_level_types::*;
import testmasterslave4_types::*;

module TestMasterSlave4 (
	input logic clk,
	input logic rst,
	input integer s_in,
	input logic s_in_sync,
	input integer s_in2,
	input logic s_in2_sync
	);

	Sections section_signal;


	always_ff @(posedge clk, posedge rst) begin
		if (rst) begin
			section_signal <= section_a;
		end else begin
				// FILL OUT HERE
		end
	end
endmodule