module Multiplicand(
    input [31:0]Multiplicand_in,
    input reset,
    input wrctrl,
    output reg [31:0] Multiplicand_out
);

reg [31:0]Multiplicand_out_reg;
initial begin 
Multiplicand_out_reg = 0;
end
always @(reset or wrctrl)begin

    if(reset)
        Multiplicand_out_reg = 32'd0;
    else if (wrctrl) 
        Multiplicand_out_reg = Multiplicand_in;
    
    Multiplicand_out = Multiplicand_out_reg;
    
end

endmodule