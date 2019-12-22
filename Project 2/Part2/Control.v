module Control(
input [5:0]Op,
output reg RegDst,
output reg MemRead,
output reg MemtoReg,
output reg [2:0]ALUOp,
output reg MemWrite,
output reg ALUSrc,
output reg RegWrite
);



always@(Op)begin
    case(Op)
        6'd54: begin// Rtyp
            ALUOp <= 3'b010;
            RegDst <= 1'b1;
            ALUSrc <= 1'b0;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b1;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
        end
    
        6'd39: begin// sw
            ALUOp <= 3'b000;
            RegDst <= 1'bz;
            ALUSrc <= 1'b1;
            MemtoReg <= 1'bz;
            RegWrite <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b1;
        end

        6'd40: begin// lw
            ALUOp <= 3'b000;
            RegDst <= 1'b0;
            ALUSrc <= 1'b1;
            MemtoReg <= 1'b1;
            RegWrite <= 1'b1;
            MemRead <= 1'b1;
            MemWrite <= 1'b0;
        end

        6'd41: begin//addi
            ALUOp <= 3'b000;
            RegDst <= 1'b0;
            ALUSrc <= 1'b1;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b1;
            MemRead <= 1'b1;
            MemWrite <= 1'b0;
        end
        6'd42: begin //subi
            ALUOp <= 3'b001;
            RegDst <= 1'b0;
            ALUSrc <= 1'b1;
            MemtoReg <= 1'b0;
            RegWrite <= 1'b1;
            MemRead <= 1'b1;
            MemWrite <= 1'b0;
        end
        default: begin
            ALUOp <= 3'bzzz;
            RegDst <= 1'bz;
            ALUSrc <= 1'bz;
            MemtoReg <= 1'bz;
            RegWrite <= 1'bz;
            MemRead <= 1'bz;
            MemWrite <= 1'bz;
        end
    endcase


end

endmodule