module ID_EX(
    input clk,
    input [1:0]WB_in,
    input [1:0]M_in,
    input [4:0]EX_in,
    input [31:0] RTdata_in,
    input [31:0] srcl_in,
    input [4:0] shamt_in,
    input [31:0] se_in,
    input [4:0] R_add_in,
    input [4:0] I_add_in,

    output reg [1:0]WB_out,
    output reg [1:0]M_out,
    output reg [4:0]EX_out,
    output reg [31:0] RTdata_out,
    output reg [31:0] srcl_out,
    output reg [4:0] shamt_out,
    output reg [31:0]se_out,
    output reg [4:0]R_add_out,
    output reg [4:0]I_add_out
);

initial begin
        WB_out = 2'b0;
        M_out = 2'b0;
        EX_out = 5'b0;
        RTdata_out = 32'b0;
        srcl_out = 32'b0;
        shamt_out = 5'b0;
        se_out = 32'b0;
        R_add_out = 5'b0;
        I_add_out = 5'b0;
end

always @(posedge clk)begin
        WB_out = WB_in;
        M_out = M_in;
        EX_out = EX_in;
        RTdata_out = RTdata_in;
        srcl_out = srcl_in;
        shamt_out = shamt_in;
        se_out = se_in;
        R_add_out = R_add_in;
        I_add_out = I_add_in;
end

endmodule