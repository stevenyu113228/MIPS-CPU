module CompMult(
    input [31:0] Multiplicand_in,
    input [31:0] Multiplier_in,
    input run,
    input reset,
    input clk,
    output ready,
    output [63:0] Product_out
    // output [31:0]Multiplicand_out
    // output [63:0] Product_inA
    // output [63:0]Product_in,
    // output [5:0]addctrl,
    // output strctrl,
    // output [31:0]counter
); 

wire strctrl;
wire wrctrl;
wire ze;
wire [5:0]addctrl;
wire [31:0]Multiplicand_out;
wire [63:0]Product_in;
wire [63:0] Product_inA;

wire [32:0]aluresult;

assign Product_in[63:32] = aluresult[32:1];
assign Product_in[31] = wrctrl ? Multiplier_in[31] : aluresult[0];
assign Product_in[30:0] = Multiplier_in[30:0];



Control ctrl(.run(run),
            .reset(reset),
            .clk(clk),
            .lsb(Product_out[0]),
            .ready(ready),
            .strctrl(strctrl),
            .wrctrl(wrctrl),
            .addctrl(addctrl)
);

Multiplicand mul(.Multiplicand_in(Multiplicand_in),
                .reset(reset),
                .wrctrl(wrctrl),
                .Multiplicand_out(Multiplicand_out)
);

ALU alu(.Src1(Multiplicand_out),
        .Src2(Product_out[63:32]),
        .funct(addctrl),
        .shamt(5'd0),
        .result(aluresult[31:0]),
        .zero(ze),
        .carry(aluresult[32])
);

Product pro(.Product_in(Product_in),
            .wrctrl(wrctrl),
            .strctrl(strctrl),
            .ready(ready),
            .reset(reset),
            .clk(clk),
            .Product_out(Product_out)
);


endmodule