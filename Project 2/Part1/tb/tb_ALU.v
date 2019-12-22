module tb_ALU;

reg [4:0] shamt;
reg [31:0] src1;
reg [31:0] src2;
reg [5:0] operation;
wire [31:0] result;
wire zero;


ALU uut(
    shamt,
    src1,
    src2,
    operation,
    result,
    zero
);

initial begin
src1 = 1;
src2 = 3;
operation = 27;
//1+3

#10
src1 = 87;
src2 = 87;
operation = 28;
//87-87 = 0,zero = 1

#10
src1 = 123;
src2 = 456;
operation = 29;
// 123 & 456 = 72

#10
operation = 30;
// 123 | 546 = 507

#10
src1 = 10;
shamt = 3;
operation = 31;
// 10 >> 3 = 1;

// #10
operation = 32;
//0 << 3 = 80

#10
operation = 0;
end

endmodule