module MUX32_3to1(
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [1:0]select,

    output reg [31:0] data_o

);
always @(*)begin
    data_o = select[1]? data3 : (select[0]?data2:data1);
end
endmodule