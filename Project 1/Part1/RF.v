module RF(
    input  [4:0]Src1addr,
    input  [4:0]Src2addr,
    output [31:0]Src1,
    output [31:0]Src2
);
    REGISTER_SEL src1_sel(Src1addr,Src1);
    REGISTER_SEL src2_sel(Src2addr,Src2);

endmodule

module REGISTER_SEL(
    input [4:0]Srcaddr,
    output reg [31:0]src
);
    always @(Srcaddr)begin
        case (Srcaddr[4:0])
            5'd0: src <= 0;
            5'd1: src <= 1;
            5'd2: src <= 2;
            5'd3: src <= 3;
            5'd4: src <= 4;
            5'd5: src <= 5;
            5'd6: src <= 6;
            5'd7: src <= 7;
            5'd8: src <= 8;
            5'd9: src <= 9;
            5'd10: src <= 10;
            5'd11: src <= 11;
            5'd12: src <= 12;
            5'd13: src <= 13;
            5'd14: src <= 14;
            5'd15: src <= 15;
            5'd16: src <= 16;
            5'd17: src <= 17;
            5'd18: src <= 18;
            5'd19: src <= 19;
            5'd20: src <= 20;
            5'd21: src <= 21;
            5'd22: src <= 22;
            5'd23: src <= 23;
            5'd24: src <= 24;
            5'd25: src <= 25;
            5'd26: src <= 26;
            5'd27: src <= 27;
            5'd28: src <= 28;
            5'd29: src <= 29;
            5'd30: src <= 30;
            5'd31: src <= 31;
        endcase
    end
endmodule