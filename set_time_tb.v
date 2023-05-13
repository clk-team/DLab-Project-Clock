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
wire [31:0]string;
wire[83:0]set_string;
wire [4:0]count;
set_time sss(clk, button_mid, button_r, button_l, button_up, button_down, year, month, day, hour, minute, sec, week, mode, set_string, count);
selectstring sel(string, clk, set_string, count, mode);

initial begin
    mode = 0;
    clk = 0;
    button_down = 0;
    button_l = 0;
    button_mid = 0;
    button_r = 0;
    button_up = 0;
    //set_time.count = 0;
//    set_time.year_th = 1;
//    set_time.year_h =5 ;
//    set_time.year_t = 8 ;
//    set_time.year_u = 3 ;
//    set_time.month_t = 0;
//    set_time.month_u = 8;
//    set_time.day_t = 0;
//    set_time.day_u = 1;
//   set_time.count = 9;

    
end


always #1 clk = ~ clk;

//always #100 button_l = ~ button_l;
always #100 button_r = ~ button_r;
//always #100 button_down = ~ button_down;
//always #100 set_time.day_u = set_time.day_u + 1;
//always #100 button_up = ~ button_up;
endmodule