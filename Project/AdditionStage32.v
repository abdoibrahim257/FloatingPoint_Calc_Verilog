module AdditionStage32(input wire clk,input wire en,input wire rst,input wire loadN,loadA,input wire PlusOrMinus,
input wire [31:0] A, input wire [31:0] B, input wire cin, output wire [31:0] sum, output wire cout);

wire [23:0] An;
wire [23:0] Bn;
wire [7:0] eAn;
wire [7:0] eBn;
wire NormaliserOE;
wire fullAdderEn;

Normalise32 N(clk,en,rst,loadN,A[22:0],B[22:0],A[30:23],B[30:23],An,Bn,eAn,eBn,NormaliserOE);

assign fullAdderEn = (NormaliserOE)? 1'b1: 1'b0;

fullAdder32 FA(clk,fullAdderEn,rst,loadA,PlusOrMinus,An,Bn,A[31],B[31],cin,sum[22:0],cout,sum[31]);

assign sum[30:23] = (fullAdderEn) ? eAn : 0;


endmodule 
