// top

module top ( 
			 clk,
       rst,
			 // Instruction Memory
			 IM_Address,
       Instruction,
			 // Data Memory
			 DM_Address,
			 DM_enable,
			 DM_Write_Data,
			 DM_Read_Data);

	parameter data_size = 32;
	parameter mem_size = 16;

	input  clk, rst;

	// Instruction Memory
	output [mem_size-1:0] IM_Address;
	input  [data_size-1:0] Instruction;

	// Data Memory
	output [mem_size-1:0] DM_Address;
	output DM_enable;
	output [data_size-1:0] DM_Write_Data;
  input  [data_size-1:0] DM_Read_Data;

	// write your code here

	wire [17:0] pcout;
	reg [17:0] pcin;
	wire [17:0] add1;
	wire [data_size-1:0] add2;
	wire [data_size-1:0] rs;
	wire [data_size-1:0] rt;

	wire RegDst,ra,ALUSrc,lh,sh,MemToReg,Jal;

	wire [4:0] RtRd;
	wire [4:0] WR;

	wire [15:0] imm;
	wire [data_size-1:0] immSignExten;
	wire [data_size-1:0] RorI;
	wire [data_size-1:0] regWD;


	wire regWrite,Zero;

	wire [3:0] ALUOp;
	wire [data_size-1:0] ALU_result;

	wire [data_size-1:0] lworlh;
	wire [data_size-1:0] sworsh;
	wire [data_size-1:0] toreg;


	wire [2:0] JControl;
	wire [1:0] JumpOP;

	PC pc(.clk(clk),.rst(rst),
			.PCin(pcin),
			.PCout(pcout));

	assign IM_Address = pcout[17:2];
	assign add1 = pcout + 4;

	assign add2 = add1 + 4;

	assign imm = Instruction[15:0];
	assign immSignExten = (imm[15])?({16'hffff,imm}):({16'h0000,imm});

	assign DM_Address = ALU_result[17:2];
	assign DM_Write_Data = sworsh;



	Regfile regfile(.clk(clk),.rst(rst),
			.Read_addr_1(Instruction[25:21]),
			.Read_addr_2(Instruction[20:16]),
			.Read_data_1(rs),
      .Read_data_2(rt),
			.RegWrite(regWrite),
			.Write_addr(WR),
			.Write_data(regWD));

	Jump_Ctrl jump_ctrl(.Zero(Zero),.JumpOP(JumpOP),.JControl(JControl));

	ALU alu(
			.ALUOp(ALUOp),
			.src1(rs),
			.src2(RorI),
			.shamt(Instruction[10:6]),
			.ALU_result(ALU_result),
			.Zero(Zero));


	Controller controller(
			.opcode(Instruction[31:26]),
			.funct(Instruction[5:0]),
			//mux
			.RegDst(RegDst),
			.ra(ra),
			.ALUSrc(ALUSrc),
			.lh(lh),
			.sh(sh),
			.MemToReg(MemToReg),
			.Jal(Jal),
			//DM
			.DM_enable(DM_enable),
			//Regfile
			.RegWrite(regWrite),
			//ALU
			.ALUOp(ALUOp),
			//JumpCtrl
			.JControl(JControl));

	//mux
	assign RtRd = (RegDst)?(Instruction[15:11]):(Instruction[20:16]);
	assign WR = (ra)?(5'd31):(RtRd);
	assign RorI = (ALUSrc)?(rt):(immSignExten);
	assign sworsh = (sh)?((rt[15])?({16'hffff,rt[15:0]}):({16'h0000,rt[15:0]})):(rt);
	assign lworlh = (lh)?((DM_Read_Data[15])?({16'hffff,DM_Read_Data[15:0]}):({16'h0000,DM_Read_Data[15:0]})):(DM_Read_Data);
	assign toreg = (MemToReg)?(lworlh):(ALU_result);
	assign regWD = (Jal)?(add2):(toreg);


	//mux of jctrl
	always @(*) begin
		case (JumpOP)
			0: pcin <= add1;
			1: pcin <= add1 + (imm << 2);
			2: pcin <= rs[17:0];
			3: pcin <= (imm << 2);
		endcase
	end
endmodule
