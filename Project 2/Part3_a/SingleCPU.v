module SingleCPU(
    input [31:0] Addr_in,
    input clk,
    output [31:0] Addr_o
);

//adder out
wire [31:0]adder_o;

//im out
wire [31:0]instruction;

//mux5b out
wire [4:0]RDaddr;

//control out
wire RegDst;
wire MemRead;
wire MemtoReg;
wire [2:0]ALUOp;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire Jump;
wire Branch;

//se out
wire [31:0]se_out;

// RF_in
wire [31:0]write_data;
// RF out
wire [31:0]register1_out;
wire [31:0]register2_out;

//mux32b1 out
wire [31:0]mux32b1_out;

//Aluctrl out
wire [5:0]operation;

//alu out
wire [31:0]alu_result;
wire zero;

//dm out
wire [31:0]dm_out;

// alu1 in
wire [31:0]alu1_in;

//alu1 out
wire [31:0]alu1_result;
wire zero1;

// and_out
wire and_out;

wire [31:0]mux32b3_o;

Adder adder(
    .data1(4),
    .data2(Addr_in),
    .data_o(adder_o)
);

IM im(
    .Addr_in(Addr_in),
    .instr(instruction)
);

MUX5b mux5b(
    .data1(instruction[20:16]),
    .data2(instruction[15:11]),
    .select(RegDst),
    .data_o(RDaddr)
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
    .RegWrite(RegWrite),
    .Jump(Jump),
    .Branch(Branch)
);

RF rf(
    .clk(clk),
    .RegWrite(RegWrite),
    .RSaddr(instruction[25:21]),
    .RTaddr(instruction[20:16]),
    .RDaddr(RDaddr),
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

Shiftleft2 sl1(
    .data_i(se_out),
    .data_o(alu1_in)
);


ALU alu1(
    .shamt(5'b0),
    .src1(alu1_in),
    .src2(adder_o),
    .operation(6'd27), //add
    .result(alu1_result),
    .zero()
);

and (and_out,Branch,zero);

MUX32b mux32b3(
    .data1(adder_o),
    .data2(alu1_result),
    .select(and_out),
    .data_o(mux32b3_o)
);


MUX32b mux32b4(
    .data1(mux32b3_o),
    .data2({adder_o[31:28],instruction[25:0],2'b00}),
    .select(Jump),
    .data_o(Addr_o)
);


endmodule