`timescale 1ns / 1ps

module topset(clk, rst, start, Done, SEG, AN);
  input clk, rst, start;
  output Done;
  output [7:0] SEG;
  output [7:0] AN;

  wire clk_N1, clk_N2;
  wire [31:0]sum_out;

  divider #(100_000_000) Divider1(.clk(clk), .clk_N(clk_N1));
  divider #(200_000) Divider2(.clk(clk), .clk_N(clk_N2));

  show_numbers SHOW(.clk(clk_N2), .sum_out(sum_out), .AN(AN), .SEG(SEG));
  top T1(clk_N1,rst,start,Done,sum_out,AN,SEG);
  
endmodule