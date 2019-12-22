module IM(input [31:0] Addr_in,
          output reg [31:0] instr);
    
    reg [31:0]Instr[31:0];
    
    initial begin
        Instr[0] = {6'd54,5'd9,5'd10,5'd8,5'd0,6'd21};
        Instr[1] = {6'd54,5'd9,5'd10,5'd9,5'd0,6'd22};

        Instr[2] = {6'd54,5'd13,5'd11,5'd11,5'd0,6'd23};
        Instr[3] = {6'd54,5'd11,5'd13,5'd13,5'd0,6'd24};
        Instr[4] = {6'd54,5'd0,5'd12,5'd11,5'd2,6'd25};
        Instr[5] = {6'd54,5'd0,5'd15,5'd13,5'd5,6'd26};
        instr = Instr[0];
    end

    always@(Addr_in)begin
        instr <= Instr[Addr_in>>2];
    end

endmodule
