`timescale 1ns / 1ps


module timeset_countdown(clk,clk2);
    input clk;
    output clk2;
    reg [15:0]q;
     always@(posedge clk)
        q = q + 1;
    assign clk2 = q[14];
endmodule
