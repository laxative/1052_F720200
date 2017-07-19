// Program Counter

module PC ( clk,
			rst,
			PCWrite,
			PCin,
			PCout);
	
	parameter bit_size = 18;

	input  clk, rst;
	input  PCWrite;
	input  [bit_size-1:0] PCin;
	output reg [bit_size-1:0] PCout;

	// write your code in here

	always @(negedge clk or rst) begin
		if (rst) begin
			// reset
			PCout <= 0;
		end
		else begin
			if(PCWrite) begin
				PCout <= PCin;
			end
			else begin
				PCout <= PCout;
			end
		end
	end

endmodule
