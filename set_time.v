`timescale 1ns/1ps

module set_time (clk, button_mid, button_r, button_l, button_up, button_down, year, month, day, hour, minute, sec, week,mode);

input clk;
input button_mid;
input button_l;
input button_r;
input button_down;
input button_up;
input [3:0]mode;

output reg[15:0]year = 16'h2023;
output reg[7:0]month = 8'h1;
output reg[7:0]day = 8'h1;
output reg[7:0]hour = 0;
output reg[7:0]minute = 0;
output reg[7:0]sec = 0;
output reg [3:0]week = 0;

reg start_set = 0;
reg [75:0] set_string;
reg[3:0] count = 0;
reg[31:0] timer;

reg [3:0]year_th = 2;
reg [3:0]year_h = 0;
reg [3:0]year_t = 2;
reg [3:0]year_u = 3;

reg [3:0]month_t = 0;
reg [3:0]month_u = 1;

reg [3:0]day_t = 0;
reg [3:0]day_u = 1;

reg [3:0]hour_t = 0;
reg [3:0]hour_u = 0;

reg [3:0]min_t = 0;
reg [3:0]min_u = 0;

reg [3:0]sec_t = 0;
reg [3:0]sec_u = 0;

reg [14:0]year_d;
reg [3:0]month_d;
reg [3:0]day_d;
reg [3:0]hour_d;
reg [3:0]min_d;
reg [3:0]sec_d;

reg [14:0]year_f;
reg [3:0]month_f;


always @(*) begin
    
   set_string <= {year , 4'd10 , month , 4'd10 , day , 4'd10 , week , 4'd10 , hour , 4'd10 , minute , 4'd10 , sec};
 
end


always @(*) begin
    year <= {year_th , year_h , year_t , year_u};
    month <= {month_t , month_u};
    day <= {day_t , day_u};
    hour <= {hour_t , hour_u};
    minute <= {min_t , min_u};
    sec <= {sec_t , sec_u};

    year_d <= year_th*1000 + year_h*100 + year_t*10 + year_u;
    month_d <= month_t*10 + month_u;
    day_d <= day_t*10 + day_u;
    hour_d <= hour_t*10 + hour_u;
    min_d <= min_t*10 + min_u;
    sec_d <= sec_t*10 + sec_u;


    if(month_d == 1 || month_d == 2)begin
        month_f <= month_d + 12;
        year_f <= year_d - 1;
    end
    
    else begin
        month_f <= month_d ;
        year_f <= year_d ;
    end

    week = ((year_f % 100) + (year_f % 100)/4 + (year_f / 100)/4 - 2*(year_f / 100) + (26*(month_f+1))/10+ day_d - 1);
    week = (week % 7 + 7)%7;
end


always @(mode) begin
    if(mode == 0)
        start_set <= 1;
    
    else
        start_set <= 0;
end

always @(posedge clk) begin

    if(button_l == 1 || button_r == 1)
        timer <= timer + 1;
        else
            timer <= 0;

    if(timer == 2500000)begin
        if(button_l == 1) begin

            if(count >=6)
                count <= 0;
            else
                count <= count +1;

        end
        else if(button_r == 1)begin

            if(count <= 0)
                count <= 6;
            else
                count <= count - 1;
        end
    
    end
end

// always @(posedge clk) begin

//     if(button_up == 1 || button_down == 1)
//         timer <= timer + 1;
//         else
//             timer <= 0;

//     if(timer == 2500000)begin
//         if(button_up == 1) begin

//             if(count >= 0 && count <= 15)
                
//             endcase

//         end
//         else if(button_down == 1)begin

//             if(count <= 0)
//                 count <= 6;
//             else
//                 count <= count - 1;
//         end
    
//     end
// end




endmodule //set_time