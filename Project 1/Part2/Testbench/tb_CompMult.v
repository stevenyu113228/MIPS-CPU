// 被乘數、乘數在第51、52行定義
`timescale 1ns/ 1ps
module tb_CompMult;
reg [31:0] Multiplicand_in;
reg [31:0] Multiplier_in;
reg run;
reg reset;
reg clk;


wire ready;
wire [63:0] Product_out;
// wire wrctrl;
// wire [31:0]Multiplicand_out;
// wire [63:0] Product_inA;
// wire [63:0]Product_in;
// wire [5:0]addctrl;
// wire strctrl;
// wire [31:0]counter;

CompMult cm(
    Multiplicand_in,
    Multiplier_in,
    run,
    reset,
    clk,
    ready,
    Product_out
    // Multiplicand_out
    // Product_inA
    // Product_in,
    // addctrl,
    // strctrl,
    // counter
);

integer i;
initial begin
    clk <= 0;
    reset <= 0;
    run <= 0;
    Multiplicand_in <= 0;
    Multiplier_in <= 0;

    #1
    clk = 1;

    // initial
    reset <= 1;
    run <= 0;
    Multiplicand_in <= 32'd15;
    Multiplier_in <= 32'd19;

    #1
    clk = 0;
    #1 
    clk = 1;

    reset <= 0;
    run <= 1;

    #1
    clk = 0;
    #1 
    clk = 1;

    run <= 0;

    for(i=0;i<100;i=i+1)begin
        #1
        clk = 0;
        #1 
        clk = 1;
    end

    reset <= 1;

    #1
    clk = 0;
    #1 
    clk = 1;


end

endmodule