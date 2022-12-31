module fullAdder32 (input wire clk,input wire en, input wire rst,input wire load, input wire PlusOrMinus,input wire [22:0] A, input wire [22:0] B, 
input wire signA, input wire signB,input wire uA,uB , input wire c_in, output wire [22:0] sum , output wire c_out, output wire signS);
	
	//declare registers for each wire with its value going to be changed
	reg [22:0] Ai; 
	reg [22:0] Bi;
	reg sA;
	reg sB;
	reg PlusOrMinusi; // 0 means addition and 1 means subtraction
	reg [22:0] sumi;
	reg c_outi;
	reg sS;
	reg UnseenA,UnseenB,UnseenS;
	
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
			UnseenA <= 1'b1;
			UnseenB <= 1'b1;
		end
		else begin
			if(en == 1) begin //if en is on check for load if load is on accept user input else start operating
				if(load == 1) begin // accept user input
					Ai<=A;
					Bi<=B;
					sA<=signA;
					sB<=signB;
					PlusOrMinusi<=PlusOrMinus;
					UnseenA <= uA;
					UnseenB <= uB;
				end
				else begin
					if(sA == 1) begin // if A is negative turn it to its 2's complement and make its sign reg positive
						Ai<= ~(Ai) + 1'b1;
						sA<=1'b0;
					end
					else if(sB == 1 && PlusOrMinusi == 1) begin // if A -- B make no changes to B and make operation register and sign of B zero
						Bi <= Bi;
						sB <= 1'b0;
						PlusOrMinusi <= 1'b0;
					end
					else if(sB == 1) begin // if B is negative turn it to its 2's complement and make its sign reg positive 
						Bi<= ~(Bi) + 1'b1;
						sB<=1'b0;					
					end
					else if(PlusOrMinusi == 1) begin // if we are subtracting turn B to its 2's complement and make its sign reg positive A-B = A + -B
						Bi<= ~(Bi) + 1'b1;
						PlusOrMinusi <= 1'b0;
					end
				end
			end
		end
		//sign bit assignment and removing 2's compliment from mantissa if applicable
		if(!PlusOrMinus) begin //if it is addition
			if(signA == signB) begin // if both have the same sign
				if(!signA) begin // if both are +ve then sum is +ve
					{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
					UnseenS <= UnseenA + UnseenB + c_outi;
					sS <= 0;
				end
				else begin // if both are -ve then sum is -ve and needs to be 2's complemented
					{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
					sumi <= ~(sumi) + 1;
					UnseenS = c_outi + UnseenA +UnseenB;
					sS <= 1;
				end
			end
			else begin //if they are not equal
				if(!signA && signB) begin //if A is +ve and B is -ve
					if(Ai >= Bi) begin //if A is larger than or equal B then sum is +ve
						{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
						UnseenS = c_outi + UnseenA +UnseenB;
						sS <= 0;						
					end
					else if(Ai < Bi) begin //if A is smaller than B then sum is -ve and needs to be 2's complemented
						{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
						sumi <= ~(sumi) + 1;
						UnseenS = c_outi + UnseenA +UnseenB;
						sS <= 1;
					end
				end
				else if(signA && !signB) begin //if A is -ve and B is +ve
					if(Ai >= Bi) begin //if A is larger than or equal B then sum is -ve and needs to be 2's complemented
						{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
						sumi <= ~(sumi) + 1;
						UnseenS = c_outi + UnseenA +UnseenB;
						sS <= 1;						
					end
					else if(Ai < Bi) begin //if A is smaller than B then sum is +ve
						{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
						UnseenS = c_outi + UnseenA +UnseenB;
						sS <= 0;
					end
				end
			end
		end
		else begin // if it is subtraction
			if(signA == signB) begin // if both have the same sign
				if(!signA && !signB) begin // if both are +ve
					if(Ai >= Bi) begin //if A is larger than or equal B then sum is +ve
						{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
						UnseenS = c_outi + UnseenA +UnseenB;
						sS <= 0;						
					end
					else if(Ai < Bi) begin //if A is smaller than B then sum is -ve and needs to be 2's complemented
						{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
						sumi <= ~(sumi) + 1;
						UnseenS = c_outi + UnseenA +UnseenB;
						sS <= 1;
					end
				end
				else if(signA && signB) begin // if both are -ve
					if(Ai >= Bi) begin //if A is larger than or equal B then sum is -ve and needs to be 2's complemented
						{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
						sumi <= ~(sumi) + 1;
						UnseenS = c_outi + UnseenA +UnseenB;
						sS <= 1;						
					end
					else if(Ai < Bi) begin //if A is smaller than B then sum is +ve
						{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
						UnseenS = c_outi + UnseenA +UnseenB;
						sS <= 0;
					end
				end
			end
			else begin //if they have different signs
				if(!signA && signB) begin //if A is +ve and B is -ve then sum is +ve
						{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
						UnseenS <= UnseenA + UnseenB + c_outi;
						sS <= 0;	
				end
				else if(signA && !signB) begin //if A is -ve and B is +ve then sum is -ve and needs to be 2's complemented
						{c_outi,sumi} <= (!(load) && !(rst)) ? Ai + Bi + c_in : 0;
						sumi <= ~(sumi) + 1;
						UnseenS = c_outi + UnseenA +UnseenB;
						sS <= 1;	
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
