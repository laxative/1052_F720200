// ID_EX

module ID_EX ( clk,  
               rst,
               // input 
			   ID_Flush,
			   // WB
			   ID_MemtoReg,
			   ID_RegWrite,
			   // M
			   ID_MemRead,
			   ID_MemWrite,
			   // write your code in here
			   ID_Jal,
			   ID_Lh,
			   ID_Sh,
			   // EX
			   ID_Reg_imm,
			   // write your code in here
			   ID_J_Mode,	   
			   // pipe
			   ID_PC,
			   ID_ALUOp,
			   ID_shamt,
			   ID_Rs_data,
			   ID_Rt_data,
			   ID_imm,
			   ID_se_imm,
			   ID_WR_out,
			   ID_Rs,
			   ID_Rt,
			   // output
			   // WB
			   EX_MemtoReg,
			   EX_RegWrite,
			   // M
			   EX_MemRead,
			   EX_MemWrite,
			   // write your code in here
			   EX_Jal,
			   EX_Lh,
			   EX_Sh,
			   // EX
			   EX_Reg_imm,
			   // write your code in here
			   // pipe
			   EX_J_Mode,
			   EX_PC,
			   EX_ALUOp,
			   EX_shamt,
			   EX_Rs_data,
			   EX_Rt_data,
			   EX_imm,
			   EX_se_imm,
			   EX_WR_out,
			   EX_Rs,
			   EX_Rt);
	
	parameter pc_size = 18;			   
	parameter data_size = 32;
	
	input clk, rst;
	input ID_Flush;
	
	// WB
	input ID_MemtoReg;
	input ID_RegWrite;
	// M
	input ID_MemRead;
	input ID_MemWrite;
	// write your code in here
	input ID_Jal;
	input ID_Lh;
	input ID_Sh;
	// EX
	input ID_Reg_imm;
	// write your code in here
	// pipe
	input [2:0] ID_J_Mode;
  input [pc_size-1:0] ID_PC;
  input [3:0] ID_ALUOp;
  input [4:0] ID_shamt;
  input [data_size-1:0] ID_Rs_data;
  input [data_size-1:0] ID_Rt_data;
  input [15:0] ID_imm;
  input [data_size-1:0] ID_se_imm;
  input [4:0] ID_WR_out;
  input [4:0] ID_Rs;
  input [4:0] ID_Rt;
	
	// WB
	output reg EX_MemtoReg;
	output reg EX_RegWrite;
	// M
	output reg EX_MemRead;
	output reg EX_MemWrite;
	// write your code in here
	output reg EX_Jal;
	output reg EX_Lh;
	output reg EX_Sh;
	// EX
	output reg EX_Reg_imm;
	// write your code in here
	// pipe
	output reg [2:0] EX_J_Mode;
	output reg [pc_size-1:0] EX_PC;
	output reg [3:0] EX_ALUOp;
	output reg [4:0] EX_shamt;
	output reg [data_size-1:0] EX_Rs_data;
	output reg [data_size-1:0] EX_Rt_data;
	output reg [15:0] EX_imm;
	output reg [data_size-1:0] EX_se_imm;
	output reg [4:0] EX_WR_out;
	output reg [4:0] EX_Rs;
	output reg [4:0] EX_Rt;
	
	// write your code in here
	always @(negedge clk or rst) begin
		if (rst) begin
			// reset
			EX_MemtoReg <= 0;
			EX_RegWrite <= 0;
			EX_MemRead  <= 0;
			EX_MemWrite <= 0;
			EX_Jal      <= 0;
			EX_Lh       <= 0;
			EX_Sh       <= 0;
			EX_Reg_imm  <= 0;
			EX_J_Mode   <= 7;
			EX_PC       <= 0;
			EX_ALUOp    <= 0;
			EX_shamt    <= 0;
			EX_Rs_data  <= 0;
			EX_Rt_data  <= 0;
			EX_imm      <= 0;
			EX_se_imm   <= 0;
			EX_WR_out   <= 0;
			EX_Rs       <= 0;
			EX_Rt       <= 0;
		end
		else begin
			if (ID_Flush) begin
				EX_MemtoReg <= 0;
				EX_RegWrite <= 0;
				EX_MemRead  <= 0;
				EX_MemWrite <= 0;
				EX_Jal      <= 0;
				EX_Lh       <= 0;
				EX_Sh       <= 0;
				EX_Reg_imm  <= 0;
				EX_J_Mode   <= 7;
				EX_PC       <= 0;
				EX_ALUOp    <= 0;
				EX_shamt    <= 0;
				EX_Rs_data  <= 0;
				EX_Rt_data  <= 0;
				EX_imm      <= 0;
				EX_se_imm   <= 0;
				EX_WR_out   <= 0;
				EX_Rs       <= 0;
				EX_Rt       <= 0;
			end
			else begin
				EX_MemtoReg <= ID_MemtoReg;
				EX_RegWrite <= ID_RegWrite;
				EX_MemRead  <= ID_MemRead;
				EX_MemWrite <= ID_MemWrite;
				EX_Jal      <= ID_Jal;
				EX_Lh       <= ID_Lh;
				EX_Sh       <= ID_Sh;
				EX_Reg_imm  <= ID_Reg_imm;
				EX_J_Mode   <= ID_J_Mode;
				EX_PC       <= ID_PC;
				EX_ALUOp    <= ID_ALUOp;
				EX_shamt    <= ID_shamt;
				EX_Rs_data  <= ID_Rs_data;
				EX_Rt_data  <= ID_Rt_data;
				EX_imm      <= ID_imm;
				EX_se_imm   <= ID_se_imm;
				EX_WR_out   <= ID_WR_out;
				EX_Rs       <= ID_Rs;
				EX_Rt       <= ID_Rt;
			end
		end
	end
endmodule










