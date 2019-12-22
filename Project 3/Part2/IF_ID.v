module IF_ID(
    input clk,
    input [31:0]instruction_in,
    output reg [31:0]instruction_out
);

initial begin
    instruction_out = 32'b0;
end



always @(posedge clk)begin
    instruction_out = instruction_in;
end


endmodule