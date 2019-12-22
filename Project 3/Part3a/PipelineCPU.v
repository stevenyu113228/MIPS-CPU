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

wire [1:0]wb1;
wire [1:0]m1;
wire [4:0]ex1;
Control control(
    .Op(instruction[31:26]),
    .RegWrite(wb1[0]),
    .MemtoReg(wb1[1]),

    .MemRead(m1[0]),
    .MemWrite(m1[1]),
    .RegDst(ex1[0]),
    .ALUOp(ex1[3:1]),
    .ALUSrc(ex1[4])
);



wire [1:0]wb4;
wire [31:0]write_reg_data;
wire [4:0]write_register4;
wire [31:0]RTdata;
wire [31:0]srcl;
RF rf(
    .clk(clk),
    .RegWrite(wb4[0]),
    .RSaddr(instruction[25:21]),
    .RTaddr(instruction[20:16]),
    .RDaddr(write_register4),
    .RDdata(write_reg_data),
    
    .RTdata(RTdata),
    .srcl(srcl)
);


wire [31:0]se_o;

SE se(
     .data_i(instruction[15:0]),
     .data_o(se_o)
);


wire [1:0]wb2;
wire [1:0]m2;
wire [4:0]ex2;
wire [31:0] RTdata1;
wire [31:0] srcl1;
wire [4:0] shamt1;
wire [31:0]se2;
wire [4:0]R_add2;
wire [4:0]I_add2;

wire [4:0]ID_EX_Rs;
wire [4:0]ID_EX_Rt;
wire [4:0]ID_EX_Rd;

ID_EX id_ex(
    .clk(clk),
    .WB_in(wb1),
    .M_in(m1),
    .EX_in(ex1),
    .RTdata_in(RTdata),
    .srcl_in(srcl),
    .shamt_in(instruction[10:6]),
    .se_in(se_o),
    .R_add_in(instruction[20:16]),
    .I_add_in(instruction[15:11]),
    .Rs_in(instruction[25:21]),
    .Rt_in(instruction[20:16]),
    .Rd_in(instruction[15:11]),

    .WB_out(wb2),
    .M_out(m2),
    .EX_out(ex2),
    .RTdata_out(RTdata1),
    .srcl_out(srcl1),
    .shamt_out(shamt1),
    .se_out(se2),
    .R_add_out(R_add2),
    .I_add_out(I_add2),
    .Rs_out(ID_EX_Rs),
    .Rt_out(ID_EX_Rt),
    .Rd_out(ID_EX_Rd)
);

/////////////////////////////

wire [5:0]ALUoperation;
wire [5:0]aluctrl1;
assign aluctrl1 = se2[5:0];

ALUctrl aluctrl(
    .funct(aluctrl1),
    .ALUOp(ex2[3:1]),
    .operation(ALUoperation)
);

wire [1:0]ForwardA;
wire [1:0]ForwardB;
wire [1:0]wb3;
wire [4:0]write_register3;

Forwarding forwarding(
    .clk(clk),
    .ID_EX_Rs(ID_EX_Rs),
    .ID_EX_Rt(ID_EX_Rt),
    .EX_MEM_Rd(write_register3),
    .MEM_WB_Rd(write_register4),
    .EX_MEM_RegWrite(wb3[0]),
    .MEM_WB_RegWrite(wb4[0]),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB)
);

wire [31:0]alusrc2;
MUX32b mux1(
    .data1(RTdata1),
    .data2(se2),
    .select(ex2[4]),
    .data_o(alusrc2)
);

wire [31:0]ALU_in_1;
wire [31:0]ALUresult2;
MUX32_3to1 mux31_1(
    .data1(srcl1),
    .data2(write_reg_data),
    .data3(ALUresult2),
    .select(ForwardA),
    .data_o(ALU_in_1)
);

wire [31:0]ALU_in_2;
MUX32_3to1 mux31_2(
    .data1(alusrc2),
    .data2(write_reg_data),
    .data3(ALUresult2),
    .select(ForwardB),
    .data_o(ALU_in_2)
);


wire [31:0]ALUresult1;
ALU alu(
    .shamt(shamt1),
    .src1(ALU_in_1),

    .src2(ALU_in_2),
    .operation(ALUoperation),
    .result(ALUresult1)
);

wire [4:0]write_register2;
MUX5b mux2(
    .data1(R_add2),
    .data2(I_add2),
    .select(ex2[0]),
    .data_o(write_register2)
);

wire [1:0]m3;

wire [31:0]write_mem_data;
EX_MEM ex_mem(
    .clk(clk),
    .WB_in(wb2),
    .M_in(m2),
    .ALUresult_in(ALUresult1),
    // .write_mem_data_in(RTdata1),
    .write_mem_data_in(RTdata1),
    .write_register_in(write_register2),
    // .Rd_in(write_register2),
    .WB_out(wb3),
    .M_out(m3),
    .ALUresult_out(ALUresult2),
    .write_mem_data_out(write_mem_data),
    .write_register_out(write_register3)
);

/////////////////////////////////////////////
wire [31:0]Read_data;
DM dm(
    .clk(clk),
    .addr(ALUresult2),
    .data(write_mem_data),
    .MemRead(m3[0]),
    .MemWrite(m3[1]),
    .DM_data(Read_data)
);

wire [31:0]Read_data1;
wire [31:0]ALUresult3;
MEM_WB mem_wb(
    .clk(clk),
    .WB_in(wb3),
    .Read_data_in(Read_data),
    .ALUresult_in(ALUresult2),
    .write_register_in(write_register3),

    .WB_out(wb4),
    .Read_data_out(Read_data1),
    .ALUresult_out(ALUresult3),
    .write_register_out(write_register4)
);

MUX32b mux3(
    .data1(ALUresult3),
    .data2(Read_data1),
    .select(wb4[1]),
    .data_o(write_reg_data)
);

endmodule