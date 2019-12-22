module tb_Control;

reg [5:0]Op;
wire RegDst;
wire MemRead;
wire MemtoReg;
wire [2:0]ALUOp;
wire MemWrite;
wire ALUSrc;
wire RegWrite;

Control uut(
    Op,
    RegDst,
    MemRead,
    MemtoReg,
    ALUOp,
    MemWrite,
    ALUSrc,
    RegWrite
);


initial begin
    Op = 6'd54;
    #10
    Op = 6'd39;
    #10
    Op = 6'd40;
    #10
    Op = 6'd41;
    #10
    Op = 6'd42;

    #10
    Op = 6'd31;
    #10
    Op = 6'd32;

    #10
    Op = 6'd00;
end


endmodule