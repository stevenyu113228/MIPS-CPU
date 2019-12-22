module tb_SE;
reg [15:0] data_i;
wire [31:0] data_o;
integer i;

SE uut(
    data_i,
    data_o
);

initial begin
    for(i=0;i<16'hffff;i=i+5)begin
       #10
       data_i =  i;
    end
end

endmodule