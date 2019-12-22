module PipelineCPU(
    input [31:0]Addr_in,
    input clk,
    output [31:0]Addr_o
);

wire [31:0]instr_Addr;
wire PCWrite;
PC pc(
    .clk(clk),
    .address_in(Addr_in),
    .enable(PCWrite),
    .address_o(instr_Addr)
);

wire [31:0]instr;
IM im(
    .Addr_in(instr_Addr),
    .instr(instr)
);


Adder adder(
    .data1(instr_Addr),
    .data2(32'd4),
    .data_o(Addr_o)
);

///////////////////////////////////////////
wire IF_IDWrite;
wire [31:0]instr_o;
IF_ID if_id(
    .clk(clk),
    .enable(IF_IDWrite),
    .instruction_in(instr),
    .instruction_out(instr_o)
);
wire [4:0]RT_addr;
wire ID_EX_MemRead;
wire stall;
wire ID_EX_RegisterRt;
wire IF_ID_RegisterRs;
wire IF_ID_RegisterRt;
assign ID_EX_RegisterRt = RT_addr;
assign IF_ID_RegisterRs = instr[25:21];
assign IF_ID_RegisterRt = instr[20:16];

Hazard_detection hz_det(
    .clk(clk),
    .ID_EX_MemRead(ID_EX_MemRead),
    .ID_EX_RegisterRt(ID_EX_RegisterRt),
    .IF_ID_RegisterRs(IF_ID_RegisterRs),
    .IF_ID_RegisterRt(IF_ID_RegisterRt),
    .stall_mux(stall),
    .IF_ID_Write(IF_IDWrite),
    .PC_Write(PCWrite)
);


wire RegDst;
wire MemRead;
wire MemtoReg;
wire [2:0]ALUOp;
wire MemWrite;
wire ALUSrc;
wire RegWrite;

Control control(
    .Op(instr[31:26]),
    .RegDst(RegDst),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
);

wire RegDst_o;
wire MemRead_o;
wire MemtoReg_o;
wire [2:0]ALUOp_o;
wire MemWrite_o;
wire ALUSrc_o;
wire RegWrite_o;

wire [22:0]tmp;
MUX32b stall_mux(
    .data1({23'b0,RegDst,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite}),
    .data2(32'b0),
    .select(stall),
    .data_o({tmp,RegDst_o,MemRead_o,MemtoReg_o,ALUOp_o,MemWrite_o,ALUSrc_o,RegWrite_o})
);

wire [1:0]WB_ooo;
wire [4:0]WB_addr_oo;
wire [31:0]WB_data;
wire [31:0]read1;
wire [31:0]read2;

RF rf(
    .clk(clk),
    .RegWrite(WB_ooo[1]),
    .RSaddr(instr[25:21]),
    .RTaddr(instr[20:16]),
    .RDaddr(WB_addr_oo),
    .RDdata(WB_data),

    .RTdata(read2),
    .srcl(read1)
);

wire [31:0]SE_o;
SE se(
    .data_i(instr[15:0]),
    .data_o(SE_o)
);

///////////////////////////////////////////////

wire [1:0]WB_o;
wire [1:0]MEM_o;
wire [4:0]EX_o;
wire [31:0]SE_oo;
wire [4:0]RS_addr;
wire [4:0]RD_addr;
wire [31:0]read1_o;
wire [31:0]read2_o;
wire [4:0]shamt_o;

ID_EX id_ex(
    .clk(clk),
    .WB_in({RegWrite_o,MemtoReg_o}),
    .M_in({MemWrite_o,MemRead_o}),
    .EX_in({RegDst_o,ALUSrc_o,ALUOp_o}),
        //   [4]RegDst [3]ALUSrc   [2:0] ALUOp
    .RTdata_in(read2),
    .srcl_in(read1),
    .shamt_in(instr[10:6]),
    .se_in(SE_o),
    // .R_add_in(),
    // .I_add_in(),
    .Rs_in(instr[25:21]),
    .Rt_in(instr[20:16]),
    .Rd_in(instr[15:11]),

    .WB_out(WB_o),
    .M_out(MEM_o),
    .EX_out(EX_o),
    .RTdata_out(read2_o),
    .srcl_out(read1_o),
    .shamt_out(shamt_o),
    .se_out(SE_oo),
    // .R_add_out()
    // .I_add_out()
    .Rs_out(RS_addr),
    .Rt_out(RT_addr),
    .Rd_out(RD_addr)
);


assign ID_EX_MemRead = MEM_o[0];

wire [31:0]ALU_o;
wire [1:0]ALU_src1;
wire [31:0]ALU_in1;

MUX32_3to1 mux32_3to1A(
    .data1(read1_o),
    .data2(WB_data),
    .data3(ALU_o),
    .select(ALU_src1),
    .data_o(ALU_in1)
);

wire [1:0]ALU_src2;
wire [31:0]To_MEM;
MUX32_3to1 mux32_3to1B(
    .data1(read2_o),
    .data2(WB_data),//換
    .data3(ALU_o), // 換
    .select(ALU_src2),
    .data_o(To_MEM)
);

wire [31:0]ALU_in2;
MUX32b mux32_2to1(
    .data1(To_MEM),
    .data2(SE_oo),
    .select(EX_o[3]),
    .data_o(ALU_in2)
);

wire [4:0]WB_addr;
MUX5b mux5_2to1(
    .data1(RT_addr),
    .data2(RD_addr),
    .select(EX_o[4]),
    .data_o(WB_addr)
);

wire [5:0]ALU_Op;
ALUctrl aluctrl(
    .funct(SE_oo[5:0]),
    .ALUOp(EX_o[2:0]),
    .operation(ALU_Op)
);

wire [31:0]ALU_out;
ALU alu(
    .shamt(shamt_o),
    .src1(ALU_in1),
    .src2(ALU_in2),
    .operation(ALU_Op),
    .result(ALU_out)
);

wire [4:0]WB_addr_o;
wire [1:0]WB_oo;
Forwarding fw(
    .clk(clk),
    .ID_EX_Rs(RS_addr),
    .ID_EX_Rt(RT_addr),
    .EX_MEM_Rd(WB_addr_o),
    .MEM_WB_Rd(WB_addr_oo),
    .EX_MEM_RegWrite(WB_oo[1]),
    .MEM_WB_RegWrite(WB_ooo[1]),

    .ForwardA(ALU_src1),
    .ForwardB(ALU_src2)
);

///////////////////////////////////////////////

wire [1:0]MEM_oo;
// wire [31:0]ALU_o;
wire [31:0]in_MEM;
EX_MEM ex_mem(
    .clk(clk),
    .WB_in(WB_o),
    .M_in(MEM_o),
    .ALUresult_in(ALU_out),
    .write_mem_data_in(To_MEM),
    .write_register_in(WB_addr),
    // .Rd_in()

    .WB_out(WB_oo),
    .M_out(MEM_oo),
    .ALUresult_out(ALU_o),
    .write_mem_data_out(in_MEM),
    .write_register_out(WB_addr_o)
);

wire [31:0]MEM_data;
DM dm(
    .clk(clk),
    .addr(ALU_o),
    .data(in_MEM),
    .MemRead(MEM_oo[0]),
    .MemWrite(MEM_oo[1]),
    .DM_data(MEM_data)
);

////////////////////////////////////////
wire [31:0]MEM_data_o;
wire [31:0]ALU_oo;

MEM_WB mem_wb(
    .clk(clk),
    .WB_in(WB_oo),
    .Read_data_in(MEM_data),
    .ALUresult_in(ALU_o),
    .write_register_in(WB_addr_o),
    // .RD_in()

    .WB_out(WB_ooo),
    .Read_data_out(MEM_data_o),
    .ALUresult_out(ALU_oo),
    .write_register_out(WB_addr_oo)
);

MUX32b mux32b_memtoreg(
    .data1(ALU_oo),
    .data2(MEM_data_o),
    .select(WB_ooo[0]),
    .data_o(WB_data)
);


endmodule