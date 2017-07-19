// Cache Control

module Cache_Control ( 
					   clk,
					   rst,
					   // input
					   en_R,
					   en_W,
					   hit,
					   // output
					   Read_mem,
					   Write_mem,
					   Valid_enable,
					   Tag_enable,
					   Data_enable,
					   sel_mem_core,
					   stall
					   );
	
	input clk, rst;
	input en_R;
	input en_W;
  input hit;
	
	output reg Read_mem;
	output reg Write_mem;
	output reg Valid_enable;
	output reg Tag_enable;
	output reg Data_enable;
	output reg sel_mem_core;		// 0 data from mem, 1 data from core
	output reg stall;
	
	// write your code here

	// state
	parameter Idle		   = 0,
			  		Wait       = 1,
			  		Read_data  = 2;
	
	reg [1:0] nxt_state;
	reg [1:0] cur_state;
	// FSM
	always @ (*) begin
		case (cur_state)
		Idle		   : nxt_state <= !hit ? Wait : Idle;
		Wait       : nxt_state <= Read_data;
		Read_data	 : nxt_state <= Idle;
		endcase
	end	

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			// reset
			cur_state       <= Idle;
			Read_mem        <= 0;
			Write_mem       <= 0;
			Valid_enable    <= 0;
			Tag_enable      <= 0;
			Data_enable     <= 0;
			sel_mem_core    <= 0;
			stall           <= 0;
		end
		else begin
			Read_mem        <= 0;
			Write_mem       <= 0;
			Valid_enable    <= 0;
			Tag_enable      <= 0;
			Data_enable     <= 0;
			sel_mem_core    <= 0;
			stall           <= 0;
			// read 
			if (en_R) begin
				case (cur_state)
					Idle: begin
						Read_mem <= ~hit;
					end
					Wait: begin
						stall <= 1;
					end
					Read_data: begin
						Valid_enable <= 1;
						Tag_enable   <= 1;
						Data_enable  <= 1;
						stall        <= 1;
					end
				endcase
				cur_state <= nxt_state;
			end
			// write
			else if (en_W) begin
				// write hit
				if(hit) begin
					Write_mem       <= 1;
					Valid_enable    <= 1;
					Tag_enable      <= 1;
					Data_enable     <= 1;
					sel_mem_core    <= 1;
					stall           <= 1;
				end
				// write miss
				else begin
					Write_mem       <= 1;
					Valid_enable    <= 0;
					Tag_enable      <= 0;
					Data_enable     <= 0;
					sel_mem_core    <= 1;
					stall           <= 1;
				end
			end
		end
	end


endmodule



















