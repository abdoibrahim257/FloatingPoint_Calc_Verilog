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

wire NaN;
wire PosInf;
wire NegInF;

reg One = 1'b1;
reg Zero = 1'b0;

reg [10:0] eSi;
wire readyi;

reg readyFinal = 1'b0;

Normalise64 N(clk,en,rst,load,A[51:0],B[51:0],A[62:52],B[62:52],An,Bn,eAn,eBn,eSn,NormaliserOE);

assign fullAdderEn = (NormaliserOE)? 1'b1: 1'b0;

fullAdder64 FA(clk,fullAdderEn,rst,PlusOrMinus,An,Bn,A[63],B[63],cin,sum,cout,signS,readyi);


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

always@(*) begin


assign NaN = (A[63] == 'bX || B[63] == 'bX) ? One:Zero;
assign PosInf = (((A[62:52] == 11'b11111111111) && (A[63] == 1'b0) )|| ((B[62:52] == 11'b11111111111) && (B[63] == 1'b0) )) ?1'b1:1'b0;
assign NegInf = (((A[62:52] == 11'b11111111111) && (A[63] == 1'b1) )|| ((B[62:52] == 11'b11111111111) && (B[63] == 1'b1) )) ?1'b1:1'b0;

end

assign ready = readyFinal;
assign sumFinal[51:0] = (NaN)? 52'bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX : (PosInf)? 52'b0 : (NegInf)? 52'b0 :(ready) ? sumi[51:0] : sumi[51:0];
assign sumFinal[62:52] = (NaN || PosInf || NegInf )? 11'b11111111111 :(ready) ? eSi : eSi;
assign sumFinal[63] = (NaN)? 1'bX: (PosInf)? 1'b0 : (NegInf)? 1'b1 :(ready) ? signS : signS;





endmodule
