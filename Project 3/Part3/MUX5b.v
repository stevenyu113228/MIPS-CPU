module MUX5b(
    input [4:0] data1,
    input [4:0] data2,
    input select,
    output [4:0] data_o
);

assign data_o = select?data2:data1;

endmodule