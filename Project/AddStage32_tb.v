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
	$display("Correct Answer on TestCase 22");
end

#(PERIOD*5)
A=32'b0_01111111_00000000000000000000000;
B=32'b1_01111111_00000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b00000000000000000000000000000000) begin
	$display("Correct Answer on TestCase 23");
end

#(PERIOD*5)

A=32'b01000000000000000000000000000000;
B=32'b01000000000000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000100000000000000000000000) begin
	$display("Correct Answer on TestCase 24");
end

#(PERIOD*5)

A=32'b01000000000000000000000000000000;
B=32'b11000000000000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b00000000000000000000000000000000) begin
	$display("Correct Answer on TestCase 25");
end

#(PERIOD*5)

A=32'b01000000000000000000000000000000;
B=32'b01000000101000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000111000000000000000000000) begin
	$display("Correct Answer on TestCase 26");
end

#(PERIOD*5)

A=32'b01000000101000000000000000000000;
B=32'b11000000000000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000010000000000000000000000) begin
	$display("Correct Answer on TestCase 27");
end

#(PERIOD*5)

A=32'b01000000000000000000000000000000;
B=32'b01000000101000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000010000000000000000000000) begin
	$display("Correct Answer on TestCase 28");
end

#(PERIOD*5)

A=32'b01000000000000000000000000000000;
B=32'b11000000101000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01000000010000000000000000000000) begin
	$display("Correct Answer on TestCase 29");
end

#(PERIOD*5)

A=32'b01001011000000000000000000000000;
B=32'b00111111100000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*4)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 30");
end


#(PERIOD*8)

A=32'b00000000010000000000000000000000; //31
B=32'b00111111000000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 31");
end

#(PERIOD*5)

A=32'b01111111000000000000000000000000;
B=32'b01000000000000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 32");
end

#(PERIOD*5)

A=32'b01111111000000000000000000000000;
B=32'b01000001001000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 33");
end

#(PERIOD*5)

A=32'b01000001001000000000000000000000;
B=32'b11000001000111111111111111111111;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 34");
end

#(PERIOD*5)

A=32'b01111111000000000000000000000000;
B=32'b01111111000101100111011010011001;

load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 35");
end

#(PERIOD*5)

A=32'b01000001001000000000000000000000;
B=32'b11000001001000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 36");
end

#(PERIOD*5)

B=32'b00000000000000000000000000000000;
A=32'b01000011101010101000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 43");
end


#(PERIOD*5)

B=32'b00111100010010100011111111010101;
A=32'b00000000000000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 42");
end

#(PERIOD*5)


A=32'b00111010000000110001001001101111;
B=32'b11111111100000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 41");
end

#(PERIOD*5)

A=32'b01111111100000000000000000000000;
B=32'b01000101100111000100000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 40");
end


#(PERIOD*5)

A=32'b00000000000000000000000000000000;
B=32'b011111111101110000101101101111100;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 37");
end

#(PERIOD*5)

A=32'b01111111100000000000000000000000;
B=32'b11111111100000000000000000000000;
load = 1'b1;

#(PERIOD*3) load = 1'b0;

#(PERIOD*10)

if(sumFinal == 32'b01001011000000000000000000000001) begin
	$display("Correct Answer on TestCase 38");
end



#(100*PERIOD)
$finish;


end

always begin
#(PERIOD) clk=~clk;
end

endmodule 