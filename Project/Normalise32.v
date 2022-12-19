
module Normalise32 ( input wire [32:0] m, input wire[6:0] e, output wire [6:0] E, output wire [33:0] M);
	
	assign E = e + 127;
	assign M = m + 34'd10000000000;

endmodule	
