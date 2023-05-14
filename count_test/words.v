`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/17 21:20:31
// Design Name: 
// Module Name: words
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


module words(last,clk,clk_o,min_10,min_1,sec_10,sec_1,milli_10,milli_1);
    
    input clk,clk_o;
    output reg[3:0]last;
    input [3:0]min_1,sec_1,milli_1;
    input [3:0]min_10,sec_10,milli_10;
  
    reg [3:0]se[0:5];
    reg [3:0]counter=0;
    reg [7:0]pwm = 0;
    wire sec_clk;
    
    timeset_sec t1(clk_o,sec_clk,100);
    
    always@(posedge clk) begin
        se[5] <= min_10;
        se[4] <= min_1;
        se[3] <= sec_10;
        se[2] <= sec_1;
        se[1] <= milli_10;
        se[0] <= milli_1;
    end
        
    always@(posedge sec_clk) begin
        if(pwm >=100)
            pwm <= 0;
        else
            pwm <= pwm + 1;
    end    
        
   always@(posedge clk) begin
        if(counter >= 5)
            counter <= 0;
        else
            counter <= counter + 1;
        end
   always@(counter) begin
       last <= se[counter]; 
   end
    
endmodule
