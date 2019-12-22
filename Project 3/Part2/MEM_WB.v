module MEM_WB(
    input clk,
    input [1:0]WB_in,
    input [31:0]Read_data_in,
    input [31:0]ALUresult_in,
    input [4:0]write_register_in,

    output reg [1:0]WB_out,
    output reg [31:0]Read_data_out,
    output reg [31:0]ALUresult_out,
    output reg [4:0]write_register_out
);


initial begin
    WB_out = 2'b0;
    Read_data_out = 32'b0;
    ALUresult_out = 32'b0;
    write_register_out = 5'b0;
end

always @(posedge clk)begin
    WB_out = WB_in;
    Read_data_out = Read_data_in;
    ALUresult_out = ALUresult_in;
    write_register_out = write_register_in;
end


endmodule