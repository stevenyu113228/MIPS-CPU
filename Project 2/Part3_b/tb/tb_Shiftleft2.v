module tb_Shiftleft2;
reg [31:0]data_i;
wire [31:0]data_o;


Shiftleft2 uut(
    data_i,
    data_o
);


initial begin
    data_i = 32'd132;
    #10
    data_i = 32'd111;
    #10
    data_i = 32'd25;
    #10
    data_i = 0;
end


endmodule