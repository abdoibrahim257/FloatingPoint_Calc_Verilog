module normalizeForDivision (input wire [31:0] N, input wire [31:0] D, output wire [31:0] newN, output wire [31:0] newD);

		wire[7:0] expN;
		wire[7:0] expD;
	
//	always@(posedge clk) begin
		//assign expN = N[30:23];
		//assign expD = D[30:23];

		assign expN = N[30:23] - D[30:23] - 8'd1;
		assign expD = 8'b1111_1111;

		assign newD = {D[31],expD,D[22:0]};
		assign newN = {N[31],expN,N[22:0]};
//	end

endmodule
