module Adder(
    input [31:0] data1,
    input [31:0] data2,
    output [31:0] data_o
);

assign data_o = data1 + data2;

endmodule