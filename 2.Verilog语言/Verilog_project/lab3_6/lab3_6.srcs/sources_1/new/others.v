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


module divider(clk, clk_N);
input clk;                    
output reg clk_N;            
parameter N = 100_000_000;
reg [31:0] counter;
 initial
    begin
        counter = 0;
        clk_N = 0;
    end
always @(posedge clk)
    begin
        counter = counter + 1;
        if (counter > N / 2)
            begin
                clk_N = ~clk_N;
                counter = 0;
            end
    end
endmodule

module counter(clk, out);
    input clk;
    output reg [2:0] out;
    always @(posedge clk)
    begin
        out = out + 1;
    end
endmodule

module rom8x4(addr, data);
    input [2:0] addr;
    output [3:0] data;
    reg [3: 0] mem [7: 0]; 
    initial
        begin
            mem[0]=4'b0000;
            mem[1]=4'b0010;
            mem[2]=4'b0100;
            mem[3]=4'b0110;
            mem[4]=4'b1000;
            mem[5]=4'b1010;
            mem[6]=4'b1100;
            mem[7]=4'b1110;
        end
    assign data[3:0] = mem[addr];
endmodule

module decoder3_8(in, out);
    input [2:0] in;
    output reg [7:0] out;
    always@(in)  
        case(in)  
            3'b000 : out[7:0] = 8'b11111110;
            3'b001 : out[7:0] = 8'b11111101;
            3'b010 : out[7:0] = 8'b11111011;
            3'b011 : out[7:0] = 8'b11110111;
            3'b100 : out[7:0] = 8'b11101111;
            3'b101 : out[7:0] = 8'b11011111;
            3'b110 : out[7:0] = 8'b10111111;
            default : out[7:0] = 8'b01111111;
        endcase
endmodule

module pattern(in, out);   //ÊıÂë¹ÜÏÔÊ¾
    input [3:0] in;
    output reg [7:0] out;
    always@(in)
        begin
            case(in)
                4'b0000 : out[7:0] = 8'b11000000;
                4'b0001 : out[7:0] = 8'b11111001;
                4'b0010 : out[7:0] = 8'b10100100;
                4'b0011 : out[7:0] = 8'b10110000;
                4'b0100 : out[7:0] = 8'b10011001;
                4'b0101 : out[7:0] = 8'b10010010;
                4'b0110 : out[7:0] = 8'b10000010;
                4'b0111 : out[7:0] = 8'b11111000;
                4'b1000 : out[7:0] = 8'b10000000;
                4'b1001 : out[7:0] = 8'b10011000;
                4'b1010 : out[7:0] = 8'b10001000;
                4'b1011 : out[7:0] = 8'b10000011;
                4'b1100 : out[7:0] = 8'b11000110;
                4'b1101 : out[7:0] = 8'b10100001;
                4'b1110 : out[7:0] = 8'b10000110;
                default : out[7:0] = 8'b10001110;
            endcase
        end
endmodule