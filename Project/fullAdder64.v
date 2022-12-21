module fullAdder64(input wire[53:0] A, input wire[53:0] B, input wire cin,output wire[53:0] S, output wire cout);

assign {cout , S} = A + B + cin;

endmodule
