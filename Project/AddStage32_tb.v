`timescale 1 ns/ 10 ps

module AddStage32_tb();

localparam PERIOD =50;

reg clk = 1'b0;
reg en;
reg rst;
reg load; 
reg PlusOrMinus;
reg cin;

reg [31:0] A;
reg [31:0] B;

wire [31:0] sumFinal;
wire cout;
wire ready;

AdditionStage32 A32(clk,en,rst,load,PlusOrMinus,A,B,cin,sumFinal,cout,ready);

initial begin
en=1'b1;
rst = 1'b1;
load = 1'b1;
PlusOrMinus = 1'b0;
cin = 1'b0;

A=32'b0_10000001_10110000000000000000000;
B=32'b0_10000000_10000000000000000000000;
#(PERIOD)
rst = 1'b0;
#(PERIOD*3)
load = 1'b0;
#(PERIOD*4)

if(sumFinal == 32'b01000001000111000000000000000000) begin
	$display("Correct Answer on TestCase 1");
end
#(PERIOD*5)
A=32'b0_01111111_00000000000000000000000;
B=32'b0_01111111_00000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000000000000000000000000000) begin
	$display("Correct Answer on TestCase 2");
end

#(PERIOD*5)
A=32'b0_01111111_00000000000000000000000;
B=32'b1_01111111_00000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b00000000000000000000000000000000) begin
	$display("Correct Answer on TestCase 3");
end

#(PERIOD*5)

A=32'b01000000000000000000000000000000;
B=32'b01000000000000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000100000000000000000000000) begin
	$display("Correct Answer on TestCase 4");
end

#(PERIOD*5)

A=32'b01000000000000000000000000000000;
B=32'b11000000000000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b00000000000000000000000000000000) begin
	$display("Correct Answer on TestCase 5");
end

#(PERIOD*5)

A=32'b01000000000000000000000000000000;
B=32'b01000000101000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000111000000000000000000000) begin
	$display("Correct Answer on TestCase 6");
end

#(PERIOD*5)

A=32'b01000000101000000000000000000000;
B=32'b11000000000000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000010000000000000000000000) begin
	$display("Correct Answer on TestCase 7");
end

#(PERIOD*5)

A=32'b01000000000000000000000000000000;
B=32'b01000000101000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000010000000000000000000000) begin
	$display("Correct Answer on TestCase 8");
end

#(PERIOD*5)

A=32'b01000000000000000000000000000000;
B=32'b11000000101000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000010000000000000000000000) begin
	$display("Correct Answer on TestCase 9");
end

#(PERIOD*5)

A=32'b01001011000000000000000000000000;
B=32'b00111111100000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 10");
end

#(PERIOD*5)


#(100*PERIOD)
$finish;


end

always begin
#(PERIOD) clk=~clk;
end

endmodule 