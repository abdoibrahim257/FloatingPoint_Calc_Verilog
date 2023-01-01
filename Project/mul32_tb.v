//`timescale 1ps/10ps

module mul32_tb ();

localparam period = 50;

reg clk, rst, en, load;
reg [31:0] A, B;
wire [31:0] result;

always #(period) clk = ~clk;

mul32 mul32_inst (
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
    #10 A = 32'b01000000101111111001100011001000;
    #10 B = 32'b01000010101100110110001110100011;
    #10 load = 0;
    
    if (result == 32'b01000100000001100100001001100110) begin
        $display("Test passed");
    end
    else begin
        $display("Test failed");
    end
    #10
    $finish;
    
end
    
endmodule