module AdditionStage64(input wire clk,input wire en,input wire rst,input wire load,input wire PlusOrMinus,
input wire [63:0] A, input wire [63:0] B, input wire cin, output wire [63:0] sumFinal, output wire cout,output wire ready);

wire [52:0] An;
wire [52:0] Bn;
wire [10:0] eAn;
wire [10:0] eBn;
wire NormaliserOE;
wire fullAdderEn;
wire [10:0] eSn;

wire [52:0] sum;
reg [52:0] sumi;
wire signS;

reg [10:0] eSi;
wire readyi;

reg readyFinal = 1'b0;

reg complemented = 1'b0;
Normalise64 N(clk,en,rst,load,A[51:0],B[51:0],A[62:52],B[62:52],An,Bn,eAn,eBn,eSn,NormaliserOE);

assign fullAdderEn = (NormaliserOE)? 1'b1: 1'b0;

fullAdder64 FA(clk,en,rst,fullAdderEn,PlusOrMinus,An,Bn,A[63],B[63],cin,sum,cout,signS,readyi);


always@(*) begin
if(readyi) begin
	sumi = sum;
	eSi = eSn;
	if(!sumi[52])begin
		if(cout) begin
			eSi=eSi+1'b1;
			sumi= sumi>>1;
		end
		else if(!cout) begin
			eSi=eSi-1'b1;
			sumi= sumi<<1;
		end
	end
	else if(sumi[52]) begin
		sumi = sumi;
		readyFinal = 1'b1;
	end
end

end


assign ready = readyFinal;
assign sumFinal[51:0] = (ready) ? sumi[51:0] : sumi[51:0];
assign sumFinal[62:52] = (ready) ? eSi : eSi;
assign sumFinal[63] = (ready) ? signS : signS;





endmodule
