// M_WB

module M_WB ( clk,
              rst,
			  // input 
			  // WB
			  M_MemtoReg,
			  M_RegWrite,
			  // pipe
			  M_DM_Read_Data,
			  M_WD_out,
			  M_WR_out,
			  // output
			  // WB
			  WB_MemtoReg,
			  WB_RegWrite,
			  // pipe
			  WB_DM_Read_Data,
			  WB_WD_out,
        WB_WR_out
			  );
	
	parameter data_size = 32;
	
	input clk, rst;
	
	// WB
    input M_MemtoReg;	
    input M_RegWrite;	
	// pipe
    input [data_size-1:0] M_DM_Read_Data;
    input [data_size-1:0] M_WD_out;
    input [4:0] M_WR_out;

	// WB
	output reg WB_MemtoReg;
	output reg WB_RegWrite;
	// pipe
    output reg [data_size-1:0] WB_DM_Read_Data;
    output reg [data_size-1:0] WB_WD_out;
    output reg [4:0] WB_WR_out;
    
	// write your code in here
	always @(negedge clk or rst) begin
		if (rst) begin
			// reset
			WB_MemtoReg     <= 0;
			WB_RegWrite     <= 0;
			WB_DM_Read_Data <= 0;
			WB_WD_out       <= 0;
			WB_WR_out       <= 0;
		end
		else begin
			WB_MemtoReg     <= M_MemtoReg;
			WB_RegWrite     <= M_RegWrite;
			WB_DM_Read_Data <= M_DM_Read_Data;
			WB_WD_out       <= M_WD_out;
			WB_WR_out       <= M_WR_out;
		end
	end
endmodule












