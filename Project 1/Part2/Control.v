module Control(
    input run,
    input reset,
    input clk,
    input lsb,
    output reg ready,
    output reg strctrl,
    output reg wrctrl,
    output reg [5:0]addctrl
);
reg runs,a;

integer counter;

initial begin
    runs = 0;
    a = 0;
    counter = 0;
    strctrl = 0;
end


always @(lsb)begin
    addctrl = lsb ? 5'd27 : 5'd0;
end

always @(posedge run)begin
    if (run && clk)begin
        runs = 1;
        wrctrl = 1;
    end
end

always @(posedge reset)begin
    if(reset)begin
        ready <= 0;
        strctrl <= 0;
        wrctrl <= 0;
        runs <= 0;
    end
end

always @(posedge clk)begin
    if (runs == 1)begin
        if(wrctrl == 1)begin
            wrctrl = 0;
        end
        else if(a == 0 && counter < 32)begin // test mul
            strctrl = 1;
             a = 1;
        end

        else if (a == 1)begin //shift
            strctrl = 0;
            a = 0;
            counter = counter + 1;
        end

        else begin // 終止條件
            runs <= 0;
            ready <= 1;
            counter <= 0;
        end
    end

end

endmodule