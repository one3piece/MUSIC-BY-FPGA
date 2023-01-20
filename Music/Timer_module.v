module Timer_module
(	
	RST, CLK, Start, TimerL, TimerR,en
);
	 input RST;
	 input CLK; 
	 input [2:0] en;
	 input Start;
	 output reg [3:0]TimerL;
	 output reg [3:0]TimerR;

	 

	 reg CLK1; 
	 reg [24:0]Count;
	 parameter T1S = 25'd25_000_000;		

	always @ ( posedge CLK or posedge Start )
		begin 
			if( Start )
				Count <= 0;				
			else if( Count == T1S - 25'b1 )
				begin
					Count <= 0;
					CLK1 <= ~CLK1;		
				end
			else
				Count <= Count + 1;
		end

	always @ ( posedge CLK1 or posedge RST )
		begin
			if( RST )  		
				begin
					//初始化倒计时
					case(en)
						3'b001:begin
						TimerR <= 4'd5;
						TimerL <= 4'd5;
						end
						3'b010:begin
						TimerR <= 4'd6;
						TimerL <= 4'd7;
						end
						3'b100:begin
						TimerR <= 4'd6;
						TimerL <= 4'd9;
						end
						default:begin
						TimerR <= 4'd0;
						TimerL <= 4'd0;
						end
					endcase
				end
			else if( Start == 0 )		
				begin
					if( TimerR == 4'd0 ) 
						begin
							if( TimerL == 4'd0 )		
								begin
									TimerL <= TimerL;
									TimerR <= TimerR;
								end
							else 
								begin
									TimerL <= TimerL - 1'b1;
									TimerR <= 4'd9;
								end
						end
					else 
						TimerR <= TimerR - 1'b1;
				end
		end
		
endmodule
	