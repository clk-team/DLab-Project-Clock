`timescale 1ns / 1ps

module timeset_sec(clk, clk_1, fre);  
    input clk;
    input [25:0]fre;
    
    output clk_1;
    reg[26:0] counter=0;  
    reg clk_1=0;
    always@(posedge clk)begin
    
            if(counter == 49999999 / fre) 
                begin
                    counter <= 0;     
                    clk_1 <= ~clk_1;      
                end
            else
                counter <= counter + 1'b1; 

	end
endmodule
