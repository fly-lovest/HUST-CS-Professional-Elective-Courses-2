`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 14:50:32
// Design Name: 
// Module Name: lab3_2
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


module counter(clk, out);
    input clk;                    // 计数时钟
    output reg [2:0] out;         // 计数值

    always @(posedge clk)         // 在时钟上升沿计数器加1
    begin
        out <= out + 1;
    end
endmodule