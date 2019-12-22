module tb_SingleCPU;
reg [31:0] Addr_in;
reg clk;
wire [31:0] Addr_o;
integer i;

SingleCPU uut(
    Addr_in,
    clk,
    Addr_o
);

initial begin
    i <= 0;
    clk <= 0;
    #10
    clk <= !clk;
    for(i=0;i<80;i=i+4)begin
        #10
        clk <= !clk;
        #10
        clk <= !clk;
        Addr_in <= i;
    end

end

endmodule