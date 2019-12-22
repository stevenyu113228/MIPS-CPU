module ID_EX(
    input clk,
    input WB_in,
    input [1:0]M_in,
    input [2:0]EX_in,
    input [31:0] RTdata_in,
    input [31:0] srcl_in,
    input [4:0] shamt_in,
    input [4:0] aluctrl_in,
    input [4:0] write_register_in,

    output reg WB_out,
    output reg [1:0]M_out,
    output reg [2:0]EX_out,
    output reg [31:0] RTdata_out,
    output reg [31:0] srcl_out,
    output reg [4:0] shamt_out,
    output reg [5:0] aluctrl_out,
    output reg [4:0] write_register_out
);

initial begin
        WB_out = 0;
        M_out = 2'b0;
        EX_out = 3'b0;
        RTdata_out = 32'b0;
        srcl_out = 32'b0;
        shamt_out = 4'b0;
        aluctrl_out = 5'b0;
        write_register_out = 4'b0;
end

always @(posedge clk)begin
        WB_out = WB_in;
        M_out = M_in;
        EX_out = EX_in;
        RTdata_out = RTdata_in;
        srcl_out = srcl_in;
        shamt_out = shamt_in;
        aluctrl_out = aluctrl_in;
        write_register_out = write_register_in;
end

endmodule