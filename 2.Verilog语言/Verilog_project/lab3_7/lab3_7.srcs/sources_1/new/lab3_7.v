`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 17:20:25
// Design Name: 
// Module Name: others
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


module dynamic_scan(clk,BTN ,SEG, AN);
input clk;              // ϵͳʱ��
input [2:0]BTN;          //BTN[0]Ϊ�м䣬[1]Ϊ��[2]Ϊ��
output [7:0] SEG;  		// �ֱ��ӦCA��CB��CC��CD��CE��CF��CG��DP
output [7:0] AN;        // 8λ�����Ƭѡ�ź�
wire clk_N;
wire BTN_tmp;   //Ϊ0ʱΪ��ͬʱ����Ϊ1ʱΪ����
wire BTN_count;  //Ϊ0ʱΪ���ƣ�Ϊ1ʱΪ����
wire [2:0]num;
wire [3:0]code;

freq(.a(BTN[2:0]),.out(BTN_tmp));
direct(.a(BTN[1]),.b(BTN[2]),.out(BTN_count));
divider (.clk(clk),.clk_N(clk_N),.butten(BTN_tmp));
counter(.clk(clk_N),.out(num[2:0]),.butten(BTN_count));
decoder3_8(.in(num[2:0]),.out(AN[7:0]));
rom8x4(.addr(num[2:0]),.data(code[3:0]));
pattern(.in(code[3:0]),.out(SEG[7:0]));
 
endmodule
