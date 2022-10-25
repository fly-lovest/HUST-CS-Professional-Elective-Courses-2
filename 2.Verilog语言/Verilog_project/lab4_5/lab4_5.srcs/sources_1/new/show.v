`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/02 20:39:36
// Design Name: 
// Module Name: Show
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


module show(clk, rst, start, Done, SEG, AN);
  input clk, rst, start;
  output Done;
  output [7:0] SEG;
  output [7:0] AN;
  wire clk_N1,clk_N2;
  wire [31:0]sum_out;
  divider #(100_000_000) Divider1(.clk(clk), .clk_N(clk_N1));
  divider #(200_000) Divider2(.clk(clk), .clk_N(clk_N2));
  show_numbers SHOW1(.clk(clk_N2), .sum_out(20), .AN(AN), .SEG(SEG));

  autocount auto1(.clk(clk_N1),.rst(rst),.start(start),.done(Done), .sum_out(sum_out));
endmodule
