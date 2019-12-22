module RF(input clk,
          input RegWrite,
          input [4:0] RSaddr,
          input [4:0] RTaddr,
          input [4:0] RDaddr,
          input [31:0] RDdata,
          output reg [31:0] RTdata,
          output reg [31:0] srcl);
    
    
    reg [31:0]REGISTER[31:0];
    
    initial begin
        REGISTER[0]  = 32'd0;
        REGISTER[1]  = 32'd11;
        REGISTER[2]  = 32'd370;
        REGISTER[3]  = 32'd183;
        REGISTER[4]  = 32'd91;
        REGISTER[5]  = 32'd234;
        REGISTER[6]  = 32'd53;
        REGISTER[7]  = 32'd127;
        REGISTER[8]  = 32'd317;
        REGISTER[9]  = 32'd179;
        REGISTER[10] = 32'd101;
        REGISTER[11] = 32'd161;
        REGISTER[12] = 32'd152;
        REGISTER[13] = 32'd39;
        REGISTER[14] = 32'd39;
        REGISTER[15] = 32'd44;
        REGISTER[16] = 32'd29;
        REGISTER[17] = 32'd334;
        REGISTER[18] = 32'd245;
        REGISTER[19] = 32'd19;
        REGISTER[20] = 32'd2;
        REGISTER[21] = 32'd13;
        REGISTER[22] = 32'd262;
        REGISTER[23] = 32'd185;
        REGISTER[24] = 32'd180;
        REGISTER[25] = 32'd180;
        REGISTER[26] = 32'd198;
        REGISTER[27] = 32'd178;
        REGISTER[28] = 32'd235;
        REGISTER[29] = 32'd22;
        REGISTER[30] = 32'd1000;
        REGISTER[31] = 32'd75;
    end
    //
    always@(posedge clk or RSaddr or RTaddr or RDaddr )begin
        RTdata <= REGISTER[RTaddr];
        srcl   <= REGISTER[RSaddr];
    end
    //negedge 
    always@(clk)begin
        if (RegWrite)begin
            REGISTER[RDaddr] <= RDdata;
        end
    end
endmodule
