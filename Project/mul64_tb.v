//`timescale 1ps/10ps

module mul64_tb ();

localparam period = 50;

reg clk, rst, en, load;
reg [63:0] A, B;
wire [63:0] result;

always #(period) clk = ~clk;

mul64 mul64_inst (
    .load(load),
    .clk(clk),
    .rst(rst),
    .en(en),
    .A(A),
    .B(B),
    .result(result)
);

initial begin

    rst = 1;
    en = 1;
    load = 1;
    A = 0;
    B = 0;
    #10 rst = 0;
    #10 en = 1;
    #10 load = 1;
    #10 A = 64'b0011111111110110011001100110011001100110011001100110011001100110;
    #10 B = 64'b011111111111001100110011001100110011001100110011001100110011010;
    #10 load = 0;
    
    if (result == 64'b0100000000000001111010111000010100011110101110000101000111101100) begin
        $display("Test passed");
    end
    else begin
        $display("Test failed");
    end
    #10
    $finish;
    
end
    
endmodule