module Normalise32 (input wire clk,input wire en,input wire rst,input wire load, input wire [22:0] A, input wire [22:0] B, input wire[7:0] eA, 
input wire[7:0] eB, 
output wire [22:0] Am, output wire [22:0] Bm, output wire [7:0] eAm, output wire [7:0] eBm,
output wire OE, output wire uA, output wire uB);

reg [22:0] Ai;
reg [22:0] Bi;
reg [7:0] eAi;
reg [7:0] eBi;
reg OEi;
reg UnseenA = 1'b1;
reg UnseenB = 1'b1;

always@(posedge clk)
begin
	if(rst) begin
		Ai <= 0;
		Bi <= 0;
		eAi <= 0;
		eBi <= 0;
	end
	else if(en) begin
		if(load) begin
			Ai <= A;
			Bi <= B;
			eAi <= eA + 127;
			eBi <= eB + 127;
			UnseenA = 1'b1;
			UnseenB = 1'b1;
		end
		else begin                       
				if(eAi>eBi) begin
					eBi <= eBi + 1;
					//Bi <= Bi >> 1;
					Bi <= {UnseenB,Bi[22:1]};
					UnseenB <= UnseenB >> 1;
					OEi <= 1'b0;
				end
				else if(eBi>eAi)begin
					eAi <= eAi + 1;
					//Ai <= Ai >> 1;
					Ai <= {UnseenA,Ai[22:1]};
					UnseenA <= UnseenA >> 1;
					OEi <= 1'b0;
				end
				if(eBi == eAi) begin
					Bi <= Bi;
					Ai <= Ai;
					eAi <= eAi;
					eBi <= eBi;
					OEi <= 1'b1;
				end
		end
	end
end

assign Am = Ai;
assign Bm = Bi;
assign eAm = eAi;
assign eBm = eBi;
assign uA = UnseenA;
assign uB = UnseenB;
assign OE = OEi;
endmodule	
