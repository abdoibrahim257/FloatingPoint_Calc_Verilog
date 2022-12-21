module fulladderWNormaliser();

reg [63:0] A;
reg [63:0] B;
reg cin;

wire [65:0] An;
wire [65:0] Bn;

wire [53:0] S;
wire cout;

Normalise64 N1(A[51:0],A[62:52],An[64:54],An[53:0]);
Normalise64 N2(B[51:0],B[62:52],Bn[64:54],Bn[53:0]);

fullAdder64 FA1(An[53:0],Bn[53:0],cin,S,cout);
assign An[65]=A[63];
assign Bn[65]=B[63];

endmodule 