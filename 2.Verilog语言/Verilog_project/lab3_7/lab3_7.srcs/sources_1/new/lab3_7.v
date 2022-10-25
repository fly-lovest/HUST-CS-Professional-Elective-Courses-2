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
input clk;              // 系统时钟
input [2:0]BTN;          //BTN[0]为中间，[1]为左，[2]为右
output [7:0] SEG;  		// 分别对应CA、CB、CC、CD、CE、CF、CG和DP
output [7:0] AN;        // 8位数码管片选信号
wire clk_N;
wire BTN_tmp;   //为0时为“同时”，为1时为慢亮
wire BTN_count;  //为0时为左移，为1时为右移
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
