module EX_MEM(
    input clk,
    input WB_in,
    input [1:0]M_in,
    input [31:0]ALUresult_in,
    input [4:0]write_register_in,

    output reg WB_out,
    output reg [1:0]M_out,
    output reg [31:0]ALUresult_out,
    output reg [4:0]write_register_out
);
initial begin
    WB_out = 0;
    M_out = 2'b0;
    ALUresult_out = 32'b0;
    write_register_out = 4'b0;
end

always @(posedge clk)begin
   WB_out = WB_in;
   M_out = M_in;
   ALUresult_out = ALUresult_in;
   write_register_out = write_register_in;
end

endmodule