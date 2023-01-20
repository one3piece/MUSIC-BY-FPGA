module beat_decoder (beat,beat_cnt_parameter);
    input [3:0] beat;
    output reg [27:0] beat_cnt_parameter;
localparam tune_pwm_parameter_4 = 27'h9896800;
localparam tune_pwm_parameter_2 = 27'h4C4B400;
localparam tune_pwm_parameter_1 = 27'h2625A00;
localparam tune_pwm_parameter_1_2 = 27'h1312D00;
localparam tune_pwm_parameter_1_4 = 27'h989680;//ʮ������?? �ķ�֮һ??989680
localparam tune_pwm_parameter_1_8 = 27'h4C4B40;
always @(beat) begin
    case (beat)
        4'h1: beat_cnt_parameter = tune_pwm_parameter_4;
        4'h2: beat_cnt_parameter = tune_pwm_parameter_2;
        4'h3: beat_cnt_parameter = tune_pwm_parameter_1;
        4'h4: beat_cnt_parameter = tune_pwm_parameter_1_2;
        4'h5: beat_cnt_parameter = tune_pwm_parameter_1_4;
        4'h6: beat_cnt_parameter = tune_pwm_parameter_1_8;
        default:beat_cnt_parameter = 27'd5000000; 
    endcase 
end
endmodule

module beat_cnt (clk,en,rstn,beat_cnt_parameter,beat_finish);
    input clk,en,rstn;
    input [27:0] beat_cnt_parameter;
    output  beat_finish;
    
    reg [27:0] cnt;
 
    always@(posedge clk or negedge rstn)
    begin
        if(!rstn)
        cnt <=27'd0;
        else if(en) begin
            if(beat_finish)
            cnt <=27'd0;
            else
            cnt <=cnt +1'd1;
            end
    end
    
    assign beat_finish =(cnt == beat_cnt_parameter)?1'd1:1'd0;
endmodule