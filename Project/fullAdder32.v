module fullAdder32 (input wire clk,input wire en, input wire rst,input wire load, input wire PlusOrMinus,input wire [23:0] A, input wire [23:0] B, 
input wire signA, input wire signB, input wire c_in, output wire [23:0] sum , output wire c_out, output wire signS);
	
	//declare registers for each wire with its value going to be changed
	reg [23:0] Ai; 
	reg [23:0] Bi;
	reg sA;
	reg sB;
	reg PlusOrMinusi; // 0 means addition and 1 means subtraction
	reg [23:0] sumi;
	reg c_outi;
	reg sS;
	
	always@(posedge clk) begin
		if(rst == 1) begin // if reset is on all is zero
			Ai<=0;
			Bi<=0;
			sA<=0;
			sB<=0;
			PlusOrMinusi<=0;
			sumi<=0;
			c_outi<=0;
			sS<=0;
		end
		else begin
			if(en == 1) begin //if en is on check for load if load is on accept user input else start operating
				if(load == 1) begin // accept user input
					Ai<=A;
					Bi<=B;
					sA<=signA;
					sB<=signB;
					PlusOrMinusi<=PlusOrMinus;
				end
				else begin
					if(!PlusOrMinusi) begin
						if(signA == signB) begin
							{c_outi,sumi} <= (!rst && !load)? Ai + Bi + c_in : 0;
							sS <= (sA & sB);
							sumi <= (sS) ? ~(sumi) + 1'b1 : sumi;
						end
						else begin
							if(signA) begin
							{c_outi,sumi} <= (!rst && !load)? Bi - Ai - c_in : 0;
							sS <= (Ai<=Bi) ? 1'b0 : 1'b1;
							sumi <= (sS) ? ~(sumi) + 1'b1 : sumi;
							end
							else if(signB) begin
							{c_outi,sumi} <= (!rst && !load)? Ai - Bi - c_in : 0;
							sS <= (Bi<=Ai) ? 1'b0 : 1'b1;
							sumi <= (sS) ? ~(sumi) + 1'b1 : sumi;
							end
						end
					end
					else begin
						if(signA == signB) begin
							if(signA) begin
								{c_outi,sumi} <= (!rst && !load)? Bi - Ai - c_in : 0;
								sS <= (Ai<=Bi) ? 1'b0 : 1'b1;
								sumi <= (sS) ? ~(sumi)+1'b1 : sumi;
							end
							else if(signB) begin
								{c_outi,sumi} <= (!rst && !load)? Ai - Bi - c_in : 0;
								sS <= (Bi<=Ai) ? 1'b0 : 1'b1;
								sumi <= (sS) ? ~(sumi)+1'b1 : sumi;
							end
						end
						else begin
							if(signA == 1'b1) begin
								{c_outi,sumi} <= (!rst && !load)? Ai + Bi + c_in : 0;
								sS <= 1'b1;
								sumi <= ~(sumi)+1'b1;
							end
							else if(signB == 1'b1) begin
								{c_outi,sumi} <= (!rst && !load)? Ai + Bi + c_in : 0;
								sS <= 1'b0;
								sumi <= (sS) ? ~(sumi) + 1'b1 : sumi;
							end
						end
					end
				end
			end
		end
	end
	assign {c_out,sum} = {c_outi,sumi};
	
	assign signS = sS;
	//we need denormalization
	//after addition if unseen is 0 shift right until unseen is 1
	//in subtarction shift left until unseen is 1 
	//if in subtraction unseen is 1 shift left inly one time
endmodule
