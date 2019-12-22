module tb_DM;
reg clk;
reg [31:0] addr;
reg [31:0] data;
reg MemRead;
reg MemWrite;
wire [31:0] DM_data;



DM uut(
    clk,
    addr,
    data,
    MemRead,
    MemWrite,
    DM_data
);

initial begin
    clk = 0;
    #10
    clk <= !clk;
    MemRead <= 0;
    MemWrite <= 1;
    data <= 32'd10;
    addr <= 32'd10;
    #10
    clk<= !clk;
    #10
    clk<= !clk;
    MemRead <= 1;
    MemWrite <= 0;
    addr <= 32'd10;
    #10
    clk <= !clk;

end

endmodule