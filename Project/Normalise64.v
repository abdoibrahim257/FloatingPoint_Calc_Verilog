module Normalise64(input wire [51:0] m, input wire [9:0] e, output wire [9:0] E, output wire[53:0] M);

assign E = e + 10'd1024;
assign M = m + 54'd10000000000000000;

endmodule 