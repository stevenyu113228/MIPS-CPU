`timescale 1ns/ 1ps
module tb_CompALU;
//input
reg [31:0]instr;

//output
wire [31:0] result;
wire zero;
wire carry;

CompALU ca(instr,result,zero,carry);
initial begin
    instr[31:26] = 0;
    instr[25:21] = 13;
    instr[20:16] = 17;
    instr[15:11] = 0;
    instr[10:6] = 0;
    instr[5:0] = 27;
    // 13 + 17 = 30;
    #10;

    instr[5:0] = 28;
    // 13 - 17 = 4294967292
    #10;

    instr[5:0] = 29;
    // 13 and 17 = 1
    #10;

    instr[5:0] = 30;
    // 13 or 17 = 29
    #10;

    instr[5:0] = 31;
    instr[10:6] = 1;
    // 13 >> 1 = 6
    #10;


    instr[5:0] = 29;
    instr[25:21] = 0;
    // 0 and 17 = 0
    #10;

end
endmodule
