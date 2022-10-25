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


module dynamic_scan(clk, SEG, AN);
input clk;              // 系统时钟
output [7:0] SEG;  		// 分别对应CA、CB、CC、CD、CE、CF、CG和DP
output [7:0] AN;        // 8位数码管片选信号
wire clk_N;
wire [2:0]num;
wire [3:0]code;
divider #(100_000)(.clk(clk),.clk_N(clk_N));
counter(.clk(clk_N),.out(num[2:0]));
decoder3_8(.in(num[2:0]),.out(AN[7:0]));
rom8x4(.addr(num[2:0]),.data(code[3:0]));
pattern(.in(code[3:0]),.out(SEG[7:0]));
 
endmodule
