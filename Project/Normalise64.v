module Normalise64 ( input wire [52:0] A, input wire [52:0] B, input wire[10:0] eA, input wire[10:0] eB, 
output wire [52:0] Am, output wire [52:0] Bm, output wire OE,input wire en,input wire load,input wire clk,input wire rst);

reg [52:0] Ai;
reg [52:0] Bi;
reg [10:0] eAi;
reg [10:0] eBi;
reg OEi;

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
			eAi <= eA;
			eBi <= eB;
		end
		else begin
			if(eAi[10] == eBi[10]) begin                         
				if(eAi>eBi) begin
					eBi <= eBi + 1;
					Bi <= Bi >> 1;
					OEi <= 1'b0;
				end
				else if(eBi>eAi)begin
					eAi <= eAi + 1;
					Ai <= Ai >> 1;
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
			else begin
				if(eAi[10] == 1) begin
					eAi <= eAi + 1;
					Ai <= Ai >> 1;
					OEi <= 1'b0;
				end
				else if(eBi[10] == 1) begin
					eBi <= eBi + 1;
					Bi <= Bi >> 1;
					OEi <= 1'b0;
				end
			end
		end
	end
end

assign Am = Ai;
assign Bm = Bi;
endmodule	
