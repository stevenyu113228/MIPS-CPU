module Hazard_detection(
    input clk,
    input ID_EX_MemRead,
    input ID_EX_RegisterRt,
    input IF_ID_RegisterRs,
    input IF_ID_RegisterRt,

    output reg stall_mux,
    output reg IF_ID_Write,
    output reg PC_Write
);


initial begin
    stall_mux <= 0;
    IF_ID_Write <= 1;
    PC_Write <= 1;
end

//posedge clk
always @(*)begin
    if(ID_EX_MemRead &&(
        (ID_EX_RegisterRt == IF_ID_RegisterRs) || (ID_EX_RegisterRt == IF_ID_RegisterRt)
        ))begin
        stall_mux = 1;
        IF_ID_Write = 0;
        PC_Write = 0;
    end
    else begin
        stall_mux = 0;
        IF_ID_Write = 1;
        PC_Write = 1;
    end
end



endmodule