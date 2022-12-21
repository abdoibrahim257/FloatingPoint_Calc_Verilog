
module fullAdder32 (input [22:0] A, input [22:0] B, input c_in, output [22:0] sum , output c_out);
	
	assign {c_out,sum} = A + B + c_in;
	
endmodule
