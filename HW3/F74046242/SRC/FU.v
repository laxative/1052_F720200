// Forwarding Unit

module FU ( // input 
			EX_Rs,
      EX_Rt,
			M_RegWrite,
			M_WR_out,
			WB_RegWrite,
			WB_WR_out,
			// output
			// write your code in here
			ForwardA,
			ForwardB,
			ForwardC,
			ForwardD
			);

	input [4:0] EX_Rs;
  input [4:0] EX_Rt;
  input M_RegWrite;
  input [4:0] M_WR_out;
  input WB_RegWrite;
  input [4:0] WB_WR_out;

	// write your code in here

	output reg ForwardA, ForwardB, ForwardC, ForwardD;
	always @(*) begin
		// 0 goes top and 1 goes bottom
		// EX forward

		// default
		ForwardA <= 0;
		ForwardB <= 1;
		ForwardC <= 0;
		ForwardD <= 1;
		// WB Forwarding
		if(WB_RegWrite) begin
			if(WB_WR_out != 0 && WB_WR_out == EX_Rs) begin
				ForwardA <= 1;
				ForwardB <= 0;
			end
			if(WB_WR_out != 0 && WB_WR_out == EX_Rt) begin
				ForwardC <= 1;
				ForwardD <= 0;
			end
		end
		// Mem Forwarding
		if(M_RegWrite) begin
			if(M_WR_out != 0 && M_WR_out == EX_Rs) begin
				ForwardA <= 0;
				ForwardB <= 0;
			end
			if(M_WR_out != 0 && M_WR_out == EX_Rt) begin
				ForwardC <= 0;
				ForwardD <= 0;
			end
		end
	end


endmodule




























