module ALUctrl(
    input [5:0] funct,
    input [2:0] ALUOp,
    output reg[5:0] operation
);

always@(funct or ALUOp)begin
    if(ALUOp == 3'b010)begin
        case(funct)
        6'd21:
            operation <= 27;
        6'd22:
            operation <= 28;
        6'd23:
            operation <= 29;
        6'd24:
            operation <= 30;
        6'd25:
            operation <= 31;
        6'd26:
            operation <= 32;
        endcase
    end
    else if (ALUOp == 3'b000)begin //lw sw addi
        operation <= 27; //add
    end
    else if (ALUOp == 3'b001)begin //sbui 
        operation <= 28; //sub
        
    end
end

endmodule