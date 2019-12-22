module Product(
    input [63:0] Product_in,
    input wrctrl,
    input strctrl,
    input ready,
    input reset,
    input clk,
    output reg[63:0] Product_out
);
reg [64:0]Product_reg;
reg a;
initial begin
    Product_reg = 0;
    Product_out = 0;
    a = 0;
end


always @(posedge clk or posedge reset)begin
    if(reset)begin
        Product_reg = 0;
        Product_out = 0;
    end
    if(!ready)begin 
        if(wrctrl)begin // load data and start
            Product_reg[31:0] = Product_in[31:0];
        end

        
        else if(strctrl && a == 0) begin  //收加法
            Product_reg[64] = Product_in[63];
            Product_reg[63:32] = Product_in[62:31];
            a = 1;
        end
        
        //shift
        else if(!strctrl && !reset && !wrctrl && clk && a == 1)begin
            Product_reg = (Product_reg >> 1);
            a = 0;
        end
        
    end
    
    Product_out[63:0] = Product_reg[63:0];
    
end
endmodule