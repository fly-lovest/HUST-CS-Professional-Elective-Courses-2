`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 22:21:44
// Design Name: 
// Module Name: FSM
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


module FSM(clk, rst, start, next_zero, ld_sum, ld_next, sum_sel, next_sel, a_sel, done);

    input clk, rst, start, next_zero;
    output reg ld_sum, ld_next, sum_sel, next_sel, a_sel, done;
    
    localparam START = 0, COMPUTE_SUM = 1, GET_NEXT = 2, DONE = 3;
    
    reg [1:0] State, StateNext;

    always @(State, start, next_zero) begin
        case(State)
            START: begin
                ld_sum <= 0;
                ld_next <= 0;
                sum_sel <= 0;
                next_sel <= 0;
                a_sel <= 0;
                done <= 0;
                if (start == 1)
                    StateNext <= COMPUTE_SUM;
                else
                    StateNext <= START;
            end
            COMPUTE_SUM: begin
                ld_sum <= 1;
                ld_next <= 0;
                sum_sel <= 1;
                next_sel <= 1;
                a_sel <= 1;
                done <= 0;

                StateNext <= GET_NEXT;
            end
            GET_NEXT: begin
                ld_sum <= 0;
                ld_next <= 1;
                sum_sel <= 1;
                next_sel <= 1;
                a_sel <= 0;
                done <= 0;
                if (next_zero == 0)
                    StateNext <= COMPUTE_SUM;
                else
                    StateNext <= DONE;
            end
            DONE: begin
                ld_sum <= 0;
                ld_next <= 0;
                sum_sel <= 0;
                next_sel <= 0;
                a_sel <= 0;
                done <= 1;
                if (start == 1)
                    StateNext <= DONE;
                else
                    StateNext <= START;
            end
        endcase
    end 
    
    always @(posedge clk) begin
        if (rst == 1)
            State <= START;
        else
            State <= StateNext;
    end
endmodule
