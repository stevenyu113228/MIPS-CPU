module MUX32b(
    input [31:0] data1,
    input [31:0] data2,
    input select,
    output [31:0] data_o
);

assign data_o = select?data2:data1;
// assign data_o = data1;

endmodule