module DM(input clk,
          input [31:0] addr,
          input [31:0] data,
          input MemRead,
          input MemWrite,
          output reg [31:0] DM_data);

    integer i;
    reg [7:0]Mem[127:0];
    
    
    initial begin
        for(i = 0;i<128;i = i+1)begin
            Mem[i] = 8'd0;
        end
    end
    
    always@(clk or MemWrite)begin
        if(clk & MemWrite)begin
            Mem[addr] <= data[31:24];
            Mem[addr + 1] <= data[23:16];
            Mem[addr + 2] <= data[15:8];
            Mem[addr + 3] <= data[7:0];
        end
    end

    always@(*)begin
        if(MemRead)begin
            DM_data <= {Mem[addr],Mem[addr+1],Mem[addr+2],Mem[addr+3]};
        end
    end

endmodule
