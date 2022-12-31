module division (input wire clk, input wire en, input wire rst, input wire load,
    input wire [31:0] N, input wire [31:0] D, output wire [31:0] result)

reg [22:0] N_Mantissa,D_Mantissa;
reg [7:0] N_Exponent,D_Exponent,Temp_Exponent,diff_Exponent,Exponent;
reg N_sign,D_sign,Sign;
//reg [22:0] Fn,Dn,Nn;
reg overflow, underflow;
reg [31:0] Xn, temp_result, temp_result2;
reg [31:0] C1 = {1'b0, 8'd21, 23'b0110_1001_0110_1001_0110_100}; // 48/17
reg [31:0] C2 = {1'b0, 8'b19, 23'b1110_0001_1110_0001_1110_000}; // 32/17
reg [31:0] numTwo = 32d'2;
        
mul mul1(clk,en,rst,load,C2,D,temp_result, overflow, underflow);
add add1(clk,en,rst,load,C1,temp_result,1,Xn); //to be changed

//first iteration (Xn = Xn(2 - Xn*D))

mul mul2(clk,en,rst,load,Xn,D,temp_result, overflow, underflow);
add add2(clk,en,rst,load,numTwo,temp_result,1,temp_result2); //to be changed
mul mul3(clk,en,rst,load,Xn,temp_result2,temp_result, overflow, underflow);
Xn = temp_result;

//second iteration (Xn = Xn(2 - Xn*D))

mul mul4(clk,en,rst,load,Xn,D,temp_result, overflow, underflow);
add add3(clk,en,rst,load,numTwo,temp_result,1,temp_result2); //to be changed
mul mul5(clk,en,rst,load,Xn,temp_result2,temp_result, overflow, underflow);
Xn = temp_result;

//third iteration (Xn = Xn(2 - Xn*D))

mul mul6(clk,en,rst,load,Xn,D,temp_result, overflow, underflow);
add add4(clk,en,rst,load,numTwo,temp_result,1,temp_result2); //to be changed
mul mul7(clk,en,rst,load,Xn,temp_result2,temp_result, overflow, underflow);
Xn = temp_result;

//fourth iteration (Xn = Xn(2 - Xn*D))

mul mul8(clk,en,rst,load,Xn,D,temp_result, overflow, underflow);
add add5(clk,en,rst,load,numTwo,temp_result,1,temp_result2); //to be changed
mul mul9(clk,en,rst,load,Xn,temp_result2,temp_result, overflow, underflow);
Xn = temp_result;

//Final

mul mul10(clk,en,rst,load,N,Xn,result, overflow, underflow);

// always @(posedge clk) begin
//     if (rst) begin
//         N_Mantissa <= 0;
//         D_Mantissa <= 0;
//         N_Exponent <= 0;
//         D_Exponent <= 0;
//         N_sign <= 0;
//         D_sign <= 0;
//         Temp_Mantissa <= 0;

//     end
//     else if (en) begin
//         if(load) begin
//             N_Mantissa = N[22:0];
//             N_Exponent = N[30:23];
//             N_sign = N[31];

//             D_Mantissa = D[22:0];
//             D_Exponent = D[30:23];
//             D_sign = D[31];

//         end
//         else begin
            
//             Temp_Exponent = N_Exponent - D_Exponent + 127;



//             integer i;
//             for(i=0;i<8;i=i+1) begin
//                 mul mul1(clk,en,rst,load,)
//             end

//             //Temp_Mantissa = N_Mantissa * D_Mantissa;
//             // Mantissa = Temp_Mantissa[47] ? Temp_Mantissa[46:24] : Temp_Mantissa[45:23];
//             // Exponent = Temp_Mantissa[47] ? Temp_Exponent + 1'b1 : Temp_Exponent;
//             Sign = N_sign ^ D_sign;
//             result = {Sign,Exponent,Mantissa};

//             if (Temp_result[30:23] < 0) begin
//                 Temp_underflow <= 1;
//             end else begin
//                 Temp_underflow <= 0;
//             end
//         end
//     end
// end

// endmodule