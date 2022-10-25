`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: autocpter_sim
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


module autocount_tb();
    reg clk, rst, start;
    wire done;
    wire [31:0] sum_out;
    wire clk_N1;
    autocount autocpter_ins(clk_N1, rst, start, done, sum_out);
     divider  #(1)Divider1(.clk(clk), .clk_N(clk_N1));
    initial begin
        clk <= 0;
        start <= 0;
        rst <= 1;
        @(posedge clk);
        rst <= 0;
        #20;
        start = 1;
        #200;
        start = 0;
    end
    always #5 clk = ~clk;

endmodule
