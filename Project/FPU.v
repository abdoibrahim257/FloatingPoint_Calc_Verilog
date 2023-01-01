module FPU(input [63:0] A, input [63:0] B, input[1:0] operation, input fpuType, clk, en ,reset, load, input cin ,output [63:0] Result, output Done, cout);

	localparam SP = 2'd0;
	localparam DP = 2'd1;
	localparam IDLE = 2'd2;
	
	reg [1:0] state_reg;
	reg [1:0] state_next;
	
	
	//registers
	reg [31:0] tempOutput;
	reg tempDone;
	reg tempCout;
	
	
	//wires 32bit
	wire coutAdd, doneAdd; //addition
	wire coutSub, doneSub; //subtraction 
	
	wire [31:0] additionValue32;
	wire[31:0] subtractionValue32;
	wire[31:0] multiplicationValue32;
	
	always@(posedge clk, posedge reset) begin
		if(reset) 
			state_reg <= IDLE;
		else
			state_reg <= state_next;
	end
	
//32

//add
AdditionStage32 Adder32(clk, en, reset, load, 1'b0, A[31:0], B[31:0], cin, additionValue32, coutAdd, doneAdd);
				
//subtract7766
AdditionStage32 Subtractior32(clk, en, reset, load, 1'b1, A[31:0], B[31:0], cin, subtractionValue32, coutSub, doneSub);
				
//multiply
mul32 multiplication32(clk, en, reset, load,A[31:0], B[31:0], multiplicationValue32);

//division
				

	
	always@( operation, state_reg, fpuType, A, B) begin //sw
		//switch case on the type of operation
		case(fpuType)
			IDLE: begin
				if(!fpuType)
					state_next = SP;
				else
					state_next = DP;
			end
			SP: begin //32bit			
				case (operation)
					2'b00 : begin 
						tempOutput = additionValue32;
						tempCout = coutAdd;
						tempDone = doneAdd;
					end
					2'b01 : begin 
						tempOutput = subtractionValue32;
						tempCout = coutSub;
						tempDone = doneSub;
					end
					2'b10 : begin //ask ramy
						tempOutput = multiplicationValue32;
					end
					2'b11 : begin //ask omar
						
					end	
					default : begin
						
					end
				endcase
			end
			DP: begin //64 bit
				case (operation)
					2'b00 : begin
						
					end
					2'b01 : begin
						
					end
					2'b10 : begin
						
					end
					2'b11 : begin
						
					end	
					default : begin
						
					end
				endcase
			end
		endcase
	end
	
endmodule
