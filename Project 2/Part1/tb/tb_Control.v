module tb_Control;
reg [5:0]Op;
wire RegWrite;
wire [2:0]ALUOp;
integer i;

Control uut(
    Op,
    RegWrite,
    ALUOp
);

initial begin
    for(i=50;i<60;i=i+1)begin
        #10
        Op = i;
    end
end

endmodule