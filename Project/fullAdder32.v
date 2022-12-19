
module fullAdder32 (input [32:0] A, input [32:0] B, input c_in, output [32:0] sum , output c_out);
	
	assign {c_out,sum} = A + B + c_in;
	
endmodule
