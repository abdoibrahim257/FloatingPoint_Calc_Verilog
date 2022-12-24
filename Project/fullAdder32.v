module fullAdder32 (input wire rst,input wire clk, input wire load,input wire en, input wire PlusOrMinus,input wire [22:0] A, input wire [22:0] B, 
input wire signA, input wire signB, input wire c_in, output wire [22:0] sum , output wire c_out);
	

	reg [22:0] Ai;
	reg [22:0] Bi;
	reg sA;
	reg sB;
	reg PlusOrMinusi;
	always@(posedge clk) begin
		if(rst == 1) begin
			Ai<=0;
			Bi<=0;
			sA<=0;
			sB<=0;
		end
		else begin
			if(en == 1) begin
				if(load == 1) begin
					Ai<=A;
					Bi<=B;
					sA<=signA;
					sB<=signB;
					PlusOrMinusi<=PlusOrMinus; 
				end
				else begin
					if(sA == 1) begin
						Ai<= ~(Ai) + 1'b1;
						sA<=1'b0;
					end
					if(sB == 1) begin
						Bi<= ~(Bi) + 1'b1;
						sB<=1'b0;					
					end
					else if(PlusOrMinusi == 1) begin
						Bi<= ~(Bi) + 1'b1;
						PlusOrMinusi <= 1'b0;
					end
				end
			end
		end
	end
	assign {c_out,sum} = (load == 0 && rst == 0) ? Ai + Bi + c_in : 0;
	
endmodule
