`timescale 1ns / 1ps

module show_numbers(clk, sum_out, AN, SEG);
  input clk;
  input [31:0] sum_out;
  output reg [7:0]AN;
	output reg [7:0]SEG;

  wire [7:0] tube[7:0];
  reg [7:0]tube_now;

  decoder_4to16 Decoder1(.in(sum_out[3:0]), .out(tube[0]));
  decoder_4to16 Decoder2(.in(sum_out[7:4]), .out(tube[1]));
  decoder_4to16 Decoder3(.in(sum_out[11:8]), .out(tube[2]));
  decoder_4to16 Decoder4(.in(sum_out[15:12]), .out(tube[3]));
  decoder_4to16 Decoder5(.in(sum_out[19:16]), .out(tube[4]));
  decoder_4to16 Decoder6(.in(sum_out[23:20]), .out(tube[5]));
  decoder_4to16 Decoder7(.in(sum_out[27:24]), .out(tube[6]));
  decoder_4to16 Decoder8(.in(sum_out[31:28]), .out(tube[7]));

initial 
    begin
	    AN = 8'b11111110;
	end
	
always @(posedge clk)
  begin
	  case(AN)
		  8'b11111110:begin
			  AN <= 8'b11111101;
			  tube_now <= tube[2];
      end
      8'b11111101:begin
			  AN <= 8'b11111011;	
			  tube_now <= tube[3];
      end
      8'b11111011:begin
			  AN <= 8'b11110111;
			  tube_now <= tube[4];
      end
      8'b11110111:begin
			  AN <= 8'b11101111;
			  tube_now <= tube[5];
      end
      8'b11101111:begin
			  AN <= 8'b11011111;
			  tube_now <= tube[6];
      end
      8'b11011111:begin
			  AN <= 8'b10111111;
			  tube_now <= tube[7];
      end
      8'b10111111:begin
			  AN <= 8'b01111111;
			  tube_now <= tube[0];
      end
      default:begin
			  AN <= 8'b11111110;		
			  tube_now <= tube[1];
      end
    endcase
    SEG <= tube_now; 		
	end
endmodule

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

module decoder_4to16(in, out);
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

