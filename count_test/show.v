`timescale 1ns / 1ps

module show(clk,ld);
    input clk;
    output reg [7:0]ld = 8'b1111_1110;
    integer i;
    always@(posedge clk) begin
        for(i = 0 ; i < 5 ;i = i + 1)begin
            ld[i+1] <= ld[i];
        end
        ld[0] <= ld[5];
    end
    
endmodule