`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/14 22:00:29
// Design Name: 
// Module Name: timeset_sec
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


module timeset_sec(clk, clk_1, fre);  //clk嚗撓??????   clk_1: 頛詨????
    input clk;
    input [25:0]fre;
    
    output clk_1;
    reg[26:0] counter=0;  //摰儔閮?,??閮?????25000000嚗?閬25雿??嚗?
    reg clk_1=0;
    always@(posedge clk)begin
    
            if(counter == 49999999 / fre) //憒??49999999
                begin
                    counter <= 0;     //??ounter?敺拇??0
                    clk_1 <= ~clk_1;      //??lk_1蝧餉??
                end
            else
                counter <= counter + 1'b1; //counter 蝜潛??

	end
endmodule
