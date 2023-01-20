module BlockROM1 # (
parameter ADDR_WIDTH = 16,
parameter DATA_WIDTH = 32
)(
input clk,
input [ADDR_WIDTH-1 : 0] addr_i,
input en,
output reg [DATA_WIDTH-1 : 0] data_o
);
(* ramstyle = "block" *) reg [DATA_WIDTH-1 : 0] music1[(2**ADDR_WIDTH-1) : 0];

initial begin
$readmemh("C:/Users/Asus/Desktop/music1.txt", music1);
end

always @ (posedge clk) begin
    if(en)
    begin
        data_o <= music1[addr_i];
    end
end
endmodule
