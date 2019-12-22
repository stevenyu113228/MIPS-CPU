module SingleCPU(
    input [31:0] Addr_in,
    input clk,
    output [31:0] Addr_o
    // output [31:0] alu_result,
    // output ALUSrc
    // output [31:0]mux32b1_out,
    // output [31:0]dm_out
);

wire [31:0]instruction;


// ctrlㄉout
wire RegDst;
wire MemRead;
wire MemtoReg;
wire [2:0]ALUOp;
wire MemWrite;
wire ALUSrc;
wire RegWrite;


wire [4:0]write_register;

wire [31:0]se_out;


wire [31:0]write_data;

wire [31:0]register1_out;
wire [31:0]register2_out;

wire [31:0]mux32b1_out;

wire [5:0]operation;

wire [31:0]alu_result;

wire zero;

wire [31:0]dm_out;

Adder adder(
    .data1(4),
    .data2(Addr_in),
    .data_o(Addr_o)
);

IM im(
    .Addr_in(Addr_in),
    .instr(instruction)
);

MUX5b mux5b(
    .data1(instruction[20:16]),
    .data2(instruction[15:11]),
    .select(RegDst),
    .data_o(write_register)
);

SE se(
    .data_i(instruction[15:0]),
    .data_o(se_out)
);

Control control(
    .Op(instruction[31:26]),
    .RegDst(RegDst),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
);

RF rf(
    .clk(clk),
    .RegWrite(RegWrite),
    .RSaddr(instruction[25:21]),
    .RTaddr(instruction[20:16]),
    .RDaddr(write_register),
    .RDdata(write_data),
    .RTdata(register2_out),
    .srcl(register1_out)
);

MUX32b mux32b1(
    .data1(register2_out),
    .data2(se_out),
    .select(ALUSrc),
    .data_o(mux32b1_out)
);

ALU alu(
    .shamt(instruction[10:6]),
    .src1(register1_out),
    .src2(mux32b1_out),
    .operation(operation),
    .result(alu_result),
    .zero(zero)
);

ALUctrl aluctrl(
    .funct(instruction[5:0]),
    .ALUOp(ALUOp),
    .operation(operation)
);

DM dm(
    .clk(clk),
    .addr(alu_result),
    .data(register2_out),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .DM_data(dm_out)
);

MUX32b mux32b2(
    .data1(alu_result),
    .data2(dm_out),
    .select(MemtoReg),
    .data_o(write_data)
);

endmodule