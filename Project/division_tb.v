`timescale 1 ns/ 10 ps

module division_tb();

localparam PERIOD =50;

reg clk = 1'b0;
reg en;
reg rst;
reg load; 


reg [31:0] N;
reg [31:0] D;

wire [31:0] result;

initial begin
en=1'b1;
rst = 1'b1;
load = 1'b1;


N=32'b0_00000000_00000000000000000000000;
D=32'b0_00000001_00000000000000000000000;
#(PERIOD)
rst = 1'b0;
#(PERIOD*3)
load = 1'b0;
#(PERIOD*100)

if(result == 32'b01000001000111000000000000000000) begin
	$display("Correct Answer on TestCase 1");
end

#(100*PERIOD)
$finish;


end

always begin
#(PERIOD) clk=~clk;
end

division div(clk,en,rst,load, N, D, result);

endmodule 