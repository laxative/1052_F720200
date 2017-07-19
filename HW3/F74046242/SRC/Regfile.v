// Regfile

module Regfile ( clk,
				 rst,
				 Read_addr_1,
				 Read_addr_2,
				 Read_data_1,
         Read_data_2,
				 RegWrite,
				 Write_addr,
				 Write_data);

	parameter bit_size = 32;

	input  clk, rst;
	input  [4:0] Read_addr_1;
	input  [4:0] Read_addr_2;

	output [bit_size-1:0] Read_data_1;  //rs
	output [bit_size-1:0] Read_data_2;  //rt

	input  RegWrite;
	input  [4:0] Write_addr;
	input  [bit_size-1:0] Write_data;

  // write your code in here
  
  reg [bit_size-1:0] reg_data [0:bit_size-1];
  integer i;

  assign Read_data_1 = reg_data[Read_addr_1];
  assign Read_data_2 = reg_data[Read_addr_2];
  always @(posedge clk or rst) begin
  	if (rst) begin
  		// reset
  		for(i=0;i<bit_size;i=i+1)
  			reg_data[i] <= 0;
  	end
  	else if (RegWrite) begin
  		reg_data[Write_addr] <= Write_data;
  	end
  end
endmodule
