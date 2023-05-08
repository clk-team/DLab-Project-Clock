`timescale 1ns/1ps

module set_time (clk, button, year, month, day, hour, minute, sec);

input clk;
input button;

output [15:0]year;
output [7:0]month;
output [7:0]day;
output [7:0]hour;
output [7:0]minute;
output [7:0]sec;

endmodule //set_time