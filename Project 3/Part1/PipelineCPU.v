module PipelineCPU(
    input clk,
    input [31:0]Addr_in,
    output [31:0]Addr_o
);



Adder adder(
    .data1(Addr_in),
    .data2(32'd4),
    .data_o(Addr_o)
);
//////////////////////////
wire [31:0]instr;
IM im(
    .Addr_in(Addr_in),
    .instr(instr)
);

wire [31:0]instruction;
IF_ID if_id(
    .clk(clk),
    .instruction_in(instr),
    .instruction_out(instruction)   
);

//////////////////////////////

wire wb1;
wire [1:0]m1;
wire [2:0]ex1;
Control control(
    .Op(instruction[31:26]),
    .RegWrite(wb1),
    .MemRead(m1[0]),
    .MemWrite(m1[1]),
    .ALUOp(ex1)
);



wire wb4;
wire [31:0]ALUresult3;
wire [4:0]write_register4;
wire [31:0]RTdata;
wire [31:0]srcl;
RF rf(
    .clk(clk),
    .RegWrite(wb4),
    .RSaddr(instruction[25:21]),
    .RTaddr(instruction[20:16]),
    .RDaddr(write_register4),
    .RDdata(ALUresult3),
    
    .RTdata(RTdata),
    .srcl(srcl)
);



wire wb2;
wire [1:0]m2;
wire [2:0]ex2;
wire [31:0] RTdata1;
wire [31:0] srcl1;
wire [4:0] shamt1;
wire [5:0] aluctrl1;
wire [4:0] write_register2;

ID_EX id_ex(
    .clk(clk),
    .WB_in(wb1),
    .M_in(m1),
    .EX_in(ex1),
    .RTdata_in(RTdata),
    .srcl_in(srcl),
    .shamt_in(instruction[10:6]),
    .aluctrl_in(instruction[5:0]),
    .write_register_in(instruction[15:11]),

    .WB_out(wb2),
    .M_out(m2),
    .EX_out(ex2),
    .RTdata_out(RTdata1),
    .srcl_out(srcl1),
    .shamt_out(shamt1),
    .aluctrl_out(aluctrl1),
    .write_register_out(write_register2)

);

/////////////////////////////

wire [5:0]ALUoperation;

ALUctrl aluctrl(
    .funct(aluctrl1),
    .ALUOp(ex2),
    .operation(ALUoperation)
);


wire [31:0]ALUresult1;
ALU alu(
    .shamt(shamt1),
    .src1(srcl1),
    .src2(RTdata1),
    .operation(ALUoperation),
    .result(ALUresult1)
);

wire wb3;
wire [1:0]m3;
wire [31:0]ALUresult2;
wire [4:0]write_register3;
EX_MEM ex_mem(
    .clk(clk),
    .WB_in(wb2),
    .M_in(m2),
    .ALUresult_in(ALUresult1),
    .write_register_in(write_register2),

    .WB_out(wb3),
    .M_out(m3),
    .ALUresult_out(ALUresult2),
    .write_register_out(write_register3)
);

/////////////////////////////////////////////
wire [31:0]Read_data;
DM dm(
    .clk(clk),
    .addr(ALUresult2),
    .MemRead(m3[1]),
    .MemWrite(m3[0]),
    .DM_data(Read_data)
);

MEM_WB mem_wb(
    .clk(clk),
    .WB_in(wb3),
    .Read_data_in(Read_data),
    .ALUresult_in(ALUresult2),
    .write_register_in(write_register3),

    .WB_out(wb4),
    .ALUresult_out(ALUresult3),
    .write_register_out(write_register4)
);

endmodule