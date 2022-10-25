`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 14:56:02
// Design Name: 
// Module Name: lab3_3
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


module divide_and_count(clk, out);
    input clk;
    output [2:0] out;
    wire clk_tmp;

    divider d1(.clk(clk), .clk_N(clk_tmp));
    counter c1(.clk(clk_tmp), .out(out[2:0]));
endmodule
