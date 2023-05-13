`timescale 1ns/1ps

module plus2counter (
    input clk,
    
    output reg [7:0]q = 8'b1111_1110
);

integer i;


always@(posedge clk)begin
    
    
    for(i = 0; i < 7; i = i + 1)
        begin
         q[i+1] <= q[i];
        end
        
        q[0]<=q[7];
      end




    
endmodule

