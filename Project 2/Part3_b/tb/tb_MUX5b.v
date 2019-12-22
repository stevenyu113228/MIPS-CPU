module tb_MUX5b;
reg [4:0] data1;
reg [4:0] data2;
reg select;

wire [4:0] data_o;

MUX5b uut(
    data1,
    data2,
    select,
    data_o
);

initial begin
    data1 = 5'd12;
    data2 = 5'd37;
    select = 1'b1;
    #10
    select = 1'b0;
    
    #10
    select = 1'b1;
end

endmodule