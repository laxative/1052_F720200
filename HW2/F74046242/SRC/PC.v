// Program Counter

module PC ( clk,
			rst,
			PCin,
			PCout);
	
	parameter bit_size = 18;

	input  clk, rst;
	input  [bit_size-1:0] PCin;
	output reg [bit_size-1:0] PCout;

	// write your code in here

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			// reset
			PCout <= 0;
		end
		else begin
			PCout <= PCin;
		end
	end

endmodule
