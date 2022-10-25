`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: datapath
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


module datapath(clk,rst,ld_sum,ld_next, sum_sel, next_sel, a_sel,next_zero, a1);
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 3;
   input clk,rst,ld_sum,ld_next,sum_sel,next_sel,a_sel;
   output next_zero;
   output [DATA_WIDTH-1:0] a1;
    wire[DATA_WIDTH-1:0] b1, s1, s2, d1, d2, d3, q2;

    ram #(DATA_WIDTH, ADDR_WIDTH) ram_ins(0, d3, 0, clk, 0, b1);
    adder #(DATA_WIDTH) adder_ins1(a1, b1, 0, s1, );
    adder #(DATA_WIDTH) adder_ins2(1, q2, 0, s2, );
    mux_21 #(DATA_WIDTH) mux_ins_sum(0, s1, sum_sel, d1);
    mux_21 #(DATA_WIDTH) mux_ins_next(0, b1, next_sel, d2);
    mux_21 #(DATA_WIDTH) mux_ins_a(q2, s2, a_sel, d3);
    register #(DATA_WIDTH) register_ins_sum(clk, rst, ld_sum, d1, a1);
    register #(DATA_WIDTH) register_ins_next(clk, rst, ld_next, d2, q2);
    comparator #(DATA_WIDTH) comparator_ins(d2, 0, next_zero, , );
endmodule

module adder(a, b, c_in, sum, c_out);
    parameter WIDTH = 8;
    
    input [WIDTH-1:0] a, b;
    input c_in;
    output [WIDTH-1:0] sum;
    output c_out;
    
    assign { c_out, sum } = a + b + c_in;
endmodule

module comparator(a, b, is_equal, is_great, is_less);
    parameter WIDTH = 8;
    
    input [WIDTH-1:0] a, b;
    output is_equal, is_great, is_less;
    
    assign is_equal = (a == b) ? 1'b1 : 1'b0;
    assign is_great = (a > b) ? 1'b1 : 1'b0;
    assign is_less = (a < b) ? 1'b1 : 1'b0;
endmodule

module mux_21(a, b, sel, out);
    parameter WIDTH = 8;
    
    input [WIDTH-1:0] a, b;
    input sel;
    output [WIDTH-1:0] out;
    
    assign out = sel == 0 ? a : b;
endmodule

module register(clk, rst_n, en, d, q);
    parameter WIDTH = 8;

    input clk, rst_n, en;
    input [WIDTH-1:0] d;
    output reg [WIDTH-1:0] q;

    always @(posedge clk) begin
        if (rst_n) q <= 0;
        else if (en) q <= d;
    end    
endmodule

module ram(data, read_addr, write_addr, clk, we, q);
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 3;

    input clk, we;
    input [DATA_WIDTH-1:0] data;
    input [ADDR_WIDTH-1:0] read_addr, write_addr;
    output reg [DATA_WIDTH-1:0] q;

    // ÉêÃ÷´æ´¢Æ÷Êı
    reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH - 1:0];

    initial begin
        $readmemh("ram_initial.mem", ram);
    end

    always @(read_addr) begin
        if (we)
            ram[write_addr] <= data;
        q <= ram[read_addr];
    end    
endmodule

