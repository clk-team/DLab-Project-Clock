`timescale 1ns/1ps

module _7bright ( reset,clk, chs,oout, sel,reset_2, selfre);

output [7:0]chs ;
output [7:0]oout;
input reset;
input clk;
input sel;
input reset_2;
input selfre;
wire [3:0]last;
wire clk2;
wire [79:0] nowtime;

 clock_top ccc(clk, reset_2,nowtime,selfre);
 frequency_divider div(clk, clk2);
 plus2counter c(clk2,reset, chs);
 words w(last, clk2, reset, sel, nowtime, clk);
 decoder de(oout, last);

    
endmodule