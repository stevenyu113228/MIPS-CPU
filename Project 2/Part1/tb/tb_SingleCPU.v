`timescale 1ns / 1ps
module tb_SingleCPU;
reg [31:0] Addr_in;
reg clk;
wire [31:0] Addr_o;
integer i;

SingleCPU singlecpu(
    Addr_in,
    clk,
    Addr_o
);

initial begin
clk <= 1;
  for(i=0;i<28;i=i+4)begin
    #10
    clk <= !clk;
    #10
    clk <= !clk;
    Addr_in <= i;
    end
end

endmodule