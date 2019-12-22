`timescale 1ns/ 1ps
module tb_Product;
reg [63:0] Product_in;
reg wrctrl;
reg strctrl;
reg ready;
reg reset;
reg clk;
wire[63:0] Product_out;


Product pro(
    Product_in,
    wrctrl,
    strctrl,
    ready,
    reset,
    clk,
    Product_out
    );


initial begin

    Product_in[63:32] <= 32'd0;

////////////////////////////////////////////
    // 初始訊號
    clk <= 1;
    reset <= 1;
    wrctrl <= 0;
    strctrl <= 0;
    ready <= 0;
    Product_in[31:0] <= 32'b0;
    // out = 0

    #1
    clk <= 0;
    #1
    clk <= 1;
   
   // load multiplier
    reset <= 0;
    wrctrl <= 1;
    Product_in[31:0] <= 32'b11;
    //out = 11

    #1
    clk <= 0;
    #1
    clk <= 1;

    wrctrl <= 0;
    if(Product_out) begin
        strctrl <= 1;
        Product_in[62:31] <= 32'b1111 + Product_out[63:32];
        Product_in[63] <= 0;
    end
    // 加法
    // out 左半1111 + 0000 右半1111


    #1
    clk <= 0;
    #1
    clk <= 1;

    strctrl <= 0;
    //位移
    

    #1
    clk <= 0;
    #1
    clk <= 1;

    if(Product_out) begin
        strctrl <= 1;
        Product_in[62:31] <= 32'b1111 + Product_out[63:32];
        Product_in[63] <= 0;
    end
    //加法

    #1
    clk <= 0;
    #1
    clk <= 1;

    strctrl <= 0;
    //位移


    #1
    clk <= 0;
    #1
    clk <= 1;

        if(Product_out) begin
        strctrl <= 1;
        Product_in[62:31] <= 32'b1111 + Product_out[63:32];
        Product_in[63] <= 0;
    end
    //加法

    #1
    clk <= 0;
    #1
    clk <= 1;

    strctrl <= 0;
    //位移


    #1
    clk <= 0;
    #1
    clk <= 1;

    if(Product_out) begin
        strctrl <= 1;
        Product_in[62:31] <= 32'b1111 + Product_out[63:32];
        Product_in[63] <= 0;
    end
    //加法

    #1
    clk <= 0;
    #1
    clk <= 1;

    strctrl <= 0;
    //位移


    #1
    clk <= 0;
    #1
    clk <= 1;



end 

endmodule