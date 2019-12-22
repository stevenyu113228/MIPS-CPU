module IM(input [31:0] Addr_in,
          output reg [31:0] instr);
    
    reg [31:0]Instr[31:0];
    
    initial begin
            Instr[0] = {6'd41,5'd0,5'd16,16'd666};
            Instr[1] = {6'd41,5'd0,5'd17,16'd777};
            Instr[2] = {6'd41,5'd16,5'd16,16'd111};
            Instr[3] = {6'd42,5'd17,5'd17,16'd111};
            Instr[4] = {6'd54,5'd18,5'd17,5'd8,5'd0,6'd22};
            Instr[5] = {6'd54,5'd0,5'd8,5'd8,5'd31,6'd25};
            Instr[6] = {6'd41,5'd0,5'd9,16'd1};

            Instr[7] = {6'd31,5'd8,5'd9,16'd2};
            Instr[8] = {6'd41,5'd0,5'd18,16'd555};
            Instr[9] = {6'd31,5'd0,5'd0,16'd1};

            Instr[10] = {6'd41,5'd0,5'd18,16'd888};

            Instr[11] = {6'd41,5'd0,5'd8,16'd0};
            Instr[12] = {6'd39,5'd8,5'd16,16'd0};
            Instr[13] = {6'd39,5'd8,5'd17,16'd4};
            Instr[14] = {6'd39,5'd8,5'd18,16'd8};

            instr = Instr[0];
    end

    always@(Addr_in)begin
        instr <= Instr[Addr_in>>2];
    end

endmodule

/*
addi s0 zero 666 
// num1 = 666

addi s1 zero 777 
// num2 = 777

addi s0 s0 111
// num1 = num1 + 111

subi s1 s1 111
// num2 = num2 - 111

sub t0 s2 s1 
// t0 = s2 - s1

srl t0 t0 31
// t0 = t0 >> 31

addi t1 zero 1
// t1 = 1

beq t0 t1 1
// if (t0 == t1 == 1) , jump

addi s2 zero 555
// s2 = 555 (no jump)

addi s2 zero 888
// s2 = 888 (jump)



addi t0 zero 0
sw s0 0 t0
sw s1 4 t0
sw s2 8 t0
*/
