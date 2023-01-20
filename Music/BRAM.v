//储存歌曲每个音符的音调信息和节拍信息
//DRAM具有由查找表拼接实现、无需时钟、较小的存储应用、相对灵活的特点；而BRAM具有定制的双口RAM资源、需要时钟、较大的存储应用。我们要储存歌曲信息，因此选用较大的BRAM。

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