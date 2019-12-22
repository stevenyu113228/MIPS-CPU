module ALU(input [4:0] shamt,
           input [31:0] src1,
           input [31:0] src2,
           input [5:0] operation,
           output reg [31:0] result,
           output zero);

/*
 add 27
 sub 28
 and 29
 or 30
 srl 31
 sll 32
 */

assign zero = result==0?1:0;

always@(*)begin
    case(operation)
    6'd27:
        result <= src1 + src2;
    6'd28:
        result <= src1 - src2;
    6'd29:
        result <= src1 & src2;
    6'd30:
        result <= src1 | src2;
    6'd31:
        result <=  src2 >> shamt;
    6'd32:
        result <= src2 << shamt;
    default:
        result <= 0;
    endcase
end
endmodule

