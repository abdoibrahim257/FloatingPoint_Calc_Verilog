module Normalise64 (input wire clk,input wire en,input wire rst,input wire load, input wire [51:0] A, input wire [51:0] B, input wire[10:0] eA, 
input wire[10:0] eB, output wire [52:0] Am, output wire [52:0] Bm, 
output wire [10:0] eAm, output wire [10:0] eBm, output wire [10:0] eSm, output wire OE);

reg [52:0] Ai;
reg [52:0] Bi;
reg [10:0] eAi;
reg [10:0] eBi;
reg OEi;

always@(posedge clk)
begin
	if(rst) begin
		Ai <= 53'b0;
		Bi <= 53'b0;
		eAi <= 53'b0;
		eBi <= 53'b0;
	end
	else if(en) begin
		if(load) begin
			Ai <= {1'b1,A};
			Bi <= {1'b1,B};
			eAi <= eA + 1023;
			eBi <= eB + 1023;
		end
		else begin                       
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
	end
end

assign Am = Ai;
assign Bm = Bi;
assign eAm = eAi;
assign eBm = eBi;
assign eSm = (eA>=eB)?eAi:eBi;
assign OE = OEi;
endmodule	
