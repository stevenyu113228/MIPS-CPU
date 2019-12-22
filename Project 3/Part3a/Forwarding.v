module Forwarding(
    input clk,
    input [4:0]ID_EX_Rs,
    input [4:0]ID_EX_Rt,
    input [4:0]EX_MEM_Rd,
    input [4:0]MEM_WB_Rd,
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,

    output reg [1:0]ForwardA,
    output reg [1:0]ForwardB
);
initial begin
    ForwardA = 2'b00;
    ForwardB = 2'b00;
end
// posedge 
always @(clk)begin
    if(EX_MEM_RegWrite == 1 &&
        EX_MEM_Rd != 0 &&
        EX_MEM_Rd == ID_EX_Rs)begin

        ForwardA = 2'b10;
    end

    else if(MEM_WB_RegWrite == 1 &&
        MEM_WB_Rd != 0 &&
        MEM_WB_Rd == ID_EX_Rs)begin

        ForwardA=2'b01;
    end

    else begin
        ForwardA=2'b00;
    end



    if(EX_MEM_RegWrite == 1 &&
        EX_MEM_Rd != 0 &&
        EX_MEM_Rd == ID_EX_Rt)begin

        ForwardB = 2'b10;
    end



    else if(MEM_WB_RegWrite == 1 &&
        MEM_WB_Rd != 0 &&
        MEM_WB_Rd == ID_EX_Rt)begin

        ForwardB = 2'b01;
    end

    else begin
        ForwardB = 2'b00;
    end
end



endmodule