module tb_ALUctrl;
reg [5:0] funct;
reg [2:0] ALUOp;
wire [5:0] operation;
integer i;

ALUctrl uut(
    funct,
    ALUOp,
    operation
);


initial begin
    ALUOp = 3'b010;
    for(i=21;i<27;i=i+1)begin
        #10
        funct = i;
    end

    #10
    ALUOp = 3'b000; //要做加法

    #10
    ALUOp = 3'b001; //要做減法

    #10
    ALUOp = 3'b010; //do nothing
end

endmodule