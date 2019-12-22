module tb_MUX32b;
reg [31:0] data1;
reg [31:0] data2;
reg select;

wire [31:0] data_o;

MUX32b uut(
    data1,
    data2,
    select,
    data_o
);

initial begin
    data1 = 32'd314159;
    data2 = 32'd123456;
    select = 1'b1;
    #10
    select = 1'b0;
    
    #10
    select = 1'b1;
end

endmodule