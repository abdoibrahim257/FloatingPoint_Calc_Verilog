module Normalise64(input wire [51:0] m, input wire [10:0] e, output wire [10:0] E, output wire[53:0] M);

assign E = e + 11'd1023;
assign M = m + 53'd10000000000000000;

endmodule 