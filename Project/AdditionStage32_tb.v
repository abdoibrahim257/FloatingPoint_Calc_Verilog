`timescale 1 ns/ 10 ps

module AdditionStage32_tb();

	localparam PERIOD = 50; 
	
	reg clk, en, rst, load, PlusOrMinus, cin;
	reg [31:0] A, B;
	
	wire cout, ready;
	wire [31:0] sumFinal;
	
	always #(PERIOD) clk = ~clk;
	
	initial begin
		clk = 1'b1;
		en = 1'b1;
		rst = 1'b1;
		load = 1'b1;
		PlusOrMinus = 1'b0; //addition
		cin = 1'b0;
		A = 32'b0_00000010_10110000000000000000000; //6.75
		B = 32'b0_00000001_10000000000000000000000; //3
		
		//#(4*period)
		//rst = 1'b0;
		
		#(PERIOD)
		load = 1'b0;//wait for normalisation
		
		#(PERIOD) //to ensure that the summmation is done finally the expected output is excpeted to be [32'b0_10000010_00111000000000000000000] = 9.75
		if(sumFinal == 32'b0_10000010_00111000000000000000000) begin
			$display("First testcase is Successfull\n");
		end
		
		//#(3*period) //2nd testcase A +ve, B -ve, operation addition
		//rst = 1'b1;
		
		#(PERIOD)
		//rst = 1'b0;
		A = 32'b0_00000010_10110000000000000000000; //6.75
		B = 32'b1_00000001_10000000000000000000000; //-3
		load = 1'b1;//load normalise
		
		#(PERIOD)
		load = 1'b0;//normalise
		
		#(PERIOD) //to ensure that the summmation is done finally the expected output is excpeted to be [32'b0_10000000_11100000000000000000000] = 3.75
		if(sumFinal == 32'b0_10000000_11100000000000000000000) begin
			$display("Second testcase is Successfull\n");
		end
		
		//#(3*period)//3rd testcase A -ve, B +ve, operation addition
		//rst = 1'b1;
		
		#(PERIOD)
		//rst = 1'b0;
		A = 32'b1_00000010_10110000000000000000000; //-6.75
		B = 32'b0_00000001_10000000000000000000000; //3
		load = 1'b1;//load normalise
		
		#(PERIOD)
		load = 1'b0;//normalise

		#(PERIOD) //to ensure that the summmation is done finally the expected output is excpeted to be [32'b1_10000000_11100000000000000000000] = -3.75
		if(sumFinal == 32'b1_10000000_11100000000000000000000) begin //this test is bugged needs 2's compliment
			$display("Third testcase is Successfull\n");
		end
		
		//#(3*period)//4th testcase A -ve, B -ve, operation addition
		//rst = 1'b1;
		
		#(PERIOD)
		//rst = 1'b0;
		A = 32'b1_00000010_10110000000000000000000; //-6.75
		B = 32'b1_00000001_10000000000000000000000; //-3
		load = 1'b1;//load normalise

		#(PERIOD)
		load = 1'b0; //load the normalised values to be loaded in the fulladder	

		#(PERIOD) //to ensure that the summmation is done finally the expected output is excpeted to be [32'b1_10000010_00111000000000000000000] = -9.75
		if(sumFinal == 32'b1_10000010_00111000000000000000000) begin
			$display("Fourth testcase is Successfull\n");
		end
		
		#(PERIOD)//5th testcase A +ve, B +ve, operation subtraction
		//rst = 1'b1;
		PlusOrMinus = 1'b1;
		
		#(PERIOD)
		//rst = 1'b0;
		A = 32'b0_00000010_10110000000000000000000; //6.75
		B = 32'b0_00000001_10000000000000000000000; //3
		load = 1'b1;//load normalise

		#(PERIOD)
		load = 1'b0; //load the normalised values to be loaded in the fulladder	

		
		#(PERIOD) //to ensure that the summation is done finally the expected output is excpeted to be [32'b0_10000000_11100000000000000000000] = 3.75
		if(sumFinal == 32'b0_10000000_11100000000000000000000) begin
			$display("Fifth testcase is Successfull\n");
		end
		
		#(PERIOD)//6th testcase A +ve, B -ve, operation subtraction
		//rst = 1'b1;
		
		#(PERIOD)
		//rst = 1'b0;
		A = 32'b0_00000010_10110000000000000000000; //6.75
		B = 32'b1_00000001_10000000000000000000000; //-3
		load = 1'b1;//load normalise

		#(PERIOD)
		load = 1'b0; //load the normalised values to be loaded in the fulladder	

		
		#(PERIOD) //to ensure that the summation is done finally the expected output is excpeted to be [32'b0_10000010_00111000000000000000000] = 9.75
		if(sumFinal == 32'b0_10000010_00111000000000000000000) begin
			$display("Sixth testcase is Successfull\n");
		end
		
		//#(3*period)//7th testcase A -ve, B +ve, operation subtraction
		//rst = 1'b1;
		
		#(PERIOD)
		//rst = 1'b0;
		A = 32'b1_00000010_10110000000000000000000; //-6.75
		B = 32'b0_00000001_10000000000000000000000; //3
		load = 1'b1;//load normalise
		
		#(PERIOD)
		load = 1'b0;//normalise
		
		#(PERIOD) //to ensure that the summation is done finally the expected output is excpeted to be [32'b1_10000010_00111000000000000000000] = -9.75
		if(sumFinal == 32'b1_10000010_00111000000000000000000) begin
			$display("Seventh testcase is Successfull\n");
		end
		
		//#(3*period)//8th testcase A -ve, B -ve, operation subtraction
		//rst = 1'b1;
		
		#(PERIOD)
		//rst = 1'b0;
		A = 32'b1_00000010_10110000000000000000000; //-6.75
		B = 32'b1_00000001_10000000000000000000000; //-3
		load = 1'b1;//load normalise
		
		#(PERIOD)
		load = 1'b0;//normalise
		
		#(PERIOD) //to ensure that the summation is done finally the expected output is excpeted to be [32'b0_10000000_11100000000000000000000] = 3.75
		if(sumFinal == 32'b0_10000000_11100000000000000000000) begin
			$display("8th testcase is Successfull\n");
		end
		
		
		#(PERIOD)
		$finish;
	end
	
	AdditionStage32 a(.clk(clk), .en(en), .rst(rst), .load(load), .PlusOrMinus(PlusOrMinus), .A(A), .B(B), .cin(cin), .sumFinal(sumFinal), .cout(cout), .ready(ready));

endmodule
