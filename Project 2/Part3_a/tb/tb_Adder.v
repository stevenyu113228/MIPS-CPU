module tb_Adder;
reg [31:0] data1;
reg [31:0] data2;
wire [31:0] data_o;
integer i;

Adder uut(
    data1,
    data2,
    data_o
);


initial begin 
for(i = 0; i<31;i=i+1)begin
    #10
    data1 = i;
    data2 = i*10;
end
end
endmodule