`timescale 1ns/ 1ps

module tb_Control;
reg run;
reg reset;
reg clk;
reg lsb;

wire ready;
wire strctrl;
wire wrctrl;
wire [5:0]addctrl;

Control ctrl(
    run,
    reset,
    clk,
    lsb,
    ready,
    strctrl,
    wrctrl,
    addctrl
);

integer i;
initial begin
    // 初始狀態
    clk <= 1;
    run <= 0;
    reset <= 1;
    lsb <= 0;
    // 全部輸出都0

    //0
    #1
    clk <= 0;
    #1
    clk <= 1;

    //2
    reset <= 0;
    run <= 1;
    // 開始
    // 載入資料
    // wrctrl = 1


    #1
    clk <= 0;
    #1
    clk <= 1;

    //4
    run <= 0;
    // load data done
    // wrctrl = 0
    
    #1
    clk <= 0;
    #1
    clk <= 1;


    //6
    lsb <= 1;
    // 判斷lsb 做加法
    // str = 1 add = 27

    
    #1
    clk <= 0;
    #1
    clk <= 1;

    //8
    // nothing
    // shift (str = 0)
    // 1


    #1
    clk <= 0;
    #1
    clk <= 1;

    //10
    // nothing
    // add (str = 1, add = 27)


    #1
    clk <= 0;
    #1
    clk <= 1;

    //12
    // nothing
    // shift (str = 0, add = 0)
    // 2

    #1
    clk <= 0;
    #1
    clk <= 1;

    //14
    lsb <= 0;
    // no add (str = 1 , add = 0)

    #1
    clk <= 0;
    #1
    clk <= 1;

    //16
    //nothing
    // shift (str=0,add=0)
    // 3

    #1
    clk <= 0;
    #1
    clk <= 1;


    //18
    lsb <= 1;
    // add (str = 1 , add = 27)

    #1
    clk <= 0;
    #1
    clk <= 1;

    //20
    //nothing
    //shif(str = 0, add = 0)

    //done!!!!! so ready = 1
    

    #1
    clk <= 0;
    #1
    clk <= 1;

    for(i=0;i<100;i=i+1)begin
        #1
        clk <= 0;
        #1
        clk <= 1;
    end
    //測試ready
end

endmodule