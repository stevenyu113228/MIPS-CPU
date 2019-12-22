module CompALU(
    input [31:0]instr,
    output [31:0] result,
    output zero,
    output carry
);
//input to RF
wire [4:0]Src1addr,Src2addr;

//input to ALU
wire [5:0]shamt,funct;
wire [31:0]Src1,Src2;


assign Src1addr[4:0] = instr[25:21];
assign Src2addr[4:0] = instr[20:16];
assign shamt[5:0] = instr[10:6];
assign funct[5:0] = instr[5:0];

RF regi(Src1addr,Src2addr,Src1,Src2);
ALU alu(Src1,Src2,funct,shamt,result,zero,carry);

endmodule
