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
    input clk;                    // ����ʱ��
    output reg [2:0] out;         // ����ֵ

    always @(posedge clk)         // ��ʱ�������ؼ�������1
    begin
        out <= out + 1;
    end
endmodule