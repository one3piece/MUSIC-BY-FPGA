module music_time_display(
    input Start,
    input RST,
    input [2:0] en,
    input CLK,
    output [7:0]Digitron_Out,
	output [3:0]DigitronCS_Out
);

    //记录歌曲播放时长
    wire [3:0]TimerL;                   //秒数的十位
	wire [3:0]TimerR;                   //秒数的个位  

     


    //计时模块
    Timer_module  Timer_module
    (	
	.RST(RST), .CLK(CLK), .Start(Start), .TimerL(TimerL), .TimerR(TimerR),.en(en) 
    );
    //数码管显示模块
    Digitron_NumDisplay  Digitron_NumDisplay
    (
	.CLK(CLK), .TimerL(TimerL),.TimerR(TimerR),
    .Digitron_Out(Digitron_Out), .DigitronCS_Out(DigitronCS_Out)
    );





endmodule