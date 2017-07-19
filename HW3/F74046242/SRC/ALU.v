// ALU

module ALU ( ALUOp,
			 src1,
			 src2,
			 shamt,
			 ALU_result,
			 Zero);
	
	parameter bit_size = 32;
	
	input [3:0] ALUOp;
	input [bit_size-1:0] src1;
	input [bit_size-1:0] src2;
	input [4:0] shamt;
	
	output reg[bit_size-1:0] ALU_result;
	output Zero;
	
	assign Zero = (ALU_result == 0);
	// write your code in here
	always @(ALUOp or src1 or src2) begin
		case (ALUOp)
			4'd0: ALU_result <= src1 & src2;            //and
			4'd1: ALU_result <= src1 | src2;            //or
			4'd2: ALU_result <= src1 + src2;            //add
			4'd6: ALU_result <= src1 - src2;            //sub
			4'd7: ALU_result <= (src1 - src2) >> 31;    //slt
			4'd9: ALU_result <= ~(src1 | src2);         //nor
			4'd10: ALU_result <= src1 ^ src2;           //xor
			4'd11: ALU_result <= src2 << shamt;         //sll
			4'd12: ALU_result <= src2 >> shamt;         //srl
			4'd13: ALU_result <= (src1 == src2);        //equal
			default: ALU_result <= 0;
		endcase
	end
endmodule





