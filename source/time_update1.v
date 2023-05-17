`timescale 1ns / 1ps

module current_time(
   input clk,
   input  [14:0]year_d,
   input  [3:0]month_d,
   input  [4:0]day_d,
   input  [5:0]hour_d,
   input  [5:0]min_d,
   input  [5:0]sec_d,
   input  [3:0]week_s,
   input  [3:0]mode, 

   output reg [15:0]year, 
   output reg [5:0]month, 
   output reg [10:0]day, 
   output reg [10:0]hour, 
   output reg [10:0]minute, 
   output reg [10:0]second, 
   output reg [10:0]week
);

wire secclk;

reg [14:0]year_f;
reg [3:0]month_f;
reg [8:0]week_f = 0;

freq_div div(clk, secclk, 1);

initial begin
    year = 2023;
    month = 5;
    day = 9;
    hour = 11;
    minute = 59;
    second = 58;
    week = 2;
end

always @(posedge secclk)
begin

   if(mode != 0)begin
    second = second + 1;
    if(second == 60)
      begin
        second <= 0;
        minute = minute + 1;
     end
     
     if(minute == 60)
      begin
        minute <= 0;
        hour = hour + 1;
      end
   
    if(hour == 24)
      begin
        hour <= 0;
        day = day + 1;
        week = week + 1;
      end

    if(week == 8)
      begin
        week <= 1;
      end

   if(month == 1 && day == 32)   
     begin
        month <= 2;
        day <= 1;
     end

     if(month == 2 && day == 30 && year % 4 == 0 && year % 400 != 0)   
     begin
        month <= 3;
        day <= 1;
     end
    if(month == 2 && day == 29 && (year % 4 != 0 || year % 400 == 0))   
     begin
        month <= 3;
        day <= 1;
     end

     if(month == 3 && day == 32)   
     begin
        month <= 4;
        day <= 1;
     end

     if(month == 4 && day == 31)   
     begin
        month <= 5;
        day <= 1;
     end

     if(month == 5 && day == 32)   
     begin
        month <= 6;
        day <= 1;
     end

     if(month == 6 && day == 31)   
     begin
        month <= 7;
        day <= 1;
     end

     if(month == 7 && day == 32)   
     begin
        month <= 8;
        day <= 1;
     end

     if(month == 8 && day == 32)   
     begin
        month <= 9;
        day <= 1;
     end

     if(month == 9 && day == 31)   
     begin
        month <= 10;
        day <= 1;
     end

     if(month == 10 && day == 32)   
     begin
        month <= 11;
        day <= 1;
     end

     if(month == 11 && day == 31)   
     begin
        month <= 12;
        day <= 1;
     end

     if(month == 12 && day == 32)   
     begin
        month <= 1;
        day <= 1;
        year <= year + 1;
     end

     if(month == 1 || month == 2)begin
        month_f <= month + 12;
        year_f <= year - 1;
        
    end
    
    else begin
        month_f <= month ;
        year_f <= year;
        
    end
       
      
        if(year == 1582)begin
            if(month > 10)
                week = (day + 2*month_f + 3*(month_f + 1)/5 + year_f + year_f / 4 - year_f / 100 + year_f / 400 + 1) % 7;

            else if(month == 10)begin

                if(day >= 1 && day <= 4)begin //1~4
                    week_f = year_f%100 + (year_f%100)/4 - year_f/100 + 2*month_f + (3*(month_f + 1)/5) + day - 1;
                    if(week_f[8] == 1)
                        week_f = ~ week_f + 1;

                    week = week_f % 7; 
                end

                else if(day >= 5 && day <= 14)begin//5~14
                    day <= 15;
                end 
                    
                
                else begin //15~31
                    week = (day + 2*month_f + 3*(month_f + 1)/5 + year_f + year_f / 4 - year_f / 100 + year_f / 400 + 1) % 7;
                end
            end
            else begin
                week_f = year_f%100 + (year_f%100)/4 - year_f/100 + 2*month_f + (3*(month_f + 1)/5) + day - 1;
                    if(week_f[8] == 1)
                        week_f = ~ week_f + 1;

                    week = week_f % 7; 
            end
        end

        
        
    
end
   else begin
   year = year_d;
   month = month_d;
   day = day_d;
   hour = hour_d;
   minute = min_d;
   second = sec_d;
   week = week_s;
   end
      
   end
  endmodule