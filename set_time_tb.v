`timescale 1ns/1ps
module set_time_tb (
    
);

reg clk;
reg button_mid;
reg button_l;
reg button_r;
reg button_down;
reg button_up;
reg [3:0]mode;

wire[15:0]year ;
wire[7:0]month ;
wire[7:0]day ;
wire[7:0]hour ;
wire[7:0]minute ;
wire[7:0]sec ;
wire [3:0]week ;

set_time sss(clk, button_mid, button_r, button_l, button_up, button_down, year, month, day, hour, minute, sec, week,mode);

initial begin
    clk = 0;
    button_down = 0;
    button_l = 0;
    button_mid = 0;
    button_r = 0;
    button_up = 0;
end

always #10 clk = ~ clk;
    
endmodule