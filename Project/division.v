module division (input wire clk, input wire en, input wire rst, input wire load,
	input wire [31:0] N, input wire [31:0] D, output wire [31:0] result);

reg overflow, underflow;
wire sign;
wire cin,cout,ready;
wire [31:0] Xn,Xn1,Xn2,Xn3,Xn4;
wire [31:0] tempResult, tempResult2;
wire [31:0] C1 = {1'b0, 8'd21, 23'b0110_1001_0110_1001_0110_100}; // 48/17
wire [31:0] C2 = {1'b0, 8'd19, 23'b1110_0001_1110_0001_1110_000}; // 32/17
wire [31:0] numTwo = 32'b0_00000001_00000000000000000000000;
wire [31:0] tempWireN, tempWireD;
wire [31:0] tempWire,tempWire2, wireX;
wire [31:0] temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9;

wire [31:0] newN, newD;

normalizeForDivision norm(N, D, newN, newD);
assign tempWireN = newN;
assign tempWireD = newD;


assign sign = N[31] ^ D[31];


//Xo (48/17 - 32/17 * D)

mul32 mul1(clk,en,rst,load,C2,tempWireD,tempWire);
AdditionStage32 add1(clk,en,rst,load,1'b1,C1,tempWire,1'b0,wireX,cout,ready);

//first iteration (Xn = Xn(2 - Xn*D))

mul32 mul2(clk,en,rst,load,wireX,tempWireD,temp1);
AdditionStage32 add2(clk,en,rst,load, 1'b1,numTwo,temp1,1'b0,temp2,cout,ready);
mul32 mul3(clk,en,rst,load,wireX,temp2,Xn);

//second iteration (Xn = Xn(2 - Xn*D))

mul32 mul4(clk,en,rst,load,Xn,tempWireD,temp3);
AdditionStage32 add3(clk,en,rst,load, 1'b1,numTwo,temp3,1'b0,temp4,cout,ready);
mul32 mul5(clk,en,rst,load,Xn,temp4,Xn1);

//third iteration (Xn = Xn(2 - Xn*D))

mul32 mul6(clk,en,rst,load,Xn1,tempWireD,temp5);
AdditionStage32 add4(clk,en,rst,load, 1'b1,numTwo,temp5,1'b0,temp6,cout,ready);
mul32 mul7(clk,en,rst,load,Xn1,temp6,Xn2);

//fourth iteration (Xn = Xn(2 - Xn*D))

mul32 mul8(clk,en,rst,load,Xn2,tempWireD,temp7);
AdditionStage32 add5(clk,en,rst,load, 1'b1,numTwo,temp7,1'b0,temp8,cout,ready);
mul32 mul9(clk,en,rst,load,Xn2,temp8,Xn3);

//Final

mul32 mul10(clk,en,rst,load,tempWireN,Xn3,tempResult);
assign result = {sign,tempResult[30:0]};

endmodule
