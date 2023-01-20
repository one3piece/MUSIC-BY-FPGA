module buzzermusic(
    input           CLK,
    input           RST,
    input           start,
    input     [2:0]  en,
    output          beep,
    output [7:0]    led,
    output [7:0]Digitron_Out,      
	output [3:0]DigitronCS_Out      
);


wire addr_finish;
wire beat_finish;
wire addr_en;
wire addr_rstn;
wire tune_pwm_en;
wire tune_pwm_rstn;
wire beat_cnt_en;
wire beat_cnt_rstn;

LED LED(            
     .CLK(CLK)          
     ,.START(start)
     ,.RST(RST)
    ,.led(led)
);

music_time_display music_time_display(
     .Start(start),
     .RST(RST),
     .en(en),
     .CLK(CLK),
     .Digitron_Out(Digitron_Out),
	 .DigitronCS_Out(DigitronCS_Out)
);
//音乐演奏
bzmusic_ctrl bzmusic_ctrl(
    .clk             (CLK)
    ,.en             (start)
    ,.rstn           (RST)
    ,.addr_finish    (addr_finish)
    ,.beat_finish    (beat_finish)
    ,.addr_en        (addr_en)
    ,.addr_rstn      (addr_rstn)
    ,.tune_pwm_en    (tune_pwm_en)
    ,.tune_pwm_rstn  (tune_pwm_rstn)
    ,.beat_cnt_en    (beat_cnt_en)
    ,.beat_cnt_rstn  (beat_cnt_rstn) 
);
wire [8:0] addr;
wire [11:0] data;
addr_cnt addr_cnt(
     .clk          (CLK)
    ,.en           (addr_en)
    ,.rstn         (addr_rstn)
    ,.data         (data)
    ,.addr         (addr)
    ,.addr_finish  (addr_finish)
);
wire [11:0] data1;
BlockROM1 #(
     .ADDR_WIDTH(8)
    ,.DATA_WIDTH(12)
) BlockROM1 (
     .en(en[0])
    ,.clk(CLK)
    ,.addr_i(addr)
    ,.data_o(data1)
);
wire [11:0] data2;
BlockROM2 #(
     .ADDR_WIDTH(8)
    ,.DATA_WIDTH(12)
) BlockROM2 (
     .en(en[1])
    ,.clk(CLK)
    ,.addr_i(addr)
    ,.data_o(data2)
);
wire [11:0] data3;
BlockROM3 #(
     .ADDR_WIDTH(8)
    ,.DATA_WIDTH(12)
) BlockROM3 (
     .en(en[2])
    ,.clk(CLK)
    ,.addr_i(addr)
    ,.data_o(data3)
);

AND AND(
     .data1 (data1)
    ,.data2 (data2)
    ,.data3 (data3)
    ,.en(en)
    ,.data (data)
);
wire [19:0] tune_pwm_parameter;
tune_decoder tune_decoder(
     .tune                (data[11:4])
    ,.tune_pwm_parameter  (tune_pwm_parameter)
);
tune_pwm tune_pwm(     
     .clk            (CLK)
    ,.en             (tune_pwm_en)
    ,.rst_n          (tune_pwm_rstn)
    ,.pwm_parameter  (tune_pwm_parameter)
    ,.clk_pwm        (beep)
);
wire  [27:0]  beat_cnt_parameter;
beat_decoder beat_decoder(
     .beat                (data[3:0])
    ,.beat_cnt_parameter  (beat_cnt_parameter)
);
beat_cnt beat_cnt(
     .clk                 (CLK)
    ,.en                  (beat_cnt_en)
    ,.rstn                (beat_cnt_rstn)
    ,.beat_cnt_parameter  (beat_cnt_parameter)
    ,.beat_finish         (beat_finish)   
);
endmodule
