module AND(
    input [2:0] en,
    input [11:0]data1,data2,data3,
    output reg[11:0] data
    );
    reg [2:0]sel=3'b000;
    always@(en)
        sel <= en;
    always@(data1,data2,data3,sel)
        case(sel) 
            3'b001 : data <= data1;
            3'b010 : data <= data2;
            3'b100 : data <= data3;
            default : data <= 0;
        endcase
endmodule