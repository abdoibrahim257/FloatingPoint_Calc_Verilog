module fullAdder32 (input wire clk,input wire en, input wire rst,input wire load, input wire PlusOrMinus,input wire [23:0] A, input wire [23:0] B,
input wire signA, input wire signB, input wire c_in, output wire [23:0] sum ,output wire c_out, output wire signS, output wire ready);
	
	//declare registers for each wire with its value going to be changed
	reg [23:0] Ai; 
	reg [23:0] Bi;
	reg sA;
	reg sB;
	reg PlusOrMinusi; // 0 means addition and 1 means subtraction
	reg [23:0] sumi;
	reg c_outi;
	reg sS;
	reg readyi;
	
	reg ld;
	reg ld2;
	reg flag = 1'b1;
	
	always@(load, flag) begin
		if(flag && load)
			ld2 <= load;
		else
			ld2<=0;
	end
	
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
			readyi<=1'b0;
		end
		else begin
			if(en == 1) begin //if en is on check for load if load is on accept user input else start operating
				ld <= ld2;
				if(ld == 1) begin // accept user input
					Ai<=A;
					Bi<=B;
					sA<=signA;
					sB<=signB;
					PlusOrMinusi<=PlusOrMinus;
					readyi<=1'b0;
					flag <= 1'b0;
				end
				else begin
					if(!PlusOrMinusi) begin
						if(signA == signB) begin
							{c_outi,sumi} <= (!rst & !ld)? Ai + Bi + c_in : 0;
							sS <= (sA & sB);
							readyi<=1'b1;
						end
						else begin
							if(signA) begin
							{c_outi,sumi} <= (!rst & !ld)? Bi - Ai - c_in : 0;
							sS <= (Ai<=Bi) ? 1'b0 : 1'b1;
							c_outi<=1'b0;
							readyi<=1'b1;
							end
							else if(signB) begin
							{c_outi,sumi} <= (!rst & !ld)? Ai - Bi - c_in : 0;
							sS <= (Bi<=Ai) ? 1'b0 : 1'b1;
							
							c_outi<=1'b0;
							readyi<=1'b1;
							end
						end
					end
					else if (PlusOrMinusi) begin
						if(signA == signB) begin
							if(!signA) begin
								{c_outi,sumi} <= (!rst & !ld)? Ai - Bi - c_in : 0;
								sS <= (Bi<=Ai) ? 1'b0 : 1'b1;
								
								c_outi<=1'b0;
								readyi<=1'b1;
							end
							else if(signA) begin
								{c_outi,sumi} <= (!rst & !ld)? Bi - Ai - c_in : 0;
								sS <= (Ai<=Bi) ? 1'b0 : 1'b1;
								
								c_outi<=1'b0;
								readyi<=1'b1;
							end
						end
						else begin
							if(signA == 1'b1) begin
								{c_outi,sumi} <= (!rst & !ld)? Ai + Bi + c_in : 0;
								sS <= 1'b1;
								readyi<=1'b1;
							end
							else if(signB == 1'b1) begin
								{c_outi,sumi} <= (!rst & !ld)? Ai + Bi + c_in : 0;
								sS <= 1'b0;
								readyi<=1'b1;
							end
						end
					end
				end
			end
		end
	end

	assign {c_out,sum} = {c_outi,sumi};
	assign signS = sS;
	assign ready = readyi;
endmodule
