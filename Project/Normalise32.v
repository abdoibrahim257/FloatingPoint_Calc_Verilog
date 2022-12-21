
module Normalise32 ( input wire [23:0] m, input wire[7:0] e, output wire [7:0] E, output wire [23:0] M);
	
	assign E = e + 8'd127;
	assign M = m + 24'd10000000;

endmodule	
