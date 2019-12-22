`timescale 1ns/ 1ps
module tb_Multiplicand;

// input
reg [31:0]Multiplicand_in;
reg reset;
reg wrctrl;

// output
wire [31:0] Multiplicand_out;

Multiplicand mul(
    Multiplicand_in,
    reset,
    wrctrl,
    Multiplicand_out
);

initial begin
    Multiplicand_in = 0;
    reset = 0;
    wrctrl = 0;
    #10 
    // zzzzzz



    Multiplicand_in = 32'd123;
    wrctrl = 1;
    #10
    // 123

    reset = 1;
    // 00000

    #10
    reset = 0;

end

endmodule