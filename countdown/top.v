`timescale 1ns / 1ps

module top(clk,up,down,left,right,start,seg,ld,state,modify,mode);

    input clk,up,down,left,right,start,modify;
    output [7:0]seg,ld;
    output [3:0]state;
    output [3:0]mode;
    
    assign modify_2 = modify;
    
    wire clk2;
    wire [3:0]last;
    wire [31:0]tmp;
    wire [31:0]tmp1;
    wire modify;
    wire [3:0]state;
    
    wire go;
    wire finish;
    
    timeset timeset(clk,clk2);
    show sh(clk2,ld);
    set_countdown set_count(clk,up,down,left,right,start,tmp1,state,go,modify,mode);
    countdown cd(clk,start,tmp1,tmp,finish,go);
    words words(last,clk2,clk,tmp,tmp1,state,go,finish);
    BCD_Encoder bcd(last,seg);
    
    
    
endmodule
