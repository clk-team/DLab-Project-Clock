`timescale 1ns/1ps

module set_time (clk, button_mid, button_r, button_l, year, month, day, hour, minute, sec, mode);

input clk;
input button_mid;
input button_l;
input button_r;
input [3:0]mode;

output reg[15:0]year = 16'h2023;
output reg[7:0]month = 8'h1;
output reg[7:0]day = 8'h1;
output reg[7:0]hour = 0;
output reg[7:0]minute = 0;
output reg[7:0]sec = 0;

reg start_set = 0;
reg [75:0] set_string;

always @(*) begin
    
   set_string <= {year + 4'd10 + month + 4'd10 + day + 4'd10 + hour + 4'd10 + minute + 4'd10 + sec};
 
end

always @(mode) begin
    if(mode == 0)
        start_set <= 1;
    
    else
        start_set <= 0;
end

always @(posedge clk) begin
    
end


endmodule //set_time