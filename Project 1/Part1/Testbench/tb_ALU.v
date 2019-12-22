`timescale 1ns/ 1ps
module tb_ALU;
// inputs
reg [31:0] Src1;
reg [31:0] Src2;
reg [5:0] funct;
reg [4:0] shamt;

// Outputs
wire [31:0]result;
wire zero;
wire carry;

ALU uut(
    .Src1(Src1),
    .Src2(Src2),
    .funct(funct),
    .shamt(shamt),
    .result(result),
    .zero(zero),
    .carry(carry)
);

initial begin
  Src1 = 0;
  Src2 = 0;
  funct = 0;
  shamt = 0;

#10 
Src1 = 32'd7;
Src2 = 32'd6;
funct = 6'd27;
// 7 + 6 = 13




#10 
funct = 6'd28;
// 7 - 6 = 1

#10 
funct = 6'd29;
// 7 and 6 = 6

#10 
funct = 6'd30;
// 7 or 6 = 7

#10 
funct = 6'd31;
shamt = 5'd3;
// 7 >> 3 = 0
// carry = 1

#10 
funct = 6'd32;
// 7 << 3 = 56


// test carry
#20;
Src1 = 32'd4294967295;
Src2 = 32'd3;
funct = 6'd27;
// 4294967295 + 3 = 2
// carry = 1

#10;
Src1 = 32'd3;
Src2 = 32'd4;
funct = 6'd28;
// 3-4 = -1 = 4294967295
// carry = 1

#10;
Src1 = 32'd4294967295;
shamt = 32'd2;
funct = 6'd32;
//  4294967295 << 2 = 4294967292
// carry = 1


#10;

end
endmodule
