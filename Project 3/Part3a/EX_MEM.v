module EX_MEM(
    input clk,
    input [1:0]WB_in,
    input [1:0]M_in,
    input [31:0]ALUresult_in,
    input [31:0]write_mem_data_in,
    input [4:0]write_register_in,
    input [4:0]Rd_in,

    output reg [1:0]WB_out,
    output reg [1:0]M_out,
    output reg [31:0]ALUresult_out,
    output reg [31:0]write_mem_data_out,
    output reg [4:0]write_register_out,
    output reg [4:0]Rd_out
);
initial begin
    WB_out = 2'b0;
    M_out = 2'b0;
    ALUresult_out = 32'b0;
    write_mem_data_out = 32'b0;
    write_register_out = 5'b0;
    Rd_out = 5'b0;
end

always @(posedge clk)begin
   WB_out = WB_in;
   M_out = M_in;
   ALUresult_out = ALUresult_in;
   write_mem_data_out = write_mem_data_in;
   write_register_out = write_register_in;
   Rd_out = Rd_in;
end

endmodule