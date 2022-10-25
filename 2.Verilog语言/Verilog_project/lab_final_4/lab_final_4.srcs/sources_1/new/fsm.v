`timescale 1ns / 1ps


module FSM(clk,rst,start,next_zero,LD_SUM,LD_NEXT,SUM_SEL,NEXT_SEL,A_SEL,DONE);
	input clk,rst,start,next_zero;
	output reg LD_SUM,LD_NEXT,SUM_SEL,NEXT_SEL,A_SEL,DONE;

	parameter START=0,COMPUTE_SUM=1,GET_NEXT=2,DO_NE=3;
	reg [1:0] State,StateNext;
    
	always @(State,start,next_zero) begin
		case(State)
			START:begin
				LD_SUM<=0;
				LD_NEXT<=0;
				SUM_SEL<=0;
				NEXT_SEL<=0;
				A_SEL<=0;
				DONE<=0;
				if(start==1)
					StateNext<=COMPUTE_SUM;
				else
					StateNext<=START;
			end
			
			COMPUTE_SUM:begin
				LD_SUM<=1;
				LD_NEXT<=0;
				SUM_SEL<=1;
				NEXT_SEL<=1;
				A_SEL<=1;
				DONE<=0;
				StateNext<=GET_NEXT;
			end

			GET_NEXT:begin
				LD_SUM<=0;
				LD_NEXT<=1;
				SUM_SEL<=1;
				NEXT_SEL<=1;
				A_SEL<=0;
				DONE<=0;
				if(next_zero==0)
					StateNext<=COMPUTE_SUM;
				else
					StateNext<=DO_NE;
			end

			DO_NE:begin
				LD_SUM<=0;
				LD_NEXT<=0;
				SUM_SEL<=0;
				NEXT_SEL<=0;
				A_SEL<=0;
				DONE<=1;
				if(start==1)
					StateNext<=DO_NE;
				else
					StateNext<=START;
			end
		endcase
	end

	always @(posedge clk) begin
		if(rst==1)
			State<=START;
		else
			State<=StateNext;
	end
endmodule