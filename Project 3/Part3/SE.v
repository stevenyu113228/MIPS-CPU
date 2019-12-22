module SE(
    input [15:0] data_i,
    output [31:0] data_o
);
assign data_o = data_i[15]?{16'hffff,data_i}:{16'h0000,data_i};


endmodule
