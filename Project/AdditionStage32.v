module AdditionStage32(input wire clk,input wire en,input wire rst,input wire load,input wire PlusOrMinus,
input wire [31:0] A, input wire [31:0] B, input wire cin, output wire [31:0] sumFinal, output wire cout,output wire ready);

wire [23:0] An;
wire [23:0] Bn;
wire [7:0] eAn;
wire [7:0] eBn;
wire NormaliserOE;
wire fullAdderEn;
wire [7:0] eSn;

wire [23:0] sum;
reg [23:0] sumi;
wire signS;

reg [7:0] eSi;
wire readyi;

reg readyFinal = 1'b0;

reg complemented = 1'b0;
Normalise32 N(clk,en,rst,load,A[22:0],B[22:0],A[30:23],B[30:23],An,Bn,eAn,eBn,eSn,NormaliserOE);

assign fullAdderEn = (NormaliserOE)? 1'b1: 1'b0;

fullAdder32 FA(clk,en,rst,fullAdderEn,PlusOrMinus,An,Bn,A[31],B[31],cin,sum,cout,signS,readyi);



always@(*) begin
if(readyi) begin
	sumi = sum;
	eSi = eSn;
	if(!sumi[23])begin
		if(cout) begin
			eSi=eSi+1'b1;
			sumi= sumi>>1;
		end
		else if(!cout) begin
			eSi=eSi-1'b1;
			sumi= sumi<<1;
		end
	end
	else if(sumi[23]) begin
		sumi = sumi;
		readyFinal = 1'b1;
	end
end

end


assign ready = readyFinal;
assign sumFinal[22:0] = (ready) ? sumi[22:0] : sumi[22:0];
assign sumFinal[30:23] = (ready) ? eSi : eSi;
assign sumFinal[31] = (ready) ? signS : signS;





endmodule
