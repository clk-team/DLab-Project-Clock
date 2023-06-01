`timescale 1ns / 1ps

module top_stopwatch(clk,start,reset,seg,ld,mode,modify);

    input clk,reset,start,modify;
    input [3:0]mode;
    output [7:0]seg,ld;
   

    wire clk2;
    wire [3:0]last;
    wire [31:0]tmp;
    
    
    timeset timese(clk,clk2);
    show sh(clk2,ld);
    stopwatch stop(clk,start,reset,tmp,mode,modify);
    words_stopwatch word(last,clk2,clk,tmp);
    BCD_Encoder bcd(last,seg);
    
    
    
endmodule
