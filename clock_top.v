`timescale 1ns/1ps
module clock_top (clk, button_up, button_down, button_right, button_left, button_middle,
 oout, chs, mode, SCL, SDA, RDY_O,ERR_O, dot, quick);

input clk;
input button_up;
input button_down;
input button_left;
input button_right;
input button_middle;
input quick;

output reg[7:0]oout;
output reg[7:0]chs;
output RDY_O,ERR_O;
output dot;
    
input [3:0]mode;

inout SCL,SDA;

wire [7:0]oout_settime;
wire [7:0]chs_settime;

wire [7:0]oout_currtime;
wire [7:0]chs_currtime;

wire [7:0]oout_temperature;
wire [7:0]chs_temperature;

wire[14:0]year_d;
wire[3:0]month_d;
wire[4:0]day_d;
wire[5:0]hour_d;
wire[5:0]min_d;
wire[5:0]sec_d;
wire[3:0]week ;


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
    .quick(quick)  
    
);
display_temperature temp(clk, chs_temperature,oout_temperature, mode,  SCL, SDA, RDY_O,ERR_O);

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
        default:
        begin
            oout <= 0;
            chs <= 0;
        end 
    endcase
end

endmodule