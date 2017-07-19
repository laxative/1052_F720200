// IF_ID

module IF_ID ( clk,
               rst,
			   // input
			   IF_IDWrite,
			   IF_Flush,
			   IF_PC,
			   IF_ir,
			   // output
			   ID_PC,
			   ID_ir);
	
	parameter pc_size = 18;
	parameter data_size = 32;
	
	input clk, rst;
	input IF_IDWrite, IF_Flush;
	input [pc_size-1:0]   IF_PC;
	input [data_size-1:0] IF_ir;
	
	output reg [pc_size-1:0]   ID_PC;
	output reg [data_size-1:0] ID_ir;

	// write your code in here
	always @(negedge clk or rst) begin
		if (rst) begin
			// reset
			ID_PC <= 0;
			ID_ir <= 0;
		end
		else begin
			if(IF_Flush) begin
				ID_PC <= 0;
				ID_ir <= 0;
			end
			else if (IF_IDWrite) begin
				ID_PC <= IF_PC;
				ID_ir <= IF_ir;
			end
			else begin
				ID_ir <= ID_ir;
				ID_PC <= ID_PC;
			end
		end
	end


endmodule