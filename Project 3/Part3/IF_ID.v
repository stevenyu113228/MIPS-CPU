module IF_ID(
    input clk,
    input enable,
    input [31:0]instruction_in,
    output reg [31:0]instruction_out
);

initial begin
    instruction_out = 32'b0;
end



always @(posedge clk)begin
    instruction_out = enable?instruction_in:instruction_out;
end


endmodule