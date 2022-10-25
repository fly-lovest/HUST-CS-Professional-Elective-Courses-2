`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: autocpter
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


module autocount(clk,rst,start,done, sum_out);
    parameter DATA_WIDTH = 32; 
    input clk,rst,start;
    output done;
    output [DATA_WIDTH-1:0] sum_out;

    wire ld_sum, ld_next, sum_sel, next_sel, a_sel, next_zero;

    datapath #(32, 4) datapath_ins(clk, rst, ld_sum, ld_next, sum_sel, next_sel, a_sel, next_zero, sum_out);
    FSM FSM_ins(clk, rst, start, next_zero, ld_sum, ld_next, sum_sel, next_sel, a_sel, done);
endmodule
