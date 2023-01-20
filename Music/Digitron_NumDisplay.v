module Digitron_NumDisplay
(
	CLK,TimerL,TimerR ,Digitron_Out, DigitronCS_Out
);
	 input CLK;
	 input [3:0]TimerL;
     input [3:0]TimerR;
	 output [7:0]Digitron_Out; 
	 output [3:0]DigitronCS_Out;
		

     parameter T1MS = 16'd50000;
	 reg [15:0]Count;
	 reg cnt ;
	 //计时器为数码管提供1000Hz刷新频率
	 always @ ( posedge CLK )
		begin	
			 if( Count == T1MS )
			 begin
				  Count <= 16'd0 ;
				  if(cnt == 1)
						cnt <= 0;
				  else 
						cnt <= cnt + 1'b1;					

			 end
			 else
				Count <= Count+1'b1;					 
	    end
	 	
	 reg [3:0]W_DigitronCS_Out ;
	//数码管动态刷新	 
	 always@(cnt)
	 begin
			case (cnt)
			1'b0:
				W_DigitronCS_Out = 4'b1110 ;
			1'b1:
				W_DigitronCS_Out = 4'b1101 ;					
			endcase
	 end
	 
	 reg [3:0]SingleNum;
	 reg [7:0]W_Digitron_Out;
	 parameter _0 = 8'b0011_1111, _1 = 8'b0000_0110, _2 = 8'b0101_1011,
			 	 _3 = 8'b0100_1111, _4 = 8'b0110_0110, _5 = 8'b0110_1101,
			 	 _6 = 8'b0111_1101, _7 = 8'b0000_0111, _8 = 8'b0111_1111,
				 _9 = 8'b0110_1111;
				 
	 always@(W_DigitronCS_Out,SingleNum)
	 begin
			case(W_DigitronCS_Out)
				4'b1110: SingleNum = TimerR;		//Display TimerL
				4'b1101: SingleNum = TimerL;			//Display TimerH		
			endcase

			case(SingleNum)
				0:  W_Digitron_Out = _0;
				1:  W_Digitron_Out = _1;
				2:  W_Digitron_Out = _2;
				3:  W_Digitron_Out = _3;
				4:  W_Digitron_Out = _4;
				5:  W_Digitron_Out = _5;
				6:  W_Digitron_Out = _6;
				7:  W_Digitron_Out = _7;
				8:  W_Digitron_Out = _8;
				9:  W_Digitron_Out = _9;
			endcase
	 end
	 
	 assign Digitron_Out = W_Digitron_Out;
	 assign DigitronCS_Out = W_DigitronCS_Out;
	
endmodule