import top_level_types::*;
import testbasic12_types::*;

module TestBasic12 (
	input logic clk,
	input logic rst,
	input CompoundType b_in,
	input logic b_in_sync,
	output logic b_in_notify,
	output integer m_out,
	output logic m_out_notify
	);

	Sections section_signal;


	always_ff @(posedge clk, posedge rst) begin
		if (rst) begin
			section_signal <= section_a;
			b_in_notify <= 1'b1;
			m_out_notify <= 1'b0;
		end else begin
				// FILL OUT HERE
		end
	end
endmodule