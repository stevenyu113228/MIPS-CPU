module ALU(
    input [31:0] Src1,
    input [31:0] Src2,
    input [5:0] funct,
    input [4:0] shamt,
    output reg [31:0] result,
    output  zero,
    output  carry
);
wire [31:0]result1;

initial begin
  result = 0;
end

// when result=0 , zero = 1
assign zero = result == 0 ? 1:0;

ALU1 alu(
  Src1,
  Src2,
  funct,
  shamt,
  result1,
  carry
);
always @(result1)begin // 因為題目的result需要是reg
  result = result1;
end

endmodule


module ALU1(
    input [31:0] Src1,
    input [31:0] Src2,
    input [5:0] funct,
    input [4:0] shamt,
    output reg[31:0] result,
    output reg carry  //因為題目carry沒有reg，所以用另外一個model來連
);

always@(Src1 or Src2 or funct or shamt)begin
  case (funct[5:0])
        6'd27: {carry,result} <= Src1 + Src2;
        6'd28: {carry,result} <= Src1 - Src2;
        6'd29: {carry,result} <= Src1 & Src2;
        6'd30: {carry,result} <= Src1 | Src2;
        6'd31: begin
            result <= (Src1 >> shamt);
            carry <= Src1[shamt-1];
            end
        6'd32: {carry,result} <= (Src1 << shamt);
        default: {carry,result} <= {1'b0,Src2};
  endcase
end

endmodule