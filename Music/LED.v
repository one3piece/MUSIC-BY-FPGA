module LED( 
	input CLK,
    input START,
    input RST,
    output reg [7:0] led
);
	localparam N=40000000;
	reg [31:0] timer;
	
	always @ (posedge CLK or posedge RST)
	begin
		if(RST)
			timer<=0;
		else if(START)
			timer<=timer;	
		else if(timer==N-1)
		 	timer<=0;
        else 
            timer<=timer+1;
	end

	always @ (*)
	begin
		if(timer==0)
		 led=8'd1;
		else if(timer==N/8-1)
		 led=8'd2;
		else if(timer==N/4-1)
		 led=8'd4;
		else if(timer==N*3/8-1)
		 led=8'd8;
		else if(timer==N/2-1)
		 led=8'd16;
		else if(timer==N*5/8-1)
		 led=8'd32;
		else if(timer==N*6/8-1)
		 led=8'd64;
		else if(timer==N*7/8-1)
		 led=8'd128;
		 
	end

endmodule