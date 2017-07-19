// top

module top ( clk,
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
	
	// wire
	// for ADD
	wire [17:0] ADD1;
	wire [17:0] ADD2;
	wire [17:0] ADD3;

	// for PC
	wire [17:0] PCout;
	reg  [17:0] PCin;
	wire        PCWrite;

	// for IF_ID
	wire IF_IDWrite;
	wire IF_Flush;
	wire [17:0]   IF_PC;
	wire [data_size-1:0] IF_ir;	
	wire [17:0]   ID_PC;
	wire [data_size-1:0] ID_ir;

	// for Regfile
	wire [data_size-1:0] src1;
	wire [data_size-1:0] src2;
	wire RegWrite;
	wire [4:0] reg_write_addr;
	wire [data_size-1:0] reg_write_data;

	// for SignExtension
	wire [data_size-1:0] SignExtension1;
	wire [data_size-1:0] SignExtension2;
	wire [data_size-1:0] SignExtension3;

	// for Controller
	wire [6:0] mux;
	wire [2:0] J_Mode;

	// for ID_EX
	// WB
	wire ID_MemtoReg;
	wire ID_RegWrite;
	// M
	wire ID_MemWrite;
	wire ID_Jal;
	wire ID_Lh;
	wire ID_Sh;
	// EX
	wire ID_Reg_imm;
	//wire [17:0] ID_PC;
  wire [3:0] ID_ALUOp;
  wire [4:0] ID_shamt;
  wire [data_size-1:0] ID_Rs_data;
  wire [data_size-1:0] ID_Rt_data;
  wire [15:0] ID_imm;
  wire [data_size-1:0] ID_se_imm;
  wire [4:0] ID_WR_out;
  wire [4:0] ID_Rs;
  wire [4:0] ID_Rt;
	// output
	wire EX_MemtoReg;
	wire EX_RegWrite;
	// M
	wire EX_MemWrite;
	wire EX_Jal;
	wire EX_Lh;
	wire EX_Sh;
	// EX
	wire EX_Reg_imm;
	// pipe
	wire [2:0] EX_J_Mode;
	wire [17:0] EX_PC;
	wire [3:0] EX_ALUOp;
	wire [4:0] EX_shamt;
	wire [data_size-1:0] EX_Rs_data;
	wire [data_size-1:0] EX_Rt_data;
	wire [15:0] EX_imm;
	wire [data_size-1:0] EX_se_imm;
	wire [4:0] EX_WR_out;
	wire [4:0] EX_Rs;
	wire [4:0] EX_Rt;

	// for Forward
	// Forward
	wire ForwardA;
	wire ForwardB;
	wire ForwardC;
	wire ForwardD;
	// Forward_Out
	wire [data_size-1:0] ForwardA_Out;
	wire [data_size-1:0] ForwardB_Out;
	wire [data_size-1:0] ForwardC_Out;
	wire [data_size-1:0] ForwardD_Out;

	// for ALU
	wire [data_size-1:0] Reg_imm_Out;
	wire Zero;
	wire [3:0] ALUOp;
	wire [data_size-1:0] ALU_result;

	// for Jump_Ctrl
	wire [1:0] EX_JumpOP;

	// for EX_MEM
	// pipe		  
	wire [data_size-1:0] EX_ALU_result;
  wire [17:0] EX_PCplus8;
  //wire [4:0] EX_WR_out;
	
	// WB
	wire M_MemtoReg;	
	wire M_RegWrite;	
	// M	
	wire M_MemWrite;	
	// write your code in here
	// pipe		  
	wire [data_size-1:0] M_ALU_result;
	wire [data_size-1:0] M_Rt_data;
	wire [17:0] M_PCplus8;
	wire [4:0] M_WR_out;


	// RegDst
	wire [4:0] RegDst_Out;
	// wrAddress
	wire [4:0] wrAddress_Out;

	//SwSh_Out
	wire [data_size-1:0] SwSh_Out;
	//LwLh_Out
	wire [data_size-1:0] LwLh_Out;

	//MEM
	wire [data_size-1:0] Jal_Out;

	//MEM_WB
	wire [data_size-1:0] M_DM_Read_Data;
	wire [data_size-1:0] M_WD_out;
	// WB
	wire WB_MemtoReg;
	wire WB_RegWrite;
	// pipe
	wire [data_size-1:0] WB_DM_Read_Data;
	wire [data_size-1:0] WB_WD_out;
	wire [4:0] WB_WR_out;

	//WB
	wire [data_size-1:0] WB_Out;


	// set module
	// PC
	PC pc( 
			.clk(clk),
			.rst(rst),
			.PCWrite(PCWrite),
			.PCin(PCin),
			.PCout(PCout));
	// IF_ID
	IF_ID if_id(
			.clk(clk),
      .rst(rst),
			// input
			.IF_IDWrite(IF_IDWrite),
			.IF_Flush(IF_Flush),
			.IF_PC(IF_PC),
			.IF_ir(IF_ir),
			// output
			.ID_PC(ID_PC),
			.ID_ir(ID_ir));

	// Regfile
	Regfile regfile(
			.clk(clk),
			.rst(rst),
			.Read_addr_1(ID_ir[25:21]),
			.Read_addr_2(ID_ir[20:16]),
			.Read_data_1(src1),
      .Read_data_2(src2),
			.RegWrite(WB_RegWrite),
			.Write_addr(reg_write_addr),
			.Write_data(reg_write_data));

	// Controller
	Controller ctrler(
			.opcode(ID_ir[31:26]),
			.funct(ID_ir[5:0]),
			//mux
			.mux(mux),
			//DM(save enable)
			.DM_enable(ID_MemWrite),
			//Regfile(write enable)
			.RegWrite(RegWrite),
			//ALU
			.ALUOp(ALUOp),
			//JumpCtrl
			.J_Mode(J_Mode));

	// ID_EX
	ID_EX id_ex(
			.clk(clk),  
      .rst(rst),
      // input 
			.ID_Flush(ID_Flush),
			// WB
			.ID_MemtoReg(ID_MemtoReg),
			.ID_RegWrite(ID_RegWrite),
			// M
			.ID_MemWrite(ID_MemWrite),
			//
			.ID_Jal(ID_Jal),
			.ID_Lh(ID_Lh),
			.ID_Sh(ID_Sh),
			// EX
			.ID_Reg_imm(ID_Reg_imm),
			// pipe
			.ID_J_Mode(J_Mode),
			.ID_PC(ID_PC),
			.ID_ALUOp(ID_ALUOp),
			.ID_shamt(ID_shamt),
			.ID_Rs_data(ID_Rs_data),
			.ID_Rt_data(ID_Rt_data),
			.ID_imm(ID_imm),
			.ID_se_imm(ID_se_imm),
			.ID_WR_out(ID_WR_out),
			.ID_Rs(ID_Rs),
			.ID_Rt(ID_Rt),
			// output
			// WB
			.EX_MemtoReg(EX_MemtoReg),
			.EX_RegWrite(EX_RegWrite),
			// M
			.EX_MemWrite(EX_MemWrite),
			//
			.EX_Jal(EX_Jal),
			.EX_Lh(EX_Lh),
			.EX_Sh(EX_Sh),
			// EX
			.EX_Reg_imm(EX_Reg_imm),
			// pipe
			.EX_J_Mode(EX_J_Mode),
			.EX_PC(EX_PC),
			.EX_ALUOp(EX_ALUOp),
			.EX_shamt(EX_shamt),
			.EX_Rs_data(EX_Rs_data),
			.EX_Rt_data(EX_Rt_data),
			.EX_imm(EX_imm),
			.EX_se_imm(EX_se_imm),
			.EX_WR_out(EX_WR_out),
			.EX_Rs(EX_Rs),
			.EX_Rt(EX_Rt));

	// Jump_Ctrl
	Jump_Ctrl jCtrl(
			.Zero(Zero),
      .JumpOP(EX_JumpOP),
			.J_Mode(EX_J_Mode));

	// HDU
	HDU hdu(
			 // input
			 .ID_Rs(ID_Rs),
       .ID_Rt(ID_Rt),
			 .EX_WR_out(EX_WR_out),
			 .EX_MemtoReg(EX_MemtoReg),
			 .EX_JumpOP(EX_JumpOP),
			 // output
			 .PCWrite(PCWrite),
			 .IF_IDWrite(IF_IDWrite),
			 .IF_Flush(IF_Flush),
			 .ID_Flush(ID_Flush));

	// ALU
	ALU alu(
			.ALUOp(EX_ALUOp),
			.src1(ForwardB_Out),
			.src2(Reg_imm_Out),
			.shamt(EX_shamt),
			.ALU_result(ALU_result),
			.Zero(Zero));

	// EX_MEM
	EX_M ex_m(
			.clk(clk),
			.rst(rst),
			// input 
			// WB
			.EX_MemtoReg(EX_MemtoReg),
			.EX_RegWrite(EX_RegWrite),
			// M
			.EX_MemWrite(EX_MemWrite),
			//
			.EX_Jal(EX_Jal),
			.EX_Lh(EX_Lh),
			.EX_Sh(EX_Sh),
			// pipe
			.EX_ALU_result(EX_ALU_result),
			.EX_Rt_data(ForwardD_Out),
			.EX_PCplus8(EX_PCplus8),
			.EX_WR_out(EX_WR_out),
			// output
			// WB
			.M_MemtoReg(M_MemtoReg),
			.M_RegWrite(M_RegWrite),
			// M
			.M_MemWrite(M_MemWrite),
			//
			.M_Jal(M_Jal),
			.M_Lh(M_Lh),
			.M_Sh(M_Sh),
			// pipe
			.M_ALU_result(M_ALU_result),
			.M_Rt_data(M_Rt_data),
			.M_PCplus8(M_PCplus8),
			.M_WR_out(M_WR_out));

	// MEM_WB
	M_WB m_wb(
		.clk(clk),
    .rst(rst),
		// input 
		// WB
		.M_MemtoReg(M_MemtoReg),
		.M_RegWrite(M_RegWrite),
		// pipe
		.M_DM_Read_Data(M_DM_Read_Data),
		.M_WD_out(M_WD_out),
		.M_WR_out(M_WR_out),
		// output
		// WB
		.WB_MemtoReg(WB_MemtoReg),
		.WB_RegWrite(WB_RegWrite),
		// pipe
		.WB_DM_Read_Data(WB_DM_Read_Data),
		.WB_WD_out(WB_WD_out),
    .WB_WR_out(WB_WR_out));

	// FU
	FU fu(
			.EX_Rs(EX_Rs),
      .EX_Rt(EX_Rt),
			.M_RegWrite(M_RegWrite),
			.M_WR_out(M_WR_out),
			.WB_RegWrite(WB_RegWrite),
			.WB_WR_out(WB_WR_out),
			// output
			.ForwardA(ForwardA),
			.ForwardB(ForwardB),
			.ForwardC(ForwardC),
			.ForwardD(ForwardD));

	// assign
	// IM
	assign IM_Address = PCout[17:2];
	// ADD
	assign ADD1 = PCout + 4;
	assign ADD2 = EX_PC + 4;
	assign ADD3 = EX_PC + (EX_imm[15:0] << 2);
	// SignExtension
	assign SignExtension1 = (ID_ir[15])?({16'hffff,ID_ir[15:0]}):({16'h0000,ID_ir[15:0]});
	//Sh
	assign SignExtension2 = (M_Rt_data[15])?({16'hffff,M_Rt_data[15:0]}):({16'h0000,M_Rt_data[15:0]});
	//Lh
	assign SignExtension3 = (DM_Read_Data[15])?({16'hffff,DM_Read_Data[15:0]}):({16'h0000,DM_Read_Data[15:0]});

	// mux
	// RegDst
	assign RegDst_Out = (mux[6])?(ID_ir[15:11]):(ID_ir[20:16]);
	// wrAddress
	assign wrAddress_Out = (mux[5])?(5'd31):(RegDst_Out);

	// IF_ID
	assign IF_PC = ADD1;
	assign IF_ir = Instruction;


	// ID_EX
	assign ID_MemtoReg = mux[1];
	assign ID_RegWrite = RegWrite;
	// M
	//assign ID_MemWrite = DM_enable;
	//
	assign ID_Jal      = mux[0];
	assign ID_Lh       = mux[2];
	assign ID_Sh       = mux[3];
	// EX
	assign ID_Reg_imm  = mux[4];
	// pipe
	assign ID_ALUOp    = ALUOp;
	assign ID_shamt    = ID_ir[10:6];
	assign ID_Rs_data  = src1;
	assign ID_Rt_data  = src2;
	assign ID_imm      = ID_ir[15:0];
	assign ID_se_imm   = SignExtension1;
	assign ID_WR_out   = wrAddress_Out;
	assign ID_Rs       = ID_ir[25:21];
	assign ID_Rt       = ID_ir[20:16];

	// Forward
	assign ForwardA_Out = (ForwardA)?(WB_Out):(Jal_Out);
	assign ForwardB_Out = (ForwardB)?(EX_Rs_data):(ForwardA_Out);
	assign ForwardC_Out = (ForwardC)?(WB_Out):(Jal_Out);
	assign ForwardD_Out = (ForwardD)?(EX_Rt_data):(ForwardC_Out);

	// ALU
	assign Reg_imm_Out  = (EX_Reg_imm)?(EX_se_imm):(ForwardD_Out);

	// EX_MEM
	// pipe
	assign EX_ALU_result = ALU_result;
	assign EX_PCplus8    = ADD2;

	//DM
	assign DM_Address = M_ALU_result[17:2];
	assign DM_Write_Data = SwSh_Out;
	assign DM_enable = M_MemWrite;

	//SwSh
	assign SwSh_Out = (M_Sh)?(SignExtension2):(M_Rt_data);
	//LwLh
	assign LwLh_Out = (M_Lh)?(SignExtension3):(DM_Read_Data);

	//MEM
	assign Jal_Out = (M_Jal)?(M_PCplus8):(M_ALU_result);

	//MEM_WB
	assign M_DM_Read_Data = LwLh_Out;
	assign M_WD_out = Jal_Out;

	//WB
	assign WB_Out = (WB_MemtoReg)?(WB_WD_out):(WB_DM_Read_Data);

	//
	assign reg_write_addr = WB_WR_out;
	assign reg_write_data = WB_Out;

	
	always @(*) begin
		// 4 to 1 mux
		case(EX_JumpOP)
			0: PCin <= ADD1;
			1: PCin <= ADD3; 
			2: PCin <= ForwardB_Out[17:0];
			3: PCin <= (EX_imm[15:0] << 2);
		endcase
	end
endmodule


























