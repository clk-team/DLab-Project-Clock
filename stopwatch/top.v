`timescale 1ns / 1ps

module top(clk,start,reset,seg,ld);

    input clk,reset,start;
    output [7:0]seg,ld;
   

    wire clk2;
    wire [3:0]last;
    wire [31:0]tmp;
    
    
    timeset timese(clk,clk2);
    show sh(clk2,ld);
    stopwatch stop(clk,start,reset,go,tmp);
    words word(last,clk2,clk,tmp);
    BCD_Encoder bcd(last,seg);
    
    
    
endmodule
