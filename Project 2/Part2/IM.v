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


        Instr[6] = {6'd39,5'd11,5'd8,16'd2}; 
        Instr[7] = {6'd40,5'd11,5'd19,16'd2};
        Instr[8] = {6'd40,5'd11,5'd20,16'd3};
        Instr[9] = {6'd39,5'd10,5'd8,16'd2};
        Instr[10] = {6'd39,5'd9,5'd20,16'd4};
        Instr[11] = {6'd41,5'd20,5'd21,16'd40};
        Instr[12] = {6'd41,5'd21,5'd22,16'd22};
        Instr[13] = {6'd42,5'd22,5'd19,16'd8};
        Instr[14] = {6'd42,5'd16,5'd23,16'd2};




        instr = Instr[0];
    end

    always@(Addr_in)begin
        instr <= Instr[Addr_in>>2];
    end

endmodule
