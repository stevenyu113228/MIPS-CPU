module PC(
    input clk,
    input [31:0]address_in,
    input enable,

    output reg [31:0]address_o
);
initial begin
    address_o = 32'b0;
end

always@(posedge clk)begin
    if(enable)begin
    address_o <= address_in;
    end
end
// assign address_o = enable ? address_in:address_o;
endmodule
