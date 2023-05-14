`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 20:02:19
// Design Name: 
// Module Name: timeset
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


module timeset(clk,clk2);
    input clk;
    output clk2;
    reg [30:0]q;
    always@(posedge clk) begin
        q <= q + 1;
    end
    assign clk2 = q[15];
endmodule
