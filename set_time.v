`timescale 1ns/1ps

module set_time (clk, button_mid, button_r, button_l, year, month, day, hour, minute, sec, mode);

input clk;
input button_mid;
input button_l;
input button_r;
input [3:0]mode;

output [15:0]year;
output [7:0]month;
output [7:0]day;
output [7:0]hour;
output [7:0]minute;
output [7:0]sec;

reg start_set = 0;

always @(mode) begin
    if(mode == 0)
        start_set <= 1;
    
    else
        start_set <= 0;
end




endmodule //set_time