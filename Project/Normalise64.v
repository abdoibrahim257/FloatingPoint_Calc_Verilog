module Normalise64(input wire [51:0] m, input wire [9:0] e, output wire [11:0] E, output wire[53:0] M);

assign E = e + 12'b010000000000;
assign M = m + 55'd10000000000000000;

endmodule 