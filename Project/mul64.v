module mul64 (
    input wire load, 
    input wire clk, 
    input wire rst, 
    input wire en, 
    input wire[63:0] A, 
    input wire[63:0] B, 
    output reg[63:0] result
  );

reg [52:0] A_Mantissa,B_Mantissa;
reg [51:0] Mantissa;
reg [105:0] Temp_Mantissa;
reg [11:0] A_Exponent,B_Exponent,Temp_Exponent,Exponent;
reg A_sign,B_sign,Sign;


always @(posedge clk) begin
    if (rst) begin
        A_Mantissa <= 0;
        B_Mantissa <= 0;
        A_Exponent <= 0;
        B_Exponent <= 0;
        A_sign <= 0;
        B_sign <= 0;

    end
    else if (en) begin
        if(load) begin
            A_Mantissa <= {1'b1,A[51:0]};
            B_Mantissa <= {1'b1,B[51:0]};
            A_Exponent <= A[62:52];
            B_Exponent <= B[62:52];
            A_sign <= A[63];
            B_sign <= B[63];
        end
        else begin
            
            Temp_Exponent = A_Exponent + B_Exponent - 1023;
				
            Temp_Mantissa = A_Mantissa * B_Mantissa;
            Mantissa = Temp_Mantissa[105] ? Temp_Mantissa[104:53] + 1'b1: Temp_Mantissa[103:52];
            Exponent = Temp_Mantissa[105] ? Temp_Exponent + 1'b1 : Temp_Exponent;
            Sign = A_sign^B_sign;
            result = {Sign,Exponent,Mantissa};
            
        end
    end
end


endmodule


