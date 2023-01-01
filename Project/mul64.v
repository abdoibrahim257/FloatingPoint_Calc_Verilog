module mul64 (
    input wire clk, 
    input wire en, 
    input wire rst, 
    input wire load,  
    input wire[63:0] A, 
    input wire[63:0] B, 
    output reg[63:0] result
  );

reg [55:0] A_Mantissa,B_Mantissa;
reg [54:0] Mantissa;
reg [79:0] Temp_Mantissa;
reg [39:0] A_Exponent,B_Exponent,Temp_Exponent,Exponent;
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
            A_Mantissa <= {1'b1,A[54:0]};
            B_Mantissa <= {1'b1,B[54:0]};
            A_Exponent <= A[62:55];
            B_Exponent <= B[62:55];
            A_sign <= A[63];
            B_sign <= B[63];
        end
        else begin
            
            Temp_Exponent = A_Exponent + B_Exponent - 1023;
            Temp_Mantissa = A_Mantissa * B_Mantissa;
            Mantissa = Temp_Mantissa[79] ? Temp_Mantissa[78:56] + 1'b1: Temp_Mantissa[77:55];
            Exponent = Temp_Mantissa[79] ? Temp_Exponent + 1'b1 : Temp_Exponent;
            Sign = A_sign^B_sign;
            result = {Sign,Exponent,Mantissa};
            
        end
    end
end


endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////

