`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/28 18:52:05
// Design Name: 
// Module Name: lab2_1
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


module _7Seg_Driver_Direct(SW, CA, CB, CC, CD, CE, CF, CG, DP, AN, LED);
	input [15:0] SW;                          // 16λ��������
	output CA, CB, CC, CD, CE, CF, CG, DP;  // 7��������������͵�ƽ��Ч
	output [7:0] AN;                          // 7�������Ƭѡ�źţ��͵�ƽ��Ч
	output [15:0] LED;                        // 16λLED��ʾ���ߵ�ƽ��Ч

    assign CA = ~SW[7];
    assign CB = ~SW[6];
    assign CC = ~SW[5]; 
    assign CD = ~SW[4];
    assign CE = ~SW[3];
    assign CF = ~SW[2];
    assign CG = ~SW[1];
    assign DP = ~SW[0];
    assign LED[15:0] = SW[15:0];
    assign AN[7:0] = ~SW[15:8];
	
endmodule
