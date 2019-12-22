module tb_IM;
reg [31:0] Addr_in;
wire [31:0] instr;
integer i;


IM uut(
    Addr_in,
    instr
);


initial begin
    for(i=0;i<=20;i=i+4)begin
        #10
        Addr_in = i;
    end
    #10
    Addr_in = 0;

end

endmodule