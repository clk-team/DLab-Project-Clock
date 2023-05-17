`timescale 1ns/1ps
module clock_top (clk, button_up, button_down, button_right, button_left, button_middle,
 oout, chs);

input clk;
input button_up;
input button_down;
input button_left;
input button_right;
input button_middle;

output reg[7:0]oout;
output reg[7:0]chs;

    
wire [3:0]mode;

wire [7:0]oout_settime;
wire [7:0]chs_settime;

wire [7:0]oout_currtime;
wire [7:0]chs_currtime;

wire[14:0]year_d;
wire[3:0]month_d;
wire[4:0]day_d;
wire[5:0]hour_d;
wire[5:0]min_d;
wire[5:0]sec_d;
wire[3:0]week ;

mode_selection sss(clk,button_up,button_down,mode,button_middle);
display_settime set(clk, chs_settime,oout_settime, sel, button_mid, button_r, button_l, button_up, button_down, mode, year_d,month_d, day_d, week, hour_d,min_d,sec_d);
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
    .seg(oout_currtime),  //七段顯示???
    .show(chs_currtime)  //七段顯示??????電?????
    
);

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
        default:
        begin
            oout <= 0;
            chs <= 0;
        end 
    endcase
end

endmodule