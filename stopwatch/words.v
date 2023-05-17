`timescale 1ns / 1ps

module words(last,clk,clk_o,tmp);
    
    input clk,clk_o;
    output reg[3:0]last;
    input [31:0]tmp;
  
    reg [3:0]se[0:7];
    reg [3:0]counter=0;
    reg [7:0]pwm = 0;
    wire sec_clk;
    
    timeset_sec t1(clk_o,sec_clk,100);
    
    always@(posedge clk) begin
        se[7] <= tmp[31:28];
        se[6] <= tmp[27:24];
        se[5] <= tmp[23:20];
        se[4] <= tmp[19:16];
        se[3] <= tmp[15:12];
        se[2] <= tmp[11:8];
        se[1] <= tmp[7:4];
        se[0] <= tmp[3:0];
    end
        
    always@(posedge sec_clk) begin
        if(pwm >=100)
            pwm <= 0;
        else
            pwm <= pwm + 1;
    end    
        
   always@(posedge clk) begin
        if(counter >= 7)
            counter <= 0;
        else
            counter <= counter + 1;
        end
   always@(counter) begin
       last <= se[counter]; 
   end
    
endmodule
