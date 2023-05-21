`timescale 1ns / 1ps

module timeset(clk,clk2);
    input clk;
    output clk2;
    reg [30:0]q;
    always@(posedge clk) begin
        q <= q + 1;
    end
    assign clk2 = q[15];
endmodule
