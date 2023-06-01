`timescale 1ns/1ps
module clock_top (clk, button_up, button_down, button_right, button_left, button_middle,
 oout, chs, SCL, SDA, RDY_O,ERR_O, dot,sound,switch, do, start);

input switch;  //鬧鐘的勿擾
input clk;
input button_up;
input button_down;
input button_left;
input button_right;
input button_middle;
input start;

output reg[7:0]oout;
output reg[7:0]chs;
output RDY_O,ERR_O;
output dot;
output sound;
output do;

//input [3:0]mode;

inout SCL,SDA;

wire [7:0]oout_settime;
wire [7:0]chs_settime;

wire [7:0]oout_currtime;
wire [7:0]chs_currtime;

wire [7:0]oout_temperature;
wire [7:0]chs_temperature;

wire [7:0]oout_stopwatch;
wire [7:0]chs_stopwatch;

wire [7:0]oout_countdown;
wire [7:0]chs_countdown;

wire[14:0]year_d;
wire[3:0]month_d;
wire[4:0]day_d;
wire[5:0]hour_d;
wire[5:0]min_d;
wire[5:0]sec_d;
wire[3:0]week ;
wire [3:0]mode;
wire do_1;

mode_sel (clk, button_left, button_right, button_middle, mode, start);
display_settime set(clk, chs_settime,oout_settime, sel,button_middle, button_right, button_left, button_up, button_down, mode, year_d,month_d, day_d, week, hour_d,min_d,sec_d);
main mmm(
    .clk(clk),
    .up(button_up),
    .down(button_down),
    .left(button_left),
    .right(button_right),
    .middle(button_middle),
    .year_d(year_d),
    .month_d(month_d),
    .day_d(day_d),
    .hour_d(hour_d),
    .min_d(min_d),
    .sec_d(sec_d),
    .week_s(week),
    .mode(mode), 
    .seg(oout_currtime),  
    .show(chs_currtime),
    .dot(dot),
    .sound(sound),
    .switch(switch),  
    .do(do),
    .do_1(do_1)
);
display_temperature temp(clk, chs_temperature,oout_temperature, mode,  SCL, SDA, RDY_O,ERR_O);
top_stopwatch stop(clk,button_middle,switch,oout_stopwatch,chs_stopwatch,mode,start);
top_countdown countd(clk,button_up,button_down,button_left,button_right,button_middle,oout_countdown,chs_countdown,state,start,mode,do_1);
always @(posedge clk) begin
    case (mode)
         0:
        begin
            oout <= oout_settime;
            chs <= chs_settime;
        end 
        1:
        begin
            oout <= oout_currtime;
            chs <= chs_currtime;
        end
        2:
        begin
            oout <= oout_currtime;
            chs <= chs_currtime;
        end
        3:
        begin
            oout <= oout_currtime;
            chs <= chs_currtime;
        end
        4:
        begin
            oout <= oout_temperature;
            chs <= chs_temperature;
        end
         5:
        begin
            oout <= oout_currtime;
            chs <= chs_currtime;
        end
         6:
        begin
            oout <= oout_stopwatch;
            chs <= chs_stopwatch;
        end
         7:
        begin
            oout <=oout_countdown;
            chs <= chs_countdown;
        end
        default:
        begin
            oout <= 0;
            chs <= 0;
        end 
    endcase
end

endmodule