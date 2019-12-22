module Control(
input [5:0]Op,
output reg RegWrite,
output reg [2:0]ALUOp
);

always@(Op)begin
    RegWrite <= 1;
    case(Op)
        6'd54:
            ALUOp <= 3'b010;
        default:
            ALUOp <= 3'b000;
            
    endcase


end

endmodule