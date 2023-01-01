module FPU(input [63:0] A, input [63:0] B, input clk, nreset, input[1:0] operation, fpuType, input ,output [63:0] Result, output Done);

	localparam SP = 2'd0;
	localparam DP = 2'd1;
	localparam IDLE = 2'd2;
	
	reg [1:0] state_reg;
	reg [1:0] state_next;
	
	always@(posedge clk, posedge reset) begin
		if(nreset) 
			state_reg <= IDLE;
		else
			state_reg <= state_next;
	end
	
	always@( operation, state_reg, fpuType, A, B) begin //sw
		//switch case on the type of operation
		case(fpuType)
			IDLE: begin
				if(!fpuType)
					state_next = SP;
				else
					state_next = DP;
			end
			SP: begin //32bit
				case (operation)
					2'b00 : begin //clk, en, rst , load, 0, A, B, cin, result, cout, Done 
						
					end
					2'b01 : begin //clk, en, rst , load, 1, A, B, cin, result, cout, Done 
						
					end
					2'b10 : begin //clk , en, rst, load, A, B, result
						
					end
					2'b11 : begin //clk , en , rst, load, loadA, loadN, N, D, result
						
					end	
					default : begin
						
					end
				endcase
			end
			DP: begin //64 bit
				case (operation)
					2'b00 : begin
						
					end
					2'b01 : begin
						
					end
					2'b10 : begin
						
					end
					2'b11 : begin
						
					end	
					default : begin
						
					end
				endcase
			end
		endcase
	end
endmodule
