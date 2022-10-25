`timescale 1ns / 1ps

module top(clk,rst,start,DONE,sum_out,AN,SEG);
	input clk,rst,start;
	output DONE;
	output [31:0] sum_out;
	output [7:0]AN;
	output [7:0]SEG;

	wire LD_SUM,LD_NEXT,SUM_SEL,NEXT_SEL,A_SEL,NEXT_ZERO;
	
	FSM		dut1(clk,rst,start,NEXT_ZERO,LD_SUM,LD_NEXT,SUM_SEL,NEXT_SEL,A_SEL,DONE);
	datapath	dut2(clk,rst,SUM_SEL,NEXT_SEL,A_SEL,LD_SUM,LD_NEXT,NEXT_ZERO,sum_out);

endmodule

module datapath(clk,rst,SUM_SEL,NEXT_SEL,A_SEL,LD_SUM,LD_NEXT,NEXT_ZERO,sum_out);
	input clk,rst,SUM_SEL,NEXT_SEL,A_SEL,LD_SUM,LD_NEXT;    
	output  NEXT_ZERO;
	output  [31:0] sum_out;
	wire [3:0] read_addr;
	wire [31:0] next1,next2,data,add_out,sum_in,NEXT_IN,ad_data;
    assign read_addr=ad_data[3:0];
    
	mux2_1 #(32) mux1(32'h0,data,NEXT_SEL,NEXT_IN);
	mux2_1 #(32) mux2(next1,next2,A_SEL,ad_data);
	mux2_1 #(32) mux3(32'h0,add_out,SUM_SEL,sum_in);
	
	compare #(32) compare1(NEXT_IN,32'h0,NEXT_ZERO);
	
	add #(32) add1(32'h1,next1,next2);
	add #(32) add2(data,sum_out,add_out);
	
	register #(32) NEXT(clk,rst,LD_NEXT,NEXT_IN,next1);
	register #(32) SUM(clk,rst,LD_SUM,sum_in,sum_out);
	
	ram #(32,4) read(read_addr,data);
endmodule

module ram(read_addr,data);
  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 3;

  input [ADDR_WIDTH-1:0] read_addr;
  output reg [DATA_WIDTH-1:0] data;

  reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

  initial begin                              
      $readmemh("ram_initial.mem",ram); 
  end
 
  always @(*) begin
      data<=ram[read_addr];
  end
endmodule


module register(clk, rst, load, D, Q);
  parameter WIDTH = 8;
  input clk, rst, load;
  input [WIDTH-1:0] D;
  output reg [WIDTH-1:0] Q;
  always @(posedge clk) begin
    if (rst) Q <=0;
    else if (load) Q <= D;
  end    
endmodule

module mux2_1(a,b,sel,q);
	parameter WIDTH = 8;
	input [WIDTH-1:0] a,b;
	input sel;
	output reg [WIDTH-1:0] q;
	always @(*) begin
		if(sel==0) q=a;
		else q=b;
	end
endmodule

module compare(a,b,NEXT_ZERO);
	parameter	WIDTH=8;
	input [WIDTH-1:0] a,b;
	output reg NEXT_ZERO;
	always @(*) begin
		if(a==b) NEXT_ZERO=1;
		else NEXT_ZERO=0;
	end
endmodule

module add(a,b,sum);
	parameter	WIDTH = 8;
	input [WIDTH-1 : 0] a,b;
	output reg [WIDTH-1 : 0] sum;
	always @(a||b) begin
		sum=a+b;
	end
endmodule