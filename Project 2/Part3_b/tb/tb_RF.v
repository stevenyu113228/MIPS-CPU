`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/18 15:56:22
// Design Name: 
// Module Name: tb_RF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//~ `New testbench
`timescale  1ns / 1ps

module tb_RF;

// RF Inputs
reg   clk = 0 ;
reg   RegWrite = 0 ;
reg   [4:0]  RSaddr = 0 ;
reg   [4:0]  RTaddr = 0 ;
reg   [4:0]  RDaddr = 0 ;
reg   [31:0]  RDdata = 0 ;

// RF Outputs
wire  [31:0]  RTdata;
wire  [31:0]  srcl;
integer i;


RF u_RF(
    clk,
    RegWrite,
    RSaddr,
    RTaddr,
    RDaddr,
    RDdata,
    RTdata,
    srcl
);




initial
begin
    clk = 1;
    for(i=0;i<32;i=i+1)begin
    #10
    clk = !clk;
    #10
    clk = !clk;
    RSaddr = i;
    RTaddr = 31-i;
    end

    RegWrite = 1;
    for(i=0;i<32;i=i+1)begin
    #10
    clk = !clk;
    #10
    clk = !clk;
    RDaddr = i;
    RDdata = i*10;
    end

    for(i=0;i<32;i=i+1)begin
    #10
    clk = !clk;
    #10
    clk = !clk;
    RSaddr = i;
    end



end

endmodule