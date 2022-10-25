`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/11 23:50:13
// Design Name: 
// Module Name: lab3_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module divider(clk, clk_N);
input clk;                      // ϵͳʱ��
output reg clk_N;                   // ��Ƶ���ʱ��
parameter N = 100_000_000;      // 1Hz��ʱ��,N=fclk/fclk_N
reg [31:0] counter;             /* ������������ͨ������ʵ�ַ�Ƶ��
                                   ����������0������(N/2-1)ʱ��
                                   ���ʱ�ӷ�ת������������ */
 initial
    begin                           // ����ʼֵ
        counter = 0;
        clk_N = 0;
    end
                        
always @(posedge clk)           // ʱ������
    begin
        counter = counter + 1;
        if (counter > N / 2)
            begin
                clk_N <= ~clk_N;
                counter <= 0;
            end
    end                         
endmodule
