module Normalise32 ( input wire [22:0] A, input wire [22:0] B, input wire[7:0] eA, input wire[7:0] eB, 
output wire [22:0] Am, output wire [22:0] Bm,input wire en,input wire load,input wire clk,input wire rst);

reg [22:0] Ai;
reg [22:0] Bi;
reg [7:0] eAi;
reg [7:0] eBi;

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
			if(eAi[7] == eBi[7]) begin                         
				if(eAi>eBi) begin
					eBi <= eBi + 1;
					Bi <= Bi >> 1;
				end
				else if(eBi>eAi)begin
					eAi <= eAi + 1;
					Ai <= Ai >> 1;
				end
			end
			else begin
				if(eAi[7] == 1) begin
					eAi <= eAi + 1;
					Ai <= Ai >> 1;
				end
				else if(eBi[7] == 1) begin
					eBi <= eBi + 1;
					Bi <= Bi >> 1;
				end
			end
		end
	end
end

assign Am = Ai;
assign Bm = Bi;
endmodule	
