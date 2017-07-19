// Controller
module Controller ( opcode,
					funct,
					// write your code in here
					//mux
					RegDst,
					ra,
					ALUSrc,
					lh,
					sh,
					MemToReg,
					Jal,
					//DM
					DM_enable,
					//Regfile
					RegWrite,
					//ALU
					ALUOp,
					//JumpCtrl
					JControl
					);

		input  [5:0] opcode;
    input  [5:0] funct;

		// write your code in here

		//mux
		output reg RegDst;
		output reg ra;
		output reg ALUSrc;
		output reg lh;
		output reg sh;
		output reg MemToReg;
		output reg Jal;
		//output
		output reg [3:0] ALUOp;
		output reg [2:0] JControl;
		output reg RegWrite;
		output reg DM_enable;

		always @(opcode or funct) begin
			if(opcode == 6'b000000) begin
				ra <= 0;
				RegWrite <= 0;
				Jal <= 0;
				JControl <= 6;  //normal
				case (funct)
					//R-format
					6'b100000:  //add
					begin
						RegDst <= 1;
						ALUSrc <= 1;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 2;
						DM_enable <= 0;
					end
					6'b100010:  //sub
					begin
						RegDst <= 1;
						ALUSrc <= 1;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 6;
						DM_enable <= 0;
					end
					6'b100100:  //and
					begin
						RegDst <= 1;
						ALUSrc <= 1;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 0;
						DM_enable <= 0;
					end
					6'b100101:  //or
					begin
						RegDst <= 1;
						ALUSrc <= 1;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 1;
						DM_enable <= 0;
					end
					6'b100110:  //xor
					begin
						RegDst <= 1;
						ALUSrc <= 1;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 10;
						DM_enable <= 0;
					end
					6'b100111:  //nor
					begin
						RegDst <= 1;
						ALUSrc <= 1;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 9;
						DM_enable <= 0;
					end
					6'b101010:  //slt
					begin
						RegDst <= 1;
						ALUSrc <= 1;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 7;
						DM_enable <= 0;
					end
					6'b000000:  //sll
					begin
						RegDst <= 1;
						ALUSrc <= 1;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 11;
						DM_enable <= 0;
					end
					6'b000010:  //srl
					begin
						RegDst <= 1;
						ALUSrc <= 1;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 12;
						DM_enable <= 0;
					end
					6'b001000:  //jr
					begin
						ra <= 0;
						Jal <= 0;
						RegWrite <= 0;
						JControl <= 0;
					end
					6'b001001:  //jalr
					begin
						ra <= 1;
						Jal <= 1;
						RegWrite <= 1;
						JControl <= 1;
					end
					default:;
				endcase
			end
			else begin
				Jal <= 0;
				JControl <= 6;  //normal
				RegWrite <= 0;
				ra <= 0;
				case (opcode)
					//I-format
					6'b001000:  //addi
					begin
						RegDst <= 0;
						ALUSrc <= 0;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 2;
						DM_enable <= 0;
					end
					6'b001100:  //andi
					begin
						RegDst <= 0;
						ALUSrc <= 0;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 0;
						DM_enable <= 0;
					end
					6'b001010:  //slti
					begin
						RegDst <= 0;
						ALUSrc <= 0;
						MemToReg <= 0;
						RegWrite <= 1;
						ALUOp <= 7;
						DM_enable <= 0;
					end
					6'b000100:  //beq
					begin
						ALUSrc <= 1;
						RegWrite <= 0;
						ALUOp <= 13;
						DM_enable <= 0;
						ra <= 0;
						Jal <= 0;
						JControl <= 2;
					end
					6'b000101:  //bne
					begin
						ALUSrc <= 1;
						RegWrite <= 0;
						ALUOp <= 13;
						DM_enable <= 0;
						ra <= 0;
						Jal <= 0;
						JControl <= 3;
					end
					6'b100011:  //lw
					begin
						RegDst <= 0;
						ALUSrc <= 0;
						MemToReg <= 1;
						RegWrite <= 1;
						ALUOp <= 2;
						lh <= 0;
						DM_enable <= 0;
						Jal <= 0;
					end
					6'b100001:  //lh
					begin
						RegDst <= 0;
						ALUSrc <= 0;
						MemToReg <= 1;
						RegWrite <= 1;
						ALUOp <= 2;
						lh <= 1;
						DM_enable <= 0;
						Jal <= 0;
					end
					6'b101011:  //sw
					begin
						ALUSrc <= 0;
						RegWrite <= 0;
						ALUOp <= 2;
						DM_enable <= 1;
						sh <= 0;
					end
					6'b101001:  //sh
					begin
						ALUSrc <= 0;
						RegWrite <= 0;
						ALUOp <= 2;
						DM_enable <= 1;
						sh <= 1;
					end
					//J-format
					6'b000010:  //j
					begin
						ra <= 0;
						Jal <= 0;
						RegWrite <= 0;
						JControl <= 4;
					end
					6'b000011:  //jal
					begin
						ra <= 1;
						Jal <= 1;
						RegWrite <= 1;
						JControl <= 5;
					end
					default:;
				endcase
			end
		end
endmodule
