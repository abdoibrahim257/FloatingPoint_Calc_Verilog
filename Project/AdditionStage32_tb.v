`timescale 1 ns/ 10 ps

module AdditionStage32_tb();

	localparam period = 50; 
	
	reg clk, en, rst, load, PlusOrMinus, cin;
	reg [31:0] A, B;
	
	wire cout, ready;
	wire [31:0] sumFinal;
	
	always #(period) clk = ~clk;
	
	initial begin
		
		clk = 1'b0;
		en = 1'b1;
		rst = 1'b1;
		loadN = 1'b1;
		PlusOrMinus = 1'b0; //addition
		cin = 1'b0;
		A = 32'b0_00000010_10110000000000000000000; //6.75
		B = 32'b0_00000001_10000000000000000000000; //3
		
		#(4*period)
		rst = 1'b0;
		
		#(3*period)
		loadN = 1'b0;//wait for normalisation
		
		#(6*period) //to ensure that the summmation is done finally the expected output is excpeted to be [32'b0_10000010_00111000000000000000000] = 9.75
		if(sumFinal == 32'b0_10000010_00111000000000000000000) begin
			$display("First testcase is Successfull\n");
		end
		
		#(4*period) //2nd testcase A +ve, B -ve, operation addition
		rst = 1'b1;
		
		#(4*period)
		rst = 1'b0;
		A = 32'b0_00000010_10110000000000000000000; //6.75
		B = 32'b1_00000001_10000000000000000000000; //-3
		loadN = 1'b1;//load normalise
		#(4*period)
		loadN = 1'b0;//normalise
		#(4*period)
		loadA = 1'b1; //load the normalised values to be loaded in the fulladder	
		#(4*period)
		loadA = 1'b0; //to start addition
		
		#(3*period) //to ensure that the summmation is done finally the expected output is excpeted to be [32'b0_10000000_11100000000000000000000] = 3.75
		if(sumFinal == 32'b0_10000000_11100000000000000000000) begin
			$display("Second testcase is Successfull\n");
		end
		
		#(4*period)//3rd testcase A -ve, B +ve, operation addition
		rst = 1'b1;
		
		#(4*period)
		rst = 1'b0;
		A = 32'b1_00000010_10110000000000000000000; //-6.75
		B = 32'b0_00000001_10000000000000000000000; //3
		loadN = 1'b1;//load normalise
		#(4*period)
		loadN = 1'b0;//normalise
		#(4*period)
		loadA = 1'b1; //load the normalised values to be loaded in the fulladder	
		#(4*period)
		loadA = 1'b0; //to start addition
		
		#(3*period) //to ensure that the summmation is done finally the expected output is excpeted to be [32'b1_10000000_11100000000000000000000] = -3.75
		if(sumFinal == 32'b1_10000000_11100000000000000000000) begin //this test is bugged needs 2's compliment
			$display("Third testcase is Successfull\n");
		end
		
		#(4*period)//4th testcase A -ve, B -ve, operation addition
		rst = 1'b1;
		
		#(4*period)
		rst = 1'b0;
		A = 32'b1_00000010_10110000000000000000000; //-6.75
		B = 32'b1_00000001_10000000000000000000000; //-3
		loadN = 1'b1;//load normalise
		#(4*period)
		loadN = 1'b0;//normalise
		#(4*period)
		loadA = 1'b1; //load the normalised values to be loaded in the fulladder	
		#(4*period)
		loadA = 1'b0; //to start addition
		
		#(3*period) //to ensure that the summmation is done finally the expected output is excpeted to be [32'b1_10000010_00111000000000000000000] = -9.75
		if(sumFinal == 32'b1_10000010_00111000000000000000000) begin
			$display("Fourth testcase is Successfull\n");
		end
		
		#(4*period)//5th testcase A +ve, B +ve, operation subtraction
		rst = 1'b1;
		PlusOrMinus = 1'b1;
		
		#(4*period)
		rst = 1'b0;
		A = 32'b0_00000010_10110000000000000000000; //6.75
		B = 32'b0_00000001_10000000000000000000000; //3
		loadN = 1'b1;//load normalise
		#(4*period)
		loadN = 1'b0;//normalise
		#(4*period)
		loadA = 1'b1; //load the normalised values to be loaded in the fulladder	
		#(4*period)
		loadA = 1'b0; //to start addition
		
		#(3*period) //to ensure that the summation is done finally the expected output is excpeted to be [32'b0_10000000_11100000000000000000000] = 3.75
		if(sumFinal == 32'b0_10000000_11100000000000000000000) begin
			$display("Fifth testcase is Successfull\n");
		end
		
		#(4*period)//6th testcase A +ve, B -ve, operation subtraction
		rst = 1'b1;
		
		#(4*period)
		rst = 1'b0;
		A = 32'b0_00000010_10110000000000000000000; //6.75
		B = 32'b1_00000001_10000000000000000000000; //-3
		loadN = 1'b1;//load normalise
		#(4*period)
		loadN = 1'b0;//normalise
		#(4*period)
		loadA = 1'b1; //load the normalised values to be loaded in the fulladder	
		#(4*period)
		loadA = 1'b0; //to start addition
		
		#(3*period) //to ensure that the summation is done finally the expected output is excpeted to be [32'b0_10000010_00111000000000000000000] = 9.75
		if(sumFinal == 32'b0_10000010_00111000000000000000000) begin
			$display("Sixth testcase is Successfull\n");
		end
		
		#(4*period)//7th testcase A -ve, B +ve, operation subtraction
		rst = 1'b1;
		
		#(4*period)
		rst = 1'b0;
		A = 32'b1_00000010_10110000000000000000000; //-6.75
		B = 32'b0_00000001_10000000000000000000000; //3
		loadN = 1'b1;//load normalise
		#(4*period)
		loadN = 1'b0;//normalise
		#(4*period)
		loadA = 1'b1; //load the normalised values to be loaded in the fulladder	
		#(4*period)
		loadA = 1'b0; //to start addition
		
		#(3*period) //to ensure that the summation is done finally the expected output is excpeted to be [32'b1_10000010_00111000000000000000000] = -9.75
		if(sumFinal == 32'b1_10000010_00111000000000000000000) begin
			$display("Seventh testcase is Successfull\n");
		end
		
		#(4*period)//8th testcase A -ve, B -ve, operation subtraction
		rst = 1'b1;
		
		#(4*period)
		rst = 1'b0;
		A = 32'b1_00000010_10110000000000000000000; //-6.75
		B = 32'b1_00000001_10000000000000000000000; //-3
		loadN = 1'b1;//load normalise
		#(4*period)
		loadN = 1'b0;//normalise
		#(4*period)
		loadA = 1'b1; //load the normalised values to be loaded in the fulladder	
		#(4*period)
		loadA = 1'b0; //to start addition
		
		#(3*period) //to ensure that the summation is done finally the expected output is excpeted to be [32'b0_10000000_11100000000000000000000] = 3.75
		if(sumFinal == 32'b0_10000000_11100000000000000000000) begin
			$display("8th testcase is Successfull\n");
		end
		
		
		
		#(10*period)
		$finish;
	end
	
	AdditionStage32 adder(clk, en, rst, loadN, loadA, PlusOrMinus, A, B, cin, sumFinal, cout, ready);

endmodule
