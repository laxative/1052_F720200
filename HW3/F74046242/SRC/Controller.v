// Controller
module Controller ( 
					opcode,
					funct,
					// write your code in here
					//mux
					mux,
					//DM(save enable)
					DM_enable,
					//Regfile(write enable)
					RegWrite,
					//ALU
					ALUOp,
					//JumpCtrl
					J_Mode
					);

		input  [5:0] opcode;
    input  [5:0] funct;

		// write your code in here

		//mux
 
		/* mux
		*  0 always goes top line
		*  1 always goes bottom line
		*  mux[6] RegDst
		*  mux[5] wrAddress
		*  mux[4] RegImm
		*  mux[3] define sw or sh
		*  mux[2] define lw or lh
		*  mux[1]	MemtoReg
		*  mux[0] define Jal or not
		*/

		output reg [6:0] mux;

		//output
		output reg [3:0] ALUOp;
		output reg [2:0] J_Mode;
		output reg RegWrite;
		output reg DM_enable;

		always @(*) begin
			if(opcode == 6'b000000) begin
				case (funct)
					//J_Mode = 7  => default
					//ALUOp  = 15 => default
					//mux default => 0
					//RegWrite    => 0
					//DM_enable   => 0

					//R-format
					6'b100000:  //add
					begin
						mux <= 7'b1000010;
						ALUOp <= 2;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b100010:  //sub
					begin
						mux <= 7'b1000010;
						ALUOp <= 6;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b100100:  //and
					begin
						mux <= 7'b1000010;
						ALUOp <= 0;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b100101:  //or
					begin
						mux <= 7'b1000010;
						ALUOp <= 1;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b100110:  //xor
					begin
						mux <= 7'b1000010;
						ALUOp <= 10;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b100111:  //nor
					begin
						mux <= 7'b1000010;
						ALUOp <= 9;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b101010:  //slt
					begin
						mux <= 7'b1000010;
						ALUOp <= 7;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b000000:  //sll
					begin
						mux <= 7'b1000010;
						ALUOp <= 11;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b000010:  //srl
					begin
						mux <= 7'b1000010;
						ALUOp <= 12;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b001000:  //jr
					begin
						mux <= 7'b1010010;
						ALUOp <= 15;
						RegWrite <= 0;
						DM_enable <= 0;
						J_Mode <= 0;
					end
					6'b001001:  //jalr
					begin
						mux <= 7'b1110011;
						ALUOp <= 15;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 1;
					end
					default:
					begin
						RegWrite    <= 0;
						DM_enable   <= 0;
					end
				endcase
			end
			else begin
				case (opcode)
					//I-format
					6'b001000:  //addi
					begin
						mux <= 7'b0010010;
						ALUOp <= 2;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b001100:  //andi
					begin
						mux <= 7'b0010010;
						ALUOp <= 0;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b001010:  //slti
					begin
						mux <= 7'b0010010;
						ALUOp <= 7;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b000100:  //beq
					begin
						mux <= 7'b0000010;
						ALUOp <= 13;
						RegWrite <= 0;
						DM_enable <= 0;
						J_Mode <= 2;
					end
					6'b000101:  //bne
					begin
						mux <= 7'b0000010;
						ALUOp <= 13;
						RegWrite <= 0;
						DM_enable <= 0;
						J_Mode <= 3;
					end
					6'b100011:  //lw
					begin
						mux <= 7'b0010000;
						ALUOp <= 2;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b100001:  //lh
					begin
						mux <= 7'b0010100;
						ALUOp <= 2;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 7;
					end
					6'b101011:  //sw
					begin
						mux <= 7'b0010010;
						ALUOp <= 2;
						RegWrite <= 0;
						DM_enable <= 1;
						J_Mode <= 7;
					end
					6'b101001:  //sh
					begin
						mux <= 7'b0011010;
						ALUOp <= 2;
						RegWrite <= 0;
						DM_enable <= 1;
						J_Mode <= 7;
					end
					//J-format
					6'b000010:  //j
					begin
						mux <= 7'b0010010;
						ALUOp <= 15;
						RegWrite <= 0;
						DM_enable <= 0;
						J_Mode <= 4;
					end
					6'b000011:  //jal
					begin
						mux <= 7'b0110011;
						ALUOp <= 15;
						RegWrite <= 1;
						DM_enable <= 0;
						J_Mode <= 5;
					end
					default:
					begin
						RegWrite    <= 0;
						DM_enable   <= 0;
					end
				endcase
			end
		end
endmodule
