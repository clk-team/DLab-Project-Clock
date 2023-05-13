`timescale 1ns/1ps

module display (clk, chs,oout, sel, button_mid, button_r, button_l, button_up, button_down, mode);

output [7:0]chs ;
output [7:0]oout;

input clk;
input sel;
input button_mid;
input button_l;
input button_r;
input button_down;
input button_up;
input [3:0]mode;

wire [3:0]last;
wire clk2;
wire [79:0] nowtime;
wire [83:0]set_string;
wire [3:0] count;



 frequency_divider div(clk, clk2);
 set_time set(clk, button_mid, button_r, button_l, button_up, button_down,mode, set_string, count);
 plus2counter c(clk2, chs);
 words ww(last, clk2, set_string, mode, count, clk);
 decoder de(oout, last);

    
endmodule