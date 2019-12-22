module SingleCPU(input [31:0] Addr_in,
                 input clk,
                 output [31:0] Addr_o
                //  output [31:0] ALU_out,
                //  output [5:0]operation,
                //  output [31:0] RTdata,
                //  output [31:0] srcl,
                //  output [31:0] instruction
                 );

    wire [31:0]instruction;
    wire [31:0]ALU_out;
    
    wire [31:0] RTdata;
    wire [31:0] srcl;
    
    wire RegWrite;
    wire [2:0]ALUOp;
    
    wire [5:0]operation;
    
    wire zero;
    
    Adder adder(
    32'd4,
    Addr_in,
    Addr_o
    );
    
    IM im(
    Addr_in,
    instruction
    );
    
    RF rf(
    clk,
    RegWrite,
    instruction[25:21],
    instruction[20:16],
    instruction[15:11],
    ALU_out,
    RTdata,
    srcl);
    
    Control ctrl(
    instruction[31:26],
    RegWrite,
    ALUOp
    );
    
    ALUctrl aluctrl(
    instruction[5:0],
    ALUOp,
    operation);

    ALU alu(
    instruction[10:6],
    srcl,
    RTdata,
    operation,
    ALU_out,
    zero
    );
    
    
    
    
endmodule
