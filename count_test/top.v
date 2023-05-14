`timescale 1ns / 1ps

module top(clk,start,start_2,reset,quick,seg,ld,go,milli_1,debounce);

    input clk,reset,start,quick;
    output [7:0]seg,ld;
    output go;
    output [3:0]milli_1;
    output reg start_2;
    output debounce;
   

    wire [3:0]min_10,min_1,sec_10,sec_1,milli_10;
    wire clk2;
    wire [3:0]last;
    
    always@(posedge clk) begin
        start_2 <= start;
    end
    
    timeset timese(clk,clk2);
    show sh(clk2,ld);
    stopwatch stop(clk,start,reset,quick,min_10,min_1,sec_10,sec_1,milli_10,milli_1,go,debounce);
    words word(last,clk2,clk,min_10,min_1,sec_10,sec_1,milli_10,milli_1);
    BCD_Encoder bcd(last,seg);
    
    
    
endmodule
