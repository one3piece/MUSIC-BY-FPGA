//�������ÿ��������������Ϣ�ͽ�����Ϣ
//DRAM�����ɲ��ұ�ƴ��ʵ�֡�����ʱ�ӡ���С�Ĵ洢Ӧ�á���������ص㣻��BRAM���ж��Ƶ�˫��RAM��Դ����Ҫʱ�ӡ��ϴ�Ĵ洢Ӧ�á�����Ҫ���������Ϣ�����ѡ�ýϴ��BRAM��

module BlockROM2 # (
parameter ADDR_WIDTH = 16,
parameter DATA_WIDTH = 32
)(
input clk,
input [ADDR_WIDTH-1 : 0] addr_i,
input en,
output reg [DATA_WIDTH-1 : 0] data_o
);
(* ramstyle = "block" *) reg [DATA_WIDTH-1 : 0] music2[(2**ADDR_WIDTH-1) : 0];

initial begin
$readmemh("C:/Users/Asus/Desktop/music2.txt", music2);
end

always @ (posedge clk) begin
    if(en)
    begin
        data_o <= music2[addr_i];
    end
end
endmodule