`timescale 1ns/ 1ps
module tb_RF;

reg [4:0] Src1addr;
reg [4:0] Src2addr;
wire [31:0] Src1;
wire [31:0] Src2;
integer i;

RF registerf(Src1addr,Src2addr,Src1,Src2);

initial begin
    Src1addr = 0;
    Src2addr = 0;
    #10;
    for(i=0;i<31;i=i+1)begin
        Src1addr = i;
        Src2addr = i+1;
        #10;
    end
end

endmodule