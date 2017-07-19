// Jump_Ctrl

module Jump_Ctrl( Zero,
                  JumpOP,
				  // write your code in here
				  JControl
				  );

  input Zero;
	output reg [1:0] JumpOP;
	// write your code in here
	input [2:0] JControl;
	
	always @(*) begin
		case (JControl)
			3'd0: JumpOP <= 2;  //jr
			3'd1: JumpOP <= 2;  //jalr
			3'd2:  //beq
			begin 
				if(Zero == 0) begin
					JumpOP <= 1;
				end
				else begin
					JumpOP <= 0;
				end
			end  
			3'd3:  //bne
			begin
			 	if(Zero != 0) begin
			 		JumpOP <= 1;
			 	end
			 	else begin
			 		JumpOP <= 0;
			 	end
			end
			3'd4: JumpOP <= 3;  //j
			3'd5: JumpOP <= 3;  //jal
			default: JumpOP <= 0;
		endcase
	end

endmodule
